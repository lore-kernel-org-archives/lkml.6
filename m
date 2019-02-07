Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6659C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9277D2190C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfBGNOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:14:24 -0500
Received: from mga04.intel.com ([192.55.52.120]:52216 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfBGNOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:14:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 05:14:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,344,1544515200"; 
   d="scan'208";a="141469710"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 07 Feb 2019 05:14:22 -0800
Received: from [10.125.252.152] (abudanko-mobl.ccr.corp.intel.com [10.125.252.152])
        by linux.intel.com (Postfix) with ESMTP id A46165800E0;
        Thu,  7 Feb 2019 05:14:18 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v1 3/3] perf-security: document perf_events/Perf resource
 control
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <9cfbf7a1-72dd-f9d0-8137-0f120fa74d21@linux.intel.com>
 <5ac4b7aa-b640-d8a4-1926-cf612fada974@linux.intel.com>
 <20190206170151.00c92333@lwn.net>
Organization: Intel Corp.
Message-ID: <e3bbc79a-fd7e-6cae-6385-97dca1fc7f85@linux.intel.com>
Date:   Thu, 7 Feb 2019 16:14:16 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190206170151.00c92333@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.02.2019 3:01, Jonathan Corbet wrote:
> On Fri, 1 Feb 2019 10:30:58 +0300
> Alexey Budankov <alexey.budankov@linux.intel.com> wrote:
> 
>> Elaborate on possible perf_event/Perf privileged users groups
>> and document steps about creating such groups.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  Documentation/admin-guide/perf-security.rst | 43 +++++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/perf-security.rst b/Documentation/admin-guide/perf-security.rst
>> index 7da7fa459718..fe90f8952be9 100644
>> --- a/Documentation/admin-guide/perf-security.rst
>> +++ b/Documentation/admin-guide/perf-security.rst
>> @@ -73,6 +73,48 @@ enable capturing of additional data required for later performance analysis of
>>  monitored processes or a system. For example, CAP_SYSLOG capability permits
>>  reading kernel space memory addresses from /proc/kallsyms file.
>>  
>> +perf_events/Perf privileged users
>> +---------------------------------
>> +
>> +Mechanisms of capabilities, privileged capability-dumb files [6]_ and file system
>> +ACLs [10]_ can be used to create a dedicated group of perf_events/Perf privileged
>> +users who are permitted to execute performance monitoring without *scope* limits.
>> +The following steps can be taken to create such a group of privileged Perf user
>> +
>> +1. Create perf_users group of privileged Perf users, assign perf_users group to
>> +   Perf tool executable and limit *access* to the executable for other users in
>> +   the system:
>> +
>> +::
>> +
>> +   # groupadd perf_users
>> +   # ls -alhF
>> +   -rwxr-xr-x  2 root root  11M Oct 19 15:12 perf
>> +   # chgrp perf_users perf
>> +   # ls -alhF
>> +   -rwxr-xr-x  2 root perf_users  11M Oct 19 15:12 perf
>> +   # chmod o-rwx perf
>> +   # ls -alhF
>> +   -rwxr-x---  2 root perf_users  11M Oct 19 15:12 perf
> 
> Since we're giving basic sysadmin info here, we should probably say
> explicitly that this will block access to the perf binary to anybody who
> is not in the perf_users group.

We already say that above:
	"limit *access* to the executable for other users in the system".

Let's have it this way then:
	"limit access to the executable for other users in the system 
         who are not in the perf_users group".

> 
>> +2. Assign required capabilities to the Perf tool executable file and enable
> 
> Assign *the* required

Accepted.

> 
>> +   members of perf_users group with performance monitoring privileges [6]_ :
>> +
>> +::
>> +
>> +   # setcap "cap_sys_admin,cap_sys_ptrace,cap_syslog=ep" perf
>> +   # setcap -v "cap_sys_admin,cap_sys_ptrace,cap_syslog=ep" perf
>> +   perf: OK
>> +   # getcap perf
>> +   perf = cap_sys_ptrace,cap_sys_admin,cap_syslog+ep
>> +
>> +As a result, members of perf_users group are capable of conducting performance
>> +monitoring by using functionality of the configured Perf tool executable that,
>> +when executes, passes perf_events subsystem *scope* checks.
>> +
>> +This specific *access* control management is only available to superuser or root
> 
> Why the *emphasis* here?  We prefer to minimize this kind of markup
> whenever possible.

Avoided emphasis here and in the other places of this paragraph.

> 
> Thanks,
> 
> jon
> 

Thanks,
Alexey
