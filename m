Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8070C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A47D218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="dtaMnSRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732057AbeLTVVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:21:13 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:52766 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbeLTVVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:21:13 -0500
X-IronPort-AV: E=Sophos;i="5.56,378,1539673200"; 
   d="scan'208";a="25523698"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Dec 2018 14:21:11 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 20 Dec 2018 14:21:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJY4bjdcLg3qpzd2kkGII7vardqheCfOs42SmZVUiOY=;
 b=dtaMnSRT4tDWXLujqgEjE0R9DoyV5NvC30960vz4as6ZvjHstZaYQFAQnlc2mNzekdEDr4ebDCsscioDyQhx4BZqSR7kRvfM5Qw83k84991Zqt/18jkjKCkijW0Pney04WPpx/9uchLi4BtGzNJPZtv9w2LCawNlEEBh2LL7cH0=
Received: from BYAPR11MB2855.namprd11.prod.outlook.com (52.135.228.141) by
 BYAPR11MB3238.namprd11.prod.outlook.com (20.177.184.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Thu, 20 Dec 2018 21:21:09 +0000
Received: from BYAPR11MB2855.namprd11.prod.outlook.com
 ([fe80::1137:d81d:de30:c394]) by BYAPR11MB2855.namprd11.prod.outlook.com
 ([fe80::1137:d81d:de30:c394%4]) with mapi id 15.20.1425.021; Thu, 20 Dec 2018
 21:21:09 +0000
From:   <Don.Brace@microchip.com>
To:     <yanjiang.jin@hxt-semitech.com>, <don.brace@microsemi.com>,
        <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <yu.zheng@hxt-semitech.com>, <jinyanjiang@gmail.com>,
        <esc.storagedev@microsemi.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: smartpqi: call pqi_free_interrupts() in
 pqi_shutdown()
Thread-Topic: [PATCH] scsi: smartpqi: call pqi_free_interrupts() in
 pqi_shutdown()
Thread-Index: AQHUmD7NG/E8sTOseEqhHXrMUj2G7aWIGLPg
Date:   Thu, 20 Dec 2018 21:21:08 +0000
Message-ID: <BYAPR11MB285583497B3E108B77267240E1BF0@BYAPR11MB2855.namprd11.prod.outlook.com>
References: <1545294755-29565-1-git-send-email-yanjiang.jin@hxt-semitech.com>
 <1545294755-29565-2-git-send-email-yanjiang.jin@hxt-semitech.com>
In-Reply-To: <1545294755-29565-2-git-send-email-yanjiang.jin@hxt-semitech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Don.Brace@microchip.com; 
x-originating-ip: [216.54.225.58]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR11MB3238;6:cfZDYpTznHNE9f9OjtnjtOqtwpblE+SMwgx01ebmi7QWXoaR6e3BConDVrnw37MOKoIUoSqy4DvgkZ8k6m6M+1kDzn4tmS1sW6gXCC6My94cC/DBsf2orF6IK7h9TmZX2ei9n88CxjYr5QbX5S9uGohSwS68fWB2WaTqGvFeh9U5dAqnRMmDrt2jRBjWk2g92szquVOFbU4QidDmZyT6EfLZSyseXXcxxmqR6+xcxOAco4W4FN96+IrsiLCP6IoCfuC/LaWO+UEEq51RQN/5MZTbP4G65u35B2NmAT49lCihRRlcI9m2zTxdbGkD2qYJoXlfVgoM9MP9iwRZYJLe1ImrZNQ/hJkgL3+dXroQlZ0xBtZiSNbiY3ZIhIemKyAgEpgtKpGMC0VXfthp5owYHt4/Ym4cmH57WJRc5vQDKeRaxktdGMVlabDu+uuLB7JrhaIWp/7pZm22zeOhONRAFg==;5:sVIhMK72LS61iqPQ8FULOYvfLroe6RBNLn4dke3swYzmhWBFOS9Kx8Vrlpys/vbbdOmEozIsEp7NZxK3+NTVuy6/W3A9Faq4AMuI2Db2nD7b5m0F6RV5REbMFijGGH5vcNG2Ws3OWWGbG0aSbaJtmzonZJchAgU4UijNuIFBsyE=;7:aV3mK4lhB03AK79zHPMJVVMIiGPYvB0OG9+kwRq8Bn3yz7HtS7y4bI2WeGzcYiqPQO3CF2T+W6Vov3DEuCEaCOmcNda/hdjoho3ro41f6ih+GteeaMCUaSUUfELrUUQSWqK0PdrWiBJ4Ip5z2GqU8w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 432f8af8-7459-4df8-2210-08d666c10f6a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR11MB3238;
x-ms-traffictypediagnostic: BYAPR11MB3238:
x-microsoft-antispam-prvs: <BYAPR11MB3238775DB6E1FD89BAC2455FE1BF0@BYAPR11MB3238.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR11MB3238;BCL:0;PCL:0;RULEID:;SRVR:BYAPR11MB3238;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(366004)(13464003)(199004)(189003)(53936002)(55016002)(33656002)(99286004)(105586002)(86362001)(7736002)(256004)(8936002)(7696005)(11346002)(9686003)(486006)(5660300001)(2906002)(71190400001)(81166006)(53546011)(76176011)(68736007)(229853002)(102836004)(3846002)(6506007)(39060400002)(25786009)(6116002)(8676002)(71200400001)(476003)(4326008)(2201001)(81156014)(66066001)(2501003)(72206003)(316002)(186003)(54906003)(97736004)(74316002)(110136005)(14454004)(106356001)(446003)(14444005)(26005)(6246003)(478600001)(305945005)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3238;H:BYAPR11MB2855.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bLU6hwwX2PwEUi9nZpiOwh17C8fs+F7A33DZozopkQcMA9099fIeX6TVu/prBYgP57JQGBDczHfITDAokLMwI06kRyFN7a/IO4m4AB/KPZw7Vj2pizZ3+j/ju9xvRGQVGnOFd8raLA3Ghbhs0H8T9hFxUreE97SqTLakw0t8nH/CN9vRJoT/sOok/fiNnWw/SZOKaNKbmwNjsQKM77e8Ao53p6pUaWjt46ymegcPmhUOJsDhnKuKVF6/IxpbjdPNJF865UQDAH5BBjvDf5qUho/yNuIQei0cHg8uQ/MoevQDCHc7jynuJNENnpLxGxQy
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 432f8af8-7459-4df8-2210-08d666c10f6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 21:21:09.1888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3238
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Yanjiang Jin [mailto:yanjiang.jin@hxt-semitech.com]=20
Sent: Thursday, December 20, 2018 2:33 AM
To: don.brace@microsemi.com; jejb@linux.vnet.ibm.com; martin.petersen@oracl=
e.com; yanjiang.jin@hxt-semitech.com
Cc: yu.zheng@hxt-semitech.com; jinyanjiang@gmail.com; esc.storagedev@micros=
emi.com; linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: smartpqi: call pqi_free_interrupts() in pqi_shutdown=
()

We must free all irqs during shutdown, else kexec's 2nd kernel would hang i=
n pqi_wait_for_completion_io() as below:

Call trace:

 pqi_wait_for_completion_io
 pqi_submit_raid_request_


This happens only in the following combinations:

1. smartpqi is built as module, not built-in; 2. We have a disk connected t=
o smartpqi card; 3. Both kexec's 1st and 2nd kernels use this disk as Rootf=
s' mount point.

Signed-off-by: Yanjiang Jin <yanjiang.jin@hxt-semitech.com>

Thank-you for your patch.

Acked-by: Don Brace <don.brace@microsemi.com>

---
 drivers/scsi/smartpqi/smartpqi_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/=
smartpqi_init.c
index a25a07a..55c1d82 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -6670,6 +6670,7 @@ static void pqi_shutdown(struct pci_dev *pci_dev)
         * storage.
         */
        rc =3D pqi_flush_cache(ctrl_info, SHUTDOWN);
+       pqi_free_interrupts(ctrl_info);
        pqi_reset(ctrl_info);
        if (rc =3D=3D 0)
                return;
--
1.8.3.1




This email is intended only for the named addressee. It may contain informa=
tion that is confidential/private, legally privileged, or copyright-protect=
ed, and you should handle it accordingly. If you are not the intended recip=
ient, you do not have legal rights to retain, copy, or distribute this emai=
l or its contents, and should promptly delete the email and all electronic =
copies in your system; do not retain copies in any media. If you have recei=
ved this email in error, please notify the sender promptly. Thank you.


