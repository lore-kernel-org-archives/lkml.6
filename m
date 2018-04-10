Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeDJLGm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 07:06:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751940AbeDJLGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 07:06:39 -0400
Date: Tue, 10 Apr 2018 13:06:33 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, srikar@linux.vnet.ibm.com,
        rostedt@goodmis.org, acme@kernel.org, ananth@linux.vnet.ibm.com,
        akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
        alexis.berlemont@gmail.com, corbet@lwn.net, dan.j.williams@intel.com,
        jolsa@redhat.com, kan.liang@intel.com, kjlx@templeofstupid.com,
        kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com, tglx@linutronix.de,
        yao.jin@linux.intel.com, fengguang.wu@intel.com, jglisse@redhat.com
Subject: Re: [PATCH v2 7/9] trace_uprobe/sdt: Fix multiple update of same
 reference counter
Message-ID: <20180410110633.GA29063@redhat.com>
References: <20180404083110.18647-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180404083110.18647-8-ravi.bangoria@linux.vnet.ibm.com>
 <20180409132928.GA25722@redhat.com>
 <84c1e60f-8aad-a0ce-59af-4fcb3f77df94@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84c1e60f-8aad-a0ce-59af-4fcb3f77df94@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

On 04/10, Ravi Bangoria wrote:
>
> > and what if __mmu_notifier_register() fails simply because signal_pending() == T?
> > see mm_take_all_locks().
> >
> > at first glance this all look suspicious and sub-optimal,
>
> Yes. I should have added checks for failure cases.
> Will fix them in v3.

And what can you do if it fails? Nothing except report the problem. But
signal_pending() is not the unlikely or error condition, it should not
cause the tracing errors.

Plus mm_take_all_locks() is very heavy... BTW, uprobe_mmap_callback() is
called unconditionally. Whatever it does, can we at least move it after
the no_uprobe_events() check? Can't we also check MMF_HAS_UPROBES?

Either way, I do not feel that mmu_notifier is the right tool... Did you
consider the uprobe_clear_state() hook we already have?

Oleg.
