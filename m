Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C32C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9988D2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="MGR+n7w0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9988D2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbeLMNju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:39:50 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40658 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbeLMNjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:39:49 -0500
Received: by mail-qk1-f193.google.com with SMTP id y16so1106086qki.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 05:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4E2Bwb5DUkf0C1vvdBwNjevr4g1q0gVM6ZGu5vUMw7I=;
        b=MGR+n7w0Q8ma9b1TeaeKXpvJnPdVxmm8gV3L0huy3O+/XUPhE59Yci9CMHqfz6FToy
         mWw99E14cEvwJJX5AC9GMHfVbkWso6/KaGmhhIwLCFwTQYbqBOKLLbqb5o88JlVrYYBA
         az7kmNSkHfHcVmim8SE3Uu3OvtdyjrWyAD2TqZmlI8+oDjyRSX84z5PCgZXtNeFi7RzY
         1OQo5P/4NpKPtB5aENfVRdosLq/jadMz3Z351JyVOJarb7I+edkMeV0aRWdSzwpgBKnw
         /eeFj1BqYKaDgnV53xsB9Qa5mriHIjLbXzgw5yJrizBYd7N28TPBUU4dUsJkBAdWT/7/
         ZSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4E2Bwb5DUkf0C1vvdBwNjevr4g1q0gVM6ZGu5vUMw7I=;
        b=RcOFVgNlaeJQ+ujTLFbmWIglysi9BM6+5iHjZyaQDgi7qDSoUGSaCT9yrEFZoz50Hx
         pyJXGMD3GZ7vmeaJ2Fc7ojF5hcHQwfivYpF9w2KrzLPdwY6NStPz+fegvJeFi4xUqS5U
         rVxRY0WrmJcX2smnM65Nj+s05pzAPT3y+6OyCQJgCJvoMKQ6JgAmOqosfn0ho8GV6Aiz
         Jyx1Zg4ygPzPWsWdUnV69nqL8PjAM+cHUdxhopZXoDjqkmvqn/AYCp/LL2vY+RFHlfAE
         mUp1vPf/J+k5Tq/XI7eERDRR2NUZvo0qSpk/PKnH7/vE+VFiWgWqpXUkWXQUBUMz8auV
         xlrg==
X-Gm-Message-State: AA+aEWbDPcgczaa5Td4e+1gpHjSS6I4C37hicFU44IbQ0rSylHzGfGmG
        ZfmU2eFqUGJxS0RNd58iBY69y6aVbuDRfg==
X-Google-Smtp-Source: AFSGD/UxO/Aat1EAOtmJEujgR6feGpGNSuBWD69clE1pwoPEgfF3IASTk2RptGzoT0ocmoGrKtvwRA==
X-Received: by 2002:a37:52d6:: with SMTP id g205mr22340313qkb.335.1544708388593;
        Thu, 13 Dec 2018 05:39:48 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m1sm1285923qkh.15.2018.12.13.05.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 05:39:48 -0800 (PST)
Message-ID: <1544708386.18411.13.camel@lca.pw>
Subject: Re: [PATCH] arm64: invalidate TLB before turning MMU on
From:   Qian Cai <cai@lca.pw>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>
Date:   Thu, 13 Dec 2018 08:39:46 -0500
In-Reply-To: <CACi5LpP+NHa1WQg78xm1y1YM0KXnFJ72pw+YrizxR5y7yt4AiQ@mail.gmail.com>
References: <1544654224.18411.11.camel@lca.pw>
         <20181213052259.56352-1-cai@lca.pw>
         <CACi5LpP+NHa1WQg78xm1y1YM0KXnFJ72pw+YrizxR5y7yt4AiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-13 at 11:10 +0530, Bhupesh Sharma wrote:
> Hi Qian Cai,
> 
> On Thu, Dec 13, 2018 at 10:53 AM Qian Cai <cai@lca.pw> wrote:
> > 
> > On this HPE Apollo 70 arm64 server with 256 CPUs, triggering a crash
> > dump just hung. It has 4 threads on each core. Each 2-core share a same
> > L1 and L2 caches, so that is 8 CPUs shares those. All CPUs share a same
> > L3 cache.
> > 
> > It turned out that this was due to the TLB contained stale entries (or
> > uninitialized junk which just happened to look valid) from the first
> > kernel before turning the MMU on in the second kernel which caused this
> > instruction hung,
> > 
> > msr     sctlr_el1, x0
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >  arch/arm64/kernel/head.S | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > index 4471f570a295..5196f3d729de 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -771,6 +771,10 @@ ENTRY(__enable_mmu)
> >         msr     ttbr0_el1, x2                   // load TTBR0
> >         msr     ttbr1_el1, x1                   // load TTBR1
> >         isb
> > +       dsb     nshst
> > +       tlbi    vmalle1                         // invalidate TLB
> > +       dsb     nsh
> > +       isb
> 
> This will be executed both for the primary and kdump kernel, right? I
> don't think we really want to invalidate the TLB when booting the
> primary kernel.
> It would be too slow and considering that we need to minimize boot
> timings on embedded arm64 devices, I think it would not be a good
> idea.

Yes, it will be executed for the first kernel as well. As James mentioned, it
needs to be done to invalidate TLB that might be used by bootloader anyway.

> 
> >         msr     sctlr_el1, x0
> >         isb
> >         /*
> > --
> > 2.17.2 (Apple Git-113)
> > 
> 
> Also did you check this issue I reported on the HPE apollo machines
> some days back with the kdump kernel boot
> <https://www.spinics.net/lists/kexec/msg21750.html>.
> Can you please confirm that you are not facing the same issue (as I
> suspect from reading your earlier Bug Report) on the HPE apollo
> machine. Also adding 'earlycon' to the bootargs being passed to the
> kdump kernel you can see if you are able to atleast get some console
> output from the kdump kernel.

No, here did not encounter the problem you mentioned.
