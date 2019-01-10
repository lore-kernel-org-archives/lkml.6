Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6C1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CD0214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DHcSkRi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfAJJlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:41:49 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46674 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbfAJJlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:41:46 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so9611152edt.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 01:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i5MFa3X2/QeXW4LIINyyZusBQeXO3956JIV5LmL87nA=;
        b=DHcSkRi9kYbg2HAAWl4rdJqXtHvOcgkyGbL0Zd6mV7XXOtgM2ZNMvUb6yQF7uEMqIF
         7gwDJoLkoGYaS5+TXBAOgdCaKqr6+Tj6DY/ctp+CVaZ2G77sl8wIz0mCLRgYP+1S3TQe
         9HAzOzdKbDNic3AC7XyzPb5MFtWzrCGGbqLAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i5MFa3X2/QeXW4LIINyyZusBQeXO3956JIV5LmL87nA=;
        b=faLrM6ZsAPo2jvsiBxBNkfwFnXZLLbEeUCTWVdFyADhbrAkg0tfTWmZ0CArhLOlFmL
         gpUtkhD+Zc6NrIv9M9d8RpWrkrUsnkYKhyh5GwVZAx9MjmnlahXn/FQZX06mR4Vw0WEe
         hP+Mynryb8hnLbTL23a73S6L7SIxpYNAQOKJDk9+6ftYJ1HnIG8FgxiSGIerAh8Pu1ZX
         427lrgazqo99x9dWFkyrLQmsOuDdsjJ2ONq/I48+3toDvyDrL59dwgQKqhiVElRUV8+Z
         KG40ZQKAVK0AgkNuvc3jKgh22KwEZ1Iex4JOP93V7HkJOi9ycqvJM5WhMSCj8vJYCdBE
         uQOg==
X-Gm-Message-State: AJcUukcjIVEQSGXul7MS11CKb34PPcoJW69VO7NCKMVdsJoXx3t4MaJL
        trRzj5rNwZCNLmmEyPzLzi6HXA==
X-Google-Smtp-Source: ALg8bN4CBjmKR8qGtlIICNcjJsOW0sI/fFunVYTkqo7Ay6TLUFTS8xQESzmqz+COdtzjK3RANoPbew==
X-Received: by 2002:a50:d753:: with SMTP id i19mr9116319edj.75.1547113304344;
        Thu, 10 Jan 2019 01:41:44 -0800 (PST)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id a11sm2047164edc.28.2019.01.10.01.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 01:41:43 -0800 (PST)
Date:   Thu, 10 Jan 2019 10:41:31 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, willy@infradead.org
Subject: Re: [PATCH RFC LKMM 7/7] tools/memory-model: Dynamically check SRCU
 lock-to-unlock matching
Message-ID: <20190110094131.GA11647@andrea>
References: <20190109210706.GA27268@linux.ibm.com>
 <20190109210748.29074-7-paulmck@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109210748.29074-7-paulmck@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 01:07:48PM -0800, Paul E. McKenney wrote:
> From: Luc Maranget <Luc.Maranget@inria.fr>
> 
> This commit checks that the return value of srcu_read_lock() is passed
> to the matching srcu_read_unlock(), where "matching" is determined by
> nesting.  This check operates as follows:
> 
>    1. srcu_read_lock() creates an integer token, which is stored into
>       the generated events.
>    2. srcu_read_unlock() records its second (token) argument into the
>       generated event.
>    3. A new herd primitive 'different-values' filters out pairs of events
>       with identical values from the relation passed as its argument.
>    4. The bell file applies the above primitive to the (srcu)
>       read-side-critical-section relation 'srcu-rscs' and flags non-empty
>       results.
> 
> BEWARE: Works only with herd version 7.51+6 and onwards.
> 
> Signed-off-by: Luc Maranget <Luc.Maranget@inria.fr>
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> [ paulmck: Apply Andrea Parri's off-list feedback. ]
> ---
>  tools/memory-model/linux-kernel.bell | 3 +++
>  tools/memory-model/linux-kernel.cat  | 2 ++
>  tools/memory-model/linux-kernel.def  | 2 +-
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
> index 9c42cd9ddcb4..def9131d3d8e 100644
> --- a/tools/memory-model/linux-kernel.bell
> +++ b/tools/memory-model/linux-kernel.bell
> @@ -73,3 +73,6 @@ flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
>  
>  (* Check for use of synchronize_srcu() inside an RCU critical section *)
>  flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
> +
> +(* Validate SRCU dynamic match *)
> +flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index 8dcb37835b61..95bf45f1215f 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  (*
> + * Requires herd version 7.51+6 or higher.

I'm not all that exited about spreading version requirements in the
source: we report this requirement in our README, and apparently we
already struggle to keep this information up-to-date.  So what about
squashing something like the below (assume that 7.52 will be released
by the time this patch hit mainline; if this won't be the case, we
may consider using the development version 7.51+6)? notice that this
also removes an (obsolete, at this point) comment from lock.cat.

  Andrea

diff --git a/tools/memory-model/README b/tools/memory-model/README
index 9d7d4f23503fd..b362a41358fa1 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -20,8 +20,8 @@ that litmus test to be exercised within the Linux kernel.
 REQUIREMENTS
 ============
 
-Version 7.49 of the "herd7" and "klitmus7" tools must be downloaded
-separately:
+Version 7.52 or higher of the "herd7" and "klitmus7" tools must be
+downloaded separately:
 
   https://github.com/herd/herdtools7
 
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 95bf45f1215fc..8dcb37835b613 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 (*
- * Requires herd version 7.51+6 or higher.
- *
  * Copyright (C) 2015 Jade Alglave <j.alglave@ucl.ac.uk>,
  * Copyright (C) 2016 Luc Maranget <luc.maranget@inria.fr> for Inria
  * Copyright (C) 2017 Alan Stern <stern@rowland.harvard.edu>,
diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index 305ded17e7411..a059d1a6d8a29 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -6,9 +6,6 @@
 
 (*
  * Generate coherence orders and handle lock operations
- *
- * Warning: spin_is_locked() crashes herd7 versions strictly before 7.48.
- * spin_is_locked() is functional from herd7 version 7.49.
  *)
 
 include "cross.cat"



> + *
>   * Copyright (C) 2015 Jade Alglave <j.alglave@ucl.ac.uk>,
>   * Copyright (C) 2016 Luc Maranget <luc.maranget@inria.fr> for Inria
>   * Copyright (C) 2017 Alan Stern <stern@rowland.harvard.edu>,
> diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
> index 1d6a120cde14..0c3f0ef486f4 100644
> --- a/tools/memory-model/linux-kernel.def
> +++ b/tools/memory-model/linux-kernel.def
> @@ -49,7 +49,7 @@ synchronize_rcu_expedited() { __fence{sync-rcu}; }
>  
>  // SRCU
>  srcu_read_lock(X)  __srcu{srcu-lock}(X)
> -srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X); }
> +srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
>  synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
>  
>  // Atomic
> -- 
> 2.17.1
> 
