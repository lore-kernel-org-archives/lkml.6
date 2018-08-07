Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7A5C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B105214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B105214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387942AbeHGNuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:50:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726555AbeHGNuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:50:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B59F540241C4;
        Tue,  7 Aug 2018 11:36:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id B15801C663;
        Tue,  7 Aug 2018 11:36:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  7 Aug 2018 13:36:27 +0200 (CEST)
Date:   Tue, 7 Aug 2018 13:36:23 +0200
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
Message-ID: <20180807113622.GC19831@redhat.com>
References: <20180731035143.11942-1-ravi.bangoria@linux.ibm.com>
 <20180731035143.11942-4-ravi.bangoria@linux.ibm.com>
 <20180803112455.GA13794@redhat.com>
 <bfb47985-8f58-e5e4-f8b4-695dfea7937f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfb47985-8f58-e5e4-f8b4-695dfea7937f@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 07 Aug 2018 11:36:27 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 07 Aug 2018 11:36:27 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

On 08/06, Ravi Bangoria wrote:
>
> >> +static int delayed_uprobe_add(struct uprobe *uprobe, struct mm_struct *mm)
> >> +{
> >> +	struct delayed_uprobe *du;
> >> +
> >> +	if (delayed_uprobe_check(uprobe, mm))
> >> +		return 0;
> >> +
> >> +	du  = kzalloc(sizeof(*du), GFP_KERNEL);
> >> +	if (!du)
> >> +		return -ENOMEM;
> >> +
> >> +	du->uprobe = uprobe;
> >> +	du->mm = mm;
> >
> > I am surprised I didn't notice this before...
> >
> > So
> > 	du->mm = mm;
> >
> > is fine, mm can't go away, uprobe_clear_state() does delayed_uprobe_remove(NULL,mm).
> >
> > But
> > 	du->uprobe = uprobe;
> >
> > doesn't look right, uprobe can go away and it can be freed, its memory can be reused.
> > We can't rely on remove_breakpoint(),
>
>
> I'm sorry. I didn't get this. How can uprobe go away without calling
>     uprobe_unregister()
>     -> rergister_for_each_vma()
>        -> remove_breakpoint()
> And remove_breakpoint() will get called

assuming that _unregister() will find the same vma with the probed insn. But
as I said, the application can munmap the probed page/vma.

No?

> > Also. delayed_uprobe_add() should check the list and avoid duplicates. Otherwise the
> > trivial
> >
> > 	for (;;)
> > 		munmap(mmap(uprobed_file));
> >
> > will eat the memory until uprobe is unregistered.
>
>
> I'm already calling delayed_uprobe_check(uprobe, mm) from delayed_uprobe_add().

Oops ;)

Oleg.

