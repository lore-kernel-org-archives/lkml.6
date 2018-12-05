Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A280C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1DC20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/5anYM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1DC20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeLEGK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:10:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:39394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbeLEGK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:10:58 -0500
Received: from sol.localdomain (c-24-23-142-8.hsd1.ca.comcast.net [24.23.142.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2FC22084C;
        Wed,  5 Dec 2018 06:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543990257;
        bh=MrJErH2B5hAyYx9gPpy35DDhGrlI75pq4mdnIQyWNoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a/5anYM2e6O6ey/sGkclQBK5oxB1ahZ0A0s+fr6vjzb03TubsWTzE2CirmuoMfN81
         NykkFzkBCPU+0Mciw3B/REOTg5884mVQ4XW5zzAkQpzos+j3UrWcXMpJ0dpp7BuOZD
         h0E3IM7FyZmxr/XmOKaVxbws0sVxAxsClhM+6X3I=
Date:   Tue, 4 Dec 2018 22:10:55 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Martin Willi <martin@strongswan.org>
Cc:     linux-crypto@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Milan Broz <gmazyland@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] crypto: x86/chacha20 - add XChaCha20 support
Message-ID: <20181205061054.GA26750@sol.localdomain>
References: <20181129230217.158038-1-ebiggers@kernel.org>
 <20181129230217.158038-5-ebiggers@kernel.org>
 <99ed681fa4d3233b18ae9328a14f9e23971073cb.camel@strongswan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99ed681fa4d3233b18ae9328a14f9e23971073cb.camel@strongswan.org>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Sat, Dec 01, 2018 at 05:40:40PM +0100, Martin Willi wrote:
> 
> > An SSSE3 implementation of single-block HChaCha20 is also added so
> > that XChaCha20 can use it rather than the generic
> > implementation.  This required refactoring the ChaCha permutation
> > into its own function. 
> 
> > [...]
> 
> > +ENTRY(chacha20_block_xor_ssse3)
> > +	# %rdi: Input state matrix, s
> > +	# %rsi: up to 1 data block output, o
> > +	# %rdx: up to 1 data block input, i
> > +	# %rcx: input/output length in bytes
> > +
> > +	# x0..3 = s0..3
> > +	movdqa		0x00(%rdi),%xmm0
> > +	movdqa		0x10(%rdi),%xmm1
> > +	movdqa		0x20(%rdi),%xmm2
> > +	movdqa		0x30(%rdi),%xmm3
> > +	movdqa		%xmm0,%xmm8
> > +	movdqa		%xmm1,%xmm9
> > +	movdqa		%xmm2,%xmm10
> > +	movdqa		%xmm3,%xmm11
> > +
> > +	mov		%rcx,%rax
> > +	call		chacha20_permute
> > +
> >  	# o0 = i0 ^ (x0 + s0)
> >  	paddd		%xmm8,%xmm0
> >  	cmp		$0x10,%rax
> > @@ -189,6 +198,23 @@ ENTRY(chacha20_block_xor_ssse3)
> >  
> >  ENDPROC(chacha20_block_xor_ssse3)
> >  
> > +ENTRY(hchacha20_block_ssse3)
> > +	# %rdi: Input state matrix, s
> > +	# %rsi: output (8 32-bit words)
> > +
> > +	movdqa		0x00(%rdi),%xmm0
> > +	movdqa		0x10(%rdi),%xmm1
> > +	movdqa		0x20(%rdi),%xmm2
> > +	movdqa		0x30(%rdi),%xmm3
> > +
> > +	call		chacha20_permute
> 
> AFAIK, the general convention is to create proper stack frames using
> FRAME_BEGIN/END for non leaf-functions. Should chacha20_permute()
> callers do so?
> 

Yes, I'll do that.  (Ard suggested similarly in the arm64 version too.)

- Eric
