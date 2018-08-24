Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D47C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982572157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="GQklfvfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982572157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeHXQZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:25:27 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:44451 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeHXQZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:25:26 -0400
Received: by mail-yb0-f196.google.com with SMTP id l16-v6so3416648ybk.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 05:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2AatoVlufRk1VTQc1uxJbg3CMnuCesgfMYFZzOv0h6I=;
        b=GQklfvfA65Xai1LppNf8dXzIhzBf3TMrFLggqerv/LoJ+MWIbCkZ/rcw1BKHyzFmxY
         V3kO84J8KrUUOMyZF/JPmGIpUoOpctQhbX75oOz6Qk6HhM6nPAcNGH5/ol74aG43nORI
         szcZ5KUTLsFItc2y4Y4DvgR3x2UG1CizxEL0t0R61EW4nYat2jt5HvjbTW88hl6q3ZVc
         PBZHed/vAjXF79DpUeZ4kdQV+09HnzN/LLk+0w5Qm93DS/TTlxrBZN5emcdrqrAAjgSC
         lZQ73hwGOatKE2aNlulT3SnQ16CmrSD0TOlG/P/fGhvcsXEaeqFRWE/YhO4gL2WXzVtu
         RSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2AatoVlufRk1VTQc1uxJbg3CMnuCesgfMYFZzOv0h6I=;
        b=j22b6wleDfU3vM69Sw3viI8dgwIA4epzadsu4SvU/FLuveuWj0nafyDHT42ZavMpho
         awrPT20KhaFh8kNlCbykMFEGAQD89ptj0pnXYcSg8W1gER25sHLBIUCyU7SlTGa6K0MB
         ASKKeyLXKQJyOuKpKnmSAzqfNSJWb8M1FHMaHZXCo6FqK01EO3vAMbUYxTuCsJi92wra
         Qpo6mWkAwHG4dXYmdhF28dwXYSj6U4VSen0dAH5VKcUhBRilNw5ksYapenx/3Rzu/QMX
         iSdcAZlHtnqqk29DpXjwEAnNNTV3c3Bp43iBgU07Z7gYlJOi8hryMC83s6SyocPhgydP
         CE/w==
X-Gm-Message-State: APzg51BfL5XYR8JD5KxVxCahbG0Jnel9LCmOhS0r70Ti1dLiNZDlwswO
        FlG3RdvmVb0RBmrsa3ekak81Wg==
X-Google-Smtp-Source: ANB0VdZmNVF0p6EW9Bg4xUh4QDrM95qRExvnKQ9G/1fcZPSkExrVY4z3hM3M+D4i8ME/Wr+TGy6/Zw==
X-Received: by 2002:a25:8005:: with SMTP id m5-v6mr867175ybk.487.1535115054358;
        Fri, 24 Aug 2018 05:50:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:fac7])
        by smtp.gmail.com with ESMTPSA id j8-v6sm2931595ywj.6.2018.08.24.05.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 05:50:53 -0700 (PDT)
Date:   Fri, 24 Aug 2018 08:50:52 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Andy Lutomirski <luto@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH v2 1/3] mm: rework memcg kernel stack accounting
Message-ID: <20180824125052.GA13774@cmpxchg.org>
References: <20180821213559.14694-1-guro@fb.com>
 <20180822141213.GO29735@dhcp22.suse.cz>
 <20180823162347.GA22650@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823162347.GA22650@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 09:23:50AM -0700, Roman Gushchin wrote:
> On Wed, Aug 22, 2018 at 04:12:13PM +0200, Michal Hocko wrote:
> > On Tue 21-08-18 14:35:57, Roman Gushchin wrote:
> > > @@ -248,9 +253,20 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
> > >  static inline void free_thread_stack(struct task_struct *tsk)
> > >  {
> > >  #ifdef CONFIG_VMAP_STACK
> > > -	if (task_stack_vm_area(tsk)) {
> > > +	struct vm_struct *vm = task_stack_vm_area(tsk);
> > > +
> > > +	if (vm) {
> > >  		int i;
> > >  
> > > +		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
> > > +			mod_memcg_page_state(vm->pages[i],
> > > +					     MEMCG_KERNEL_STACK_KB,
> > > +					     -(int)(PAGE_SIZE / 1024));
> > > +
> > > +			memcg_kmem_uncharge(vm->pages[i],
> > > +					    compound_order(vm->pages[i]));
> > 
> > when do we have order > 0 here?
> 
> I guess, it's not possible, but hard-coded 1 looked a bit crappy.
> Do you think it's better?

Yes, specifying the known value (order 0) is much better. I asked
myself the same question as Michal: we're walking through THREAD_SIZE
in PAGE_SIZE steps, how could it possibly be a higher order page?

It adds an unnecessary branch to the code and the reader's brain.
