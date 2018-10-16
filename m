Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCBCC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CA92098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NrX4xRKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CA92098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeJQBTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:19:02 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:45956 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbeJQBTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:19:01 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 0181124E0D73;
        Tue, 16 Oct 2018 10:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1539710855; bh=xs1oKAmQZKMnbyQZIWLwz4nucbWh/FytIoNc2quLmoI=;
        h=From:To:CC:Subject:Date:References:From;
        b=NrX4xRKiadL8SrUXMTE9PrVRQbomEVrMuQevhBFJBfJfEdOpf0bgsImllmVUWTP0c
         ohBDPUyXHM+2mBc4w2DbbVq1cDjtin5yc27i1HjnLspt6RHQyS0u1K31MgzIx0nsnE
         ettaqvgSG2vKXh6mzq6upGfTfBGoqWh2ShTXadRVE2NcmC1/qPQnI6yDVq76+E6khD
         al6vvU1z3gLDJ5OMpamaymKpn2BQ1aSJaSo5mB5dvER9ZjmE0dQ4LnAbKOnl8m+Y+K
         2MbjvoSfWQOvawaWHlraqhYy3GTjANVY7QHr/XdpEQAhtiimSLB88PnBqwAjJNy7ZN
         p5ZRKAQ9qQfUw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id E2AAF308C;
        Tue, 16 Oct 2018 10:27:34 -0700 (PDT)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Tue, 16 Oct 2018 10:27:35 -0700
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>
Subject: Re: [PATCH] ARC: IOC: panic if kernel was started with previously
 enabled IOC
Thread-Topic: [PATCH] ARC: IOC: panic if kernel was started with previously
 enabled IOC
Thread-Index: AQHUW+Pi2l0qN/ga1kOYlHrTlH6D2Q==
Date:   Tue, 16 Oct 2018 17:27:34 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B0AE414@US01WEMBX2.internal.synopsys.com>
References: <20181004131212.16405-1-Eugeniy.Paltsev@synopsys.com>
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

On 10/04/2018 06:12 AM, Eugeniy Paltsev wrote:=0A=
> Disabling and reconfiguring of IOC are quite a tricky actions because=0A=
> nobody knows what happens if there're IOC-ahndled tarnsactions in flight=
=0A=
> when we're disabling IOC.=0A=
>=0A=
> And the problem is external DMA masters [that were initialized and set=0A=
> in a bootlaoder that was executed before we got here] might continue=0A=
> to send data to memory even at this point and we have no way to prevent=
=0A=
> that.=0A=
>=0A=
> That said it's much safer to not enable IOC at all anywhere before Linux=
=0A=
> kernel.=0A=
>=0A=
> As we can build u-boot with IOC support (mostly for debugging purposes)=
=0A=
> let's check that kernel was started with disabled IOC regardless of=0A=
> our plans to use it or not.=0A=
>=0A=
> Also while I'm at it, replace hardcoded bits in ARC_REG_IO_COH_PARTIAL=0A=
> and ARC_REG_IO_COH_ENABLE registers by definitions.=0A=
>=0A=
> Inspired by: https://lkml.org/lkml/2018/1/19/557=0A=
>=0A=
=0A=
Applied with updated changelog !=0A=
=0A=
-Vineet=0A=
