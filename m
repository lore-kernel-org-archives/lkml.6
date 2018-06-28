Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC101C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADD32790F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeXNvAKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADD32790F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966026AbeF1UXD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752881AbeF1UXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:23:01 -0400
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF8F327921
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 20:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530217381;
        bh=3uR/svpXwiY3T1jMgHIraI2J27+mcsWt0eEAkXT6Ynw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=AeXNvAKSD5SmlZ2Acd3T49BfJNQ91gE98fLa1YFNnSyCYj8OxUk6lSlSTIRqlbchg
         4p1HPsrqdyUmBZYMnAGKrVuBORSvh75swyfKjzRo0CmZ6c0LsDRB0U/AuMfMZ8bAnn
         c8dioRdpVKhA5I0Pb/IbysKij/QEuRB/vSuAbnYs=
Received: by mail-wm0-f46.google.com with SMTP id z137-v6so10356620wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 13:23:00 -0700 (PDT)
X-Gm-Message-State: APt69E15CC+T+CuoNKf+x7irmd1QGQqy9MtyZRVMPN2bn6Lf0zBizR9f
        55YVDBAJlhepgQtNxecFZpdV9gckcANNE9qg5Rva/Q==
X-Google-Smtp-Source: AAOMgpdH4Bcr+YJ+YMSRjPqM2s1XPrpXlXLU25NobWOo0N2oYjBYQvYScVHXl+wn1JDFd7gwnQNlPCcFzyUAmurPJd8=
X-Received: by 2002:a1c:4a9d:: with SMTP id n29-v6mr8690665wmi.46.1530217379095;
 Thu, 28 Jun 2018 13:22:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7e92:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 13:22:38
 -0700 (PDT)
In-Reply-To: <20180628162359.9054-1-mathieu.desnoyers@efficios.com>
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 28 Jun 2018 13:22:38 -0700
X-Gmail-Original-Message-ID: <CALCETrULo_VP4XHbXcZTevWY5d-6PdHUtrDS8DEF_OaozQOaNg@mail.gmail.com>
Message-ID: <CALCETrULo_VP4XHbXcZTevWY5d-6PdHUtrDS8DEF_OaozQOaNg@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: validate rseq_cs fields are < TASK_SIZE
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 9:23 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> Validating the abort_ip field of rseq_cs ensures that the kernel don't
> return to an invalid address when returning to userspace after an abort.
> I don't fully trust each architecture code to cleanly deal with invalid
> return addresses.
>
> Validating the range [ start_ip, start_ip + post_commit_offset ] is an
> extra validation step ensuring that userspace provides valid values to
> describe the critical section.
>
> If validation fails, the process is killed with a segmentation fault.
>
> Change the rseq ABI so rseq_cs start_ip, post_commit_offset and abort_ip
> fields are seen as 64-bit fields by both 32-bit and 64-bit kernels rather
> that ignoring the 32 upper bits on 32-bit kernels. This ensures we have
> a consistent behavior for a 32-bit binary executed on 32-bit kernels and
> in compat mode on 64-bit kernels.

This is okay with me for a fix outside the merge window.  Can you do a
followup for the next merge window that fixes it better, though?  In
particular, TASK_SIZE is generally garbage.  I think a better fix
would be something like adding a new arch-overridable helper like:

static inline unsigned long current_max_user_addr(void) { return TASK_SIZE; }

and overriding it on x86 as something like:

static inline unsigned long current_max_user_addr(void) {
#ifdef CONFIG_IA32_EMULATION
  return user_64bit_mode(current_pt_regs()) ? TASK_SIZE_MAX : (1UL << 32) - 1;
#else
  return TASK_SIZE_MAX;
}

TASK_SIZE really needs to die.
