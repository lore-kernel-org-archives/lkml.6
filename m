Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4432AC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7C42145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7C42145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbeJRVXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:23:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34539 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeJRVXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:23:34 -0400
Received: from [213.61.215.195] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gD8Fe-0000MO-7U; Thu, 18 Oct 2018 15:22:10 +0200
Date:   Thu, 18 Oct 2018 15:22:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [Patch v3 06/13] mm: Pass task instead of task->mm as argument
 to set_dumpable
In-Reply-To: <c793fcd092063a68f1de7ce982df2ebb347a3542.1539798901.git.tim.c.chen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1810181504020.1647@nanos.tec.linutronix.de>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com> <c793fcd092063a68f1de7ce982df2ebb347a3542.1539798901.git.tim.c.chen@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018, Tim Chen wrote:

> Change the argument to set_dumpable from task->mm to task.  This allows us
> to later add hooks to modify a task's property according to whether it is
> a non-dumpable task. Non dumpable tasks demand a higher level of security.
> Changes the dumpable value from in to unsigned int as negative number is
> not allowed.

Please use paragraphs and do not write everything in one big lump. Also
please start with the context and the rationale for a change before
explaining what. Suggestion:

  set_dumpable() takes a struct mm pointer as argument, but for finer
  grained security control of hardware vulnerabilites a architecture
  specific set_dumpable() needs to be added which needs access to the task
  struct and not only to the tasks mm struct.

  Replace the mm pointer with a task pointer and fix up implementation and
  call sites.
  
  While at it change the type of the value argument from int to unsigned
  int as the valid dumpable mode values are greater equal zero.

Hmm?

> diff --git a/fs/exec.c b/fs/exec.c
> index 1ebf6e5..e204830 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1362,9 +1362,9 @@ void setup_new_exec(struct linux_binprm * bprm)
>  	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
>  	    !(uid_eq(current_euid(), current_uid()) &&
>  	      gid_eq(current_egid(), current_gid())))
> -		set_dumpable(current->mm, suid_dumpable);
> +		set_dumpable(current, (unsigned int) suid_dumpable);

Yuck. For one the type cast is pointless, but can we please fix the whole
thing and make suid_dumpable unsigned int?

Thanks,

	tglx
