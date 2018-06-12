Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 26A52C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5CD208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="d4oZCkTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5CD208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933473AbeFLHuq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:50:46 -0400
Received: from mail-co1nam03on0057.outbound.protection.outlook.com ([104.47.40.57]:38361
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933327AbeFLHup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Suu/VQa4xk8JhOEwpTjmUtYVCV5zUCg7DM5MLev0Fig=;
 b=d4oZCkTfU3drxelHPPNsLX/WngX1918Yw4mxzPcMsOumiVcDKBX5Meq3bUebg4Kj6Ii/IIBy4j29SvPvKZy1Ae+928KkUqU6Bc/JxPargTCVWILCTolPDNuzYspbImyHrZ93HhsDE5uSf9KK3PSzBNnq+kieg3Y18jvrgy0u2lE=
Received: from MW2PR07MB4042.namprd07.prod.outlook.com (52.132.179.25) by
 MW2PR07MB4028.namprd07.prod.outlook.com (52.132.179.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Tue, 12 Jun 2018 07:50:42 +0000
Received: from MW2PR07MB4042.namprd07.prod.outlook.com
 ([fe80::7964:8ea4:50eb:9c8]) by MW2PR07MB4042.namprd07.prod.outlook.com
 ([fe80::7964:8ea4:50eb:9c8%6]) with mapi id 15.20.0841.019; Tue, 12 Jun 2018
 07:50:42 +0000
From:   "Rangankar, Manish" <Manish.Rangankar@cavium.com>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
CC:     Dept-Eng QLogic Storage Upstream 
        <QLogic-Storage-Upstream@cavium.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: bnx2i: add error handling for ioremap_nocache
Thread-Topic: [PATCH] scsi: bnx2i: add error handling for ioremap_nocache
Thread-Index: AQHUAftOcvzdcv7x0UmI9J2eEj1F/qRcP7lQ
Date:   Tue, 12 Jun 2018 07:50:42 +0000
Message-ID: <MW2PR07MB404280BA7B708DE79A5A07C4E37F0@MW2PR07MB4042.namprd07.prod.outlook.com>
References: <1528773180-37120-1-git-send-email-jiazhouyang09@gmail.com>
In-Reply-To: <1528773180-37120-1-git-send-email-jiazhouyang09@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Manish.Rangankar@cavium.com; 
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR07MB4028;7:3dC2twDE3Dm2TX54T9T2x+m9cWC7nJ1QmrFeA7Ear4KHu5tMBq4dN2pjq+2Eu7Oj8gX8GNTzFWOzlJQR+jbC7pCNJJmKOc5p0bweAuAMEYw95lPTJ6aVrANMij7Jod9DJB8OSeOex6k43q4abffM5H78iRDlBF2i6OFeGttCvJVeKtM7ArWqGPRvB+0x3WxU4OltHqN8xZz2+F5y17MwXBUZkLfSEEfF9+1Vltzoxuydgw2P1cuLN+1dV0ehUlmZ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MW2PR07MB4028;
x-ms-traffictypediagnostic: MW2PR07MB4028:
x-microsoft-antispam-prvs: <MW2PR07MB4028EC847715967FB60DC9F4E37F0@MW2PR07MB4028.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(104084551191319)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MW2PR07MB4028;BCL:0;PCL:0;RULEID:;SRVR:MW2PR07MB4028;
x-forefront-prvs: 07013D7479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(376002)(366004)(346002)(39860400002)(189003)(13464003)(199004)(2900100001)(53936002)(6246003)(14454004)(105586002)(106356001)(25786009)(39060400002)(33656002)(3846002)(97736004)(66066001)(6116002)(4326008)(2906002)(9686003)(446003)(26005)(3660700001)(5250100002)(3280700002)(486006)(186003)(11346002)(102836004)(476003)(6436002)(229853002)(76176011)(81156014)(81166006)(59450400001)(8676002)(7696005)(55016002)(8936002)(74316002)(99286004)(316002)(54906003)(7736002)(6506007)(305945005)(6916009)(68736007)(5660300001)(1411001)(72206003)(478600001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR07MB4028;H:MW2PR07MB4042.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Air65sbNWD5b4HjQvj+Yo8PWC8NbsdsN4xuFyXCmV1+tnScl6r2mClprjbpOEIraqVjQ0jOJVTM/0I359lRfR3D+nk507wWn5WOPFQHcX4XtR5a4g9eW5/pkYIKmy5/tMxLB5GauyZVwAzR8JiEXUK+Cr8FdT2sMSrTTugqg185LaeTalaVr/LzgzzXVP3vt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: edd67f18-7d92-46ce-e07c-08d5d03932df
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd67f18-7d92-46ce-e07c-08d5d03932df
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2018 07:50:42.7178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB4028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Zhouyang Jia <jiazhouyang09@gmail.com>
> Sent: Tuesday, June 12, 2018 8:43 AM
> Cc: Zhouyang Jia <jiazhouyang09@gmail.com>; Dept-Eng QLogic Storage
> Upstream <QLogic-Storage-Upstream@cavium.com>; James E.J. Bottomley
> <jejb@linux.vnet.ibm.com>; Martin K. Petersen <martin.petersen@oracle.com=
>;
> linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] scsi: bnx2i: add error handling for ioremap_nocache
>=20
> When ioremap_nocache fails, the lack of error-handling code may cause
> unexpected results.
>=20
> This patch adds error-handling code after calling ioremap_nocache.
>=20
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  drivers/scsi/bnx2i/bnx2i_hwi.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/scsi/bnx2i/bnx2i_hwi.c b/drivers/scsi/bnx2i/bnx2i_hw=
i.c index
> 8f03a86..e9e669a 100644
> --- a/drivers/scsi/bnx2i/bnx2i_hwi.c
> +++ b/drivers/scsi/bnx2i/bnx2i_hwi.c
> @@ -2727,6 +2727,8 @@ int bnx2i_map_ep_dbell_regs(struct bnx2i_endpoint
> *ep)
>  					      BNX2X_DOORBELL_PCI_BAR);
>  		reg_off =3D (1 << BNX2X_DB_SHIFT) * (cid_num & 0x1FFFF);
>  		ep->qp.ctx_base =3D ioremap_nocache(reg_base + reg_off, 4);
> +		if (!ep->qp.ctx_base)
> +			return -ENOMEM;
>  		goto arm_cq;
>  	}
>=20
> --
> 2.7.4

Thanks,

Acked-by: Manish Rangankar <Manish.Rangankar@cavium.com>
