Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52624C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA4C20879
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="K2tyW42J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA4C20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeLFAv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:51:58 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34361 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeLFAv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 19:51:58 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so18647153ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 16:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=27zl8fU/HOr7ybzVb97DC2+fYB7HlvYLVzEmuFxVMmc=;
        b=K2tyW42JlQRDYhNaxvTA1ZtGlw5SzlxlVXEwDA2OCJAOjZZKUkBtMQ+kANCcyZ6lh0
         +hh3EaovlriX8sLtBwYE+VDgXCDZblBsqp2Ro9Wr6mBsEm1Ol1cwmXBQNGdPDs47y2Vg
         1acx/aup5J+TvUF983fdDaOqsrvroFe3YUyws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=27zl8fU/HOr7ybzVb97DC2+fYB7HlvYLVzEmuFxVMmc=;
        b=oOAuVLGcEFxxVoEfX8o4+P6KfkbuRSuzpbwsKdw491jDdXLTZ1LFbMD9S5VJLmZweH
         L1bvT6oFXYvw+Bv12N2Lcew4lKolCmypSsgDa1gpiRmf7KgKp+jZxcYrFriSaYkhjN7K
         UFjHub4eTB14HsiH2Q4rnubnBIPn9AKUmb46vh2DpyLuD58XbP7bxW0c2P8lNG5mnPGy
         RPKWMx16uWxK/dDi9X/wr/KTEcz5aoYCHXDhNcC0TNs4OWSyYUKFGnF0GQ2/PCJwJijB
         qM1Eupv3Wm/PABnBK7ANlLa3ovBYiS9lEP3GmfPjEDTvWnxI8WHTfbxwskMljL9y8k9f
         IVlQ==
X-Gm-Message-State: AA+aEWa75r6zvj5XzCFpVp4JpFtoJY4Z9DRexmoxAFnLtMMxKfYVvwrZ
        fqiMnCYj8WUGieQSesda0+TYWQ==
X-Google-Smtp-Source: AFSGD/VA02PO8pWt6uGMI2j6WurAMmYBcSTFaCwvJG6VQY997ulVcgN5fPQXvxy/WSPzLPEpWh0bGw==
X-Received: by 2002:a17:906:1a49:: with SMTP id j9-v6mr20349531ejf.45.1544057516294;
        Wed, 05 Dec 2018 16:51:56 -0800 (PST)
Received: from andrea (dynamic-2a00-1028-8386-da8a-eacb-c188-78b9-634c.ipv6.broadband.iol.cz. [2a00:1028:8386:da8a:eacb:c188:78b9:634c])
        by smtp.gmail.com with ESMTPSA id i46sm1856384eda.37.2018.12.05.16.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 16:51:55 -0800 (PST)
Date:   Thu, 6 Dec 2018 01:51:47 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Josh Triplett <josh@joshtriplett.org>, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:core/rcu] rcutorture: Make initrd/init execute in userspace
Message-ID: <20181206005147.GA3300@andrea>
References: <tip-229ab0cb5be3bfbac5947df7240f6905470ca413@git.kernel.org>
 <20181204222412.GA6874@localhost>
 <20181204230423.GP4170@linux.ibm.com>
 <20181205222523.GA14609@localhost>
 <20181206000809.GX4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206000809.GX4170@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> commit 4f8f751961b536f77c8f82394963e8e2d26efd84
> Author: Paul E. McKenney <paulmck@linux.ibm.com>
> Date:   Tue Dec 4 14:59:12 2018 -0800
> 
>     torture: Explain and simplify odd "for" loop in mkinitrd.sh
>     
>     Why a Bourne-shell "for" loop?  And why 192 instances of "a"?  This commit
>     adds a shell comment to present the answer to these mysteries.  It also
>     uses a series of factor-of-four Bourne-shell assignments to make it
>     easy to see how many instances there are, replacing the earlier wall of
>     'a' characters.
>     
>     Reported-by: Josh Triplett <josh@joshtriplett.org>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> index da298394daa2..ff69190604ea 100755
> --- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> +++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> @@ -40,17 +40,24 @@ mkdir $T
>  cat > $T/init << '__EOF___'
>  #!/bin/sh
>  # Run in userspace a few milliseconds every second.  This helps to
> -# exercise the NO_HZ_FULL portions of RCU.
> +# exercise the NO_HZ_FULL portions of RCU.  The 192 instances of "a" was
> +# empirically shown to give a nice multi-millisecond burst of user-mode
> +# execution on a 2GHz CPU, as desired.  Modern CPUs will vary from a
> +# couple of milliseconds up to perhaps 100 milliseconds, which is an
> +# acceptable range.
> +#
> +# Why not calibrate an exact delay?  Because within this initrd, we
> +# are restricted to Bourne-shell builtins, which as far as I know do not
> +# provide any means of obtaining a fine-grained timestamp.
> +
> +a4="a a a a"
> +a16="$a4 $a4 $a4 $a4"
> +a64="$a8 $a8 $a8 $a8"

Mmh, are you sure you don't want s/a8/a16/ here? ;-)

  Andrea


> +a192="$a64 $a64 $a64"
>  while :
>  do
>  	q=
> -	for i in \
> -		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> -		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> -		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> -		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> -		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a \
> -		a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a
> +	for i in $a192
>  	do
>  		q="$q $i"
>  	done
> 
