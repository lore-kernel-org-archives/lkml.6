Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A82ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 21:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8920B20832
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 21:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="N+gLIw48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8920B20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJYG0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 02:26:03 -0400
Received: from rcdn-iport-9.cisco.com ([173.37.86.80]:30733 "EHLO
        rcdn-iport-9.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeJYG0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 02:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1776; q=dns/txt; s=iport;
  t=1540418175; x=1541627775;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=IV6orGr/xdbqlrK35ApBylp9n16mmZ0zFDuRyL2MVRk=;
  b=N+gLIw48De2+shZUfDMu7QxVcIpg7cY+OTWgQ9D+8mlLg+MdWMReWMA4
   v3Yzjwp8vXq+fVMfsBOzyYIlMZgG56xNY0D6oq5y2zF/YK9CRiehnal3D
   JeVzsu077OSRhmBHQtGpHKMqS8P4IgfKWAbeDA54mGX8n4i2E9u/Xn8Ps
   c=;
X-IronPort-AV: E=Sophos;i="5.54,421,1534809600"; 
   d="scan'208";a="386539682"
Received: from rcdn-core-9.cisco.com ([173.37.93.145])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 21:56:14 +0000
Received: from [10.154.208.140] ([10.154.208.140])
        by rcdn-core-9.cisco.com (8.15.2/8.15.2) with ESMTP id w9OLuCGJ009286;
        Wed, 24 Oct 2018 21:56:13 GMT
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
 <20181024135212.GF30128@redhat.com>
From:   Enke Chen <enkechen@cisco.com>
Message-ID: <d24eac49-f808-7d4d-f5fc-59ad2464fb73@cisco.com>
Date:   Wed, 24 Oct 2018 14:56:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181024135212.GF30128@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.154.208.140, [10.154.208.140]
X-Outbound-Node: rcdn-core-9.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Olge:

On 10/24/18 6:52 AM, Oleg Nesterov wrote:
> On 10/23, Enke Chen wrote:
>>
>>>> +	/*
>>>> +	 * Send the pre-coredump signal to the parent if requested.
>>>> +	 */
>>>> +	read_lock(&tasklist_lock);
>>>> +	notify = do_notify_parent_predump(current);
>>>> +	read_unlock(&tasklist_lock);
>>>> +	if (notify)
>>>> +		cond_resched();
>>>
>>> Hmm. I do not understand why do we need cond_resched(). And even if we need it,
>>> why we can't call it unconditionally?
>>
>> Remember the goal is to allow the parent (e.g., a process manager) to take early
>> action. The "yield" before doing coredump will help.
> 
> I don't see how can it actually help...
> 
> cond_resched() is nop if CONFIG_PREEMPT or should_resched() == 0.
> 
> and the coredumping thread will certainly need to sleep/wait anyway.

I am really surprised by this - cond_resched() is used in many places and it actually
does not do anything w/o CONFIG_PREEMPT.

Will remove.

> 
>>> And once again, SIGCHLD/SIGUSR do not queue, this means that PR_SET_PREDUMP_SIG
>>> is pointless if you have 2 or more children.
>>
>> Hmm, could you point me to the code where SIGCHLD/SIGUSR is treated differently
>> w.r.t. queuing?  That does not sound right to me.
> 
> see the legacy_queue() check. Any signal < SIGRTMIN do not queue. IOW, if SIGCHLD
> is already pending, then next SIGCHLD is simply ignored.

Got it. This means that a distinct signal (in particular a RT signal) would be more
preferred. This is what it is done in our application. You earlier suggestion about
removing the signal limitation makes a lot sense to me now.

Given that a distinct signal is more preferred, I am wondering if I should just remove
CLD_PREDUMP from the patch.

Thanks.  -- Enke




