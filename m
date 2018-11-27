Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B111C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB59320828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DI3z0hgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB59320828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbeK0LWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:22:49 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41007 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbeK0LWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:22:48 -0500
Received: by mail-ed1-f65.google.com with SMTP id z28so17484308edi.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 16:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k8iOlVxSKhg9npKXXykaFBaHfDaJKx5StjBvmcvLyYM=;
        b=DI3z0hgmhQaMc98oONcI60nIeQ5l/a7mFmDaY38KoayPHRGygvFst3b0PggRAhkQrJ
         WIOWf/ICC+jUyvR7tbHlZG1dRhvYSYwng+otKrUsJis+DDZhtWXXnDoBaxf660vUJQU7
         2MbWfE+g+V2QClNN13cRlAwEfNozqR0bUhwKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k8iOlVxSKhg9npKXXykaFBaHfDaJKx5StjBvmcvLyYM=;
        b=j4DK+D5N36giwbBU1WLGUVWlmqxDXHp9kDbqMSeAEwfOuJW8MLSScCOJ2FIPBoTylA
         EuVxcQUzpFO/LEwfqKigTCS1hsudHUj8ffHjH3NZxNpICTq4J9EIc9eXerxtmoFTb2dI
         13mpmxQTxTLDHExsRSFFrjGwnEX/NfHmeSEWc1sLknMRkffNO1v6HJDRpHZmCAqcJXr/
         GzmoiEngszojHCYO2irM+y/g3OB+rk447F/Kzk4PW76uwgNtxTAIcNnt0rupf+1d58q+
         WcIdeK613D8Of07Dz/BK2RplJTUaoNf/gOZOh+CwAN9CpnFsj73cozwmi0bsH2H4Q+0j
         Jhkg==
X-Gm-Message-State: AGRZ1gJLPSvrygzBuNiqMy11lpMaz9DDFSUt3ju2H4MmbpRlaxbcq5Lk
        rtWu9fOUAB/LEfwMipFGJga7yg==
X-Google-Smtp-Source: AJdET5ep8sfrA7ZgYIhlQZDQ6WqU4MwhU36/vEAho8IV09ATEMLUtKo1BOCHngON1eoiIGR+XM1kGA==
X-Received: by 2002:a17:906:154c:: with SMTP id c12-v6mr21746945ejd.69.1543278409755;
        Mon, 26 Nov 2018 16:26:49 -0800 (PST)
Received: from andrea (dynamic-2a00-1028-8386-da8a-eacb-c188-78b9-634c.ipv6.broadband.iol.cz. [2a00:1028:8386:da8a:eacb:c188:78b9:634c])
        by smtp.gmail.com with ESMTPSA id z2sm551081edd.4.2018.11.26.16.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 16:26:49 -0800 (PST)
Date:   Tue, 27 Nov 2018 01:26:42 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] tools/memory-model: Add SRCU support
Message-ID: <20181127002642.GA4087@andrea>
References: <Pine.LNX.4.44L0.1811151101310.1308-100000@iolanthe.rowland.org>
 <20181119120120.GA5092@andrea>
 <20181126223509.GM4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126223509.GM4170@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> commit 72f61917f12236514a70017d1ebafb9b8d34a9b6
> Author: Paul E. McKenney <paulmck@linux.ibm.com>
> Date:   Mon Nov 26 14:26:43 2018 -0800
> 
>     tools/memory-model: Update README for addition of SRCU
>     
>     This commit updates the section on LKMM limitations to no longer say
>     that SRCU is not modeled, but instead describe how LKMM's modeling of
>     SRCU departs from the Linux-kernel implementation.
>     
>     TL;DR:  There is no known valid use case that cares about the Linux
>     kernel's ability to have partially overlapping SRCU read-side critical
>     sections.
>     
>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

Indeed!,

Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>

  Andrea


> 
> diff --git a/tools/memory-model/README b/tools/memory-model/README
> index 0f2c366518c6..9d7d4f23503f 100644
> --- a/tools/memory-model/README
> +++ b/tools/memory-model/README
> @@ -221,8 +221,29 @@ The Linux-kernel memory model has the following limitations:
>  		additional call_rcu() process to the site of the
>  		emulated rcu-barrier().
>  
> -	e.	Sleepable RCU (SRCU) is not modeled.  It can be
> -		emulated, but perhaps not simply.
> +	e.	Although sleepable RCU (SRCU) is now modeled, there
> +		are some subtle differences between its semantics and
> +		those in the Linux kernel.  For example, the kernel
> +		might interpret the following sequence as two partially
> +		overlapping SRCU read-side critical sections:
> +
> +			 1  r1 = srcu_read_lock(&my_srcu);
> +			 2  do_something_1();
> +			 3  r2 = srcu_read_lock(&my_srcu);
> +			 4  do_something_2();
> +			 5  srcu_read_unlock(&my_srcu, r1);
> +			 6  do_something_3();
> +			 7  srcu_read_unlock(&my_srcu, r2);
> +
> +		In contrast, LKMM will interpret this as a nested pair of
> +		SRCU read-side critical sections, with the outer critical
> +		section spanning lines 1-7 and the inner critical section
> +		spanning lines 3-5.
> +
> +		This difference would be more of a concern had anyone
> +		identified a reasonable use case for partially overlapping
> +		SRCU read-side critical sections.  For more information,
> +		please see: https://paulmck.livejournal.com/40593.html
>  
>  	f.	Reader-writer locking is not modeled.  It can be
>  		emulated in litmus tests using atomic read-modify-write
> 
