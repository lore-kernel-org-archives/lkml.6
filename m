Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C3BECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B4020834
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="BTXBrpdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B4020834
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbeJYGcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 02:32:22 -0400
Received: from alln-iport-2.cisco.com ([173.37.142.89]:37932 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeJYGcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 02:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2009; q=dns/txt; s=iport;
  t=1540418552; x=1541628152;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=/SsMWhXKMEgM4sSn8P6VxadKYcdsWlS3XGgb5Urgnzg=;
  b=BTXBrpdO0TAnsJleYGtNh4Pj0RODyNCRU40pgGtkqTUGXzZCqvlzTw+s
   n5xGxwsKOaLY5mI68G/wQ0Qe0YZDMNsHNx4WUygbK/Yh71qf+DanFgeeD
   dElf6cnrRJ/FOgB8+XM1QWUHfgzwVsNdOSq2jpIjMpwSS6Bktbx+44giI
   k=;
X-IronPort-AV: E=Sophos;i="5.54,422,1534809600"; 
   d="scan'208";a="191158926"
Received: from alln-core-9.cisco.com ([173.36.13.129])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 22:02:32 +0000
Received: from [10.154.208.140] ([10.154.208.140])
        by alln-core-9.cisco.com (8.15.2/8.15.2) with ESMTP id w9OM2TCG020367;
        Wed, 24 Oct 2018 22:02:30 GMT
Subject: Re: [PATCH v3] kernel/signal: Signal-based pre-coredump notification
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
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
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Victor Kamensky (kamensky)" <kamensky@cisco.com>,
        xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>,
        Enke Chen <enkechen@cisco.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
 <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
 <20181024140214.GG30128@redhat.com>
From:   Enke Chen <enkechen@cisco.com>
Message-ID: <b6908962-84e3-3791-e827-2f463bb50eb2@cisco.com>
Date:   Wed, 24 Oct 2018 15:02:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181024140214.GG30128@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.154.208.140, [10.154.208.140]
X-Outbound-Node: alln-core-9.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Oleg:

On 10/24/18 7:02 AM, Oleg Nesterov wrote:
> On 10/23, Enke Chen wrote:
>>
>> --- a/fs/coredump.c
>> +++ b/fs/coredump.c
>> @@ -590,6 +590,12 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>>  	if (retval < 0)
>>  		goto fail_creds;
>>
>> +	/*
>> +	 * Send the pre-coredump signal to the parent if requested.
>> +	 */
>> +	do_notify_parent_predump();
>> +	cond_resched();
> 
> I am still not sure cond_resched() makes any sense here...
> 
>> @@ -1553,6 +1553,9 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
>>  	tty_audit_fork(sig);
>>  	sched_autogroup_fork(sig);
>>
>> +	/* Clear the pre-coredump signal for the child */
>> +	sig->predump_signal = 0;
> 
> No need, copy_signal() does zalloc().
> 

Removed.

> 
>> +void do_notify_parent_predump(void)
>> +{
>> +	struct sighand_struct *sighand;
>> +	struct kernel_siginfo info;
>> +	struct task_struct *parent;
>> +	unsigned long flags;
>> +	int sig;
>> +
>> +	read_lock(&tasklist_lock);
>> +	parent = current->parent;
>> +	sig = parent->signal->predump_signal;
>> +	if (sig != 0) {
>> +		clear_siginfo(&info);
>> +		info.si_pid = task_tgid_vnr(current);
>> +		info.si_signo = sig;
>> +		if (sig == SIGCHLD)
>> +			info.si_code = CLD_PREDUMP;
>> +
>> +		sighand = parent->sighand;
>> +		spin_lock_irqsave(&sighand->siglock, flags);
>> +		__group_send_sig_info(sig, &info, parent);
>> +		spin_unlock_irqrestore(&sighand->siglock, flags);
> 
> You can just use do_send_sig_info() and remove sighand/flags/spin_lock_irqsave.

Ok.

> 
> Perhaps the "likely" predump_signal==0 check at the start makes sense to avoid
> read_lock(tasklist).

I am not sure if we should/need to deviate from the convention (locking before
access the parent). In any case it may not matter as the coredump is in the
exceptional code flow.

> 
> And I'd suggest to move it into coredump.c and make it static. It won't have
> another user.

Ok.

Thanks.  -- Enke

