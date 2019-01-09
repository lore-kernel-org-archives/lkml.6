Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A75AC43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A7E21783
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUo9Va03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfAIBLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:11:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37960 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbfAIBLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 20:11:36 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so2738226plb.5;
        Tue, 08 Jan 2019 17:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Yw7LxcbEhRGObVUu3WnzKblWii9vQwCnCaLzeNRym0=;
        b=cUo9Va03yYo9gO/j+AzWlh2hfYMC5oqRXuqcJl9pwC9JskKtwpCxiccsGmyDI9FiWS
         rdI8Fgxj0uf026RUpVVt7jxr+tn8Bk1Gvz1i97iyeQ++6HTsV8xZ9dyYpxV/39E0ZjH5
         UImjJB3HBdB2hjOnKB7uPdtosqmLgPT7KEHJ9mP4tV0/AmlE5ePaHS8VPcJbSBcUc5OV
         o23d2zNWiFLCr1sYdQ8AtjHE9YzVXUbFKl57aufWRK1BFrtxjK1EUkWIasILwKGEIUGk
         ICw/insHQPkkJxaVse2fBxBEXiB/3R+MwHSKU5lV6ZWYLCpslYUMluVBd7n1QS+pR1ZX
         fiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Yw7LxcbEhRGObVUu3WnzKblWii9vQwCnCaLzeNRym0=;
        b=mewf4Rq9G7s0w86auYAZtI3IbPlt01mt9hmGMlQxRIy2sRNF8PY8wQ6t1rybHHLVT/
         87l8pMZxBYYzxLAxbSPIqSA1phY58X+QsB02+30hcdec4BvWlTNd+OO3Bk/Qq7X4WQpz
         LI9h+6NqjBVnb8DUdtErSXrGi3Y2y5ZikOCOSn9S9DlXuTCbdiqmf4S4DrLTM1W91AvC
         xu7TDg0wV17i+gw/Lzxi+PK0SXpnJqakSSdHC1fzOEDQy1HG3Uv5iA7dAVqg1uabEfXD
         pNzcum4h1ThUuMOhGKrXjIzGMAAbbeMmDYjFgfJYom1nGbM/QtpIl63FeEb+cKJu877p
         fJwQ==
X-Gm-Message-State: AJcUukcmz2aoxZEInOdj4xc4VYYGvROlfStWzy0qSFBlPHIBAcEftA7w
        PlL+J/7EU71gGO22lYZDeDgaiEIX
X-Google-Smtp-Source: ALg8bN6tDb+v1igfnNaHAeQYLveZmjgj0L6jwjizsZv4CmnT4AfR400lwXqRmClJtAe/XknmcA+U7Q==
X-Received: by 2002:a17:902:e18c:: with SMTP id cd12mr3777883plb.279.1546996295621;
        Tue, 08 Jan 2019 17:11:35 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:200::7:958e])
        by smtp.gmail.com with ESMTPSA id s130sm136120735pgc.60.2019.01.08.17.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 17:11:34 -0800 (PST)
Date:   Tue, 8 Jan 2019 17:11:32 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, stable@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net
Subject: Re: [PATCH] x86/speculation: Add document to describe Spectre and
 its mitigations
Message-ID: <20190109011130.wrsrcaly2mgnou3k@ast-mbp>
References: <64efec3fda40c0758601bf9b1480a35d76d3c487.1545413988.git.tim.c.chen@linux.intel.com>
 <20181223231149.5yuenb53pavlvr3m@ast-mbp.dhcp.thefacebook.com>
 <2278b1c7-5d20-3c89-eab1-ea34145dc73d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2278b1c7-5d20-3c89-eab1-ea34145dc73d@linux.intel.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 01:12:45PM -0800, Tim Chen wrote:
> On 12/23/18 3:11 PM, Alexei Starovoitov wrote:
> > On Fri, Dec 21, 2018 at 09:44:44AM -0800, Tim Chen wrote:
> >> +
> >> +4. Kernel sandbox attacking kernel
> >> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >> +
> >> +The kernel has support for running user-supplied programs within the
> >> +kernel.  Specific rules (such as bounds checking) are enforced on these
> >> +programs by the kernel to ensure that they do not violate access controls.
> >> +
> >> +eBPF is a kernel sub-system that uses user-supplied program
> >> +to execute JITed untrusted byte code inside the kernel. eBPF is used
> >> +for manipulating and examining network packets, examining system call
> >> +parameters for sand boxes and other uses.
> >> +
> >> +A malicious local process could upload and trigger an malicious
> >> +eBPF script to the kernel, with the script attacking the kernel
> >> +using variant 1 or 2 and reading memory.
> > 
> > Above is not correct.
> > The exploit for var2 does not load bpf progs into kernel.
> > Instead the bpf interpreter is speculatively executing bpf prog
> > that was never loaded.
> > Hence CONFIG_BPF_JIT_ALWAYS_ON=y is necessary to make var2 harder
> > to exploit.
> > Same goes for other in kernel interpreters and state machines.
> > 
> >> +
> >> +Necessary Prerequisites:
> >> +1. Malicious local process
> >> +2. eBPF JIT enabled for unprivileged users, attacking kernel with secrets
> >> +on the same machine.
> > 
> > This is not quite correct either.
> > Var 1 could have been exploited with and without JIT.
> > Also above sounds like that var1 is still exploitable through bpf
> > which is not the case.
> > 
> 
> Alexi,
> 
> Do you have any suggestions on how to rewrite this two paragraphs?  You
> are probably the best person to update content for this section.

how about moving bpf bits out of this doc and placing them under Documentation/bpf/ ?
We can create bpf_security.rst there with specdown mitigations, best practices,
useful sysctl and config knobs, etc.

