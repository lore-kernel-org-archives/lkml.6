Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3516DC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACB52089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Ys0cKFhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACB52089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeJPCDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:03:02 -0400
Received: from alln-iport-5.cisco.com ([173.37.142.92]:9115 "EHLO
        alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeJPCDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3381; q=dns/txt; s=iport;
  t=1539627401; x=1540837001;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3VyR/4dAXHv7RqKXiqhrTdYn7PXBE5hOvQG7GeJZHrI=;
  b=Ys0cKFhrjxYur9HuccFJbTRyKSVXTU1KMBe7pflU8JrI0UYE405v3eP9
   drps2TBl1gJg46kaSoKPcnpGXP+NOpmuorWHf24dQOj4CZn3ao4QxDPJz
   xqOArjOL8kfLW3cX0jtGErmDCHn7GfcYFC2/6OjdKZC2OYJJ9NWrnTj6L
   M=;
X-IronPort-AV: E=Sophos;i="5.54,385,1534809600"; 
   d="scan'208";a="185684398"
Received: from alln-core-10.cisco.com ([173.36.13.132])
  by alln-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 18:16:40 +0000
Received: from [10.154.208.167] ([10.154.208.167])
        by alln-core-10.cisco.com (8.15.2/8.15.2) with ESMTP id w9FIGbt9018701;
        Mon, 15 Oct 2018 18:16:37 GMT
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
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
 <20181013064023.GA28177@kroah.com>
From:   Enke Chen <enkechen@cisco.com>
Message-ID: <37401cea-5a37-2cd9-8595-8b07dfc4de7d@cisco.com>
Date:   Mon, 15 Oct 2018 11:16:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181013064023.GA28177@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.154.208.167, [10.154.208.167]
X-Outbound-Node: alln-core-10.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg:

> Shouldn't there also be a manpage update, and a kselftest added for this
> new user/kernel api that is being created?
> 

I will submit a patch for manpage update once the code is accepted.

Regarding the kselftest, I am not sure.  Once the prctl() is limited to
self (which I will do), the logic would be pretty straightforward. Not
sure if the selftest would add much value.

Thanks.  -- Enke

On 10/12/18 11:40 PM, Greg Kroah-Hartman wrote:
> On Fri, Oct 12, 2018 at 05:33:35PM -0700, Enke Chen wrote:
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
>>
>> Currently there are two ways for a parent process to be notified of a
>> child process's state change. One is to use the POSIX signal, and
>> another is to use the kernel connector module. The specific events and
>> actions are summarized as follows:
>>
>> Process Event    POSIX Signal                Connector-based
>> ----------------------------------------------------------------------
>> ptrace_attach()  do_notify_parent_cldstop()  proc_ptrace_connector()
>>                  SIGCHLD / CLD_STOPPED
>>
>> ptrace_detach()  do_notify_parent_cldstop()  proc_ptrace_connector()
>>                  SIGCHLD / CLD_CONTINUED
>>
>> pre_coredump/    N/A                         proc_coredump_connector()
>> get_signal()
>>
>> post_coredump/   do_notify_parent()          proc_exit_connector()
>> do_exit()        SIGCHLD / exit_signal
>> ----------------------------------------------------------------------
>>
>> As shown in the table, the signal-based pre-coredump notification is not
>> currently available. In some cases using a connector-based notification
>> can be quite complicated (e.g., when a process manager is written in shell
>> scripts and thus is subject to certain inherent limitations), and a
>> signal-based notification would be simpler and better suited.
>>
>> Signed-off-by: Enke Chen <enkechen@cisco.com>
>> ---
>>  arch/x86/kernel/signal_compat.c    |  2 +-
>>  include/linux/sched.h              |  4 ++
>>  include/linux/signal.h             |  5 +++
>>  include/uapi/asm-generic/siginfo.h |  3 +-
>>  include/uapi/linux/prctl.h         |  4 ++
>>  kernel/fork.c                      |  1 +
>>  kernel/signal.c                    | 51 +++++++++++++++++++++++++
>>  kernel/sys.c                       | 77 ++++++++++++++++++++++++++++++++++++++
>>  8 files changed, 145 insertions(+), 2 deletions(-)
> 
> Shouldn't there also be a manpage update, and a kselftest added for this
> new user/kernel api that is being created?
> 
> thanks,
> 
> greg k-h
> 
