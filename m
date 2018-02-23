Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeBWQAH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:00:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:48858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751808AbeBWQAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:00:04 -0500
Subject: Re: Reasoning about memory ordering
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        mathieu.desnoyers@efficios.com, Peter Zijlstra <peterz@infradead.org>,
        parri.andrea@gmail.com
References: <0db16ef6-c805-b1f6-527f-8fec149e3df5@suse.com>
 <20180223153807.64666cfe@alans-desktop>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <c7e3e457-fac3-7e9f-2045-f4b9a7d54702@suse.com>
Date: Fri, 23 Feb 2018 17:59:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180223153807.64666cfe@alans-desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.02.2018 17:38, Alan Cox wrote:
>> Given this is the current state of the code (it's part of btrfs) I believe
>> the following could/should be done: 
> 
> Is there benchmarking data to show that a custom lock is justified
> (especiaally given it's going to mean btrfs and rtlinux don't play
> together nicely since it won't be able to see the mutex lock and do
> priority boosting ?)

No, unfortunately this is not code that was written by me. I'm just
arguing it's not entirely correct. Generally in btrfs we'd like to allow
concurrent DIO read/write accesses to unrelated portionsin a file. Hence
I can't just use inode_Lock (DIO writes are synchronized with
inode_lock). Also I cannot use inode_shared_Lock to synchronize multiple
DIO reader against writers (including truncate) since this tanks
perfromance and I already tried[0] this approach and received a NAK...

[0] https://patchwork.kernel.org/patch/10232015/

> 
> Alan
> 
> 
> 
