Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018B3C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8CC206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfBWDCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 22:02:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfBWDCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 22:02:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4248120645;
        Sat, 23 Feb 2019 03:02:45 +0000 (UTC)
Date:   Fri, 22 Feb 2019 22:02:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-ID: <20190222220243.633bbf48@gandalf.local.home>
In-Reply-To: <20190223022850.nv4hnweueetprbot@ast-mbp.dhcp.thefacebook.com>
References: <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
        <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
        <CAHk-=wib9VSbwbS+N82ZPNtvt4vrvYyHyQduhFimX8nyjCyZyA@mail.gmail.com>
        <20190222.133842.1637029078039923178.davem@davemloft.net>
        <CAHk-=wh9uWJaih5i6qBPer5rzcs=A+yb_ejU093b1esAhoFveQ@mail.gmail.com>
        <20190222225103.o5rr5zr4fq77jdg4@ast-mbp.dhcp.thefacebook.com>
        <CAHk-=wjJqVXydQf_dprBmr=zXsyNVrB9mBCmDL0nGmH_b0vY5g@mail.gmail.com>
        <20190222235618.dxewmv5dukltaoxl@ast-mbp.dhcp.thefacebook.com>
        <CAHk-=whu_iwv4TQP5Xd62bTfWW-uswVecUbFeiSCuTWnH1xgPg@mail.gmail.com>
        <20190223022850.nv4hnweueetprbot@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 18:28:53 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> First we introduce bpf_probe_kernel_read and bpf_probe_user_read and
> introduce clang/gcc tooling to catch the mistakes.
> Going over this 400+ places and manually grepping kernel sources
> for __user keyword is not a great proposal if we want to keep those users.
> Once we have this working we can remove bpf_probe_read() altogether.
> Rejecting bpf prog at load time is a clear signal that user has to fix it
> (instead of changing run-time behavior).
> When the verifier gets even smarter it could potentially replace prob_read
> with probe_kernel_read and probe_user_read when it has that type info.

I was about to suggest this approach. Document that bpf_probe_read() is
known to be buggy and will be deprecated in the future, and that all
new bpf scripts should start using bpf_probe_kernel/user_read()
instead (after they have been implemented of course). And give time for
people to fix their current scripts.

Perhaps in the near future, trigger some kind of warning for users that
use bpf_probe_read().

-- Steve
