Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C05CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07D620835
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07D620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeH2Bug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:50:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:55245 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbeH2Bug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:50:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 14:56:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,300,1531810800"; 
   d="scan'208";a="69851103"
Received: from megha-z97x-ud7-th.sc.intel.com (HELO [143.183.85.162]) ([143.183.85.162])
  by orsmga006.jf.intel.com with ESMTP; 28 Aug 2018 14:56:40 -0700
Message-ID: <1535494636.15041.15.camel@megha-Z97X-UD7-TH>
Subject: Re: KASAN: use-after-free Read in sha512_ctx_mgr_resubmit
From:   Megha Dey <megha.dey@linux.intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot <syzbot+d5455bac3ba1ee9114e5@syzkaller.appspotmail.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        the arch/x86 maintainers <x86@kernel.org>
Date:   Tue, 28 Aug 2018 15:17:16 -0700
In-Reply-To: <CAKv+Gu_oZ0Z37WV1h4opi-cYZT5FWU_bmrkBjx8LXpvKpPoZNA@mail.gmail.com>
References: <00000000000072d64d05737b6b8c@google.com>
         <20180820073119.GA14931@sol.localdomain>
         <CAKv+Gu9Y0TLOuMba43HPihYqy-kk0nttBfPj1_UukiYy1cBcFw@mail.gmail.com>
         <20180822062036.mdq4q5o5zdzuxh7s@gondor.apana.org.au>
         <1535411336.3516.2.camel@megha-Z97X-UD7-TH>
         <CAKv+Gu_oZ0Z37WV1h4opi-cYZT5FWU_bmrkBjx8LXpvKpPoZNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-28 at 01:01 +0200, Ard Biesheuvel wrote:
> On 28 August 2018 at 01:08, Megha Dey <megha.dey@linux.intel.com> wrote:
> > On Wed, 2018-08-22 at 14:20 +0800, Herbert Xu wrote:
> >> On Tue, Aug 21, 2018 at 02:43:56PM +0200, Ard Biesheuvel wrote:
> >> >
> >> > I agree. The code is obviously broken in a way that would have been
> >> > noticed if it were in wide use, and it is too complicated for mere
> >> > mortals to fix or maintain. I suggest we simply remove it for now, and
> >> > if anyone wants to reintroduce it, we can review the code *and* the
> >> > justification for the approach from scratch (in which case we should
> >> > consider factoring out the algo agnostics plumbing in a way that
> >> > allows it to be reused by other architectures as well)
> >>
> >> I agree too.  Could one of you guys send me a patch to remove
> >> them?
> >>
> >
> > Hi,
> >
> > We are working on a fix to solve these corner cases.
> >
> 
> Great. thanks.
> 
> But it would also be helpful if you could try and answer the questions
> raised by Eric:
> - in which cases does this driver result in a speedup?

The multibuffer algorithm approach results in a speedup only when there
are a large number of independent jobs. Similarly if there is a steady
stream of independent jobs, multibuffer works well. So another way of
looking at this is that if there are a lot of flushes, then one
shouldn't be using multibuffer algorithms.
 
> - how should we tune the flush delay to prevent pathological
> performance regressions?

We have not optimized the flush delay on the ground that it should not
be occurring often. If this seems to be happening a lot, then perhaps we
could optimize it along the lines that if more than N "lanes" are full,
we will continue to use the present flush algorithm, else we could
switch to an optimized single buffer code for one of the lanes. Any
other suggestions are welcome too.
 
> - is it still safe in the post-Spectre era of computing to aggregate
> hash input from different sources (which may be different users
> altogether) and process them as a single source of input?

hmmm, I am not sure how one could do side-channel attack, could you
maybe give an example? One could do a denial of service attack, by
flooding it with too many requests.

Also Eric had raised the issue whether we need AVX2 multibuffer now that
we have SHA instructions. However, for cases where jobs come in fast
enough, sha1-mb is seen to perform better than sha-ni algorithm.

Since, we already have lowered the priority of the multibuffer
algorithms, users who know that they would have a consistent inflow of
jobs should only opt for the multibuffer algorithm.

From Herbert's suggestion, I am also working on removing the mcryptd
layer for the multibuffer algorithms, and follow the simd model to
simplify the multibuffer model.

Hence, instead of removing these algorithms, I would like to suggest the
following:
1. Find a fix for the corner cases of memory corruption
2. Remove mcryptd layer, add simd interface for hash 
3. try to reuse code for hash multibuffer algorithms instead of
duplicating the same code 3 times.

Thanks,
Megha 

