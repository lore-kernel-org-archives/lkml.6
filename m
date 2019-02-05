Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48593C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C87D2146F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfBEJSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:18:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45794 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfBEJSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:18:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id q15so2702613wro.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 01:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bwKkBCF+9isGOvXuiIMP4wXJ+umkZY3Wc52SOZ5A6so=;
        b=JmyqfWEjsagTHZJ40KGCdgGuysvU/WFGrh5swzgc8O2zZRbrcU2e8M3rqdWEGTHC7B
         RewFjoIM+KrXwYahgDYglQ45u9OpqzcJ3/EnbV6Ive6H0pOAU5yuZBFTq7NC5tn4s111
         ETXu/uegkpQUrwi3MJWnE3TV8QuoEjAIkvILr/N9SZsm3AoJbrFCjlbOWBUQjCnLpEzu
         uPALJtEFGv0Pi5nIzoeUeiXeYGpQkudhVNr51000RN1yBBal8IOdKZa7WcKP135T6Dq0
         +LhQvWWUf9O6d/xmEWqWprloEw1fS7RpZzS8AXoI6bmdBT1KjbCv8BrusaYhQDv3ZKAY
         cnRA==
X-Gm-Message-State: AHQUAubAxk6rgWdZ3azrlLG22EiyBkusv3IJrL85sGnu5SF5n+GMhhMI
        q9xWNX+wrufZYWDjMQRGz7K/Gw==
X-Google-Smtp-Source: AHgI3IYSEtZ+nhUlMe9Ul2qAsANuJfy9YkfrdWNEkVGRVGHJc0aCtUO+hd5+/vrDyvTH5UEpbw/PzQ==
X-Received: by 2002:a5d:4206:: with SMTP id n6mr2835806wrq.327.1549358284067;
        Tue, 05 Feb 2019 01:18:04 -0800 (PST)
Received: from localhost.localdomain ([151.15.206.34])
        by smtp.gmail.com with ESMTPSA id o9sm10119659wmh.3.2019.02.05.01.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 01:18:03 -0800 (PST)
Date:   Tue, 5 Feb 2019 10:18:01 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v6 3/5] cgroup/cpuset: make callback_lock raw
Message-ID: <20190205091801.GD30905@localhost.localdomain>
References: <20190117084739.17078-1-juri.lelli@redhat.com>
 <20190117084739.17078-4-juri.lelli@redhat.com>
 <20190204115550.GB17550@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204115550.GB17550@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/19 12:55, Peter Zijlstra wrote:
> On Thu, Jan 17, 2019 at 09:47:37AM +0100, Juri Lelli wrote:
> > @@ -2366,7 +2366,7 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
> >  	cpuset_filetype_t type = seq_cft(sf)->private;
> >  	int ret = 0;
> >  
> > -	spin_lock_irq(&callback_lock);
> > +	raw_spin_lock_irq(&callback_lock);
> >  
> >  	switch (type) {
> >  	case FILE_CPULIST:
> > @@ -2388,7 +2388,7 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
> >  		ret = -EINVAL;
> >  	}
> >  
> > -	spin_unlock_irq(&callback_lock);
> > +	raw_spin_unlock_irq(&callback_lock);
> >  	return ret;
> >  }
> >  
> could we not convert this to use cpuset_mutex ?

Looks like we can.

I'll do the change.
