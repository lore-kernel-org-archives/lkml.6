Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754204AbeBGSLJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 13:11:09 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:49151 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754002AbeBGSLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 13:11:07 -0500
Date: Wed, 7 Feb 2018 10:10:55 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        mingo@redhat.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rao.shoaib@oracle.com
Subject: Re: [PATCH 0/2] rcu: Transform kfree_rcu() into kvfree_rcu()
Message-ID: <20180207181055.GB12446@bombadil.infradead.org>
References: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain>
 <20180207021703.GC3617@linux.vnet.ibm.com>
 <20180207042334.GA16175@bombadil.infradead.org>
 <20180207050200.GH3617@linux.vnet.ibm.com>
 <db9bda80-7506-ae25-2c0a-45eaa08963d9@virtuozzo.com>
 <20180207083104.GK3617@linux.vnet.ibm.com>
 <20180207085700.393f90d0@gandalf.local.home>
 <20180207174513.5cc9b503@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207174513.5cc9b503@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 05:45:13PM +0100, Jesper Dangaard Brouer wrote:
> On Wed, 7 Feb 2018 08:57:00 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> > To me kvfree() is a special case and should not be used by RCU as a
> > generic function. That would make RCU and MM much more coupled than
> > necessary.
> 
> For the record, I fully agree with Steve here. 
> 
> And being a performance "fanatic" I don't like to have the extra branch
> (and compares) in the free code path... but it's a MM-decision (and
> sometimes you should not listen to "fanatics" ;-))

While free_rcu() is not withut its performance requirements, I think it's
currently dominated by cache misses and not by branches.  By the time RCU
gets to run callbacks, memory is certainly L1/L2 cache-cold and probably
L3 cache-cold.  Also calling the callback functions is utterly impossible
for the branch predictor.
