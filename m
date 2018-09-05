Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A91CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E205D2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rAGyf8KC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E205D2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbeIEFsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 01:48:18 -0400
Received: from mail-db5eur01on0050.outbound.protection.outlook.com ([104.47.2.50]:35584
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbeIEFsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 01:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOzJdybAygc5sgpZvEl4mrUuI9Bz1LjJQm93d1xdWT8=;
 b=rAGyf8KCxHg/1pRyTP6M4Pye7sFumy+GZEsfwUlSrPYOd/FaQHHQl2lu8lrxNPUlEhV2oh3rOg+WEIlz5o1GNPgpgbbnHNp3ZwVE1NJlRrKkSu0T4iR0pY3zsAGkuFkVc3lIhi8ef+16PaEOKkT8nJdGR46XcZxKNO6Zj4jZBkg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.71.159) by
 DB3PR0402MB3705.eurprd04.prod.outlook.com (52.134.70.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Wed, 5 Sep 2018 01:20:32 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1c65:743b:56d0:5aa2]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1c65:743b:56d0:5aa2%4]) with mapi id 15.20.1101.016; Wed, 5 Sep 2018
 01:20:32 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] tty: serial: imx: add lock for registers save/restore
Thread-Topic: [PATCH 1/2] tty: serial: imx: add lock for registers
 save/restore
Thread-Index: AQHUL8ku3TsrhHE5VEGNDUadzR95naTgvR2AgABP1fA=
Date:   Wed, 5 Sep 2018 01:20:32 +0000
Message-ID: <DB3PR0402MB3916F184893B6C6D2881F4EFF5020@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1533809169-24133-1-git-send-email-Anson.Huang@nxp.com>
 <20180904203205.yboqvzkkrm6g7go5@pengutronix.de>
In-Reply-To: <20180904203205.yboqvzkkrm6g7go5@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3705;6:3VEqv5/CmqG9SYU27ekG8Pacboy+PO39BTTPW2bX8m2grqhLYHnEr56QCD//s+dOsVv630Q7JM9iXVhHux3MYSAc0hAFd5FPUNWOKycAkUQtxoiqxpGDLW4/Pz1CAfCgRwX3/IxYLLQVOxY07L2qxbExUumW9oBHMIsBnPMMQGo8qu7eTt+QX4/hXaJGnB0TdTF3muluoWE6gLRGYApjieqws7Tn1hobJ+dd0lqnhamJqcd7BXCPHYDxrVpxm8AnzyIQEIVl2D55pkW2z8+/6G40ZzzjfpRBNfr9TBJXcksSF4GSDFCpTzUiCOKSLApjjS6vnlu9nlOkOdkkSxTsGoUiV9HER0SXTybkDu4K1tqhQxYOlqhzo/PJxN+phDavr+JRG6/KfUiriIAXRvknynPFgYC3ylortqkBh7KZBGTQVXYtychbNwqTluWaOWmbc+dtp4tuDaBSr+H0Xr342w==;5:TXw/gZyVIstN4PA5O5mdp7NO+WL/5gLnnDR+/AKC3hM88sBbAOMCOYMXPYf2yderP375Tmot97ZMC1ixanFH8zta8pI35aSOpcv9W0k6YPWKRe4z/8SGcP6TkwTyC8J0O7SYF0NrhdyxHSxVnK367uNUZc9dpuQKgKTBDN26Ks8=;7:83aTmPcdTvk4kKCYSDWsbgmwodbkoYvK2dUgtlcpNccDxdE8PNeQ20RdZvug1Ue78+H5aQQIWiPfTh1Dfux0q0si62cmXjLLus/1j9urSeluLKo+2/lcNYGJvClyqqTFK+OlZKHfUglmDcyFjyh2pczQhcttXPXgGrzEh+fpHo/Z+cNbq4/RuQnpFy4KeTTX6OtntLLTUxbQKsRyWQS9a5F9ZtbIfnqpmQytIGuclqhf7sh8cX5YdM0n2p+SY+Ra
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 07facc54-064d-43cb-cf1c-08d612cdc626
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3705;
x-ms-traffictypediagnostic: DB3PR0402MB3705:
x-microsoft-antispam-prvs: <DB3PR0402MB3705536866E6F6903D1D38D4F5020@DB3PR0402MB3705.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(189930954265078)(185117386973197)(45079756050767)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699016);SRVR:DB3PR0402MB3705;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3705;
x-forefront-prvs: 078693968A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(366004)(39860400002)(376002)(13464003)(189003)(199004)(45080400002)(229853002)(14444005)(2900100001)(8676002)(33656002)(5250100002)(97736004)(256004)(6306002)(9686003)(6436002)(55016002)(53936002)(105586002)(106356001)(3846002)(6116002)(66066001)(6916009)(25786009)(6506007)(53546011)(476003)(6246003)(316002)(446003)(11346002)(8936002)(81166006)(44832011)(54906003)(26005)(81156014)(186003)(102836004)(4326008)(7696005)(76176011)(86362001)(575784001)(7736002)(68736007)(2906002)(74316002)(478600001)(305945005)(5660300001)(99286004)(14454004)(486006)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3705;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vA2hH561YUskgqTrvWq1sBrNKDowdifHSeKLfQxwPrM+oT/zDf9PvMoTgrrGwyRn9N5Jbag86GU5e+/MQgXw1XRYi0bhELJroM3SnSz1KVYtH9r+XvEKi55CAYx/sX6tYxVsJie1jme1DlR+d0tChSuGcdGC3uaxcjGfPiU164yx1AjFFUe8n8qzHTG6Y49L2uPXp6V0jfXxaI+4biYORRJbQtALJD8OXzhopEib4VmUgH9h+WGBLaWVTgWQ9WqU63zmFa/To7hGNRxWvAGE0c1kP8dEncadzoAC8WJp6fpJRJzH5vTpswwR7hbaXUceikVPOMzGV+cH7vOt4El/lJYZuq8B39POWg7OFB6viuM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07facc54-064d-43cb-cf1c-08d612cdc626
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2018 01:20:32.1219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3705
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Uwe

Anson Huang
Best Regards!


> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Wednesday, September 5, 2018 4:32 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: gregkh@linuxfoundation.org; jslaby@suse.com;
> linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: Re: [PATCH 1/2] tty: serial: imx: add lock for registers save/re=
store
>=20
> Hello,
>=20
> On Thu, Aug 09, 2018 at 06:06:08PM +0800, Anson Huang wrote:
> > In noirq suspend/resume stage with no_console_suspend enabled,
> > .imx_console_write() may be called to print out log_buf message by
> > .printk(), so there will be race condition between
> > .imx_console_write() and .serial_imx_save/restore_context(),
> > need to add lock to protect the registers save/restore operations.
>=20
> The function names changes some time ago. Also I'd drop the leading dots =
in
> the names which I would understand as members in a struct.
>=20
> Is this a theoretical issue, or did you see actual breakage?
=20
I will update the function name and remove the dots.

And we did see actual breakage during stress test, although the reproduce r=
ate
is NOT that high, but the issue came out and fixed by this patch.=20

>=20
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  drivers/tty/serial/imx.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c index
> > 239c0fa..a09ccef 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -2376,9 +2376,12 @@ static int imx_uart_remove(struct
> > platform_device *pdev)
> >
> >  static void imx_uart_restore_context(struct imx_port *sport)  {
> > +	unsigned long flags;
> > +
> >  	if (!sport->context_saved)
> >  		return;
>=20
> Is it safe to check .context_saved without holding the lock?
=20
Ah, my mistake, will put the check inside the lock. Please help
review V2 patch set, thanks.

Anson.

>=20
> > +	spin_lock_irqsave(&sport->port.lock, flags);
> >  	imx_uart_writel(sport, sport->saved_reg[4], UFCR);
> >  	imx_uart_writel(sport, sport->saved_reg[5], UESC);
> >  	imx_uart_writel(sport, sport->saved_reg[6], UTIM); @@ -2390,11
> > +2393,15 @@ static void imx_uart_restore_context(struct imx_port *sport=
)
> >  	imx_uart_writel(sport, sport->saved_reg[2], UCR3);
> >  	imx_uart_writel(sport, sport->saved_reg[3], UCR4);
> >  	sport->context_saved =3D false;
> > +	spin_unlock_irqrestore(&sport->port.lock, flags);
> >  }
> >
> >  static void imx_uart_save_context(struct imx_port *sport)  {
> > +	unsigned long flags;
> > +
> >  	/* Save necessary regs */
> > +	spin_lock_irqsave(&sport->port.lock, flags);
> >  	sport->saved_reg[0] =3D imx_uart_readl(sport, UCR1);
> >  	sport->saved_reg[1] =3D imx_uart_readl(sport, UCR2);
> >  	sport->saved_reg[2] =3D imx_uart_readl(sport, UCR3); @@ -2406,6
> > +2413,7 @@ static void imx_uart_save_context(struct imx_port *sport)
> >  	sport->saved_reg[8] =3D imx_uart_readl(sport, UBMR);
> >  	sport->saved_reg[9] =3D imx_uart_readl(sport, IMX21_UTS);
> >  	sport->context_saved =3D true;
> > +	spin_unlock_irqrestore(&sport->port.lock, flags);
> >  }
> >
> >  static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=3D02%7C01%7Canson.huang%40nxp.com%7C74
> a28e347934451a59bf08d612a57f8c%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C0%7C636716899353510311&amp;sdata=3DlByZDd%2BbQitjEf%2FaiN3
> e26El3ErT0fnmvaKCqckF7Qc%3D&amp;reserved=3D0  |
