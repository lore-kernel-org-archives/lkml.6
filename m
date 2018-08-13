Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C825C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0991921754
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="MIv59kwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0991921754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbeHMRCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 13:02:55 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:56964 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbeHMRCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 13:02:55 -0400
X-IronPort-AV: E=Sophos;i="5.53,233,1531810800"; 
   d="scan'208";a="17872136"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Aug 2018 07:20:26 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 13 Aug 2018 07:20:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIraA1M9NvMPDqZoAAnyzrPIxIwDrgi7oQ5d+vf95pg=;
 b=MIv59kwW34f4Gl3m6gt7+lyDaOOJ2Ah6l+XU8NQ46SoNZ+RvH5L841cQYBTZP69FoP4lnUVIxzHbE7696VGcgvkKK278E0IrF6repOKRmAgB1FVGrcS/lPIhOjZnsjclFyXP6+7q8Wp0Xf47TkEqQ/vZz4XY4EhEmKg1dq3PQMw=
Received: from BYAPR11MB2855.namprd11.prod.outlook.com (52.135.228.141) by
 BYAPR11MB2616.namprd11.prod.outlook.com (52.135.227.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 13 Aug 2018 14:20:20 +0000
Received: from BYAPR11MB2855.namprd11.prod.outlook.com
 ([fe80::c98e:2eb9:6814:9a27]) by BYAPR11MB2855.namprd11.prod.outlook.com
 ([fe80::c98e:2eb9:6814:9a27%6]) with mapi id 15.20.1017.022; Mon, 13 Aug 2018
 14:20:20 +0000
From:   <Don.Brace@microchip.com>
To:     <zhongjiang@huawei.com>, <don.brace@microsemi.com>,
        <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] scsi: Use vmemdup_user to replace the open code
Thread-Topic: [PATCH v2] scsi: Use vmemdup_user to replace the open code
Thread-Index: AQHUMwTwEROcISOHQ0me0T7LocJVlKS9uzJA
Date:   Mon, 13 Aug 2018 14:20:20 +0000
Message-ID: <BYAPR11MB28555A88771594AA31AC7596E1390@BYAPR11MB2855.namprd11.prod.outlook.com>
References: <1534164200-28408-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1534164200-28408-1-git-send-email-zhongjiang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Don.Brace@microchip.com; 
x-originating-ip: [216.54.225.58]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR11MB2616;6:zscAkr50RdUzPL+wkTShyMDSJc2USPM00GL5+jbGT0E0YFQC4lp5lTm/iGcEV/sPz2A1OubsOaPtcfdeUw8hcOl2Bsd6N0B/qTuVxsNIzNC5aGyJfgX9ypiVF81SxB5gaNVoHH6XBvfXHZbDxGLNw/ll0EuM5x7v3W+yhfazDZuJ3WgwcV/U0fXyn1eH0UgkkyAUHQBp5IO07NsxFHzSKkbGgtmBhNxHDT1Tk3+1kTiMgsZQYFtqaX3S0NahFnOH/VJTEMQhw+D+2eE2aETej6B/oWoofgubKi4HxqC08c7NDDWUuItULp8kSBiHnC7eUT4Ll/Ysln2vPLcO1YFaWgILJoIfApqWJ4bZcfeFR7rbEILusg/LId7r6BZ2sL1i2M2O6xd4+n74MNWwizRB0MM+bQCj5Zfq7axkXx6yFBq3VpA//gphr9b046fcRc4uzWMwUq0q4IbB2rBk1UQ4uQ==;5:nXMyATok6iJhj0NlndIxnGm+JnKwtfo1Pq1KVpNj1/wkuaMCIzGJm0xPoWMQ2FanlSbEF03hNnPIp3P/r4diCIbK7pi0fagyKtwpl/zJt0B8BmDCCQlcL2WzzI7X1LzsqOAgGQ11ygK6f5t6zKa/O2VBZ+fkYDjui15lHubMS2A=;7:HhuJZWqtxQosOOjK9csh3nQg5Mn2MKcyPBEwCCgIR1mtfztYGOykYgOXFHo6gnT21c7mnG1cnM0bAbugzoFrdvm+1CfP5zYdzhmzL373wPUxG0VIEVjDY2djJKh1r+5KVffkkLZ9G1//1GXya4rx+UZtrG9yrQSeB66iJx3tYze3imonXyTJkzqAAJB/+fEIhQrCVjYEOafDFlUpfbln1+YSQ+ssv+sWxTPR9wc3euUWEH3y/mihSSSdroO9nIXq
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a3363da3-1858-4c30-0e0a-08d60127e6d0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR11MB2616;
x-ms-traffictypediagnostic: BYAPR11MB2616:
x-microsoft-antispam-prvs: <BYAPR11MB2616A1EF2B51FFF890E8F113E1390@BYAPR11MB2616.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(50582790962513)(788757137089)(72170198267865)(104084551191319)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BYAPR11MB2616;BCL:0;PCL:0;RULEID:;SRVR:BYAPR11MB2616;
x-forefront-prvs: 07630F72AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(366004)(396003)(199004)(189003)(13464003)(6246003)(14454004)(81166006)(81156014)(11346002)(8676002)(7696005)(5660300001)(110136005)(97736004)(26005)(74316002)(53936002)(6436002)(86362001)(99286004)(76176011)(478600001)(53546011)(102836004)(7736002)(6506007)(305945005)(72206003)(9686003)(8936002)(55016002)(186003)(446003)(316002)(68736007)(105586002)(106356001)(66066001)(5250100002)(476003)(4326008)(33656002)(2906002)(2501003)(2201001)(3846002)(256004)(6116002)(486006)(2900100001)(229853002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB2616;H:BYAPR11MB2855.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jUkM3CmB4ignKv/rXw9HYKtx3jRQI4pZpAa7vFbgWcKsnngXeawcc5EP7HhU5hz7632Jh8gLf4FVsX9BcUG2h4SkDVAZD4+tBwLTnYqQv5ekCpRKD3WNWfzy9GAJrPd8/XbLVhpTYX8fCy7atuU1yneUFe4w2bFvNWOyKgXy0BizErTVES4Q49lWd4eumqLI/l+Y6tAQ1ktf2Nd83cdpHZYWtQmAYT3dslO2latFj0PIQ/7qfiLRAHE/PRefJa950epOwbjsv+0LXhssV5Kh6IhT7DDuj6qod2BBw52rsn9J98c9I30+dEe5ETR6utzpUQ1wUpJkl+axac+eZOk2w7zW6FajQelQ+wt9UJnpuKw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a3363da3-1858-4c30-0e0a-08d60127e6d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2018 14:20:20.5449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2616
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: zhong jiang [mailto:zhongjiang@huawei.com]
> Sent: Monday, August 13, 2018 7:43 AM
> To: don.brace@microsemi.com; jejb@linux.vnet.ibm.com;
> martin.petersen@oracle.com
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH v2] scsi: Use vmemdup_user to replace the open code
>=20
> EXTERNAL EMAIL
>=20
>=20
> EXTERNAL EMAIL
>=20
>=20
> vmemdup_user is better than duplicating its implementation, So just
> replace the open code.
>=20
> The issue is detected with the help of Coccinelle.
>=20
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Tested-by: Don Brace <don.brace@microsemi.com>
Acked-by: Don Brace <don.brace@microsemi.com>

> ---
>  drivers/scsi/hpsa.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
> index 58bb70b..666ba09e5 100644
> --- a/drivers/scsi/hpsa.c
> +++ b/drivers/scsi/hpsa.c
> @@ -6381,13 +6381,9 @@ static int hpsa_big_passthru_ioctl(struct ctlr_inf=
o
> *h, void __user *argp)
>                 return -EINVAL;
>         if (!capable(CAP_SYS_RAWIO))
>                 return -EPERM;
> -       ioc =3D kmalloc(sizeof(*ioc), GFP_KERNEL);
> -       if (!ioc) {
> -               status =3D -ENOMEM;
> -               goto cleanup1;
> -       }
> -       if (copy_from_user(ioc, argp, sizeof(*ioc))) {
> -               status =3D -EFAULT;
> +       ioc =3D vmemdup_user(argp, sizeof(*ioc));
> +       if (IS_ERR(ioc)) {
> +               status =3D PTR_ERR(ioc);
>                 goto cleanup1;
>         }
>         if ((ioc->buf_size < 1) &&
> @@ -6505,7 +6501,7 @@ static int hpsa_big_passthru_ioctl(struct ctlr_info=
 *h,
> void __user *argp)
>                 kfree(buff);
>         }
>         kfree(buff_size);
> -       kfree(ioc);
> +       kvfree(ioc);
>         return status;
>  }
>=20
> --
> 1.7.12.4

