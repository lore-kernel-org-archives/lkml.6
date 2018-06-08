Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tKbYGC6kGlsjfAAAmS7hNA
	; Fri, 08 Jun 2018 15:46:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2865C607DC; Fri,  8 Jun 2018 15:46:00 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1nqrKwz7"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 86BE360590;
	Fri,  8 Jun 2018 15:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86BE360590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeFHPp4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 11:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752253AbeFHPpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 11:45:54 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CB41206B7;
        Fri,  8 Jun 2018 15:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528472754;
        bh=n110tSqAwn+pK27UjSskUGnplidWClQcVRLni8sJcXE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1nqrKwz7rOfVawa208VntQaO2GwtO/IVZeSlp1x/W/uBRIcbauPkCz5XKdVzdqd7i
         R36Zz5kzz0eUpiGJe6YW03jbyXrvvOj3l6Ep2Nl7caNsTNah2v6SKyf0NbsB9djPSr
         2ne3ueddE5cfBPWYFjZehmkJNWwAvp+VfTJRekgI=
Date: Sat, 9 Jun 2018 00:45:49 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: oleg@redhat.com, srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH 0/7] Uprobes: Support SDT markers having reference count
 (semaphore)
Message-Id: <20180609004549.ea7b1854772217598bb1cdfd@kernel.org>
In-Reply-To: <71f19b63-a641-1705-f087-a39b8b81c4be@linux.ibm.com>
References: <20180606083344.31320-1-ravi.bangoria@linux.ibm.com>
        <20180608101023.cbf20db485026213d490cb7c@kernel.org>
        <0d487b32-3141-ec30-6cca-eba7159d70b0@linux.ibm.com>
        <20180608141431.c0196a2c80a8d4701bc9db58@kernel.org>
        <71f19b63-a641-1705-f087-a39b8b81c4be@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jun 2018 12:04:25 +0530
Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:

> Hi Masami,
> 
> >> So for kernel modules,
> >>
> >> is it fine to change current ABI from
> >>     uprobe_register(inode, offset, consumer)
> >> to
> >>     uprobe_register(inode, offset, ref_ctr_offset, consumer)
> >>
> >> Or I should introduce new function for this:
> >>     uprobe_register_refctr(inode, offset, ref_ctr_offset, consumer)
> >> and export it to kernel module?
> >>
> >> What's your suggestion?
> > 
> > Latter is fine to me. Since the refctr is introduced totally in userspace
> > (for SDT) and free-address userspace probing doesn't need refctr, maybe
> > we should keep those separated.
> 
> Sure.
> 
> > 
> >> [...]
> >>
> >>>>
> >>>>  - This patches still has one issue. If there are multiple instances of
> >>>>    same application running and user wants to trace any particular
> >>>>    instance, trace_uprobe is updating reference counter in all instances.
> >>>>    This is not a problem on user side because instruction is not replaced
> >>>>    with trap/int3 and thus user will only see samples from his interested
> >>>>    process. But still this is more of a correctness issue. I'm working on
> >>>>    a fix for this.
> >>>
> >>> Hmm, it sounds like not a correctness issue, but there maybe a performace
> >>> tradeoff. Tracing one particulear instance, other instances also will get
> >>> a performance loss
> >>
> >>
> >> Right, but it's temporary. I mean, putting everything in to this series was making
> >> it complex. So this is the initial one and I'll send followup patches which will
> >> optimize the reference counter update.
> > 
> > Ah, OK. If you have prepared the followup patches, could you also send it
> > with this series? Perhups it will help us to understand the issue clearer.
> 
> Not ready as such.. it's making the code bit complicated. I'm working on it
> and will send the next series with those patches included.

OK, thanks!

> >>> (Only if the parameter preparation block is heavy,
> >>> because the heaviest part of probing - trap/int3 and recording data - isn't
> >>> executed.)
> >>>> BTW, why this happens? I thought the refcounter part is just a data which
> >>> is not shared among processes...
> >>>
> >>
> >> This happens because we are not calling consumer_filter function. consumer_filter
> >> is the one who decides whether to change the instruction to trap or not in a given
> >> mm. We also need to call it before updating reference counter.
> > 
> > Hmm, it sounds simple... maybe we can increment refctr in install_breakpoint/
> > remove_breakpoint?
> 
> Not really, it would be simpler if I can put it inside install_breakpoint().
> Consider an mmap() case. Probed instruction resides in the text section whereas
> reference counter resides in the data section. These sections gets mapped using
> separate mmap() calls. So, when process mmaps the text section we will change the
> instruction, but section holding the reference counter may not have been mapped
> yet in the virtual memory. If so, we will fail to update the reference counter.

Got it. 
In such case, maybe we can hook the target page mmapped and do install_breakpoint()
at that point. Since the instruction is protected by a refctr, unless mmap the
page on where the refctr is, the program doesn't reach the tracepoint. Is that right?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
