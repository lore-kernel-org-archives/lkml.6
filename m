Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB27DC5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E5D20862
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="i4HxwCjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E5D20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932850AbeGJCJK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 22:09:10 -0400
Received: from mail-cys01nam02on0081.outbound.protection.outlook.com ([104.47.37.81]:62717
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754450AbeGJCJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 22:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBCGIyjNlIAMDVQ7ozPJCiVsDf+ttc7rx//gnH1tgdU=;
 b=i4HxwCjc1WyCi/nr4oNCKqmvbMLNMKt+tt9js77QfHZjSITH/MKUgdfKtGqT1Xx3w7Hzi3FFTu7gBitucrMKZ58OEgMALy5HSRvMgnlTv5bb8G7/dnL0ZwhQRAs5OSeUkmTmNk0OLzrqEr64wYgFfcz3P3r9QWxKDDAoWCxfTjI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BN6PR03MB2625.namprd03.prod.outlook.com (2603:10b6:404:59::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Tue, 10 Jul 2018 02:08:59 +0000
Date:   Tue, 10 Jul 2018 10:07:04 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] serial: 8250_dw: add fractional divisor support
Message-ID: <20180710100704.236d256c@xhacker.debian>
In-Reply-To: <20180709163241.4d4ee343@xhacker.debian>
References: <20180709160942.11a74f7a@xhacker.debian>
        <20180709162315.7f53eb9a@xhacker.debian>
        <20180709163241.4d4ee343@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: PR0P264CA0037.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::25) To BN6PR03MB2625.namprd03.prod.outlook.com
 (2603:10b6:404:59::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39e6336d-af32-452b-8113-08d5e60a1af9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2625;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;3:8UHyzcmsPzXYS0C7tblnyJrIb+FbedqMscvUs0gUV+FPRPvRAxfHh9BgRTxBu14egyxMgLZ5mmV7H/deLRldbgrWrMCKCpl2vZ2AESLiQ//Bxp4xNaMIyXTM+GyD1tgWgQqrA1lKV3nRePmC6iNQg2wzKudDNsb9WsGS9qvseBbRSO/iyTO8NcK2VVgrwn/n7uVada5L3uizlPEn0z3FZH09HUvXHVNh0JxhpEpNiDEjICJISEaYVDJcFUuoM6D3;25:BphHRxgckuXhJZ/F6SE65xlMd4auFoQIHXxqjVz8NxU5/pc/zo49Pf3kdbIxnWAaa5o8tpezGN5tDXgdpA8dFxADQ5v32WuxZ3UDeOa8z2eAEWrnbbRBNzOvAdycFMV/2vAW/pmyKJtUKqhW5S18A4BB6shqBazITw36xMkOk9odhh3Kn5xODqtgDR2Y9PiK8z15om0OwhB5B0c8AiWyAzWd1ckiKjlXzNdZpD3/QzxFYafmchX3/VlqjohHa8BfQx3dTQtVjoVKakvZKHgsOtBMeGal6EdkjHrdHd0nV8qglKV32ArI9HtB0ogEXX/RHwsDnOQt5/WumYqAT9sp7g==;31:DJuHfAoPKPBXXseq4uDH1oaSPi/0G2j4V0UG4bxww8OSgoVbMrB1fBGg528PP0+llftJ1W5QSIDl3RRAbcDHz573abGsketCdggCi6/zYB9902kRtd29WOnemNQjM0axoDUqG2nl1gKXOxOWcxORW96VdQ8NXDLd0O67K8hKqaYm2t7zXYnlwSfoVbGNXMK4nzetvSfEO0vrm9TgctoWW5/2yVKhfYFXMdIRpyk1UrI=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2625:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;20:6MvX8/I33lLNYoaE/K0OU4A2yK+MlxaRnCAFYfks6M/XgM7JXCwziYfIaobcYnVIwUo3/NYQHf6SZWp97ZW5rsY48l04Kli4+RyAMwczi/NPb2lYszFh2XZdFdxyJ+2N18BIJEFzfZooKxa/hOocQRC14s1Pjh3UHxPO4UBg2pK4GoDnM248zuO4TNfSfFDn6Th+a9dTZjGG1xUEZPnx4R6v7GMyb3r4fpIYfYebb9KABBPePqQ4sYhZ8RLjBhcTeT2YAwJHY94aAD5ffPdoBbFt0WdTLP9OYwi1Te5mv4rkcLH9yzlIzf6a42ITwjV3yMUEFB+6+iRWpi/MOhAI8lhW9/AJ2RKcZLMFCljjwWbZRQ7IUS1HDns2Zt8lLZhwBUaQd9wPhfOP2ya9GQ/IxieeqqmGLeKyNYNSIFUITg6l8A9z1mJeT9JK8wOlYXyyHTNM5lrOxHLE2ztvVIE2QoibDOcoio//mCk1xdZFHWr3pP8V/2MklYjA4xROXu8G;4:lxDaitzSfSGsKkiChgfQS8yQUHrkc2rAjKagZ307hC4r0AE2F5fesoXw4u0MEaQDfZgR5L7G0pKItIDghj7Ioeu3f1xmOnyJwRBSwBtSBq++m8TrPP/L15htxvvamidU5yUJ3zvUvLgSN3ttwdXRt7Tkxi98zI4yytyjm9FRCOUJ4aCd87VeFaz+bGN3EDDlU893V5TKEH1b3G4kj9S3zTBv37jNRQx3k9U1a1ShQQVFiweKoAxFpI9tK0fDyvM2IU1rq6MkszwZgCxiuZqd5A==
X-Microsoft-Antispam-PRVS: <BN6PR03MB26257BF90D1E6055C35ED18CED5B0@BN6PR03MB2625.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN6PR03MB2625;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2625;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(136003)(396003)(189003)(199004)(66066001)(68736007)(72206003)(478600001)(4326008)(2906002)(26005)(6116002)(47776003)(316002)(25786009)(16526019)(186003)(3846002)(50226002)(7696005)(23726003)(1076002)(52116002)(486006)(956004)(476003)(106356001)(105586002)(110136005)(81166006)(53936002)(6666003)(54906003)(76176011)(33896004)(86362001)(97736004)(50466002)(8936002)(5660300001)(386003)(6246003)(55016002)(9686003)(229853002)(14444005)(446003)(8746002)(305945005)(6506007)(8676002)(7736002)(81156014)(11346002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2625;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2625;23:j0V1tNw6ZbXMQhEEba1ugiWkiRqBDlvrj9iruOKZQ?=
 =?us-ascii?Q?f7RS1gAuS37+p98AtThsctMkXxF4H56zGTjKJEhlr7/JJPLTozXympYKBxPs?=
 =?us-ascii?Q?72bxhucZhni8Ez5taOkKcMaJROtoONxInzOTMleiQr5EkWuYbfopOo8mXPfm?=
 =?us-ascii?Q?a3IlO8fWYqxZkORzXqR4LbXALwiSlDudXU3cZcKA8iNfNW8jLwCeigkbmzcJ?=
 =?us-ascii?Q?h8FQ/y9kZcp6k1sxM+3rj0rPQgcSPdLavr5zL+w24NZQx5Rpa+Am3N44GJab?=
 =?us-ascii?Q?Uv85U2sE/TOfyvLqLfK3Qlh/C6aXwqz4CTSPBdju6KAF8mUBruthN+rBTH35?=
 =?us-ascii?Q?MNQxws0FOET3YeflBVrj4/QB/C5XHpwK7EaN5jYKjXMrShRoYs4xD4uQYDmx?=
 =?us-ascii?Q?MFBFGC6jRp6k/+YCMeGKTq8lsmeM8ndiu1XJsobalYsQLgl2EiGC2tVC9SeB?=
 =?us-ascii?Q?pmVelt0KlSmyp1VUpDFlXMrRS0JTUftPWFUEQtm+Kbf+1B8eAePPYTwy35qR?=
 =?us-ascii?Q?kqLhuGdiA9Brxz5tUQFv4fvI53ptVzGqlX2210UyTGHOoaFCt6lfFJgo1/HQ?=
 =?us-ascii?Q?Uhqx//6igglDTkQ8i3mBbj0bu9zRlqzWn6/9sJwvjbD6dTo0CtiqhMDAluix?=
 =?us-ascii?Q?6gKtLwL4zeq73iDr9ykHDIRp3Hxs0hYcE8b8xILLxgO4WdKj/0erK+q7a2EE?=
 =?us-ascii?Q?8Kr/9i2iO8F2/tXl2s63bJvScNsxDRknfbdJZNcqgFtNcZzEyzSFqNJAJcsL?=
 =?us-ascii?Q?I1/qw3S+HZGgRLWthcHE/67SZlhI54lgmbrfgpPRMZL0+UbJzOUbFz6Xurni?=
 =?us-ascii?Q?8Ox3CCJMH4HeQXos+q0HFHzLM/0+4bRq/qVcAKggq+qh7boO+SS8fakc2IWY?=
 =?us-ascii?Q?66hQmq0ns7kmMZSO4cseFzuv6/M0GLqektxX3tfoLwSDOk6FmAW70CNgKUPV?=
 =?us-ascii?Q?SlPiWCdPI6OQrg7mbIqwQfRM5FOmhVvQJxZugRo2v+YgoJsBF305UyUQt+Kd?=
 =?us-ascii?Q?tedN1PcZjpf2NRCqd/3/JtSL6B8mfOwcjraDZg/Cmil64wcFE02biNTgboui?=
 =?us-ascii?Q?ClRJcUnJFYcErS0jUTZJJsGnZo05iaK0errKgEGoLzigbPRKsTWaGEtYv69E?=
 =?us-ascii?Q?Kc7CuD1BnqTrcxEZXAAnj3/xX6pJoKHpAFKKHd/oLNbg1lbdTJbHjgS7AU58?=
 =?us-ascii?Q?GGJPqXvM14nxkrX3qcWd/n2oyenaf1D6sFICgg29kHpvrVrtBsQEiID1M8jp?=
 =?us-ascii?Q?4sjlKNB8l6htfmVF9Hdj1BR4BaO7fEjKoyojTkCxQjOZsns+dbgX8hffVJ9u?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: LgNXKSI/KpURWzoHgXaeZtteRas5ELL0TpN81cZJmalOUmvfnV/8W66Slbxgfckex06Q5PUnlwImu2nTphVwM3mc+/P1jRRpwxO+AGi9kywDviNHSMljB9bZiXNZCoJcChdLYL/gwg5ZkWpMnsl1qkXJ9fuhTVIF9d//M2m78Ocj1O649Y0QSjzfP6hjr8ECTKWGN9omikNlmpvS4uxSrO88pAHM2ufTCbgxKqXaKrringM+AXKu6vXLwsPwjyRSktB6idcHGJ5gk0RXS7slAexpBX/8do/K4lkNmuH4SX+cNdaP2qjKLS/c69SWe+Jlq51av5tbE+TCFCVRkERFvZM6gKFPOXsGt1eTxlbvCNo=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;6:GbSU45e584mFvNH3Ds9Usw+nT4Wut4paNy6nDpbJVjWkhEpLZip/vjFpsvQ4VqoHGvaPw68rkYzDBpgiqM8NGCcMjHr3RZabXuXtnx+/p68SfSJeuEJqjuergkWOtbJ6VavYebIrlx5erfFq16i6aLrH4Z6GTY+xJbOhYb6/WaUoo+1fcTAQzzpfS4BDavSpPdDhxo2ihGggcUvsYiFp4cMo0Rxe3e7+Z588mlHWAjxiCbwbY+iW1VKSlkffgUfOICNBngGLaCjaSMKab984I1RI+fWs2erciKP9/FIDoa0JZbjLTSY6uOONG/UzRak2lXZDsN7p7RJh0kLTiig8moViM2lgKKbqmIE7Q5S4iPgXulfEQoa5ozyFogcQR4Gvqnwo10G99bwrYhHtifSVH6zvWPXR9LYKtPuxAzPeoQFfhG1hGTn9+tUzRrWHiL57CFFJl46VTzigJd1pYW4g/A==;5:jen7hI/CLleJMag/SY3GllielPy093IuIToAm+mtniENd7+OCZo10vF+BaKRWH9+Oiu0D/8+QMJOpxK0KG2GOqOuMN6gQlsi7Iw22gP7xNVRCBmxuw4nFwqur+AQv/dEGQMsDHOLB5fWT/C1sZMRDmtJ+ZG9uWp80ZeysRSPwv0=;24:p/TF2sC3FPW0CHgerRuv4Uz/OAGxRw9tr+rAPucrESGKQR8OwXcL3+NnZ8wNS3hnTXuIuXQXzrNXC4lyLM/gSwzciPCSEwMh4Gqrmw03p1I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;7:GG+uuMT1b90ws6Czcv4n5WO5yNUznbU38aiL6D5mqyH8Rry1PedMc1YQ5nmlopCqXgzYxZwrggMeuyeoRhDFHhmNojySVn4MTw1Ja2zF71V2XTRj/swWA9wcJFai72DbWkm1QR51PWw7YaJN3ukwLlb78tF9YtP1idODJDGR2ZEIdMJ+lJeRywYzoAA6LoAvcJdSUPcRNv9vQInLjnPOaeSBFyfCmPLryghH35k7KvxcUvSW3N3vYHs/UlsW4KtY
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 02:08:59.5203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e6336d-af32-452b-8113-08d5e60a1af9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2625
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, 9 Jul 2018 16:32:41 +0800 Jisheng Zhang wrote:

> Hi Andy,
>=20
> On Mon, 9 Jul 2018 16:23:15 +0800 Jisheng Zhang wrote:
>=20
> > For Synopsys DesignWare 8250 uart which version >=3D 4.00a, there's a
> > valid divisor latch fraction register. The fractional divisor width is
> > 4bits ~ 6bits.
> >=20
> > Now the preparation is done, it's easy to add the feature support.
> > This patch firstly tries to get the fractional divisor width during
> > probe, then setups dw specific get_divisor() and set_divisor() hook.
> >=20
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  drivers/tty/serial/8250/8250_dw.c | 45 +++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >=20
> > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/825=
0/8250_dw.c
> > index fa8a00e8c9c6..e90c3d229f00 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -31,6 +31,7 @@
> > =20
> >  /* Offsets for the DesignWare specific registers */
> >  #define DW_UART_USR	0x1f /* UART Status Register */
> > +#define DW_UART_DLF	0xc0 /* Divisor Latch Fraction Register */
> >  #define DW_UART_CPR	0xf4 /* Component Parameter Register */
> >  #define DW_UART_UCV	0xf8 /* UART Component Version */
> > =20
> > @@ -55,6 +56,7 @@
> > =20
> >  struct dw8250_data {
> >  	u8			usr_reg;
> > +	u8			dlf_size;
> >  	int			line;
> >  	int			msr_mask_on;
> >  	int			msr_mask_off;
> > @@ -366,6 +368,37 @@ static bool dw8250_idma_filter(struct dma_chan *ch=
an, void *param)
> >  	return param =3D=3D chan->device->dev->parent;
> >  }
> > =20
> > +/*
> > + * divisor =3D clk / (16 * baud) =3D div(I) + div(F)
> > + * "I" means integer, "F" means fractional
> > + *
> > + * 2^dlf_size * clk / (16 * baud) =3D 2^dlf_size * (div(I) + div(F))
> > + * so, (clk << (dlf_siz - 4)) / baud =3D (div(I) + div(F)) << dlf_size
> > + *
> > + * let quot =3D DIV_ROUND_CLOSEST(clk << (dlf_size - 4), baud), we get
> > + * div(I) =3D quot >> dlf_size
> > + * div(F) =3D quot & dlf_mask, where dlf_mask =3D GENMASK(dlf_size - 1=
, 0)
> > + */
> > +static unsigned int dw8250_get_divisor(struct uart_port *p,
> > +				       unsigned int baud,
> > +				       unsigned int *frac)
> > +{
> > +	unsigned int quot;
> > +	struct dw8250_data *d =3D p->private_data;
> > +
> > +	quot =3D DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4), baud);
> > +	*frac =3D quot & GENMASK(d->dlf_size - 1, 0);
> > +
> > +	return quot >> d->dlf_size; =20
>=20
> After more consideration, I sent out this version for the following two
> points:
>=20
> 1. the max frac divisor width is 6bits now, but we dunno whether future IP
> extends it or not. This patch version can still support > 6bits width exc=
ept
> the overflow concern. But fixing overflow(if there is) is as simple as us=
ing\
> the DIV_ROUND_CLOSEST_ULL macro.
>=20
> 2. this version makes use of well implemented GENMASK to get the dlf_mask,
> the micro is well understood, I think. so the code is simplified as well.
>=20
> 3. the magic "4" is explained in the comments, I hope it could help the
> code.

I agree with your "making the code simple" concern. So I have a considerati=
on
again. I think I made the code complex unnecessarily, the simplest get_divi=
sor code
could be:

get_divisor()
{
	unsigned int quot, rem;

	quot =3D clk / (16 * baud);
	rem =3D clk % (16 *baud);
	*frac =3D DIV_ROUND_CLOSEST(rem << dlf_size, 16*baud);

	return quot;
}

Compared with previous version, this one adds one more div instruction,
but remove several "shift, and" instructions, the performance isn't that ba=
d.
=46rom another side, even this version gets a trivial performance regression,
the get_divisor() doesn't sit on the hot code path. Making the code simpler=
 is
more important.

I will send a new version.

Thanks
