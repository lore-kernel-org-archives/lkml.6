Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1695C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 03:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6744C20815
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 03:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="azuMsxLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeLTDt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 22:49:28 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:33954 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbeLTDt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 22:49:27 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 37C4724E0EE2;
        Wed, 19 Dec 2018 19:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545277767; bh=B7gUdpmaSbLGKs2pnMeBKwiBlkfkHHFdBK1BHJWFeQQ=;
        h=From:To:CC:Subject:Date:References:From;
        b=azuMsxLrGFIHkBP+//dmHWx0rkrel7Vt264oQxpSmo0mfgBaY08sIG4Hd3agOZyks
         oJU8h8w6VPDtdwil68uqP0wNhn1nDhLn4F8J9jEOvaAhBbPFg+Kc8PGVL+O/Ve6MdY
         HNbzyHLjBTqewCFTzn+p1oHj0MFHzJtVD9bOzLIxv+Iie23C3Hdtf5Yz+1qa7uizML
         RUR3CSN9WyPYHLlrlH+e8SCQ4PaY5LHe0x/BDumJ86iR0WLGyF0TKJhFx7RIOcAXOH
         jBjZbcAEUsiYZM2AX39i2TDRHEa9lp24c/EmD5dH++iBW8DkNSzu4FwOFlZM7rIaAJ
         bIWxQfP3e9F3g==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 14F6C3BC5;
        Wed, 19 Dec 2018 19:49:27 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed,
 19 Dec 2018 19:49:27 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] ARC: adjust memblock_reserve of kernel memory
Thread-Topic: [PATCH] ARC: adjust memblock_reserve of kernel memory
Thread-Index: AQHUl7Y3xyclRc6qjkizV/X3iTxkVw==
Date:   Thu, 20 Dec 2018 03:49:26 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230750146422685@US01WEMBX2.internal.synopsys.com>
References: <20181219161616.10422-1-Eugeniy.Paltsev@synopsys.com>
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

On 12/19/18 8:16 AM, Eugeniy Paltsev wrote:=0A=
> In setup_arch_memory we reserve the memory area wherein the kernel=0A=
> is located. Current implementation may reserve more memory than=0A=
> it actually required in case of CONFIG_LINUX_LINK_BASE is not=0A=
> equal to CONFIG_LINUX_RAM_BASE. This happens because we calculate=0A=
> start of the reserved region relatively to the CONFIG_LINUX_RAM_BASE=0A=
> and end of the region relatively to the CONFIG_LINUX_RAM_BASE.=0A=
>=0A=
> For example in case of HSDK board we wasted 256MiB of physical memory:=0A=
> ------------------->8------------------------------=0A=
> Memory: 770416K/1048576K available (5496K kernel code,=0A=
>     240K rwdata, 1064K rodata, 2200K init, 275K bss,=0A=
>     278160K reserved, 0K cma-reserved)=0A=
> ------------------->8------------------------------=0A=
>=0A=
> Fix that.=0A=
>=0A=
> Cc: stable@vger.kernel.org=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
=0A=
LGTM. I presume you have booted HSDK with it and done some smoke testing.=
=0A=
=0A=
-Vineet=0A=
