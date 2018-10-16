Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635EAC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DB3208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="V67bTpn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DB3208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeJPImd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 04:42:33 -0400
Received: from rcdn-iport-1.cisco.com ([173.37.86.72]:39119 "EHLO
        rcdn-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbeJPImd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 04:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2554; q=dns/txt; s=iport;
  t=1539651288; x=1540860888;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Wxt6zpQuAM3odC+kaqJBM3BXxWKcUizGUsiWYNNcI2Q=;
  b=V67bTpn/VLv7N9XSvF1VII43rFImVCsBvqVzVa9xHXnEg+TZEvEjRw7H
   nV1s4JXp6bpVrl3Cotpc+p/5F5qIQBGHRNtShc2lruXWEfNU14FytRrsh
   usKuoDysSrELsUDCkM6jASmX5kiwi5fFJHu516CYJwH9vI6tdTaMaJELp
   o=;
X-IronPort-AV: E=Sophos;i="5.54,386,1534809600"; 
   d="scan'208";a="466859805"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 00:54:47 +0000
Received: from [10.154.208.167] ([10.154.208.167])
        by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTP id w9G0sha4000557;
        Tue, 16 Oct 2018 00:54:43 GMT
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Victor Kamensky (kamensky)" <kamensky@cisco.com>,
        xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>,
        Enke Chen <enkechen@cisco.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <87va62lri4.fsf@xmission.com>
From:   Enke Chen <enkechen@cisco.com>
Message-ID: <6211eeaa-ce07-a909-e4c2-172618ddfb95@cisco.com>
Date:   Mon, 15 Oct 2018 17:54:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87va62lri4.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.154.208.167, [10.154.208.167]
X-Outbound-Node: rcdn-core-8.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Eric:

On 10/15/18 4:28 PM, Eric W. Biederman wrote:
> Enke Chen <enkechen@cisco.com> writes:
> 
>> For simplicity and consistency, this patch provides an implementation
>> for signal-based fault notification prior to the coredump of a child
>> process. A new prctl command, PR_SET_PREDUMP_SIG, is defined that can
>> be used by an application to express its interest and to specify the
>> signal (SIGCHLD or SIGUSR1 or SIGUSR2) for such a notification. A new
>> signal code (si_code), CLD_PREDUMP, is also defined for SIGCHLD.
>>
>> Background:
>>
>> As the coredump of a process may take time, in certain time-sensitive
>> applications it is necessary for a parent process (e.g., a process
>> manager) to be notified of a child's imminent death before the coredump
>> so that the parent process can act sooner, such as re-spawning an
>> application process, or initiating a control-plane fail-over.
> 
> You talk about time senstive and then you talk about bash scripts.
> I don't think your definition of time-sensitive and my definition match.

It's certainly not my preference to have a process manager (or one for each
application) written in bash scripts. But they do work, and are deployed.

> 
> With that said I think the best solution would be to figure out how to
> allow the coredump to run in parallel with the usual exit signal, and
> exit code reaping of the process> 
> That would solve the problem for everyone, and would not introduce any
> new complicated APIs.

That would certainly help. But given the huge deployment of Linux, I don't
think it would be feasible to change this fundamental behavior (signal post
coredump).

> 
> Short of that having the prctl in the process that receives the signals
> they you are doing is the right way to go.

Thanks for for the encouragement.

> 
> You are however calling do_notify_parent_predump from the wrong
> function, and frankly with the wrong locking.  There are multiple paths
> to the do_coredump function so you really want this notification from
> do_coredump.

This makes two - Oleg also suggested doing it in do_coredump().
I will look into it, perhaps also relocated proc_coredump_connector().

> 
> But I still think it would be better to solve the root cause problem and
> change the coredump logic to be able to run in parallel with the normal
> exit notification and zombie reaping logic.  Then the problem you are
> trying to solve goes away and everyone's code gets simpler.
> 
> Eric
> 

Thanks.  -- Enke

