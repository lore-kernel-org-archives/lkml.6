Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF59C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6DF20823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UrKLo599"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6DF20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbeJ3VwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 17:52:04 -0400
Received: from mail-eopbgr710056.outbound.protection.outlook.com ([40.107.71.56]:30816
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727759AbeJ3VwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 17:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFbi8pKmhABnLANmGrKw9LxXbnl3/V4M4bgnBQ5ydTE=;
 b=UrKLo599edSsV0qCCTchbfqLqeGLZTRjpKV5tTum9B1C6mSFrrCrMzjC/cFaruGoV54yZYvHTUeNC84AguF9kjmj4geBO3D7SDK1jTeZaRJ5I5OgDWKygPR0IrkIK/cjgdWQGPbcheFMLcOf4rsqZhbgdisOE/3WwSAY5IoCpAk=
Received: from SN4PR0201MB3630.namprd02.prod.outlook.com (10.167.129.156) by
 SN4PR0201MB3503.namprd02.prod.outlook.com (10.167.129.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Tue, 30 Oct 2018 12:58:38 +0000
Received: from SN4PR0201MB3630.namprd02.prod.outlook.com
 ([fe80::1523:7f43:9e90:e694]) by SN4PR0201MB3630.namprd02.prod.outlook.com
 ([fe80::1523:7f43:9e90:e694%4]) with mapi id 15.20.1273.027; Tue, 30 Oct 2018
 12:58:34 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Andrew Lunn <andrew@lunn.ch>, Kurt Kanzenbach <kurt@linutronix.de>
CC:     Anirudha Sarangi <anirudh@xilinx.com>,
        John Linn <linnj@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michals@xilinx.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] net: xilinx_emaclite: recheck condition after timeout
 in mdio_wait()
Thread-Topic: [PATCH 2/2] net: xilinx_emaclite: recheck condition after
 timeout in mdio_wait()
Thread-Index: AQHUcDNk69Ux0mxAzEWr6CP+xgELPqU3srMAgAAFj/A=
Date:   Tue, 30 Oct 2018 12:58:33 +0000
Message-ID: <SN4PR0201MB36306924359BB3A8BD5F19D7C7CC0@SN4PR0201MB3630.namprd02.prod.outlook.com>
References: <20181030093139.10226-1-kurt@linutronix.de>
 <20181030093139.10226-3-kurt@linutronix.de> <20181030121030.GD27873@lunn.ch>
In-Reply-To: <20181030121030.GD27873@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN4PR0201MB3503;6:htEBMgzPpUsAeunIzHXyXInM4sAK1xmfALSX+CMXrNBQj0a+74qBlGRF08nPLUMtX2FoCNvphP9hgk14Of6WPlLozBnwg+qAodDD6u+RZyJZU98PmDR9wdJPkYLJuycGsGZ++w2fDn21pv5dbqfzAkNeAD/sBtxJH5EIZtKKIpwUnPWK10ZAXYrH0mb9LuFuxVkjkuYsI/QQlWKsDr/f+pl9G+YvjNX0Gn8oZ3vo2ffOLbOKucckgfl8QOu1w2gauwMb6vxm/aLxsRL5QbDcWdm1P28/uLhu2u7xKw+mc8zvZNYK4JZ3dE0birub4VgiNd4ilaGsDi8+tjnWh/lOEiLxypD9l2c/+D28+fXBbeHyxxOld00a7iZs3sBSYxEhJ7WtiG40+8Bi3vQYvMJyiqFVtlA3R9iZ35jmsJ1vxIgu6Jd8H2MbAHObJCkle2qvidqKoy/Icig+JB5FzBN4Bw==;5:HcIRYDeKAIiHFwR+LmhcR9y8HHdSx8r0f2b/4xvbWNFONAEd2gC7IsffFQoZqSdNBAsU/fObrAQXgsyz0WGV0d3jm6inEP6SQlp7HztRrMJXxyhQXFI8QMmbbDai/QNHE2ARUEX8/aP9bL+hxBX03uWE7vbwtJOPEr9ll6X3CwU=;7:Cs5b0HHxyht6VLFhMz2CzmVqdkJ38STzAFyUyNSw20s0H8fnjDwpvX1lFwMf4Y+m7RV7L6JGJGPe/ri6wlLhqZWMCQ9BEa25T+ReRAaOOqRPlHnx6IgXmX5CrpFwyP5UI6+Wj3kr2C2QdkbTlc6R6Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(366004)(199004)(189003)(5250100002)(4326008)(7736002)(86362001)(74316002)(97736004)(105586002)(81166006)(54906003)(7696005)(14454004)(106356001)(8676002)(8936002)(110136005)(76176011)(316002)(478600001)(99286004)(2900100001)(53936002)(71190400001)(6436002)(55016002)(81156014)(25786009)(5660300001)(6506007)(186003)(256004)(71200400001)(2906002)(33656002)(3846002)(486006)(446003)(26005)(6246003)(476003)(6116002)(11346002)(305945005)(102836004)(66066001)(229853002)(68736007)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3503;H:SN4PR0201MB3630.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 14671e62-a46d-447d-0be6-08d63e676690
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN4PR0201MB3503;
x-ms-traffictypediagnostic: SN4PR0201MB3503:
x-microsoft-antispam-prvs: <SN4PR0201MB35034FFEB674E960388A7863C7CC0@SN4PR0201MB3503.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN4PR0201MB3503;BCL:0;PCL:0;RULEID:;SRVR:SN4PR0201MB3503;
x-forefront-prvs: 08417837C5
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PPX+Nx7lFi1/GB0wcOVKEArdOTcwrsLUoO9wgt0NiNPs0VaGczDPmdidzEz7Ammp0fEYSeSJogEDeu17L2d5Yb1fVFdQuLB9/tp/QiGQtd3JlpPxmoox5mshObOWZW+o7T8r/ILNCAqCHQfrtHo256KAELZz3EKWG+HI3NtmShbsoVWac7I/e1zb/SX9VSiiRMxvHzJIIiFzQmF4JYAHJD/66yX1p7i3CPacM7D3cnphZx6ZO7q0xlER1lov6TGQeH8C1gVDWpfaUj//6KfHbFkyuOTv/bNOCQMkevMnOVymkJodUy6yCELUUlYLWDhbz5S9Clw7FWsEPzp2vWhI3zVpoFuYB+6++I+E6ZCBE78=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14671e62-a46d-447d-0be6-08d63e676690
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2018 12:58:34.0922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
>=20
> On Tue, Oct 30, 2018 at 10:31:39AM +0100, Kurt Kanzenbach wrote:
> > The function could report a false positive if it gets preempted between
> reading
> > the XEL_MDIOCTRL_OFFSET register and checking for the timeout.  In such=
 a
> case,
> > the condition has to be rechecked to avoid false positives.
> >
> > Therefore, check for expected condition even after the timeout occurred=
.
> >
> > Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> > ---
> >  drivers/net/ethernet/xilinx/xilinx_emaclite.c | 20 +++++++++++++++----=
-
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> > index 639e3e99af46..957d03085bd0 100644
> > --- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> > +++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> > @@ -714,19 +714,29 @@ static irqreturn_t xemaclite_interrupt(int irq, v=
oid
> *dev_id)
> >  static int xemaclite_mdio_wait(struct net_local *lp)
> >  {
> >  	unsigned long end =3D jiffies + 2;
> > +	u32 val;
> >
> >  	/* wait for the MDIO interface to not be busy or timeout
> >  	 * after some time.
> >  	 */
> > -	while (xemaclite_readl(lp->base_addr + XEL_MDIOCTRL_OFFSET) &
> > -			XEL_MDIOCTRL_MDIOSTS_MASK) {
> > +	while (1) {
> > +		val =3D xemaclite_readl(lp->base_addr +
> XEL_MDIOCTRL_OFFSET);
>=20
> Hi Kurt
>=20
> It looks like readx_poll_timeout() should work here.

Yes, valid point. readx_poll_timeout API repoll addr after timeout.
Reusing it would simplify the flow.

>=20
>    Andrew
