Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1170C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 20:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EBD216E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 20:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AuIKTQSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0EBD216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbeJUEeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 00:34:15 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:46165 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725746AbeJUEeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 00:34:15 -0400
Received: by mail-ed1-f44.google.com with SMTP id v22-v6so1438683eds.13
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 13:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vga9uxOk9UJJKweYvD9I2ZzcNh/2rFvmD7GFIxa2hTQ=;
        b=AuIKTQSorYrwnPeEvktnS/fdS3vEhimASiob9Tb+QhmKmfTQe/QTsnJtT4lxucodv7
         5U9GxeH/EIPM8EZBDdXkffa5NGysR8TUtgnybz7PhJMjkiQYlycW3GDfk8SwSAvBJD5A
         yhigKUGgEy5Uyra/tAf/U5JlY2Ae2i7YJRiis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vga9uxOk9UJJKweYvD9I2ZzcNh/2rFvmD7GFIxa2hTQ=;
        b=fS0Udf92CEsoHQg08KGN9d8t6lu3cBclGq91cm9RKwMIdmmtvsjGcNTTVA9gKRyGFA
         Y810QnMT+Usz8sgRm/YyahgGELj4ChWjfZ33QKYGv0myfgvNMzSmGImtpqtlyu6JV59O
         p4GLgpus2XUG+VMj+jimfmhN+1u5eFubpTHgU+uCrX1uD33Y1O2EkdtXsXKv6wDoDU1S
         8Gohg4Xf7X2W0+cKtd8d9+cWHMN0CyfOeJs16AA1eLg8M18NzYtrIIGZe/Czg/dQ8pnO
         AxZJZO1FpS7DnwVTN61/ChWGnMF1tOBMXfAgskqps9uuWEdZ5u90XbVYAGvMFLWMhyqR
         FY/Q==
X-Gm-Message-State: ABuFfogmH7xYTSbPvb2ryyR73GNLnosdp3X2bhe+RmWFuAd45zrDT6Bc
        +lfnCAL0/I7ZscCNhU2pmv0Vfw==
X-Google-Smtp-Source: ACcGV62HZIxj5s5IFa50LmGN1ZWn3XqZH7kXf+975C0jIiWys4ltbIn+myI9wDAq7X0ligwCFmXfsg==
X-Received: by 2002:a50:f284:: with SMTP id f4-v6mr9356809edm.233.1540066956584;
        Sat, 20 Oct 2018 13:22:36 -0700 (PDT)
Received: from andrea (15.152.230.94.awnet.cz. [94.230.152.15])
        by smtp.gmail.com with ESMTPSA id x15-v6sm12276654edm.26.2018.10.20.13.22.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Oct 2018 13:22:35 -0700 (PDT)
Date:   Sat, 20 Oct 2018 22:22:29 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        davidtgoldblatt@gmail.com, stern@rowland.harvard.edu,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com
Subject: Re: Interrupts, smp_load_acquire(), smp_store_release(), etc.
Message-ID: <20181020202229.GA10526@andrea>
References: <20181020161049.GA13756@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181020161049.GA13756@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> The second (informal) litmus test has a more interesting Linux-kernel
> counterpart:
> 
> 	void t1_interrupt(void)
> 	{
> 		r0 = READ_ONCE(y);
> 		smp_store_release(&x, 1);
> 	}
> 
> 	void t1(void)
> 	{
> 		smp_store_release(&y, 1);
> 	}
> 
> 	void t2(void)
> 	{
> 		r1 = smp_load_acquire(&x);
> 		r2 = smp_load_acquire(&y);
> 	}
> 
> On store-reordering architectures that implement smp_store_release()
> as a memory-barrier instruction followed by a store, the interrupt could
> arrive betweentimes in t1(), so that there would be no ordering between
> t1_interrupt()'s store to x and t1()'s store to y.  This could (again,
> in paranoid theory) result in the outcome r0==0 && r1==0 && r2==1.

FWIW, I'd rather call "paranoid" the act of excluding such outcome ;-)
but I admit that I've only run this test in *my mind*: in an SC world,

  CPU1				CPU2

  t1()
    t1_interrupt()
      r0 = READ_ONCE(y); // =0
				t2()
				  r1 = smp_load_acquire(&x); // =0
      smp_store_release(&x, 1);
    smp_store_release(&y, 1);
				  r2 = smp_load_acquire(&y); // =1


> So how paranoid should we be with respect to interrupt handlers for
> smp_store_release(), smp_load_acquire(), and the various RMW atomic
> operations that are sometimes implemented with separate memory-barrier
> instructions?  ;-)

Good question! ;-)

  Andrea


> 
> 							Thanx, Paul
> 
