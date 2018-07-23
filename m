Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1415ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952CF20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952CF20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388842AbeGWR2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:28:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388542AbeGWR2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:28:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C625BD9E;
        Mon, 23 Jul 2018 16:26:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 397C77C3B;
        Mon, 23 Jul 2018 16:26:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 23 Jul 2018 18:26:33 +0200 (CEST)
Date:   Mon, 23 Jul 2018 18:26:29 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v6 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
Message-ID: <20180723162629.GA8584@redhat.com>
References: <20180716084706.28244-1-ravi.bangoria@linux.ibm.com>
 <20180716084706.28244-4-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716084706.28244-4-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 23 Jul 2018 16:26:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 23 Jul 2018 16:26:33 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a mixed feeling about this series... I'll try to summarise my thinking
tomorrow, but I do not see any obvious problem so far. Although I have some
concerns about 5/6, I need to re-read it after sleep.


On 07/16, Ravi Bangoria wrote:
>
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
> +		if (!du->uprobe->ref_ctr_offset ||

Is it possible to see ->ref_ctr_offset == 0 in delayed_uprobe_list?

> @@ -1072,7 +1282,13 @@ int uprobe_mmap(struct vm_area_struct *vma)
>  	struct uprobe *uprobe, *u;
>  	struct inode *inode;
>  
> -	if (no_uprobe_events() || !valid_vma(vma, true))
> +	if (no_uprobe_events())
> +		return 0;
> +
> +	if (vma->vm_flags & VM_WRITE)
> +		delayed_uprobe_install(vma);

Obviously not nice performance-wise... OK, I do not know if it will actually
hurt in practice and probably we can use the better data structures if necessary.
But can't we check MMF_HAS_UPROBES at least? I mean,

	if (vma->vm_flags & VM_WRITE && test_bit(MMF_HAS_UPROBES, &vma->vm_mm->flags))
		delayed_uprobe_install(vma);

?


Perhaps we can even add another flag later, MMF_HAS_DELAYED_UPROBES set by
delayed_uprobe_add().

Oleg.

