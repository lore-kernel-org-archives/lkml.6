Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEC6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8842220873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8842220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbeK0Rwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 12:52:34 -0500
Received: from mga14.intel.com ([192.55.52.115]:16241 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbeK0Rwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 12:52:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 22:55:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,285,1539673200"; 
   d="scan'208";a="90176551"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 26 Nov 2018 22:55:41 -0800
Received: from [10.125.251.223] (abudanko-mobl.ccr.corp.intel.com [10.125.251.223])
        by linux.intel.com (Postfix) with ESMTP id 9B3035802E4;
        Mon, 26 Nov 2018 22:55:37 -0800 (PST)
Subject: Re: [PATCH v2 1/2] Documentation/admin-guide: introduce
 perf-security.rst file
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <259a9cd2-5c56-4f8d-57c4-cabaeaa774bc@linux.intel.com>
 <4d95341d-d1f4-fc48-f173-a6fedfc70d33@linux.intel.com>
 <20181125124732.6c1807de@lwn.net>
 <02dbd6dc-86b5-2307-4122-b716c51b9eaa@linux.intel.com>
 <20181126132833.5302688b@lwn.net>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <3a07906e-83c0-e7ae-7249-84deafdd52e0@linux.intel.com>
Date:   Tue, 27 Nov 2018 09:55:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181126132833.5302688b@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.11.2018 23:28, Jonathan Corbet wrote:
> On Mon, 26 Nov 2018 11:57:21 +0300
> Alexey Budankov <alexey.budankov@linux.intel.com> wrote:
> 
>>>> +For the purpose of performing security checks Linux implementation splits
>>>> +processes into two categories [6]_ : a) privileged processes (whose effective
>>>> +user ID is 0, referred to as superuser or root), and b) unprivileged processes
>>>> +(whose effective UID is nonzero).  
>>>
>>> Is that really what's going on here?  If I understand things correctly,
>>> it's looking for CAP_SYS_PTRACE rather than a specific UID; am I missing
>>> something here?  
>>
>> You are right regarding CAP_SYS_PTRACE but this capability is not the only 
>> one which is used by perf_events for security checks, so the capabilities 
>> clarification is kept aside of these patches, because patches initial intention 
>> is to clarify security specifics of sysctl_perf_even_paranoid settings.
>>
>> I agree that the document can be extended with details clarifying capabilities 
>> used by perf_events for security checks.
> 
> I don't really like the idea of adding a document that we know doesn't
> really describe how the security decision is made.  Even a one-line
> parenthetical saying that things are more complicated and giving a pointer
> to a place to look for details would help, IMO.

Well, makes sense. It is possible to have something similar to this:

...

For the purpose of performing security checks the Linux implementation splits
processes into two categories [6]_ : a) privileged processes (whose effective
user ID is 0, referred to as superuser or root), and b) unprivileged processes
(whose effective UID is nonzero).

Privileged processes bypass all kernel security permission checks so perf_events
performance monitoring is fully available to privileged processes without
access, scope and resource restrictions.

Unprivileged processes are subject to full security permission check based on 
the process's credentials [5]_ (usually: effective UID, effective GID, and 
supplementary group list).

Linux divides the privileges traditionally associated with superuser into
distinct units, known as capabilities [6]_, which can be independently enabled
and disabled on per-thread basis for processes and files of unprivileged users.

Unprivileged processes with enabled CAP_SYS_ADMIN capability are treated as 
privileged processes with respect to perf_events performance monitoring and
bypass *scope* permissions checks in the kernel.

Unprivileged processes using perf_events system call API is also subject for
PTRACE_MODE_READ_REALCREDS ptrace access mode check [7]_ , whose outcome determines
whether monitoring is permitted. So unprivileged process provided with
CAP_SYS_PTRACE capability are effectively permitted to pass the check.

Other capabilities being granted to unprivileged processes can effectively
enable capturing of additional data required for later performance analysis of
monitored processes or system. For example CAP_SYSLOG capability permits
reading kernel space memory addresses from /proc/kallsyms file.

...

Thanks,
Alexey

> 
> Either way, I can merge this, but I'd like to have an ack from the perf
> folks first.
> 
> Thanks,
> 
> jon
> 
