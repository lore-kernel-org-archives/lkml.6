Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C176ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB1F20877
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB1F20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbeGPPgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:36:18 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:33615 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeGPPgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:36:18 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1ff56x-0005Ul-EU; Mon, 16 Jul 2018 09:08:27 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1ff56w-0001X9-Pg; Mon, 16 Jul 2018 09:08:27 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>
References: <877em2jxyr.fsf_-_@xmission.com>
        <20180711024459.10654-9-ebiederm@xmission.com>
        <20180716145540.GA20960@redhat.com>
Date:   Mon, 16 Jul 2018 10:08:22 -0500
In-Reply-To: <20180716145540.GA20960@redhat.com> (Oleg Nesterov's message of
        "Mon, 16 Jul 2018 16:55:40 +0200")
Message-ID: <87lgabrzfd.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ff56w-0001X9-Pg;;;mid=<87lgabrzfd.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/lOV6g8ozUF3mOjoGUbBHzizy+QK7i25g=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH 09/11] tty_io: Use do_send_sig_info in __do_SACK  to forcibly kill tasks
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 07/10, Eric W. Biederman wrote:
>>
>> Therefore use do_send_sig_info in all cases in __do_SAK to kill
>> tasks as allows for exactly what the code wants to do.
>
> OK, but probably the changelog should also mention that now even the global
> init will be killed if it has this tty opened.

force_sig was ensuring the global init would die.  So that isn't a
change.  Mentioning it isn't a bad idea.

The change for global init is it will now die if init is a member of the
session or init is using this tty as it's controlling tty.

Semantically killing init with SAK is completely appropriate.  As
otherwise the guarantee that nothing has the terminal open will be
present.  So yes I will update the description.

Eric

>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  drivers/tty/tty_io.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
>> index cec58c53b0c4..42ac168c2a47 100644
>> --- a/drivers/tty/tty_io.c
>> +++ b/drivers/tty/tty_io.c
>> @@ -2747,7 +2747,7 @@ void __do_SAK(struct tty_struct *tty)
>>  	do_each_pid_task(session, PIDTYPE_SID, p) {
>>  		tty_notice(tty, "SAK: killed process %d (%s): by session\n",
>>  			   task_pid_nr(p), p->comm);
>> -		send_sig(SIGKILL, p, 1);
>> +		do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, true);
>>  	} while_each_pid_task(session, PIDTYPE_SID, p);
>>  
>>  	/* Now kill any processes that happen to have the tty open */
>> @@ -2755,7 +2755,7 @@ void __do_SAK(struct tty_struct *tty)
>>  		if (p->signal->tty == tty) {
>>  			tty_notice(tty, "SAK: killed process %d (%s): by controlling tty\n",
>>  				   task_pid_nr(p), p->comm);
>> -			send_sig(SIGKILL, p, 1);
>> +			do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, true);
>>  			continue;
>>  		}
>>  		task_lock(p);
>> @@ -2763,7 +2763,7 @@ void __do_SAK(struct tty_struct *tty)
>>  		if (i != 0) {
>>  			tty_notice(tty, "SAK: killed process %d (%s): by fd#%d\n",
>>  				   task_pid_nr(p), p->comm, i - 1);
>> -			force_sig(SIGKILL, p);
>> +			do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, true);
>>  		}
>>  		task_unlock(p);
>>  	} while_each_thread(g, p);
>> -- 
>> 2.17.1
>> 
