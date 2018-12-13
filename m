Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D0EC67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377DC20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="nS/MNkST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377DC20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbeLMDds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 22:33:48 -0500
Received: from mail-eopbgr790123.outbound.protection.outlook.com ([40.107.79.123]:6954
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbeLMDds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 22:33:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=te6TkXPtqOsY38RpsYccp2igloiapKAKFhpb3jat+Ks=;
 b=nS/MNkSTi5D13qi4TQFa0DlnqqgeAPb2DxQw6yzHJHxEZM/27dK2n5vtruItSBLPSqnmMj09sRVA/RiTv5iucC+a4/ytD+Zy6nZ0tX6s7HuJEEi8AD/fSym/EP9tg5vHjnL9N7qYq9lyq7T1hhAsYDlrNYrPQmgfYcEaA8Pbkbs=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1070.namprd22.prod.outlook.com (10.174.169.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 03:33:03 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%7]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 03:33:03 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Marek Vasut <marex@denx.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: Fix clearing FIFOs in RS485 mode again
Thread-Topic: [PATCH] serial: 8250: Fix clearing FIFOs in RS485 mode again
Thread-Index: AQHUknyRs52wg14NwUm+r/H2374buKV72ByAgAAOsoCAAAscgIAAEjWA
Date:   Thu, 13 Dec 2018 03:33:02 +0000
Message-ID: <20181213033301.febmn5qt3chn3vqb@pburton-laptop>
References: <20181213004120.yn35mzfo4skffabv@pburton-laptop>
 <cd3e2787-48e1-ce70-0fa7-94df6dc81794@denx.de>
 <20181213014805.77u5dzydo23cm6fq@pburton-laptop>
 <117fda17-40e6-664b-2b8a-f1032610bf0b@denx.de>
In-Reply-To: <117fda17-40e6-664b-2b8a-f1032610bf0b@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0088.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::29) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:647:4100:4687:84d1:277a:c6e5:ae34]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1070;6:MAP9yA+7fVFWHPdrzkRjhr6KKTawEluC8/g/Mhlm6FRf8GIx27EHpepmh0uQkr7ETLlwIaKV7Dwb6/lsUzBRnqtIuXkLadpg0wxq2AVmmg4xasaTELjoikmWVYPNiWPYHkwaUSNA2PsCzKl8ltECUKAvydPvV7QZj+j6OnCqiXQu2u5tL7FaWk7xSSc1eeegWHCFJqVlQqtrjYm2kOpZnwjshcW0WZ9YO2vmUIB244cbyGIkJpI7K1qyHdpKkTLU61yr9Mtn9YsiCX+Qusc1OQlGwob4hTrJ6Z+vgSMdbxT587FjF6r9AjsCeFm//81ogq2sKlbuwfkP3AJksMmK4ZWfSvOZoDw0MvjcCE+Z0j2BKWiIDaTjlhlm3pF/wuADwnJYbTGqs5bBK9bnKMNoEE5h40P+I/TMqE+nszeLDxiyiudBZNeeSVSt77QOSh7JZ5795ES4m8ZnWz0N0rVSlQ==;5:/Zlm/HlGTmOFwDViqaTb3RImW1rYe5xkiYdNpnj37geNXZQy20/f0Unnd9Iq0quBLEEBhKvP7RaUx4Gp5OHtV3kPcbR+TaY2ur2cDBhYUuT1BJFAms4pgbiVcaM5vfzTwIQNwUSWSLagg+it6EsGW3aEfFHjFt8bYk5l2EBOlb8=;7:WbaYsUg6g3HfkSR71EoiSjrss+dU+so7h3ij9X/U0W+PEaKadjE22vF1ECQRXO9F5UydPIsPNIp7ENg293vrbiq8e8KhMM/E735o4dSKo4e0x/3WH/4oklfRYoeKTth+E7kKuyqeWjQ2GrF6YddrKw==
x-ms-office365-filtering-correlation-id: 34f693af-09f4-4d81-3cb0-08d660abafda
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1070;
x-ms-traffictypediagnostic: MWHPR2201MB1070:
x-microsoft-antispam-prvs: <MWHPR2201MB107081BB82641702A286CDB2C1A00@MWHPR2201MB1070.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(148016)(149066)(150057)(6041310)(20161123562045)(2016111802025)(20161123564045)(20161123558120)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1070;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1070;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(39830400003)(366004)(376002)(396003)(346002)(199004)(189003)(5660300001)(71190400001)(58126008)(46003)(68736007)(6246003)(71200400001)(8936002)(52116002)(6486002)(316002)(93886005)(305945005)(53936002)(6512007)(9686003)(42882007)(54906003)(476003)(446003)(81166006)(99286004)(81156014)(8676002)(486006)(44832011)(14454004)(11346002)(256004)(186003)(76176011)(6436002)(14444005)(102836004)(97736004)(6916009)(105586002)(25786009)(229853002)(106356001)(508600001)(4326008)(33716001)(6116002)(1076002)(6506007)(386003)(33896004)(2906002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1070;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wxTfcnddp7XUNeSff6dUwYhy/7wfZ+WC0VZv/lxCcREXMBJcnWbIRzYvURqZhmPWcdDH68ZNN5Xcflgpp3odYOYneGSeVA5IJ4OR6RBc1Bg/AFL4DZNErBSez3j6LKKg/uXcElccD6QHYCZQqQ8O7G0hBQwuqF7Zsx4ThBb8WaDNcCRxmng5RoW75euETBpv2oWQ/MwkRud+WPZeEhxVfP0emsnPAmVIqmMp03Ve44e/S8aFXy8nv5ysWia6FvTuMkEbHH9U56NM/yagDm8b+Zbwp1mZJf0p4FfA0ZmL829k16HP14OMbGd/ootzoe3F
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1419985650AB9D43A74B10BCE9FE6B39@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f693af-09f4-4d81-3cb0-08d660abafda
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 03:33:03.0067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Thu, Dec 13, 2018 at 03:27:51AM +0100, Marek Vasut wrote:
> > I wonder whether the issue may be the JZ4780 UART not automatically
> > resetting the FIFOs when FCR[0] changes. This is a guess, but the manua=
l
> > doesn't explicitly say it'll happen & the programming example it gives
> > says to explicitly clear the FIFOs using FCR[2:1]. Since this is what
> > the kernel has been doing for at least the whole git era I wouldn't be
> > surprised if other devices are bitten by the change as people start
> > trying 4.20 on them.
>=20
> The patch you're complaining about is doing exactly that -- it sets
> UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT in FCR , and then clears it.
> Those two bits are exactly FCR[2:1]. It also explicitly does not touch
> any other bits in FCR.

No - your patch does that *only* if the FIFO enable bit is set, and
presumes that clearing FIFOs is a no-op when they're disabled. I don't
believe that's true on my system. I also believe that not touching the
FIFO enable bit is problematic, since some callers clearly expect that
to be cleared.

> > @@ -558,25 +558,26 @@ static void serial8250_clear_fifos(struct uart_82=
50_port *p)
> >  	if (p->capabilities & UART_CAP_FIFO) {
> >  		/*
> >  		 * Make sure to avoid changing FCR[7:3] and ENABLE_FIFO bits.
> > -		 * In case ENABLE_FIFO is not set, there is nothing to flush
> > -		 * so just return. Furthermore, on certain implementations of
> > -		 * the 8250 core, the FCR[7:3] bits may only be changed under
> > -		 * specific conditions and changing them if those conditions
> > -		 * are not met can have nasty side effects. One such core is
> > -		 * the 8250-omap present in TI AM335x.
> > +		 * On certain implementations of the 8250 core, the FCR[7:3]
> > +		 * bits may only be changed under specific conditions and
> > +		 * changing them if those conditions are not met can have nasty
> > +		 * side effects. One such core is the 8250-omap present in TI
> > +		 * AM335x.
> >  		 */
> >  		fcr =3D serial_in(p, UART_FCR);
> > +		serial_out(p, UART_FCR, fcr | clr_mask);
> > +		serial_out(p, UART_FCR, fcr & ~clr);
>=20
> Note that, if I understand the patch correctly, this will _not_ restore
> the original (broken) behavior. The original behavior cleared the entire
> FCR at the end, which cleared even bits that were not supposed to be
> cleared .

It will restore the original behaviour with regards to disabling the
FIFOs, so long as callers that expect that use
serial8250_clear_and_disable_fifos().

> This patch will make things worse by retaining the clr_mask set in the
> FCR, thus the FCR[2:1] will be set when you return from this function.
> That cannot be right ?

You're mistaken - clr_mask (ie. the FIFO reset bits) get cleared again
by the second call to serial_out(), I just did it without modifying the
fcr variable - ie. we write the original fcr value again at the end, but
with UART_FCR_ENABLE_FIFO cleared in the
serial8250_clear_and_disable_fifos() case. It would probably be clearer
with the clr argument renamed disable or something like that.

Thanks,
    Paul
