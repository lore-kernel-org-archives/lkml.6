Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD5AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74642085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Oi9RYkN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74642085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeKGFSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:18:46 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33710 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeKGFSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 00:18:46 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so6381668ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 11:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ci4FNFYUwOJpBW4NZH6/tdwR7GKUvVrFu55mBArxxGY=;
        b=Oi9RYkN2Ho6zzSjaVYtGtpJGJHmmOqPqV/M3NJJMY5Qk9hZycsyqw0h4Iv/JWHXbP9
         IafyVBUPfqEX6BE+jZmnt7rM+N/lmA9IwOvZW8dAbqDAV4guFDP3iNIeJ42zsy/zLjtv
         09EphLsOxEAVIXLkqJ76aZ1JQb9LwRqKQ8hG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ci4FNFYUwOJpBW4NZH6/tdwR7GKUvVrFu55mBArxxGY=;
        b=cAzoTTD0r2UMobpqiR7BE9RldOSpKHMhO6nukcB37+438hfsYBaVcCXr12eMnxT8EN
         AsRQC8eN7pnueohvFOpNHIoimZtIqeGEGiM5lc9kEAOG6SzTq3kewbfr2exdCkSBwm+V
         p2CjiUTL4JbFqziMxH5SnKqqsv2USiVYf00HXXOWRL1xzGDIOC4L8gJO/zejXktZbs/N
         AQRBsXJU26brKm0S17KhKsLoFOpTfdR6qrvrLJCHwqM0LS10n8/qXV2wn1l6CoqW/KOq
         pGLnMZx5aSZoi/MNePsbPlSMI3sHYHX+aeqnaxCZwlRjzjmayzPBxVFa1qdIQOqnVRYr
         y3Nw==
X-Gm-Message-State: AGRZ1gK/1G5QEozDm1oDajmLJXUks3nT51vFQW3th/gBdfxlarJdqfAu
        gIZTpACbFm4OIsW56sEt5JGphCsGiIA=
X-Google-Smtp-Source: AJdET5cf26pk+eap1PfDfq3uwuG5UfShEJoBnyb0UfVQibgbwTsKqGafIh6KjswQYt/EkrkDzlQn8A==
X-Received: by 2002:a2e:5747:: with SMTP id r7-v6mr4940714ljd.141.1541533913350;
        Tue, 06 Nov 2018 11:51:53 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id e94sm4816189lfi.23.2018.11.06.11.51.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 11:51:52 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id x85-v6so12620280ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 11:51:52 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr19514787lji.133.1541533911557;
 Tue, 06 Nov 2018 11:51:51 -0800 (PST)
MIME-Version: 1.0
References: <20181106100229.GI22431@hirez.programming.kicks-ass.net>
 <CAHk-=wjFL-4p-4FrJbtKADXRaBPK_Pi_-BSSqm_j784Mq6aHjQ@mail.gmail.com> <20181106194149.GC9761@hirez.programming.kicks-ass.net>
In-Reply-To: <20181106194149.GC9761@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 6 Nov 2018 11:51:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgTKDiDiQzoH=-ho1bn_SqvxHg+SEy1tQ_dSqqJJB5Rcw@mail.gmail.com>
Message-ID: <CAHk-=wgTKDiDiQzoH=-ho1bn_SqvxHg+SEy1tQ_dSqqJJB5Rcw@mail.gmail.com>
Subject: Re: [RFC][PATCH] tree-wide: Remove __inline__ and __inline usage
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        bp@alien8.de, namit@vmware.com, joe@perches.com,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        segher@kernel.crashing.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 11:42 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Do you want me to do that patch, or have you already just done it?

I'd rather see it go through something like -tip than doing it myself
directly, and get at least some of the automated testing before
unleashing it on an unsuspecting world.

I don't think it will affect much, but there *could* be situations
where there are some crusty __inline__ users that actually want
__always_inline behavior.

And we *may* actually have cases where we want the "let compiler make
a judgement call" behavior, so with this change people will have that
as an option. But yes, in the short term, it has the possibility of
regressions due to missed inlining.

                Linus
