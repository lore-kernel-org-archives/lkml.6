Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C6EC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D0B216EE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="j1+OC/9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D0B216EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbeHCFHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 01:07:34 -0400
Received: from ozlabs.org ([203.11.71.1]:42337 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbeHCFHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 01:07:34 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 41hXDf01cyz9s3Z; Fri,  3 Aug 2018 13:13:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1533266002; bh=UYbEv5KLltTctk3RA2mBy4F74bubu9dPJuuEIjnxR+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j1+OC/9sDuTl/qRuMd2SaomwBOUl2TQEaPTWk8OqSfLjVeBpmid4WyFrYx+iCkN52
         FJoTeQSYtHVFNzw0F8BIUZe8wLRnORzvydFPSdSmEzNoBFVcrBoM811xY629is77M0
         b3v4rs8Ty8yrnSjhknHqNoCTXcLpAVtOI/HUkEuyea+eNm/73aA2jeOw0Wk7cC/oSc
         ZY1uw5h76JES00qbBhj7ZjtCp3hl8om1OrkZROV5uU6MiAzSTq0JHvzpoC2q0zNBUM
         QNtKIfcN/m6wDckr3BhMyUHWcc4Qe2YmqkSvjwsXOoQrQUZub8RjX2+qIzHSldWQAc
         wBo8CshRUZFmA==
Date:   Fri, 3 Aug 2018 13:13:15 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-ppp@vger.kernel.org, Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppp: mppe: Remove VLA usage
Message-ID: <20180803031315.GA30807@fergus>
References: <20180716040516.GA32783@beast>
 <CAK8P3a1tph9VPJnYYhBvH_1wZ79wXDvfnJt_CEruj3T-TBG1jg@mail.gmail.com>
 <CAGXu5jKaNk8x9v+uVQ_O7gxr50s1-Q901JbQupnkBFYiUjd7UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKaNk8x9v+uVQ_O7gxr50s1-Q901JbQupnkBFYiUjd7UQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 04:27:01PM -0700, Kees Cook wrote:
> On Mon, Jul 16, 2018 at 4:01 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Jul 16, 2018 at 6:05 AM, Kees Cook <keescook@chromium.org> wrote:
> >> In the quest to remove all stack VLA usage from the kernel[1], this
> >> removes the discouraged use of AHASH_REQUEST_ON_STACK (and associated
> >> VLA) by switching to shash directly and keeping the associated descriptor
> >> allocated with the regular state on the heap.
> >>
> >> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> >>
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > I had concerns at first that this approach might make it slower, but
> > upon reading through implementation of the shash_ahash_ implementation,
> > I concluded that it can only be better than before, improving both
> > performance and stack usage.
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Paul,
> 
> Is this something you can take via your tree?

No, it would go via the netdev tree, I expect.

Paul.
