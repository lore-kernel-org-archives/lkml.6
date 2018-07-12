Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF11C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031F320BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IpfUcaWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031F320BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbeGLIn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:43:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37408 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeGLInZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:43:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id n17-v6so5114829wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 01:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iXap7DYeYpsbQyalEh7351XYbxlkaaUGjBzPbw2c+gc=;
        b=IpfUcaWcRzF2WDLwf7B/Jap880GjtDde7qWxgv9Rqr+f4O1z2uuFvKBTdTpC0nUAjc
         CskqinHPjOtZ9UYDNAfOeUTsP+tfBVM+BQqzVeSDZ1nBoIuL6jL2aniOnZMv/8e8CNwv
         WCwwkuL0MiNw2bV3apH+sQ3GsrBPI2OzqKsA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iXap7DYeYpsbQyalEh7351XYbxlkaaUGjBzPbw2c+gc=;
        b=gd92ufeah8lNpCIvfPwNMSNiVDgGJXjeDyrTGNmVB/ileC8fmvTY9wf75DgMyvPs9f
         GY5YcPXRNgnxZ03NFXtOUmRVVQWDZydM8S5fWwxQDlALtI5sqrNq9Ypy7DlfRDpc4fup
         zSZeL7IOcA2PvV7jsvVaDN5qUN2OxYhq154StJSCwaRbi8Tl4HzmJf5126FJUaYfCfd8
         aKAEXDW42VCnomAsXQZqI1P+Tw1RFP1sz6MpmHo0n0hKY0DpVKjhvQWIHwa2c1xVvz4V
         hcW22DfS/wHvS+ZdHI/1luSkpfclrkJQL41qdrHJTwedlDWlZqUqIst1A639Nixfjoae
         PjBQ==
X-Gm-Message-State: AOUpUlHfM4NDM8tRI8OL76C/0S0tdYrBgoepVgTAPvZuj4OYvCNqNNFO
        pzhI8algjHZB93TftwuOZeIqyQ==
X-Google-Smtp-Source: AAOMgpfY3SESGiOrLCDiZgC6lJvTFu/u9tzfMLfRxTBLvkaq2hdsUICG/nawfLImYZ8B5BJ0UmzGfA==
X-Received: by 2002:a1c:3c4:: with SMTP id 187-v6mr668234wmd.96.1531384490771;
        Thu, 12 Jul 2018 01:34:50 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id a14-v6sm3027723wmb.44.2018.07.12.01.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 01:34:50 -0700 (PDT)
Date:   Thu, 12 Jul 2018 10:34:44 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Daniel Lustig <dlustig@nvidia.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180712083444.GA4927@andrea>
References: <Pine.LNX.4.44L0.1807091519180.2462-100000@iolanthe.rowland.org>
 <20180710093821.GA5414@andrea>
 <20180711094310.GA13963@arm.com>
 <20180711123421.GA9673@andrea>
 <20180711155751.GC18477@arm.com>
 <20180711170053.GM2476@hirez.programming.kicks-ass.net>
 <e5148058-c551-ca65-eef3-4259badecf57@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5148058-c551-ca65-eef3-4259badecf57@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> All the discussion here[1] for example is about having ordering and
> doing an smp_cond_load_acquire() on a variable which is sometimes
> protected by a CPU's rq->lock and sometimes not?  Isn't that one of the
> key use cases for this whole discussion?

Not a "pure" one:

  http://lkml.kernel.org/r/1530629639-27767-1-git-send-email-andrea.parri@amarulasolutions.com

we also need "W->R ordering" in schedule()! so there better be an
smp_mb__after_spinlock() or a barrier providing similar ordering.

Nick was suggesting a "weaker version" of this barrier back in:

  362a61ad61199e ("fix SMP data race in pagetable setup vs walking")

c.f., the comment in mm/memory.c:__pte_alloc(), but that does not
math our pattern (UNLOCK+LOCK), AFAICT.

  Andrea


> 
> [1] https://lkml.org/lkml/2015/10/6/805
> 
> Dan
