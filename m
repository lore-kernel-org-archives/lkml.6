Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C8DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2048520869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2048520869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeIDJnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:43:51 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:38850 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbeIDJnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:43:51 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fx3kd-00009J-UR; Tue, 04 Sep 2018 13:19:43 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fx3k1-0003In-RM; Tue, 04 Sep 2018 13:19:05 +0800
Date:   Tue, 4 Sep 2018 13:19:05 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-crypto@vger.kernel.org, dm-devel@redhat.com,
        qat-linux@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/9] crypto: Remove VLA usage
Message-ID: <20180904051905.a2vyzijz6xyxvyhb@gondor.apana.org.au>
References: <20180807211843.47586-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807211843.47586-1-keescook@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 02:18:34PM -0700, Kees Cook wrote:
> v8 cover letter:
> 
> I continue to hope this can land in v4.19, but I realize that's unlikely.
> It would be nice, though, if some of the "trivial" patches could get taken
> (e.g. cbc, xcbc, ccm VLA removals) so I don't have to keep repeating them.
> *fingers crossed*
> 
> Series cover letter:
> 
> This is nearly the last of the VLA removals[1], but it's one of the
> largest because crypto gets used in lots of places. After looking
> through code, usage, reading the threads Gustavo started, and comparing
> the use-cases to the other VLA removals that have landed in the kernel,
> I think this series is likely the best way forward to shut the door on
> VLAs forever.
> 
> For background, the crypto stack usage is for callers to do an immediate
> bit of work that doesn't allocate new memory. This means that other VLA
> removal techniques (like just using kmalloc) aren't workable, and the
> next common technique is needed: examination of maximum stack usage and
> the addition of sanity checks. This series does that, and in several
> cases, these maximums were already implicit in the code.
> 
> This series is intended to land via the crypto tree for 4.19, though it
> touches dm, networking, and a few other things as well, since there are
> dependent patches (new crypto #defines being used, etc).

I have applied patches 1-4 and 6-8.  I'd like to get an ack from
the dm folks regarding patch 5.  As to patch 9, please fix it so
it doesn't rely on the BUG_ON to catch things.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
