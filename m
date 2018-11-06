Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AC4C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C0220827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JO0qWV36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C0220827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388673AbeKGEqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:46:04 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35328 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387804AbeKGEqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:46:04 -0500
Received: by mail-lf1-f67.google.com with SMTP id d7-v6so9733394lfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 11:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xh1YW4TLVzoxWPV5pcwDLa+/6PZPrjIYN54hW6mR+Bw=;
        b=JO0qWV36mbcGhMrEzN0m/cdfvg0Kv+rRbV1X9IpZm5otpm3tLr+L7PbXkdyCGVnJay
         /z7oVLeqJLhBh++28EItoaCAospcqz2EMr7la+rqzYc1Fp+IVXhtcC88vBMQ0HeD5OKW
         u6j4bTu9gBVv1wyjWjIxSJbL/VhhjHq5cb3so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xh1YW4TLVzoxWPV5pcwDLa+/6PZPrjIYN54hW6mR+Bw=;
        b=Vh0g/qgM4cj62X3E0NWKVDHSXeAElwcSfIB2/ky9TMcaWoyPjMOsq5+1skHJwQox00
         OUGV92X2BbbHy6bVqEbcvAdXBtU8WbUob8JUi30krPRwxwA4S+fupKsuW8fbyymdL4Ft
         5EKM3Fu+OTS0/fZjor+g6IY/Y4NZZ1jxdZF6HA7aUmagaRg2CKdYRItLIGfY3+k5bOE3
         ilqy8whxsFtKZMPBFXnY1c5yCvK9AjWeXjrwrQO1MHJF1afIR9yy8fflX/Zu2eudgPUn
         bxiMlUDtV8OEcM7bCzf7Y0sEs2yMWTF56oFrStljraf6D8NuErprS7Dztyo/A0Qvwpq9
         4kJQ==
X-Gm-Message-State: AGRZ1gKPSQzidAokFOdIQZuJxnJBxIFUummU5gu2krNzliK1G8oyIoU1
        oK5D4m8SOar/w+186yMry2zR4Q4fHro=
X-Google-Smtp-Source: AJdET5eZEXWQ883fXZhecnbzj2dNYu5wKpkTnbDiXVcpYr6xOCArW0AaejYQF1WouY43xJ3wtnTxnQ==
X-Received: by 2002:a19:1365:: with SMTP id j98mr15375352lfi.55.1541531958582;
        Tue, 06 Nov 2018 11:19:18 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id s17-v6sm3298756lji.87.2018.11.06.11.19.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 11:19:17 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id k19-v6so12488491lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 11:19:16 -0800 (PST)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr7271346ljh.59.1541531955992;
 Tue, 06 Nov 2018 11:19:15 -0800 (PST)
MIME-Version: 1.0
References: <20181106100229.GI22431@hirez.programming.kicks-ass.net>
In-Reply-To: <20181106100229.GI22431@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 6 Nov 2018 11:18:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjFL-4p-4FrJbtKADXRaBPK_Pi_-BSSqm_j784Mq6aHjQ@mail.gmail.com>
Message-ID: <CAHk-=wjFL-4p-4FrJbtKADXRaBPK_Pi_-BSSqm_j784Mq6aHjQ@mail.gmail.com>
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

On Tue, Nov 6, 2018 at 2:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Therefore I'm proposing to run:
>
>   git grep -l "\<__inline\(\|__\)\>" | while read file
>   do
>         sed -i -e 's/\<__inline\(\|__\)\>/inline/g' $file
>   done
>
> On your current tree, and apply the below fixup patch on top of that
> result.

So I started doing this, and in fact fixed up a few more issues by
hand on top of your patch, but then realized hat it's somewhat
dangerous and possibly broken.

For the uapi header files in particular, __inline__ may actually be
required. Depending on use, and compiler settings, "inline" can be a
word reserved for the user, and shouldn't be used by system headers.

Now, several uapi headers obviously *do* use "inline", and I think in
this day and age that's fine, but I don't actually want to break
possible valid uses.

So I'd argue that we don't actually want to get rid of "__inline__" at
all, because we may need it.

But we *could* get rid of these two lines in include/linux/compiler_types.h

  #define __inline__ inline
  #define __inline   inline

and just say that "inline" for the kernel means "always_inline", but
if you use __inline__ or __inline then you get the "raw" compiler
inlining.

Then people can decide to get rid of __inline__ on a case-by-case basis.

                 Linus
