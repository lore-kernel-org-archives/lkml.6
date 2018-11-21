Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC118C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9914120659
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="A/BX2PJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9914120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732848AbeKVGRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:17:37 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:33962 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeKVGRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:17:36 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id A768124E12C5;
        Wed, 21 Nov 2018 11:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542829317; bh=SMSSTlNFhJOx8xe5MPofETBAI9S74btb7y31gJPLUNU=;
        h=From:To:CC:Subject:Date:References:From;
        b=A/BX2PJRw5MhB6GdxV6EHkePCBkv0OQh2vBbD3Oj9eNB8y6KSMbtXGZtBR1osYQ1u
         tkPb59G/UbtOxvSNS9TpfiUZvMdgV8gJl1HebB1WiLPCxdNbIbUZjuxRrksM9Egu5j
         rfpz72yEe5ohp/y+07VCAmQy5n/1D5PyORZoTL4kdpuI/ueDA8y6nxQhko5cB9luqK
         OhAwDcBOPJe/WV0cMTWbjy9HHJz6S4Nmek4dpjh8OKzSj3eKIh/VSKdxYxm44n5B7g
         jrgrz1nFGxaN68VzgYwXVOyE1FcJpyB0416vSSjU/BjH5LYhfmKCXA7Y37HJ35NSpy
         Tk5vDR7ykDpCQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2B04B387E;
        Wed, 21 Nov 2018 11:41:57 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed,
 21 Nov 2018 11:41:57 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Vitor Soares <vitor.soares@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jose Abreu <jose.abreu@synopsys.com>
CC:     arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: Misaligned Access
Thread-Topic: Misaligned Access
Thread-Index: AQHUa8BEl692JJiolkiUiQERHFjjDw==
Date:   Wed, 21 Nov 2018 19:41:56 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014641580A@US01WEMBX2.internal.synopsys.com>
References: <13D59CF9CEBAF94592A12E8AE55501350113CD10@DE02WEMBXB.internal.synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B0B4CD5@US01WEMBX2.internal.synopsys.com>
 <9ffd1270-ad92-88b7-eb53-85c65fe971dd@synopsys.com>
 <f8c469e7-9e1d-18d6-4e56-ba4338462048@synopsys.com>
 <ebe7f165-2901-2885-0583-c7be53329372@synopsys.com>
 <4881796E12491D4BB15146FE0209CE6468198AC6@DE02WEMBXB.internal.synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA230750146415496@US01WEMBX2.internal.synopsys.com>
 <661a4323-5768-4977-5434-ab644c5418aa@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC lkml, Arnd : subject matter expert=0A=
=0A=
On 11/21/18 10:06 AM, Vitor Soares wrote:=0A=
> I use the follow function to get data from a RX Fifo.=0A=
>=0A=
>=0A=
> static void dw_i3c_master_read_rx_fifo(struct dw_i3c_master *master,=0A=
>                         u8 *bytes, int nbytes)=0A=
> {=0A=
>      readsl(master->regs + RX_TX_DATA_PORT, bytes, nbytes / 4);=0A=
=0A=
So the semantics are reading the same fifo register N times, to get the N w=
ords,=0A=
hence read*s*l is appropriate. That however expects the buffer to be 4 byte=
s=0A=
aligned, hence your issue. You can't possibly use the reads*b* as we want t=
he=0A=
=0A=
The obvious but crude hack is to use a temp array for readsl and then copy =
over=0A=
using memcpy, but I'm sure there are better ways, @Arnd ? To summarize is i=
ssue is=0A=
a driver triggering unaligned access due to the misinteraction of API (driv=
er get=0A=
an unaligned u8 *) which goes against expectations of io accessor readl  (n=
eeded=0A=
since the register contents are 4 bytes)=0A=
=0A=
=0A=
>      if (nbytes & 3) {=0A=
>          u32 tmp;=0A=
>=0A=
>          readsl(master->regs + RX_TX_DATA_PORT, &tmp, 1);=0A=
>          memcpy(bytes + (nbytes & ~3), &tmp, nbytes & 3);=0A=
>      }=0A=
> }=0A=
>=0A=
>=0A=
> and the pointer u8 *bytes is what is unaligned and breaks when inside of =
=0A=
> realdsl() it does:=0A=
>=0A=
>      *buf++ =3D x;=0A=
>=0A=
>=0A=
> Note that the u8 *bytes pointer is the __u8 *buf of the i2c_msg struct.=
=0A=
=0A=
