Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165778AbeBORwA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:52:00 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:51774 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1164231AbeBORv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:51:57 -0500
Date: Thu, 15 Feb 2018 12:51:56 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Akira Yokosawa <akiyks@gmail.com>
cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>, <mingo@kernel.org>,
        <parri.andrea@gmail.com>, <will.deacon@arm.com>,
        <peterz@infradead.org>, <boqun.feng@gmail.com>, <npiggin@gmail.com>,
        <dhowells@redhat.com>, <j.alglave@ucl.ac.uk>, <luc.maranget@inria.fr>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: Trial of conflict resolution of Alan's patch
In-Reply-To: <fa35db31-7a73-4865-1505-5378dcb2a0f8@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1802151246190.1286-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2018, Akira Yokosawa wrote:

> So, I attempted to rebase the patch to current (somewhat old) master of
> https://github.com/aparri/memory-model. Why? Because the lkmm branch
> in Paul's -rcu tree doesn't have linux-kernel-hardware.cat.
> 
> However, after this change, Z6.0+pooncelock+pooncelock+pombonce still
> has the result "Sometimes". I must have done something wrong in the
> conflict resolution.
> 
> Note: I have almost no idea what this patch is doing. I'm just hoping
> to give a starting point of a discussion.

Yes, that litmus test gives "Sometimes" both with and without the 
patch.  But consider instead this slightly changed version of that 
test, in which P2 reads Z instead of writing it:

C Z6.0-variant

{}

P0(int *x, int *y, spinlock_t *mylock)
{
	spin_lock(mylock);
	WRITE_ONCE(*x, 1);
	WRITE_ONCE(*y, 1);
	spin_unlock(mylock);
}

P1(int *y, int *z, spinlock_t *mylock)
{
	int r0;

	spin_lock(mylock);
	r0 = READ_ONCE(*y);
	WRITE_ONCE(*z, 1);
	spin_unlock(mylock);
}

P2(int *x, int *z)
{
	int r1;
	int r2;

	r2 = READ_ONCE(*z);
	smp_mb();
	r1 = READ_ONCE(*x);
}

exists (1:r0=1 /\ 2:r2=1 /\ 2:r1=0)

Without the patch, this test gives "Sometimes"; with the patch it gives 
"Never".  That is what I thought Paul was talking about originally.  

Sorry if my misunderstanding caused too much confusion for other 
people.

Alan
