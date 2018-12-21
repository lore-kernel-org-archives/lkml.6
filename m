Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73417C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3279121906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Dr/HrLVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404042AbeLUXwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 18:52:34 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39805 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732613AbeLUXwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 18:52:34 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so3149513pld.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 15:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xa8YBftbit4LNU64bv2g0Ji6QGiSR3QswJ4spPgs5h8=;
        b=Dr/HrLVsyJDciRZ3b6VzcvXivcuj7bTDCHFh7BkZ84RNzZAOmyBW+7+BqoipP6Wevk
         VMYy0d30/uBPD37UreftstG8zqPTtd/lyyASBdw31WD9HcfMjf3a/uKQG3HGK9BV1W4s
         FpIRz4A2MbKeP+Jvj0zvuAd2YDoYiBmbrt+Csa9kVRjvjbLtGOvjyAkw7FskK1T+j/B+
         LIdWXpRN9t4sEYJvI1fFHt7WKdsq40OhA07EE9QudEaCrK2gHDgAfxXyWgcWANte1hoq
         BVwhWCrIFstqmm4v506IYvt0IqdKSNx8jWThoV2LBwj0CXGPUeuvvxplg02bxVgfJUBN
         8rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xa8YBftbit4LNU64bv2g0Ji6QGiSR3QswJ4spPgs5h8=;
        b=EceKETpNDPj2bDi745X91pHkKBwEUYJxLtmxvB5Bccc/4xU45WCgJFofRfv0MV6N5k
         hLod5hY/QWIbfv/PJ04x9wj4UzI0h+CIxqMd9z6iP3/0QJc5L1wvqbQL2kSz2rl2HN6L
         5k80u30refiLS5q/F1UOXwj2IYIBV2AyrKeJupHBuivHTPhHDOOPV3a77oWJgzlkBnbA
         oXmaMTOqobjGCfCIGcl4ZoZhYH5xFqijDJNm1JUlJGXAlcuMHwSnkuBIcixZuhPThfRC
         QFEA81wEloE9KqyIOEGvqv/OBdIY/vlEpWQDDu/h6fS0EmC5Fwv3VyumrpWqWXto2ulm
         A9Ew==
X-Gm-Message-State: AJcUukd0eDBsJyodoZVOYt7vDqBS14/8L9PX69fe97/ldilE8xrhrfiJ
        T4jt83FUKikmh/DOwEKtC5/j4A==
X-Google-Smtp-Source: ALg8bN6j1YeXXULYyGA+KFxfTkusOG7wI7lX3KpaAbsIYcEUjjCn1zPjGVmg7Ej9s+ch7T9BnrVj4A==
X-Received: by 2002:a17:902:bcc7:: with SMTP id o7mr4568107pls.281.1545436352687;
        Fri, 21 Dec 2018 15:52:32 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 15sm35800446pfr.55.2018.12.21.15.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 15:52:31 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gaUak-0006MP-PS; Fri, 21 Dec 2018 16:52:30 -0700
Date:   Fri, 21 Dec 2018 16:52:30 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joe Perches <joe@perches.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Tariq Toukan <tariqt@mellanox.com>, xavier.huwei@huawei.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Stephen Warren <swarren@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: rfc: bool structure members (was Re: [PATCH V3] net/mlx4: Get
 rid of page operation after dma_alloc_coherent)
Message-ID: <20181221235230.GC13168@ziepe.ca>
References: <20181219182031.8675-1-swarren@wwwdotorg.org>
 <20181220174318.GA21404@ziepe.ca>
 <20181220174448.GA21149@lst.de>
 <1545328145.185366.500.camel@acm.org>
 <072c2d9d187daf0672bf54ab035e47a05fd1cd1d.camel@perches.com>
 <20181221033159.GF23877@ziepe.ca>
 <b906bec0fd12d25474561263087a26b8b0519fe4.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b906bec0fd12d25474561263087a26b8b0519fe4.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 09:12:43PM -0800, Joe Perches wrote:
> Care to submit a coding_style.rst patch or
> improve the one below this?

I took yours and revised it a little bit. I spent some time looking at
assembly and decided to drop the performance note, the number of cases
that run into overhead seems pretty small and probably already
requires !! to be correct. There is also an equally unlikely gain, ie
'if (a & b)' optimizes a tiny bit better for bool types.

I also added a small intro on bool, as I know some people are
unfamiliar with C11 _Bool and might think bool is just '#define bool
u8'

(for those added to the cc) I'm looking at cases, like the patch that
spawned this, where the struct has a single bool and no performance
considerations. As CH said, seeing that get converted to int due to
checkpatch is worse than having used bool. Using u8 won't make this
struct smaller or faster.

Cheers,
Jason

From c5e2c887f6326e1c4369876f39996417da5e90cc Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@mellanox.com>
Date: Fri, 21 Dec 2018 16:29:22 -0700
Subject: [PATCH] coding-style: Clarify the expectations around bool

There has been some confusion since checkpatch started warning about bool
use in structures, and people have been avoiding using it.

Many people feel there is still a legitimate place for bool in structures,
so provide some guidance on bool usage derived from the entire thread that
spawned the checkpatch warning.

Link: https://lkml.kernel.org/r/CA+55aFwVZk1OfB9T2v014PTAKFhtVan_Zj2dOjnCy3x6E4UJfA@mail.gmail.com
Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 Documentation/process/coding-style.rst | 33 ++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 4e7c0a1c427a9a..efdb1d32035fe1 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -918,7 +918,32 @@ result.  Typical examples would be functions that return pointers; they use
 NULL or the ERR_PTR mechanism to report failure.
 
 
-17) Don't re-invent the kernel macros
+17) Using bool
+--------------
+
+The Linux kernel uses the C11 standard for the bool type. bool values can only
+evaluate to 0 or 1, and implicit or explicit conversion to bool automatically
+converts the value to true or false. When using bool types the !! construction
+is not needed, which eliminates a class of bugs.
+
+When working with bool values the true and false labels should be used instead
+of 0 and 1.
+
+bool function return types, arguments and stack variables are always fine to
+use whenever appropriate. Use of bool is encouraged to improve readability and
+is often a better option than 'int' for storing boolean values.
+
+Do not use bool if cache line layout or size of the value matters, its size
+and alignment varies based on the compiled architecture. Structures that are
+optimized for alignment and size should not use bool.
+
+If a structure has many true/false values, consider consolidating them into a
+bitfield with 1 bit members, or using an appropriate fixed width type, such as
+u8.
+
+Otherwise limited use of bool in structures does improve readability.
+
+18) Don't re-invent the kernel macros
 -------------------------------------
 
 The header file include/linux/kernel.h contains a number of macros that
@@ -941,7 +966,7 @@ need them.  Feel free to peruse that header file to see what else is already
 defined that you shouldn't reproduce in your code.
 
 
-18) Editor modelines and other cruft
+19) Editor modelines and other cruft
 ------------------------------------
 
 Some editors can interpret configuration information embedded in source files,
@@ -975,7 +1000,7 @@ own custom mode, or may have some other magic method for making indentation
 work correctly.
 
 
-19) Inline assembly
+20) Inline assembly
 -------------------
 
 In architecture-specific code, you may need to use inline assembly to interface
@@ -1007,7 +1032,7 @@ the next instruction in the assembly output:
 	     : /* outputs */ : /* inputs */ : /* clobbers */);
 
 
-20) Conditional Compilation
+21) Conditional Compilation
 ---------------------------
 
 Wherever possible, don't use preprocessor conditionals (#if, #ifdef) in .c
-- 
2.19.2

