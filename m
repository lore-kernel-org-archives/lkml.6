Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846CAC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C41024EC8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C41024EC8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753042AbeGBSCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:02:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752288AbeGBSCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:02:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8583EC12AA;
        Mon,  2 Jul 2018 18:02:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 24C1A2166B5D;
        Mon,  2 Jul 2018 18:01:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  2 Jul 2018 20:02:00 +0200 (CEST)
Date:   Mon, 2 Jul 2018 20:01:56 +0200
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
Message-ID: <20180702180156.GA31400@redhat.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
 <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 02 Jul 2018 18:02:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 02 Jul 2018 18:02:00 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02, Ravi Bangoria wrote:
>
> Hi Oleg,
>
> On 07/02/2018 02:39 AM, Oleg Nesterov wrote:
> > On 06/28, Ravi Bangoria wrote:
> >>
> >> @@ -294,6 +462,15 @@ int uprobe_write_opcode(struct uprobe *uprobe, struct mm_struct *mm,
> >>  	if (ret <= 0)
> >>  		goto put_old;
> >>
> >> +	/* Update the ref_ctr if we are going to replace instruction. */
> >> +	if (!ref_ctr_updated) {
> >> +		ret = update_ref_ctr(uprobe, mm, is_register);
> >> +		if (ret)
> >> +			goto put_old;
> >> +
> >> +		ref_ctr_updated = 1;
> >> +	}
> >
> > Why can't this code live in install_breakpoint() and remove_breakpoint() ?
> > this way we do not need to export "struct uprobe" and change set_swbp/set_orig_insn,
> > and the logic will be more simple.
>
> IMO, it's more easier with current approach. Updating reference counter
> inside uprobe_write_opcode() makes it tightly coupled with instruction
> patching. Basically, reference counter gets incremented only when first
> consumer gets activated and will get decremented only when last consumer
> is going away.
>
> Advantage is, we can get rid of sdt_mm_list patch*, because increment and
> decrement are anyway happening in sync. This makes the implementation lot
> more simpler. If I do it inside install_breakpoit()/ remove_breakpoint(),
> I've to reintroduce sdt_mm_list which makes code more complicated and ugly.

Why? I do not understand. Afaics you can have the same logic, but the resulting
code will be simpler and more clear.

> BTW, is there any harm in exporting struct uprobe outside of uprobe.c?

I think it is always better to avoid the exporting if possible (and avoid
changing the arch-dependant set_swbp/set_orig_insn). But once again, I think
this only complicates the code for no reason.

> > So why do we need a counter but not a boolean? IIRC, because the counter can
> > be shared, in particular 2 different uprobes can have the same >ref_ctr_offset,
> > right?
>
> Actually, it's by design. This counter keeps track of current tracers
> tracing on a particular SDT marker. So only boolean can't work here.
> Also, yes, multiple markers can share the same reference counter.

markers or uprobes? OK, I'll assume that multiple uprobes can share the counter.

> > But who else can use this counter and how? Say, can userspace update it too?
>
> There are many different ways user can change the reference counter.
> Ex, systemtap and bcc both uses uprobe to probe on a marker but reference
> counter update logic is different in both of them. Systemtap records all
> exec/mmap events and updates the counter when it finds interested process/
> vma. bcc directly hooks into process's memory (/proc/pid/mem).

OK, and how exactly they update the counter? I mean, can we assume that, say,
bcc or systemtap can only increment or decrement it?

If yes, perhaps we can simplify the kernel code...

Oleg.

