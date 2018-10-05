Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABF3C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1917208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gbiIpNlV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1917208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbeJFF5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 01:57:55 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:57870 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbeJFF5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 01:57:55 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id EF1A624E0DE9;
        Fri,  5 Oct 2018 15:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1538780223; bh=/HKoNZVI/dZBAI0pkC4esBXehc/Y5nDz2WhG+I4kpYU=;
        h=From:To:CC:Subject:Date:References:From;
        b=gbiIpNlVmfFLW+QPdu6vcNA+Z+Fh6eiU/cS+IspmpR2VPmADVcEbbnDhNtYkS2Ppp
         drsFB7OLcvQg0hb2G0FYxOO0j7o3TKiyq3eYSvfan9P4BoH3OfMwPT1vlSVe1DzEf/
         Fm2v4nefigVahEwaRB2VZpPldYIAhfb8cFpJZgNH1nyw0uO//uRIU+ztkDKeV9rBeK
         W7ZmXPiLY75PPNv4Rj5w4YQb3FRzh1jCaFwKRM81pI0MJ9I6MNCjBVtKqHSnIRaJcR
         59eYupR6AzOroLcrVmfJnxLMmOzoDnyNFAjimvGtM2S16LpYRAFlngiGE0N8HCJ8OV
         EUU3dk4BgM8xQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id A152D3A42;
        Fri,  5 Oct 2018 15:57:02 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Fri, 5 Oct 2018 15:56:53 -0700
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
Date:   Fri, 5 Oct 2018 22:56:52 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B09B9EF@us01wembx1.internal.synopsys.com>
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
>  =0A=
> diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c=0A=
> index f2701c13a66b..ee7b63e9c5e3 100644=0A=
> --- a/arch/arc/mm/cache.c=0A=
> +++ b/arch/arc/mm/cache.c=0A=
> @@ -1144,6 +1144,25 @@ noinline void __init arc_ioc_setup(void)=0A=
>  {=0A=
>  	unsigned int ioc_base, mem_sz;=0A=
>  =0A=
> +	/*=0A=
> +	 * Disabling and reconfiguring of IOC are quite a tricky actions becaus=
e=0A=
> +	 * nobody knows what happens if there're IOC-ahndled tarnsactions in=0A=
> +	 * flight when we're disabling IOC.=0A=
> +	 *=0A=
> +	 * And the problem is external DMA masters [that were initialized and=
=0A=
> +	 * set in a bootlaoder that was executed before we got here] might=0A=
> +	 * continue to send data to memory even at this point and we have=0A=
> +	 * no way to prevent that.=0A=
> +	 *=0A=
> +	 * That said it's much safer to not enable IOC at all anywhere before=
=0A=
> +	 * Linux kernel.=0A=
> +	 */=0A=
> +	if (read_aux_reg(ARC_REG_IO_COH_ENABLE) & ARC_IO_COH_ENABLE_BIT)=0A=
> +		panic("kernel was started with previously enabled IOC!\n");=0A=
=0A=
While I understand the needs, this seems excessive, should we warm the user=
,=0A=
instead of panic ? Did you run into specific issue to warrant this !=0A=
=0A=
OTOH in recent past more than 1 person ran into some hsdk uboot shenanigans=
, where=0A=
we had to upgrade the uboot to get it working with prebuit images - is that=
 what=0A=
you are trying to prevent here - panic early instead of random user errors =
/ hangs=0A=
later ?=0A=
=0A=
-Vineet=0A=
