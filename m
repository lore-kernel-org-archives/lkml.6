Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033639AbeEXQ0V (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:26:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1033618AbeEXQ0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:26:14 -0400
Date: Thu, 24 May 2018 18:26:08 +0200
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
        yao.jin@linux.intel.com, fengguang.wu@intel.com, jglisse@redhat.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v3 6/9] trace_uprobe: Support SDT markers having
 reference count (semaphore)
Message-ID: <20180524162608.GA27082@redhat.com>
References: <20180417043244.7501-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180417043244.7501-7-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417043244.7501-7-ravi.bangoria@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

sorry for delay!

I am trying to recall what this code should do ;) At first glance, I do
not see any serious problem in this version... except it doesn't apply
to Linus's tree. just one question for now.

On 04/17, Ravi Bangoria wrote:
>
> @@ -941,6 +1091,9 @@ typedef bool (*filter_func_t)(struct uprobe_consumer *self,
>  	if (ret)
>  		goto err_buffer;
>  
> +	if (tu->ref_ctr_offset)
> +		sdt_increment_ref_ctr(tu);
> +

iiuc, this is probe_event_enable()...

Looks racy, but afaics the race with uprobe_mmap() will be closed by the next
change. However, it seems that probe_event_disable() can race with trace_uprobe_mmap()
too and the next 7/9 patch won't help,

> +	if (tu->ref_ctr_offset)
> +		sdt_decrement_ref_ctr(tu);
> +
>  	uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
>  	tu->tp.flags &= file ? ~TP_FLAG_TRACE : ~TP_FLAG_PROFILE;

so what if trace_uprobe_mmap() comes right after uprobe_unregister() ?
Note that trace_probe_is_enabled() is T until we update tp.flags.

Oleg.
