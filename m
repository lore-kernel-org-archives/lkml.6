Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A94C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0965020832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0965020832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbeK2CZ4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:25:56 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:35255 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbeK2CZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:25:55 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gS1gt-0004Gx-LG; Wed, 28 Nov 2018 08:23:52 -0700
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gS1gt-0000Ak-0W; Wed, 28 Nov 2018 08:23:51 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     =?utf-8?Q?J=C3=BCrg?= Billeter <j@bitron.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181127225408.7553-1-j@bitron.ch>
        <20181127225408.7553-2-j@bitron.ch>
        <20181128144230.GG30395@redhat.com>
Date:   Wed, 28 Nov 2018 09:23:39 -0600
In-Reply-To: <20181128144230.GG30395@redhat.com> (Oleg Nesterov's message of
        "Wed, 28 Nov 2018 15:42:31 +0100")
Message-ID: <87r2f5gr9g.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1gS1gt-0000Ak-0W;;;mid=<87r2f5gr9g.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ZIhrxRrHeEu/P26ASig1IcfQQ3S/A0H0=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] prctl: add PR_{GET,SET}_KILL_DESCENDANTS_ON_EXIT
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 11/27, Jürg Billeter wrote:
>>
>> @@ -704,6 +713,9 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
>>  	struct task_struct *p, *n;
>>  	LIST_HEAD(dead);
>>  
>> +	if (group_dead && tsk->signal->kill_descendants_on_exit)
>> +		walk_process_tree(tsk, kill_descendant_visitor, NULL);
>
> Well, this is not exactly right, at least this is suboptimal in that
> other sub-threads can too call walk_process_tree(kill_descendant_visitor)
> later for no reason.

Oleg I think I am missing something.

Reading kernel/exit.c I see "group_dead = atomic_dec_and_test(&tsk->signal->live)".
Which seems like enough to ensure exactly one task/thread calls walk_process_tree.

Can you explain what I am missing?

Eric

