Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E4AC5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4FF20850
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DB+6NBev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfASBLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 20:11:52 -0500
Received: from mail-eopbgr690116.outbound.protection.outlook.com ([40.107.69.116]:52096
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727128AbfASBLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 20:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfPtfL79+y9dJmSECeCgE7Jgb5yfuiUywvuP99n6dKc=;
 b=DB+6NBevfwY8prXXNjfgDB0YPz19QaZKCDKhV21A4pLAUygU5fIfJWkuKzOox60LeLIUWy8ZjeVRzMkCy3IHoiePOtbbPmKeq3KdrEJtnZLzaMB/PnxZjbl25XuOq0dk4XBdZWsuiP8K1xpUl+LBbCnyXhWCjy/YCKjlsWqfj6o=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0837.namprd21.prod.outlook.com (10.173.192.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.8; Sat, 19 Jan 2019 01:11:48 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::e596:e32f:3aa3:2461]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::e596:e32f:3aa3:2461%7]) with mapi id 15.20.1558.009; Sat, 19 Jan 2019
 01:11:48 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH hyperv-fixes,1/3] Fix ethtool change hash key error
Thread-Topic: [PATCH hyperv-fixes,1/3] Fix ethtool change hash key error
Thread-Index: AQHUrGzJd5sgbbWZ/0OIblITJjtdkaW1zr5A
Date:   Sat, 19 Jan 2019 01:11:48 +0000
Message-ID: <CY4PR21MB0773266E93762A74097F6DDBD79D0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20190115005144.4494-1-haiyangz@linuxonhyperv.com>
 <20190115005144.4494-2-haiyangz@linuxonhyperv.com>
In-Reply-To: <20190115005144.4494-2-haiyangz@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-19T01:11:46.0847112Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b1f598ce-214f-4500-8df6-20c700b558b1;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2001:4898:80e8:a:e112:b8a4:906c:6906]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0837;6:sIbIm/fw2zaqzfe/rB3D6R3delM6QEFk7KtgSX3KSQ7SU1IV8pUGIswDIVhO8EL2kA1Hzur+GZIiE/BpLxMxOacJNAKMlV/bGktwskIqUt4N58Um7NBXVfZKNgDmcaBam8gnKcNMAPxAKt66MtqS8lmVUNanagV3hhvGNa5cfml6TGYinCtM/6BieFO2gWNmPS7reov2MbFGpm/MM/qhjI1VTbbfWVrHkK/zC6kKHsqc9m8VPH5eLPJnaa3Bn6B/c0EmT5nx/O2Fr2OtmGRX4n3X5R1tNs3Ifdef9A1ISYkmtYU1DbJUqefy2tzWQQpKtRpLI3gxdlRkOiLUvbT5IjckP2NRWQ7b+z9VSAWn6k1T37PFKEKJ8v3FT6dxWV+p1+uxn0tMG21cJLPOBE316RV7GWB2XlR5Bb0T5Uhtmto/YeLuDJK6Vdc9J1PhGfRuNG2r+BObPb8I8jD2XqFFDw==;5:dK8K9SZHrDwmLdm7q/d3o9u56QZEEZwgISWUNEblk78AekFZMIxikp74EZTWrBa35bTqq3kdLtK5fET1XKcXwTirXUtzLw9EwuzKl+oTEwEJhFl/KNmp6fhNJJHQViXT5wv1UvI+G3BeS6SFshTwyhdHoRJOiEywWWBviCjw499PMIHG2XxRDFiHQwtSn+6rNWQ39Kato3gkHw95G4/4kw==;7:CsaPKakG7Vn0pKOTo7Fa7BblF8lDwfi0IL4Idpk8ENrN8eDcIjnqYCkqCfMhHgOtSD7GdewTgv8ipnno6Bc42pka8O3+cgMerLTQg3RJVD8bHTvoYHhP4Gs69x3pLxecf+bp5O+M0xXgFda6f3ZPBQ==
x-ms-office365-filtering-correlation-id: c8dc2dfb-19ca-4082-fa3f-08d67dab1623
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0837;
x-ms-traffictypediagnostic: CY4PR21MB0837:
x-ms-exchange-purlcount: -3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB083763E5543DB9B906FF63B3D79D0@CY4PR21MB0837.namprd21.prod.outlook.com>
x-forefront-prvs: 09222B39F5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(376002)(366004)(39860400002)(189003)(199004)(186003)(46003)(2906002)(6506007)(486006)(105586002)(71200400001)(110136005)(74316002)(316002)(478600001)(14444005)(25786009)(10290500003)(86362001)(7736002)(54906003)(256004)(2501003)(446003)(71190400001)(97736004)(106356001)(6346003)(11346002)(476003)(305945005)(9686003)(76176011)(86612001)(53936002)(8936002)(81156014)(102836004)(229853002)(55016002)(99286004)(81166006)(6436002)(6246003)(5660300001)(14454004)(4744005)(22452003)(68736007)(8676002)(6116002)(1511001)(33656002)(10090500001)(8990500004)(7696005)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0837;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XkdnzmC1GQvHHtTFt0Qkeo9O/JAsJSj89MEo7tnE/T7TpOlAmTcXXg5Yt68VDFoNZysw9JxNmIl/2aD8Ur7P2PJsb08BhQNvsn/KIZqFiLJGn93s719Yn8WNg+cZ+TlXP4/qm/0kLUK7RyUAaEDISBN3ZfOx96LQS0awR93kIxuXBJi9RhFpmfOAXFmDZ33svPvezOYw+furtncLN4JaTtAPkXR8Ow4Py2XAPuKXYm6KrN9ptSJD/2u/L+tfwH4kr+oriCAHZjHoHxzK+wmTWzHxbBeEkVXSWkp/T2K2oTsXG80/fJkFetB61R61xEGJRz7kvKeZzSW/b8sHlzkapAMzLxqwZ/EnZsFzaVpw7BhFT4lcb4GI+f7sz2EZ8XH6C5qm6sqtFjG5//r19GbVsWEMC7cEWUQK71VPD/SEk1Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8dc2dfb-19ca-4082-fa3f-08d67dab1623
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2019 01:11:48.2338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>  Sent: Monday, January 14, 201=
9 4:52 PM
>=20
> Hyper-V hosts require us to disable RSS before changing RSS key,
> otherwise the changing request will fail. This patch fixes the
> coding error.
>=20
> Fixes: ff4a44199012 ("netvsc: allow get/set of RSS indirection table")
> Reported-by: Wei Hu <weh@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/net/hyperv/rndis_filter.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>=20
Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
