Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeECGvX convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 02:51:23 -0400
Received: from send.cs.ucr.edu ([169.235.30.36]:59568 "EHLO send.cs.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751951AbeECGvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 02:51:22 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] kernel/exit.c: pointer sighand could be uninitialized
From: Chengyu Song <csong@cs.ucr.edu>
In-Reply-To: <20180503050650.GX30522@ZenIV.linux.org.uk>
Date: Wed, 2 May 2018 23:44:20 -0700
Cc: Yizhuo Zhai <yzhai003@ucr.edu>, mingo@kernel.org,
        keescook@chromium.org, akpm@linux-foundation.org,
        paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        Zhiyun Qian <zhiyunq@cs.ucr.edu>
Content-Transfer-Encoding: 8BIT
Message-Id: <6CE8A8F1-EA1D-489D-BA4A-E9E02C0B43E2@cs.ucr.edu>
References: <CABvMjLTfuDqNEt4+1E6R47UFQOj7N1SAhb3KCwxjHsxm7itaog@mail.gmail.com>
 <20180503050650.GX30522@ZenIV.linux.org.uk>
To: Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right. Should have checked the commit history ... this has been brought up before:

> Peter Zijlstra - May 18, 2016, 5:02 p.m.
> 
> > +struct task_struct *task_rcu_dereference(struct task_struct **ptask)
> > +{
> > +	struct task_struct *task;
> > +	struct sighand_struct *sighand;
> 
> I think that needs: ' = NULL',

and led to the comments added there.

Sorry for wasting your time.

-chengyu

> On May 2, 2018, at 10:06 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> On Wed, May 02, 2018 at 06:48:57PM -0700, Yizhuo Zhai wrote:
>> Variable 'sighand' could be uninitialized if probe_kernel_address fails
>> (-EFAULT). The later use in the if statement may lead to undefined behavior.
> 
> Excuse me, but that's nonsense.  The value *copied* into it (in case
> probe_kernel_address() has not failed) may be just as uninitialized.
> If mere "compare uninitialized pointer value to NULL" can cause nasal demons to fly,
> 	* we are screwed anyway
> 	* the piece of crap compiler should be printed on sandpaper and used to
> polish its authors.
> 
> Read the comments in there, please.  Especially the one regarding the second case.
