Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602ECC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 23:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E16218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 23:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfADXKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 18:10:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfADXKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 18:10:18 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DBEF9C057E00;
        Fri,  4 Jan 2019 23:10:17 +0000 (UTC)
Received: from sky.random (ovpn-121-144.rdu2.redhat.com [10.10.121.144])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A1BB5C1A1;
        Fri,  4 Jan 2019 23:10:15 +0000 (UTC)
Date:   Fri, 4 Jan 2019 18:10:13 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot+cbc64b24b2b2d54c07a9@syzkaller.appspotmail.com,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Peter Xu <peterx@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: KASAN: use-after-free Read in handle_userfault (2)
Message-ID: <20190104231013.GB4924@redhat.com>
References: <000000000000665f2e057cd00db6@google.com>
 <CACT4Y+Y-Yv0a1DzqsTHRSP52DdKLy0J2fAfsVfZUSNNnAOUnzg@mail.gmail.com>
 <CACT4Y+bxTz6d11v89gpDSEPyB+sJssNGPmEsC9-LVsGbxEpcuA@mail.gmail.com>
 <20181230154648.GB9832@redhat.com>
 <CACT4Y+Y+ZdBPXGhytZycqcLc_7GOR-VZB8KKuX_qUgxmiVT60w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y+ZdBPXGhytZycqcLc_7GOR-VZB8KKuX_qUgxmiVT60w@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 04 Jan 2019 23:10:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 02:37:58PM +0100, Dmitry Vyukov wrote:
> If we are proceeding with "mm: some enhancements to the page fault
> mechanism", that's good as it will eliminate at least part of this
> output.

Agreed.

> There are 2 types of debug configs: ones add additional checks for
> machines and another add verbose output for humans. CONFIG_DEBUG_VM
> seems to be more of the first type of debug config -- additional
> checks for machines. I've seen some of the second type debug configs
> are prefixed with DEBUG_VERBOSE or something along these lines. Maybe
> it makes sense to split this out of CONFIG_DEBUG_VM. Since it's a
> "gray" check (rather then white/black check), it can't be used in
> CI/fuzzing setups anyways -- not possible to analyse thousands of
> cases manually (though maybe we actually hitting some that can be
> classified as kernel bugs).

The problem with the DEBUG_VERBOSE is that if the kernel needs a
rebuild it's only marginally better than having to ask the developer
to add a one liner dump_stack before rebuilding the kernel.

Next time we need it, it may be simpler to figure a dynamic tracing
trick than to ask a rebuild.

In addition of pursuing the VM_FAULT_RETRY improvements from Peter,
it'd be fine to drop it for now to avoid confusing the machines.

> Yes, the problem is way more general. As you noted it applies to 100K
> of EINVAL|EFAULT|ENOMEM, it's super hard to figure out what/where
> exactly goes wrong in the kernel getting only -22. But at the same

What stands out for this location is that it's the bailout point
of all non uffd compatible syscalls.

The chances such annotation turns out to be useful is much higher than
a random -EINVAL location, but in principle it's the same kind of
issue and I agree it'd be unpractical to annotate them manually.

> time we can't have all of these 100K places dump stacks. I don't know
> what's a good solution for this. Manually annotating 100K places does
> not look like the right way to go. Maybe kprobes can do this? In some
> cases I used CONFIG_KCOV  and kcovtrace
> (https://github.com/google/syzkaller/blob/master/tools/kcovtrace/kcovtrace.c)
> to collect kernel trace from a failing syscall.

If there is a de facto standard to search for a "syscall bailout call
trace" that can provide us that very same dump_stack, that should work
for this uffd issue too indeed.

KCOV may or may not be enabled in enterprise -debug kernels, but the
main limitation of the kcovtrace.c seems to be the lack of threading
support and the privilege inheritance through fork. While it's not
mandatory, the uffd manager is practically always implemented as a
thread of some process so whatever alternative to dump_stack() should
work with threads.

I think kprobes/ebpf should work provided debug info is available
(which is not always guaranteed), otherwise to obtain it without debug
info, it'd require a ftrace static trace point to use with the
function graph tracer I guess.

Thanks,
Andrea
