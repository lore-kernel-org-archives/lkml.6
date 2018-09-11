Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4872BC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91B42087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7+UPPnq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91B42087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbeILDKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 23:10:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbeILDKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 23:10:13 -0400
Received: from gmail.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96E4120866;
        Tue, 11 Sep 2018 22:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536703731;
        bh=0tcTJoC+KLyeNupw0SdfcyDq7jhJPoeTVfEKiBJ/5NQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q7+UPPnqf2KUvejfW+Bow3OjVid9vN2pDbtU6pP7oZQkjboAD3kJxm37TDJhWcNeF
         v4qUE67ynOa8qvimOFJQlpKodyyuEYrtUoaijFizeFRQwbxVnbA28yaYgfGIMV/OuJ
         89e7RKTVz8Abav3DEtyZPCX5uHspSATJFTcoYzXU=
Date:   Tue, 11 Sep 2018 15:08:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography
 library
Message-ID: <20180911220849.GC81235@gmail.com>
References: <20180911010838.8818-1-Jason@zx2c4.com>
 <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 12:08:56PM +0200, Ard Biesheuvel wrote:
> 
> I won't go into the 1000s lines of generated assembly again - you
> already know my position on that topic.
> 

I'd strongly prefer the assembly to be readable too.  Jason, I'm not sure if
you've actually read through the asm from the OpenSSL implementations, but the
generated .S files actually do lose a lot of semantic information that was in
the original .pl scripts.  For example, in the Poly1305 NEON implementation
which I'm especially interested in (but you could check any of the other
generated files too), the original .pl script has register aliases showing the
meaning of each register.  Just grabbing a random hunk:

        vshr.u64    $T0,$D3,#26
        vmovn.i64   $D3#lo,$D3
         vshr.u64   $T1,$D0,#26
         vmovn.i64  $D0#lo,$D0
        vadd.i64    $D4,$D4,$T0     @ h3 -> h4
        vbic.i32    $D3#lo,#0xfc000000
          vsri.u32  $H4,$H3,#8      @ base 2^32 -> base 2^26
         vadd.i64   $D1,$D1,$T1     @ h0 -> h1
          vshl.u32  $H3,$H3,#18
         vbic.i32   $D0#lo,#0xfc000000

(Yes, it's still not *that* readable, but D0-D4 and H0-H4 map directly to d0-d4
and h0-h4 in the C implementation.  So someone familiar with Poly1305
implementations can figure it out.)

In contrast, the generated .S file just has the raw registers.  It's difficult
to remember what each register is used for.  In fact, someone who actually
wanted to figure it out would probably find themselves referring to the .pl
script -- which raises the question of why the .S file is the "source" and not
the .pl script...

        vshr.u64        q15,q8,#26
        vmovn.i64       d16,q8
         vshr.u64       q4,q5,#26
         vmovn.i64      d10,q5
        vadd.i64        q9,q9,q15               @ h3 -> h4
        vbic.i32        d16,#0xfc000000
          vsri.u32      q14,q13,#8              @ base 2^32 -> base 2^26
         vadd.i64       q6,q6,q4                @ h0 -> h1
          vshl.u32      q13,q13,#18
         vbic.i32       d10,#0xfc000000

- Eric
