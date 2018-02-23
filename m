Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeBWMa0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 07:30:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:56005 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751351AbeBWMaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 07:30:25 -0500
From: Nikolay Borisov <nborisov@suse.com>
Subject: Reasoning about memory ordering
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        mathieu.desnoyers@efficios.com, Peter Zijlstra <peterz@infradead.org>,
        parri.andrea@gmail.com
Message-ID: <0db16ef6-c805-b1f6-527f-8fec149e3df5@suse.com>
Date: Fri, 23 Feb 2018 14:30:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I'm cc'ing a bunch of people I know are well-versed in 
the black arts of memory ordering! 

Currently in btrfs we have roughly the following sequence: 

T1:													T2:
i_size_write(inode, newsize);                                                         						
set_bit(BTRFS_INODE_READDIO_NEED_LOCK, &inode->runtime_flags);          				atomic_inc(&inode->i_dio_count);
smp_mb(); 												if (iov_iter_rw(iter) == READ) {
														if (test_bit(BTRFS_INODE_READDIO_NEED_LOCK, &BTRFS_I(inode)->runtime_flags)) {
if (atomic_read(&inode->i_dio_count)) {											if (atomic_dec_and_test(&inode->i_dio_count))   
	wait_queue_head_t *wq = bit_waitqueue(&inode->i_state, __I_DIO_WAKEUP);                 				wake_up_bit(&inode->i_state, __I_DIO_WAKEUP);
        DEFINE_WAIT_BIT(q, &inode->i_state, __I_DIO_WAKEUP);                    				}
                                                                                				if (offset >= i_size_read(inode))
        do {                                                                    			               return;
                prepare_to_wait(wq, &q.wq_entry, TASK_UNINTERRUPTIBLE);                                 }      
                if (atomic_read(&inode->i_dio_count))                           
                        schedule();                                             
        } while (atomic_read(&inode->i_dio_count));                             
        finish_wait(wq, &q.wq_entry);           
}

smp_mb__before_atomic();                                                
clear_bit(BTRFS_INODE_READDIO_NEED_LOCK, &inode->runtime_flags);     

The semantics I'm after are: 

1. If T1 goes to sleep, then T2 would see the 
BTRFS_INODE_READDIO_NEED_LOCK and hence will execute the 
atomic_dec_and_test and possibly wake up T1. This flag serves as a way 
to indicate to possibly multiple T2 (dio readers) that T1 is blocked
and they should unblock it and resort to acquiring some locks (this is not 
visible in this excerpt of code for brevity). It's sort of a back-off 
mechanism.

2. BTRFS_INODE_READDIO_NEED_LOCK bit must be set _before_ going to sleep 

3. BTRFS_INODE_READDIO_NEED_LOCK must be cleared _after_ the thread has 
been woken up. 

4. After T1 is woken up, it's possible that a new T2 comes and doesn't see 
the  BTRFS_INODE_READDIO_NEED_LOCK flag set but this is fine, since the check 
for i_size should cause T2 to just return (it will also execute atomic_dec_and_test)

Given this is the current state of the code (it's part of btrfs) I believe
the following could/should be done: 

1. The smp_mb after the set_bit in T1 could be removed, since there is 
already an implied full mm in prepare_to_wait. That is if we go to sleep, 
then T2 is guaranteed to see the flag/i_size_write happening by merit of 
the implied memory barrier in prepare_to_wait/schedule. But what if it doesn't 
go to sleep? I still would like the i_size_write to be visible to T2

2. The bit clearing code in T1 should be possible to be replaced by 
clear_bit_unlock (this was suggested by PeterZ on IRC).

3. I suspect there is a memory barrier in T2 that is missing. Perhaps
there should be an smp_mb__before_atomic right before the test_bit so that 
it's ordered with the implied smp_mb in T1's prepare_to_wait. 
