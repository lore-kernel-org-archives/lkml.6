Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754087AbeBGS0X (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 13:26:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:51702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753390AbeBGS0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 13:26:22 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA65720835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 7 Feb 2018 13:26:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        mingo@redhat.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rao.shoaib@oracle.com
Subject: Re: [PATCH 0/2] rcu: Transform kfree_rcu() into kvfree_rcu()
Message-ID: <20180207132619.6595e4a9@gandalf.local.home>
In-Reply-To: <20180207181055.GB12446@bombadil.infradead.org>
References: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain>
        <20180207021703.GC3617@linux.vnet.ibm.com>
        <20180207042334.GA16175@bombadil.infradead.org>
        <20180207050200.GH3617@linux.vnet.ibm.com>
        <db9bda80-7506-ae25-2c0a-45eaa08963d9@virtuozzo.com>
        <20180207083104.GK3617@linux.vnet.ibm.com>
        <20180207085700.393f90d0@gandalf.local.home>
        <20180207174513.5cc9b503@redhat.com>
        <20180207181055.GB12446@bombadil.infradead.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2018 10:10:55 -0800
Matthew Wilcox <willy@infradead.org> wrote:

> > For the record, I fully agree with Steve here. 

Thanks, but...

> > 
> > And being a performance "fanatic" I don't like to have the extra branch
> > (and compares) in the free code path... but it's a MM-decision (and
> > sometimes you should not listen to "fanatics" ;-))  
> 
> While free_rcu() is not withut its performance requirements, I think it's
> currently dominated by cache misses and not by branches.  By the time RCU
> gets to run callbacks, memory is certainly L1/L2 cache-cold and probably
> L3 cache-cold.  Also calling the callback functions is utterly impossible
> for the branch predictor.

I agree with Matthew.

This is far from any fast path. A few extra branches isn't going to
hurt anything here as it's mostly just garbage collection. With or
without the Spectre fixes.

-- Steve
