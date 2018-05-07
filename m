Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbeEGP46 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 11:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752303AbeEGP45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 11:56:57 -0400
Date: Tue, 8 May 2018 00:56:51 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: oleg@redhat.com, peterz@infradead.org, srikar@linux.vnet.ibm.com,
        rostedt@goodmis.org, acme@kernel.org, ananth@linux.vnet.ibm.com,
        akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
        alexis.berlemont@gmail.com, corbet@lwn.net, dan.j.williams@intel.com,
        jolsa@redhat.com, kan.liang@intel.com, kjlx@templeofstupid.com,
        kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com, tglx@linutronix.de,
        yao.jin@linux.intel.com, fengguang.wu@intel.com, jglisse@redhat.com
Subject: Re: [PATCH v3 6/9] trace_uprobe: Support SDT markers having
 reference count (semaphore)
Message-Id: <20180508005651.45553d3cf72521481d16b801@kernel.org>
In-Reply-To: <f3d066d2-a85a-bd21-d4f9-fc27e59135df@linux.ibm.com>
References: <20180417043244.7501-1-ravi.bangoria@linux.vnet.ibm.com>
        <20180417043244.7501-7-ravi.bangoria@linux.vnet.ibm.com>
        <20180504134816.8633a157dd036489d9b0f1db@kernel.org>
        <206e4a16-ae21-7da3-f752-853dc2f51947@linux.ibm.com>
        <f3d066d2-a85a-bd21-d4f9-fc27e59135df@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 May 2018 13:51:21 +0530
Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:

> Hi Masami,
> 
> On 05/04/2018 07:51 PM, Ravi Bangoria wrote:
> >
> >>> +}
> >>> +
> >>> +static void sdt_increment_ref_ctr(struct trace_uprobe *tu)
> >>> +{
> >>> +	struct uprobe_map_info *info;
> >>> +
> >>> +	uprobe_down_write_dup_mmap();
> >>> +	info = uprobe_build_map_info(tu->inode->i_mapping,
> >>> +				tu->ref_ctr_offset, false);
> >>> +	if (IS_ERR(info))
> >>> +		goto out;
> >>> +
> >>> +	while (info) {
> >>> +		down_write(&info->mm->mmap_sem);
> >>> +
> >>> +		if (sdt_find_vma(tu, info->mm, info->vaddr))
> >>> +			sdt_update_ref_ctr(info->mm, info->vaddr, 1);
> >> Don't you have to handle the error to map pages here?
> > Correct.. I think, I've to feedback error code to probe_event_{enable|disable}
> > and handler failure there.
> 
> I looked at this. Actually, It looks difficult to feedback errors to
> probe_event_{enable|disable}, esp. in the mmap() case.

Hmm, can't you roll that back if sdt_increment_ref_ctr() fails?
If so, how does sdt_decrement_ref_ctr() work in that case?

> Is it fine if we just warn sdt_update_ref_ctr() failures in dmesg? I'm
> doing this in [PATCH 7]. (Though, it makes more sense to do that in
> [PATCH 6], will change it in next version).

Of course we need to warn it at least, but the best is rejecting to
enable it.

> 
> Any better ideas?
> 
> BTW, same issue exists for normal uprobe. If uprobe_mmap() fails,
> there is no feedback to trace_uprobe and no warnigns in dmesg as
> well !! There was a patch by Naveen to warn such failures in dmesg
> but that didn't go in: https://lkml.org/lkml/2017/9/22/155

Oops, that's a real bug. It seems the ball is in Naveen's hand.
Naveen, could you update it according to Oleg's comment, and resend it?

> 
> Also, I'll add a check in sdt_update_ref_ctr() to make sure reference
> counter never goes to negative incase increment fails but decrement
> succeeds. OTOH, if increment succeeds but decrement fails, the
> counter remains >0 but there is no harm as such, except we will
> execute some unnecessary code.

I see. Please carefully clarify whether such case is kernel's bug or not.
I would like to know what the condition causes that uneven behavior.

Thank you,

> 
> Thanks,
> Ravi
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
