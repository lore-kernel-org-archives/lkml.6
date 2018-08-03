Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53CEC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C352175D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C352175D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbeHCNUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:20:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38506 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726933AbeHCNUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:20:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6C5540216F7;
        Fri,  3 Aug 2018 11:24:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 39FB42026D65;
        Fri,  3 Aug 2018 11:24:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  3 Aug 2018 13:24:59 +0200 (CEST)
Date:   Fri, 3 Aug 2018 13:24:55 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org, liu.song.a23@gmail.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        ananth@linux.vnet.ibm.com, alexis.berlemont@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v7 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
Message-ID: <20180803112455.GA13794@redhat.com>
References: <20180731035143.11942-1-ravi.bangoria@linux.ibm.com>
 <20180731035143.11942-4-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731035143.11942-4-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 03 Aug 2018 11:24:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 03 Aug 2018 11:24:59 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

I was going to give up and ack this series, but it seems I noticed
a bug...

On 07/31, Ravi Bangoria wrote:
>
> +static int delayed_uprobe_add(struct uprobe *uprobe, struct mm_struct *mm)
> +{
> +	struct delayed_uprobe *du;
> +
> +	if (delayed_uprobe_check(uprobe, mm))
> +		return 0;
> +
> +	du  = kzalloc(sizeof(*du), GFP_KERNEL);
> +	if (!du)
> +		return -ENOMEM;
> +
> +	du->uprobe = uprobe;
> +	du->mm = mm;

I am surprised I didn't notice this before...

So
	du->mm = mm;

is fine, mm can't go away, uprobe_clear_state() does delayed_uprobe_remove(NULL,mm).

But
	du->uprobe = uprobe;

doesn't look right, uprobe can go away and it can be freed, its memory can be reused.
We can't rely on remove_breakpoint(), the application can unmap the probed page/vma.
Yes we do not care about the application in this case, say, the next uprobe_mmap() can
wrongly increment the counter, we do not care although this can lead to hard-to-debug
problems. But, if nothing else, the kernel can crash if the freed memory is unmapped.
So I think put_uprobe() should do delayed_uprobe_remove(uprobe, NULL) before kfree()
and delayed_uprobe_remove() should be updated to handle the mm==NULL case.

Also. delayed_uprobe_add() should check the list and avoid duplicates. Otherwise the
trivial

	for (;;)
		munmap(mmap(uprobed_file));

will eat the memory until uprobe is unregistered.


> +static bool valid_ref_ctr_vma(struct uprobe *uprobe,
> +			      struct vm_area_struct *vma)
> +{
> +	unsigned long vaddr = offset_to_vaddr(vma, uprobe->ref_ctr_offset);
> +
> +	return uprobe->ref_ctr_offset &&
> +		vma->vm_file &&
> +		file_inode(vma->vm_file) == uprobe->inode &&
> +		vma->vm_flags & VM_WRITE &&
> +		!(vma->vm_flags & VM_SHARED) &&

		vma->vm_flags & (VM_WRITE|VM_SHARED) == VM_WRITE &&

looks a bit better to me, but I won't insist.

> +static int delayed_uprobe_install(struct vm_area_struct *vma)
> +{
> +	struct list_head *pos, *q;
> +	struct delayed_uprobe *du;
> +	unsigned long vaddr;
> +	int ret = 0, err = 0;
> +
> +	mutex_lock(&delayed_uprobe_lock);
> +	list_for_each_safe(pos, q, &delayed_uprobe_list) {
> +		du = list_entry(pos, struct delayed_uprobe, list);
> +
> +		if (!valid_ref_ctr_vma(du->uprobe, vma))
> +			continue;
> +
> +		vaddr = offset_to_vaddr(vma, du->uprobe->ref_ctr_offset);
> +		ret = __update_ref_ctr(vma->vm_mm, vaddr, 1);
> +		/* Record an error and continue. */
> +		err = ret & !err ? ret : err;

I try to avoid the cosmetic nits, but I simply can't look at this line ;)

		if (ret && !err)
			err = ret;

> @@ -1072,7 +1281,14 @@ int uprobe_mmap(struct vm_area_struct *vma)
>  	struct uprobe *uprobe, *u;
>  	struct inode *inode;
>
> -	if (no_uprobe_events() || !valid_vma(vma, true))
> +	if (no_uprobe_events())
> +		return 0;
> +
> +	if (vma->vm_flags & VM_WRITE &&
> +	    test_bit(MMF_HAS_UPROBES, &vma->vm_mm->flags))
> +		delayed_uprobe_install(vma);

OK, so you also added the VM_WRITE check and I agree. But then I think we
should also check VM_SHARED, just like valid_ref_ctr_vma() does?

Oleg.

