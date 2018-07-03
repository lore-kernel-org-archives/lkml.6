Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F57C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A0D2064D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A0D2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934090AbeGCQgy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:36:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934030AbeGCQgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:36:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D29424078B89;
        Tue,  3 Jul 2018 16:36:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 30CF71C640;
        Tue,  3 Jul 2018 16:36:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  3 Jul 2018 18:36:49 +0200 (CEST)
Date:   Tue, 3 Jul 2018 18:36:45 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
Message-ID: <20180703163645.GA23144@redhat.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
 <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com>
 <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 03 Jul 2018 16:36:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 03 Jul 2018 16:36:49 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03, Ravi Bangoria wrote:
>
> Ok let me explain the difference.
>
> Current approach:
>
>     ------------
>     register_for_each_vma() / uprobe_mmap()
>       install_breakpoint()
>         uprobe_write_opcode() {
>                 if (instruction is not already patched) {
>                         /* Gets called only _once_. */
>                         increment the reference counter;
>                         patch the instruction;
>                 }
>         }

Yes I see. And I am not sure this all is correct. And I still hope we can do
something better, I'll write another email.

For now, let's discuss your current approach.

> Now, if I put it inside install_breakpoint():
>
>     ------------
>     uprobe_register()
>       register_for_each_vma()
>         install_breakpoint() {
>                 /* Called _for each consumer_ */

How so? it is not called for each consumer. I think you misread this code.

>                 increment the reference counter _once_;
>                 uprobe_write_opcode()
> 		...
>         }

So. I meant that you can move the _same_ logic into install_breakpoint() and
remove_breakpoint(). And note that ref_ctr_updated in uprobe_write_opcode() is
only needed because it can retry the fault.

IOW, you can simply do update_ref_ctr(is_register => 1) at the start of
install_breakpoint(), and update_ref_ctr(0) in remove_breakpoint(), there are
no other callers of uprobe_write_opcode(). To clarify, it is indirectly called
by set_swbp() and set_orig_insn(), but this doesn't matter.

Or you can kill update_ref_ctr() and (roughly) do

	rc_vma = find_ref_ctr_vma(...);
	if (rc_vma)
		__update_ref_ctr(..., 1);
	else
		delayed_uprobe_add(...);

at the start of install_breakpoint() and

	rc_vma = find_ref_ctr_vma(...);
	if (rc_vma)
		__update_ref_ctr(..., -1);
	delayed_uprobe_remove(...);

in remove_breakpoint().


>     uprobe_mmap()
>       install_breakpoint() {
>                 increment the reference counter _for each consumer_;

Again, I do not understand where do you see the "for each consumer" thing.

>                 uprobe_write_opcode()

In short. There is a 1:1 relationship between uprobe_write_opcode(is_register => 1)
and install_breakpoint(), and between uprobe_write_opcode(is_register => 0) and
remove_breakpoint(). Whatever uprobe_write_opcode() can do if is_register == 1 can be
done in install_breakpoint(), the same for is_register == 0 and remove_breakpont().

What have I missed?

Oleg.

