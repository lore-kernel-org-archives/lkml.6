Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4000DC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57832087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vfhTsBGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57832087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbeIJVoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:44:23 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41082 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbeIJVoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:44:22 -0400
Received: by mail-yw1-f67.google.com with SMTP id q129-v6so8090461ywg.8;
        Mon, 10 Sep 2018 09:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yBo+85NhrUdN6aK7r+jXnl4rvCHAICnsTnP5HSqpDCI=;
        b=vfhTsBGf6nWARbvnLkOoWzM7qoHCoHnPSKBYojJrwdz4z5Ctb7rITLVMtmTJ5xb3zc
         FHSSB4KYpnG3OCjNs9aMO+sOMeReYoad3nhKqAyvdnlsVOHhVbHnGwSUrrlFuQgCkjfx
         2gZwT6BU9fwpQyMseMyKIddiyNO2mz1eVGAhQ7qTbFGaDPHgwaXirrZN3AWUwPX6DFYF
         yuZajW9Ctum2oxVbW883s5jmtDM2VyevvpG7ovCnVQtYA6aYj4NuOv3zLLAASUWyKjGn
         aarMIg5dw5itm6S8Cq7J8vnRfWoVHaLTI80d0L4HtlzYrotvdViDckzuy/nwLfMjUmdU
         +/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yBo+85NhrUdN6aK7r+jXnl4rvCHAICnsTnP5HSqpDCI=;
        b=WzOa6vkDSfK4fYtT4tm/Ix8/L2QRUqZoHYLNW5LyrquY1NhqfpIiLnil0P1g+6Jaew
         iQCo4h+wNRhXjC+q4PSzDfYxgT7OirLLDmw1aSBDcKrDx/tVvI9jj160mo55/RLoSqVG
         3p5DKkhTnRLq+d5o1O70fjxwravGxpR8J7omxd0EDaYXcE8YMPywxX28LNd2znn2NpFf
         Gt1maSRvYhN6ohjJgulMJc8tb2SxmiGU1J0tQvepn1Oq+/6hjP17Ic+ELNLJoGvkvcQC
         T0PnZs+gjEAqnpAvd2QFGMbOFy4PS7V6M0kz1xYX+JYScK8g50ECLwnNcVsHnJhsjyMt
         fW0Q==
X-Gm-Message-State: APzg51C2VjYB/dIuwY0Se8jgQPRwxm41HbSHl7Lui1o6tBj2nEqA2VSU
        hGfcFYrMa0FDPaOntnuflwM=
X-Google-Smtp-Source: ANB0VdYh5dz6PaXeLZtMLYBhUpNLPuTq1apu8WkTwRsPgR56psaVtGwkNfz7gnLLATSpWUpXbub/SQ==
X-Received: by 2002:a81:120c:: with SMTP id 12-v6mr1587847yws.61.1536598164241;
        Mon, 10 Sep 2018 09:49:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:3223])
        by smtp.gmail.com with ESMTPSA id r69-v6sm5840427ywh.44.2018.09.10.09.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 09:49:23 -0700 (PDT)
Date:   Mon, 10 Sep 2018 09:49:20 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180910164920.GE1100574@devbig004.ftw2.facebook.com>
References: <20180909125824.9150-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180909125824.9150-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ming.

On Sun, Sep 09, 2018 at 08:58:24PM +0800, Ming Lei wrote:
> @@ -196,15 +197,6 @@ static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
>  
>  	atomic_long_add(PERCPU_COUNT_BIAS, &ref->count);
>  
> -	/*
> -	 * Restore per-cpu operation.  smp_store_release() is paired
> -	 * with READ_ONCE() in __ref_is_percpu() and guarantees that the
> -	 * zeroing is visible to all percpu accesses which can see the
> -	 * following __PERCPU_REF_ATOMIC clearing.
> -	 */

So, while the location of percpu counter resetting moved, the pairing
of store_release and READ_ONCE is still required to ensure that the
clearing is visible before the switching to percpu mode becomes
effective.  Can you please rephrase and keep the above comment?

> -	for_each_possible_cpu(cpu)
> -		*per_cpu_ptr(percpu_count, cpu) = 0;
> -
>  	smp_store_release(&ref->percpu_count_ptr,
>  			  ref->percpu_count_ptr & ~__PERCPU_REF_ATOMIC);
>  }
...
> @@ -357,10 +349,11 @@ EXPORT_SYMBOL_GPL(percpu_ref_kill_and_confirm);
>  void percpu_ref_reinit(struct percpu_ref *ref)
>  {
>  	unsigned long flags;
> +	unsigned long __percpu *percpu_count;
>  
>  	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
>  
> -	WARN_ON_ONCE(!percpu_ref_is_zero(ref));
> +	WARN_ON_ONCE(__ref_is_percpu(ref, &percpu_count));

Can you elaborate this part?  This doesn't seem required for the
described change.  Why is it part of the patch?

Thanks.

-- 
tejun
