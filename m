Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16110C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC31020837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KV54+wcm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC31020837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbeIBRbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:31:38 -0400
Received: from mail-eopbgr680096.outbound.protection.outlook.com ([40.107.68.96]:60224
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728712AbeIBRbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFeAh49S7pni7Vl3G1tJo22Ew5+deRMSVE7K2e+KrXU=;
 b=KV54+wcmsxDhMdnfHSyVFlRqbi2zGrDU2BPKQgO2SfxcLdqaGp4iW6hIRob/Fq/kCSPR2pHInjjC+ShDVKBrOTKsBPJRbFH1ipxShk2ktQtC4Mt5GBR8d3+vhlNFzeltCmglLAaITlfavE0kR9qCTLRyKp08zD8cFCIhAT9unAw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:15:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 09/47] uio: potential double frees if
 __uio_register_device() fails
Thread-Topic: [PATCH AUTOSEL 4.4 09/47] uio: potential double frees if
 __uio_register_device() fails
Thread-Index: AQHUQr8P4za1kV3fOE+4A9+vp3lWWQ==
Date:   Sun, 2 Sep 2018 13:15:47 +0000
Message-ID: <20180902131533.184092-9-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:Lt8UEwIfn6XhixRaYKBgCnNRRkKltMNNN5iuTQtOYhkbINXRbp1EZsBAdfyzQaPb3eqK1AflPdy0wkHTxyGv9M16brWW2pGXacjVNdi3nr1Oe1/EKxJVuBxYTNnDZOsLe8VJ6XEGqBqGHuLnj8HU3JJWo0R64cPIp2YBK8d8T8w1anUgs/qxj2N8/QrQauK/Vlcl/7HIxLUdGGhoFzL8kuJlPC9HHSmGEZFId1crSgJUkVdmnp/016O3mOs1CTLVmZdREJ8bN2P/DJbYP0Fi5GFVSNZTvJLEZPJDAKxj5EwUXBYU10iQScQDRofqpwZLcEO+Rc0xxKr6DSigxtLBmDwPlaIogdW9q07P12VDtliloQ2OQJviU/V2M4NjkSHR7GA6QzzePbIUNna8AyBJTJVAppc8ATEQjS2QSfU1heCVpDpL57jlvNdpSBJPR9Q/WlDhbpv6ONTWEmfOSdnG6Q==;5:n98HDevo+zcSDQPmdf4Jegq2TZasycQhxFcuapbnJnkzMqfv77fbtWR+etOvvzpo0fIBRJLM7oU7SryPp77a244kSS6Vu7GQ31Jho/wqrwV4NqqDMx2M6WOTGjW4HvwSZ/HzLtog9rcV2k5DoqvMcAUfZRS/nJ5wu4GqLVnT1kg=;7:ZsJGSsNvfyXH4FaKTDbdunZCxzOUe6dK8MfB94dLLiQmYMcF7QetJSqa0PyLCDTcuRL8Gc+5dW8eTPM5R3EsJDyK1Q8s5Vu+HeOpqJzso7hWeIWeyEvsmVTllPuekOt4GJ00r0RkmwQd+1sCaLqwFjh6Pq0cgXbQUD9bc0WV6ZSXwIM0bZwA8yxwLj49UZD3oTq66ZwnlxFR5utUyxHl3iBX5g4+W09D3Xt4JeA/6u1/TaeH39YZy1vUjMPxcl0R
x-ms-office365-filtering-correlation-id: 4430a92e-d038-4fc8-e2e1-08d610d6327f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB062994EE3F994910C8690D1CFB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(8676002)(478600001)(10090500001)(14454004)(10290500003)(72206003)(476003)(5660300001)(5250100002)(106356001)(110136005)(54906003)(316002)(105586002)(86612001)(102836004)(14444005)(26005)(256004)(6506007)(2616005)(6116002)(217873002)(305945005)(446003)(1076002)(3846002)(2906002)(11346002)(97736004)(6346003)(81166006)(81156014)(7736002)(6436002)(66066001)(25786009)(86362001)(4326008)(186003)(53936002)(8936002)(6486002)(22452003)(6512007)(99286004)(2501003)(36756003)(68736007)(2900100001)(486006)(107886003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: XdQ6TVB+tUeag/YnHMpH6pT5SOTrguSyE7ADvLUwdV4Zr7yuJJ/tpMO2S/FvNwuR/3BZynAYOmSAb4WTKhjhPpb5+cBQXOlscw6tJi794YQDhnvPYers61sSBuT4E/Y9LUxU4PMngf0mMPs0KZ0VHKm0AlzfBrX8xGS3SaeiLjav7ypVRxW/ohB9zj39OI019yT0NTtK6F5w9PH4msCCmjZ5ne7NKW07A9uTxtIEyFAYUH6pb45zgMj4EsebSombIaZiWydCMPfWwryKVBdecEb16PH+sEL0FXUkm2ZRHaEJOuiH9Qz5kMv607BxRbEZIALhWNiZ0WXj1OTgXMsvRSmrnmcusNJOEkQhCgVTXJ4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4430a92e-d038-4fc8-e2e1-08d610d6327f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:47.4130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit f019f07ecf6a6b8bd6d7853bce70925d90af02d1 ]

The uio_unregister_device() function assumes that if "info->uio_dev" is
non-NULL that means "info" is fully allocated.  Setting info->uio_de
has to be the last thing in the function.

In the current code, if request_threaded_irq() fails then we return with
info->uio_dev set to non-NULL but info is not fully allocated and it can
lead to double frees.

Fixes: beafc54c4e2f ("UIO: Add the User IO core code")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/uio/uio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index bcc1fc027311..b9823eb9c195 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -833,8 +833,6 @@ int __uio_register_device(struct module *owner,
 	if (ret)
 		goto err_uio_dev_add_attributes;
=20
-	info->uio_dev =3D idev;
-
 	if (info->irq && (info->irq !=3D UIO_IRQ_CUSTOM)) {
 		/*
 		 * Note that we deliberately don't use devm_request_irq
@@ -850,6 +848,7 @@ int __uio_register_device(struct module *owner,
 			goto err_request_irq;
 	}
=20
+	info->uio_dev =3D idev;
 	return 0;
=20
 err_request_irq:
--=20
2.17.1
