Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEF6C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59A220645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59A220645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeIDX3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:29:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:19412 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbeIDX3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:29:07 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 12:02:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,330,1531810800"; 
   d="scan'208";a="71570405"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.20])
  by orsmga006.jf.intel.com with ESMTP; 04 Sep 2018 12:02:41 -0700
Date:   Tue, 4 Sep 2018 12:02:41 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Fengguang Wu <fengguang.wu@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Huang Ying <ying.huang@intel.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Peng DongX <dongx.peng@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 2/5] [PATCH 2/5] proc: introduce
 /proc/PID/idle_bitmap
Message-ID: <20180904190241.GB5869@linux.intel.com>
References: <20180901112818.126790961@intel.com>
 <20180901124811.530300789@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180901124811.530300789@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2018 at 07:28:20PM +0800, Fengguang Wu wrote:
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index da3dbfa09e79..732a502acc27 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -305,6 +305,7 @@ extern const struct file_operations proc_pid_smaps_rollup_operations;
>  extern const struct file_operations proc_tid_smaps_operations;
>  extern const struct file_operations proc_clear_refs_operations;
>  extern const struct file_operations proc_pagemap_operations;
> +extern const struct file_operations proc_mm_idle_operations;
>  
>  extern unsigned long task_vsize(struct mm_struct *);
>  extern unsigned long task_statm(struct mm_struct *,
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index dfd73a4616ce..376406a9cf45 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1564,6 +1564,69 @@ const struct file_operations proc_pagemap_operations = {
>  	.open		= pagemap_open,
>  	.release	= pagemap_release,
>  };
> +
> +/* will be filled when kvm_ept_idle module loads */
> +struct file_operations proc_ept_idle_operations = {
> +};
> +EXPORT_SYMBOL_GPL(proc_ept_idle_operations);

Exposing EPT outside of VMX specific code is wrong, e.g. this should
be something like proc_kvm_idle_operations.  This is a common theme
for all of the patches.  Only the low level bits that are EPT specific
should be named as such, everything else should be encapsulated via
KVM or some other appropriate name. 

> +static ssize_t mm_idle_read(struct file *file, char __user *buf,
> +			    size_t count, loff_t *ppos)
> +{
> +	struct task_struct *task = file->private_data;
> +	ssize_t ret = -ESRCH;

No need for @ret, just return the error directly at the end.  And
-ESRCH isn't appropriate for a task that exists but doesn't have an
associated KVM object.

> +
> +	// TODO: implement mm_walk for normal tasks
> +
> +	if (task_kvm(task)) {
> +		if (proc_ept_idle_operations.read)
> +			return proc_ept_idle_operations.read(file, buf, count, ppos);
> +	}

Condensing the task_kvm and ops check into a single if saves two lines
per instance, e.g.:

	if (task_kvm(task) && proc_ept_idle_operations.read)
		return proc_ept_idle_operations.read(file, buf, count, ppos);
> +
> +	return ret;
> +}
> +
> +
> +static int mm_idle_open(struct inode *inode, struct file *file)
> +{
> +	struct task_struct *task = get_proc_task(inode);
> +
> +	if (!task)
> +		return -ESRCH;
> +
> +	file->private_data = task;
> +
> +	if (task_kvm(task)) {
> +		if (proc_ept_idle_operations.open)
> +			return proc_ept_idle_operations.open(inode, file);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mm_idle_release(struct inode *inode, struct file *file)
> +{
> +	struct task_struct *task = file->private_data;
> +
> +	if (!task)
> +		return 0;
> +
> +	if (task_kvm(task)) {
> +		if (proc_ept_idle_operations.release)
> +			return proc_ept_idle_operations.release(inode, file);
> +	}
> +
> +	put_task_struct(task);
> +	return 0;
> +}
> +
> +const struct file_operations proc_mm_idle_operations = {
> +	.llseek		= mem_lseek, /* borrow this */
> +	.read		= mm_idle_read,
> +	.open		= mm_idle_open,
> +	.release	= mm_idle_release,
> +};
> +
>  #endif /* CONFIG_PROC_PAGE_MONITOR */
>  
>  #ifdef CONFIG_NUMA
> -- 
> 2.15.0
> 
> 
> 
