Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026C9C5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B132087A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="eVZfxckQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B132087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeJQIcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 04:32:55 -0400
Received: from alln-iport-2.cisco.com ([173.37.142.89]:46104 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeJQIcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 04:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1480; q=dns/txt; s=iport;
  t=1539736792; x=1540946392;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=k+wpnzYASk9ONwkxPvmO8mxqNuCZGjxaCVVWWtG4COs=;
  b=eVZfxckQr1EnrYg9bLgixJTnRFPJQDlpy7hPwQ7qD/x0WVxHBTmqiRa2
   4hSrO1pUNkjdMvFKMJQq1g3YWOKpSpoXeNoJwapgK5ZqBPTAjRUnk4PUa
   nnG12v/Ys9kmFaMpgJNcUwB3pNWB7Tk+UN0jITuc8iAdDyx/u/UnCBTjy
   0=;
X-IronPort-AV: E=Sophos;i="5.54,389,1534809600"; 
   d="scan'208";a="187078699"
Received: from alln-core-11.cisco.com ([173.36.13.133])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 00:39:52 +0000
Received: from [10.154.208.185] ([10.154.208.185])
        by alln-core-11.cisco.com (8.15.2/8.15.2) with ESMTP id w9H0dmJu004726;
        Wed, 17 Oct 2018 00:39:48 GMT
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
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
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Victor Kamensky (kamensky)" <kamensky@cisco.com>,
        xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Enke Chen <enkechen@cisco.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <20181015120521.GA10146@redhat.com>
 <20398328-4ee1-96b2-5723-4b7eed55f0a2@cisco.com>
 <20181016141405.GA22045@redhat.com>
From:   Enke Chen <enkechen@cisco.com>
Message-ID: <f06be2d1-c6fd-21d3-00ae-01b8d4eaaade@cisco.com>
Date:   Tue, 16 Oct 2018 17:39:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016141405.GA22045@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.154.208.185, [10.154.208.185]
X-Outbound-Node: alln-core-11.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Oleg:

On 10/16/18 7:14 AM, Oleg Nesterov wrote:
> On 10/15, Enke Chen wrote:
>>
>>> I don't understand why we need valid_predump_signal() at all.
>>
>> Most of the signals have well-defined semantics, and would not be appropriate
>> for this purpose.
> 
> you are going to change the rules anyway.
> 
>> That is why it is limited to only SIGCHLD, SIGUSR1, SIGUSR2.
> 
> Which do not queue. So the parent won't get the 2nd signal if 2 children
> crash at the same time.
> 
>>>>  		if (sig_kernel_coredump(signr)) {
>>>> +			/*
>>>> +			 * Notify the parent prior to the coredump if the
>>>> +			 * parent is interested in such a notificaiton.
>>>> +			 */
>>>> +			int p_sig = current->real_parent->predump_signal;
>>>> +
>>>> +			if (valid_predump_signal(p_sig)) {
>>>> +				read_lock(&tasklist_lock);
>>>> +				do_notify_parent_predump(current);
>>>> +				read_unlock(&tasklist_lock);
>>>> +				cond_resched();
>>>
>>> perhaps this should be called by do_coredump() after coredump_wait() kills
>>> all the sub-threads?
>>
>> proc_coredump_connector(current) is located here, they should stay together.
> 
> Why?
> 
> Once again, other threads are still alive. So if the parent restarts the service
> after it recieves -predump_signal, the new process can "race" with the old thread.

Yes, it is a good idea to do the signal notification in do_coredump() after
coredump_wait(). Will make the change as suggested.

Thanks.  -- Enke
