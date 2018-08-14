Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4311EC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FAD2172B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FAD2172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388067AbeHNUNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:13:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387747AbeHNUNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:13:01 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90C5721728;
        Tue, 14 Aug 2018 17:24:55 +0000 (UTC)
Date:   Tue, 14 Aug 2018 13:24:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        peterz@infradead.org, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] Make call_srcu() available during very early boot
Message-ID: <20180814132453.093a4921@gandalf.local.home>
In-Reply-To: <20180814170618.GA24813@linux.vnet.ibm.com>
References: <20180814162448.GA20414@linux.vnet.ibm.com>
        <20180814124945.5cf1753f@gandalf.local.home>
        <20180814170618.GA24813@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018 10:06:18 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:


> > >  #define __SRCU_STRUCT_INIT(name, pcpu_name)				\
> > > -	{								\
> > > -		.sda = &pcpu_name,					\
> > > -		.lock = __SPIN_LOCK_UNLOCKED(name.lock),		\
> > > -		.srcu_gp_seq_needed = 0 - 1,				\
> > > -		__SRCU_DEP_MAP_INIT(name)				\
> > > -	}
> > > +{									\
> > > +	.sda = &pcpu_name,						\
> > > +	.lock = __SPIN_LOCK_UNLOCKED(name.lock),			\
> > > +	.srcu_gp_seq_needed = 0 - 1,					\  
> > 
> > Interesting initialization of -1. This was there before, but still
> > interesting none the less.  
> 
> If I recall correctly, this subterfuge suppresses compiler complaints
> about initializing an unsigned long with a negative number.  :-/

Did you try:

	.srcu_gp_seq_needed = -1UL,

?

-- Steve

