Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932130AbeBGQeV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 11:34:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:37238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754466AbeBGQeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 11:34:19 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9300D21788
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 7 Feb 2018 11:34:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        mingo@redhat.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, brouer@redhat.com,
        rao.shoaib@oracle.com
Subject: Re: [PATCH 0/2] rcu: Transform kfree_rcu() into kvfree_rcu()
Message-ID: <20180207113416.33b6247b@gandalf.local.home>
In-Reply-To: <20180207161846.GA902@bombadil.infradead.org>
References: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain>
        <20180207021703.GC3617@linux.vnet.ibm.com>
        <20180207042334.GA16175@bombadil.infradead.org>
        <20180207050200.GH3617@linux.vnet.ibm.com>
        <db9bda80-7506-ae25-2c0a-45eaa08963d9@virtuozzo.com>
        <20180207083104.GK3617@linux.vnet.ibm.com>
        <20180207085700.393f90d0@gandalf.local.home>
        <20180207161846.GA902@bombadil.infradead.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2018 08:18:46 -0800
Matthew Wilcox <willy@infradead.org> wrote:

> Do we need to be able to free any of those objects in order to rename
> kfree_rcu() to just free_rcu()?

I'm just nervous about tightly coupling free_rcu() with all the *free()
from the memory management system. I've been burnt in the past by doing
such things.

What's the down side of having a way of matching *free_rcu() with all
the *free()s? I think it's easier to understand, and rcu doesn't need
to worry about changes of *free() code.

To me:

	kfree_rcu(x);

is just a quick way of doing 'kfree(x)' after a synchronize_rcu() call.

But a "free_rcu(x)", is something I have to think about, because I
don't know from the name exactly what it is doing.

I know this may sound a bit bike shedding, but the less I need to think
about how other sub systems work, the easier it is to concentrate on my
own sub system.

-- Steve
