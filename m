Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C98C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C5D21747
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C5D21747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbeHMOcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:32:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728557AbeHMOcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:32:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C4A940122B3;
        Mon, 13 Aug 2018 11:50:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 738F52026D66;
        Mon, 13 Aug 2018 11:50:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 13 Aug 2018 13:50:23 +0200 (CEST)
Date:   Mon, 13 Aug 2018 13:50:19 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Song Liu <liu.song.a23@gmail.com>, srikar@linux.vnet.ibm.com,
        Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
Message-ID: <20180813115019.GB28360@redhat.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com>
 <CAPhsuW49+qA7kT7yE4tgbnAuox-iOzssg-jc2abG8XDo6XeX8A@mail.gmail.com>
 <95a1221e-aecc-42be-5239-a2c2429be176@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95a1221e-aecc-42be-5239-a2c2429be176@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 13 Aug 2018 11:50:23 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 13 Aug 2018 11:50:23 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/13, Ravi Bangoria wrote:
>
> On 08/11/2018 01:27 PM, Song Liu wrote:
> >> +
> >> +static void delayed_uprobe_delete(struct delayed_uprobe *du)
> >> +{
> >> +       if (!du)
> >> +               return;
> > Do we really need this check?
>
> Not necessary though, but I would still like to keep it for a safety.

Heh. I tried to ignore all minor problems in this version, but now that Song
mentioned this unnecessary check...

Personally I really dislike the checks like this one.

	- It can confuse the reader who will try to understand the purpose

	- it can hide a bug if delayed_uprobe_delete(du) is actually called
	  with du == NULL.

IMO, you should either remove it and let the kernel crash (to notice the
problem), or turn it into

	if (WARN_ON(!du))
		return;

which is self-documented and reports the problem without kernel crash.

> >> +       rc_vma = find_ref_ctr_vma(uprobe, mm);
> >> +
> >> +       if (rc_vma) {
> >> +               rc_vaddr = offset_to_vaddr(rc_vma, uprobe->ref_ctr_offset);
> >> +               ret = __update_ref_ctr(mm, rc_vaddr, is_register ? 1 : -1);
> >> +
> >> +               if (is_register)
> >> +                       return ret;
> >> +       }
> > Mixing __update_ref_ctr() here and delayed_uprobe_add() in the same
> > function is a little confusing (at least for me). How about we always use
> > delayed uprobe for uprobe_mmap() and use non-delayed in other case(s)?
>
>
> No. delayed_uprobe_add() is needed for uprobe_register() case to handle race
> between uprobe_register() and process creation.

Yes.

But damn, process creation (exec) is trivial. We could add a new uprobe_exec()
hook and avoid delayed_uprobe_install() in uprobe_mmap().

Afaics, the really problematic case is dlopen() which can race with _register()
too, right?

Oleg.

