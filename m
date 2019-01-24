Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3818DC282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E442D2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kRShINm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfAXCkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 21:40:03 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:42160 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbfAXCkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 21:40:03 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c49257f0000>; Thu, 24 Jan 2019 10:39:59 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 23 Jan 2019 18:39:59 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 23 Jan 2019 18:39:59 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Jan
 2019 02:39:58 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (104.47.41.57) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Thu, 24 Jan 2019 02:39:57 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3414.namprd12.prod.outlook.com (20.178.196.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 24 Jan 2019 02:39:54 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064%5]) with mapi id 15.20.1558.016; Thu, 24 Jan 2019
 02:39:54 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V1] i2c: tegra: Add DMA Support
Thread-Topic: [PATCH V1] i2c: tegra: Add DMA Support
Thread-Index: AQHUrQSOLXC14Is8LEKiEDfaAG100aW5kSYAgAQvlIA=
Date:   Thu, 24 Jan 2019 02:39:54 +0000
Message-ID: <BYAPR12MB3398E0C5EE66FDE8F0813847C29A0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1547578806-17923-1-git-send-email-skomatineni@nvidia.com>
 <20190121103932.GB16756@ulmo>
In-Reply-To: <20190121103932.GB16756@ulmo>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3414;6:3ObqbdiJe9tW4KdidGJ+6S9odnxsUP2gYsgB/5oZIHajdPM+Tnm0tmTdeIu1VuQ3UMtZAP6XQizPZFNRrxJnPJlnX37/aHqzwRvxr3bn+T9S2Nb68d/hhZ1W/zVtFbQeiuoii9mQYRwzAYZQ6S+I+7PkWNf+I/8sbuARH/GWXfIKkrguuuLTLTnmbivpVr50UPfENt1nwCt5tV/j1ch+nsLYR6tdf0egzcna6TfElIzFDPGKo2z852FjKM5UI9CqCYVur1k33CTRmT1J7TqWQmt36LIeZT3RUkTmAbr3uUi5dLxHhfTOptpJSbkdmOnnzcma9pLR+BXxK2GwICosoYCzbxFKaQdlJAePyT5nZr62/rxKpUpFY02MU1L7Ge9zsoCKgL9PcNsngJOPsbScrSVOV648+V1JUmlSsqLlS6opNUL8g0ZEGWfaUspjLVZBRa6qU2HXpxlZ7itpr7Staw==;5:p+5QCAeD/Jbx5yKLHDIfpjdJAMe2cLpmNGsM+bedw7sK4mNIL1U7FjFm/M3MiyB5Go/SZ56tNHlg68TBg2LwO0ycRgrZqLrKLfqdCokfsclpRqFLLZ514CkyCJlCiZaIELKe0IaJ32UNTmNrBcayUP2g+25L6P40e/iB+ZaJIUJlcTEdelgjGEh6c45gzJhNnmsp45wY07WngBCLu1qpfg==;7:Ax2NHV2JVxpHK+6Y6fs6cMT3XheNuoKk2+RsoUQFp05AgJiN2Pb5RpetWko47bNAkPTUSAobS+3h32BeKputLx723DaK5ykm4hU4BogU0hwTBmksqZ9P90BiS3aLRvsJIqd6Bh+8bSHhYKHQwILRsQ==
x-ms-office365-filtering-correlation-id: a03f46c5-98df-4095-5614-08d681a53945
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3414;
x-ms-traffictypediagnostic: BYAPR12MB3414:
x-microsoft-antispam-prvs: <BYAPR12MB34149EBD98A7C2A5B9C43758C29A0@BYAPR12MB3414.namprd12.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(43544003)(54906003)(81166006)(106356001)(3846002)(68736007)(105586002)(8936002)(316002)(81156014)(8676002)(186003)(39060400002)(6916009)(74316002)(6246003)(6116002)(9686003)(256004)(14444005)(25786009)(53936002)(486006)(4326008)(71200400001)(71190400001)(102836004)(476003)(7696005)(11346002)(305945005)(99286004)(7736002)(446003)(33656002)(66066001)(14454004)(6436002)(6506007)(86362001)(76176011)(55016002)(229853002)(2906002)(26005)(97736004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3414;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: f+aizFQ/Cvg/Toiw3Ikr9US3XyJl3hVYJeO6l4AKJvYVpXyO4+YXzTbzxHv1It+C/8q/fLtotODUW6DiRc7NPel98K4K+BniQFHfwNcdpqUKDQ2PG3YD8SF6A8NfQfi+ysLC71/mQrpYf4weYbrVHad63HmW5pwdlSm/3N3U0Eobipr6XP+hyFL43/+sVPT5nHuJCVZJLAE9ggP80QITDJe0BxV9WBXfdjrplGivejbP72EdUyggvUJT4l2yL21yx/D6GywQvJ0sWpnExDEtliyrDCDSdmTNobgqOk+Ii7rsspgIjYcRCPTKahzI0TwLdK9LcZykLbMthvY5W6iP1qrgeydgGbPS/aBoEhMY1cWkkPGXTmPDUs88z52KNNZgeicPu7eDRSghTnRdvWSqFQxpJbLBI0hsnV9SUvgQZYw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a03f46c5-98df-4095-5614-08d681a53945
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 02:39:54.8775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3414
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548297599; bh=yEDMBaPaKnnzSvU7/DYKL8eOSmk6mqglh7HJMniyXMY=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         spamdiagnosticoutput:spamdiagnosticmetadata:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=kRShINm4vzkoMbse1WTZrzu4OyPlXQ5w9j3UJb7/5pliQxx6ixl6jzxgY/u/WFQ3P
         S0m1+8lzp0sEfLe/qAGkRS06ssJCe6Q06MCv5j8fMfDqM8d6i22yZzM5hXViwL37QP
         wx/muJl8idQ7YVXMQ0wlhTN+XBCYwgfBdOgXnnxfKy6BOLatDI26zjB05h6JsF5Qtd
         3a3/FbHR+rAPfd61muv7M77otWI3Z1fKCA3lUYd8FBabzQQUnk8BcTrIjS+c6STBtb
         57IFOFlfeQvwatDuYBSHj02lCn0ofqoxP7fX2/q/mzF75mhZkYY7r4JUfDoW1oeSxY
         xRbxxCbYn/ElQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> > This patch adds DMA support for Tegra I2C.
>
> In the subject: "Support" -> "support". And in the commit description per=
haps add some more details about why this is useful, maybe accompany with s=
ome performance numbers (if > you can come up with any) or describe why the=
re's a threshold for PIO vs. DMA transfers.
>
> As it is, it's not immediately clear why we need or want these 400+ extra=
 lines of code.
>
> > Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> > ---
> >  drivers/i2c/busses/i2c-tegra.c | 494=20
> > +++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 456 insertions(+), 38 deletions(-)
> >=20
>
>
> > @@ -658,7 +809,16 @@ static irqreturn_t tegra_i2c_isr(int irq, void *de=
v_id)
> >  	if (i2c_dev->is_dvc)
> >  		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
> > =20
> > -	if (status & I2C_INT_PACKET_XFER_COMPLETE) {
> > +	if (status & I2C_INT_ALL_PACKETS_XFER_COMPLETE) {
> > +		if (i2c_dev->is_curr_dma_xfer)
> > +			i2c_dev->msg_buf_remaining =3D 0;
>
> Why are we forcing msg_buf_remaining to 0 here and below? Doesn't the res=
t of the code take care of that already? Is it always guaranteed that all b=
ytes will have been transferred in > DMA mode?

During the write (Memory to TX FIFO thru DMA), DMA completion happens prior=
 to XFER_PACKET_COMPLETE INT from I2C
During the read (RX_FIFO to Memory thru DMA), XFER_PACKET_COMPLETE I2C INT =
gets generated prior to DMA Completion
Receiving XFER_PACKET_COMPLETE interrupts from I2C confirms successful I2C =
transfer, so In DMA Mode, msg_buf_remaining is forced to 0

DMA callback notification happens only on successful transfer of all bytes.
In case of incomplete transfer by DMA, call back notification will not be g=
enerated and DMA timeouts.
Also, DMA timeout is verified prior to msg_complete timeout.
=20
Thanks
Sowjanya
