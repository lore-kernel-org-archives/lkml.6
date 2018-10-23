Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1739C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F2920813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Dd49pQ0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F2920813
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbeJXGFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:05:41 -0400
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:5643 "EHLO
        rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeJXGFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2002; q=dns/txt; s=iport;
  t=1540330828; x=1541540428;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=58B8RRPYBCJ60ow6croL5YgH1PwEoU/3Hr7hsBhUVNg=;
  b=Dd49pQ0fNqBC9PAWtkqMzHaqewAroq036z74dzW/P9lhVpwxPHxJAQoK
   QpNjewg28ag5WJZEg58mgURF4sKw4JWC1xUAexrcomAFAM17074j0epb2
   ZjBYt5fuIbcGTllNp+k0BXC0xhF55PXIFvMOR9zSfIHiWQYePfQEmSlPF
   w=;
X-IronPort-AV: E=Sophos;i="5.54,417,1534809600"; 
   d="scan'208";a="470623750"
Received: from alln-core-7.cisco.com ([173.36.13.140])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 21:40:27 +0000
Received: from [10.154.208.140] ([10.154.208.140])
        by alln-core-7.cisco.com (8.15.2/8.15.2) with ESMTP id w9NLeAf5000968;
        Tue, 23 Oct 2018 21:40:10 GMT
Subject: Re: [PATCH v2] kernel/signal: Signal-based pre-coredump notification
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
 <20181023092348.GA14340@redhat.com>
 <1e68a3ce-32cd-b058-3d1d-36455ceca848@cisco.com>
From:   Enke Chen <enkechen@cisco.com>
Message-ID: <a7cd5312-f743-cf57-7945-c2964026f652@cisco.com>
Date:   Tue, 23 Oct 2018 14:40:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1e68a3ce-32cd-b058-3d1d-36455ceca848@cisco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.154.208.140, [10.154.208.140]
X-Outbound-Node: alln-core-7.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Oleg:

On 10/23/18 12:43 PM, Enke Chen wrote:

>>
>>> --- a/fs/coredump.c
>>> +++ b/fs/coredump.c
>>> @@ -546,6 +546,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>>>  	struct cred *cred;
>>>  	int retval = 0;
>>>  	int ispipe;
>>> +	bool notify;
>>>  	struct files_struct *displaced;
>>>  	/* require nonrelative corefile path and be extra careful */
>>>  	bool need_suid_safe = false;
>>> @@ -590,6 +591,15 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>>>  	if (retval < 0)
>>>  		goto fail_creds;
>>>
>>> +	/*
>>> +	 * Send the pre-coredump signal to the parent if requested.
>>> +	 */
>>> +	read_lock(&tasklist_lock);
>>> +	notify = do_notify_parent_predump(current);
>>> +	read_unlock(&tasklist_lock);
>>> +	if (notify)
>>> +		cond_resched();
>>
>> Hmm. I do not understand why do we need cond_resched(). And even if we need it,
>> why we can't call it unconditionally?
> 
> Remember the goal is to allow the parent (e.g., a process manager) to take early
> action. The "yield" before doing coredump will help.
> 
> The yield is made conditional because the notification is conditional.
> Is that ok?

Given this is in do_coredump(), it is ok to make it unconditional for simplicity.

>>
>>> +bool do_notify_parent_predump(struct task_struct *tsk)
>>> +{
>>> +	struct sighand_struct *sighand;
>>> +	struct kernel_siginfo info;
>>> +	struct task_struct *parent;
>>> +	unsigned long flags;
>>> +	pid_t pid;
>>> +	int sig;
>>> +
>>> +	parent = tsk->parent;
>>> +	sighand = parent->sighand;
>>> +	pid = task_tgid_vnr(tsk);
>>> +
>>> +	spin_lock_irqsave(&sighand->siglock, flags);
>>> +	sig = parent->signal->predump_signal;
>>> +	if (!valid_predump_signal(sig)) {
>>> +		spin_unlock_irqrestore(&sighand->siglock, flags);
>>> +		return false;
>>> +	}
>>
>> Why do we need to check parent->signal->predump_signal under ->siglock?
>> This complicates the code for no reason, afaics.

Will simplify.

Thanks.  -- Enke

