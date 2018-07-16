Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21312ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B190A20856
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B190A20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbeGPPS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:18:28 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:53522 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbeGPPS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:18:28 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1ff4pl-0006p0-29; Mon, 16 Jul 2018 08:50:41 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1ff4pV-0006Qe-BU; Mon, 16 Jul 2018 08:50:40 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>
References: <877em2jxyr.fsf_-_@xmission.com>
        <20180711024459.10654-7-ebiederm@xmission.com>
        <20180716125144.GA18262@redhat.com>
Date:   Mon, 16 Jul 2018 09:50:20 -0500
In-Reply-To: <20180716125144.GA18262@redhat.com> (Oleg Nesterov's message of
        "Mon, 16 Jul 2018 14:51:45 +0200")
Message-ID: <8736wjtetv.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ff4pV-0006Qe-BU;;;mid=<8736wjtetv.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19iZc11nrAlcKLM5hnLbsLDKuIpwiQkmBs=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH 07/11] signal: Deliver group signals via PIDTYPE_TGID not PIDTYPE_PID
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 07/10, Eric W. Biederman wrote:
>>
>> Now that we can make the distinction use PIDTYPE_TGID rather than
>> PIDTYPE_PID.
>
> Wai, wait, this doesn't look right...
>
>> There is no immediate effect as they point point at the
>> same task,
>
> How so? pid_task(pid, PIDTYPE_TGID) will return NULL unless this pid is actually
> a group leader's pid,
>
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -1315,7 +1315,7 @@ int kill_pid_info(int sig, struct siginfo *info, struct pid *pid)
>>
>>  	for (;;) {
>>  		rcu_read_lock();
>> -		p = pid_task(pid, PIDTYPE_PID);
>> +		p = pid_task(pid, PIDTYPE_TGID);
>>  		if (p)
>>  			error = group_send_sig_info(sig, info, p);
>
> So, currently kill(pid_nr) always works, even if pid_nr is a sub-thread's tid.
>
> After this change kill(2) will always fail with -ESRCH in this case.
>
> Or I am totally confused?

No you are not.

That does at least need to be documented in the description of the
patch.

In practice since glibc does not make thread id's available I don't
expect anyone relies on this behavior.  Since no one relies on it we
can change it without creating a regression.

I believe this can be described as fixing a bug that we were not able to
before the introduction of PIDTYPE_TGID.

I will update my change description.

Eric
