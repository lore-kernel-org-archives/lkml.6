Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA13ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 23:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4684E2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 23:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4684E2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeGUAcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 20:32:14 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:41942 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbeGUAcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 20:32:14 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fgf1r-0007RY-VR; Fri, 20 Jul 2018 17:41:44 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fgf1r-0003Lk-6N; Fri, 20 Jul 2018 17:41:43 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
References: <877em2jxyr.fsf_-_@xmission.com>
        <20180711024459.10654-7-ebiederm@xmission.com>
        <20180716125144.GA18262@redhat.com> <8736wjtetv.fsf@xmission.com>
        <CA+55aFxDsE8sb5wQQNJdxvt8m6n6aVpOo1yVpk1BEzXDv8XzaQ@mail.gmail.com>
        <87bmb7oy94.fsf@xmission.com> <20180717095628.GA27482@redhat.com>
        <20180717101811.GB27482@redhat.com>
Date:   Fri, 20 Jul 2018 18:41:34 -0500
In-Reply-To: <20180717101811.GB27482@redhat.com> (Oleg Nesterov's message of
        "Tue, 17 Jul 2018 12:18:12 +0200")
Message-ID: <87pnzh79w1.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fgf1r-0003Lk-6N;;;mid=<87pnzh79w1.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+b+t5/ZaM4s72pvvQc7neT7239l48z6BE=
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

> On 07/17, Oleg Nesterov wrote:
>>
>> And, I didn't mention this yesterday, but probably the next 08/11 patch can
>> have the same problem. But this is a bit more complicated because send_sigio()
>> uses the same "type" both for do_each_pid_task() and as an argument passed to
>> do_send_sig_info().
>
> perhaps it can simply do
>
> 	if (type <= PIDTYPE_TGID) {
> 		rcu_read_lock();
> 		p = pid_task(pid, PIDTYPE_PID);
> 		send_sigio_to_task(p, fown, fd, band, type);
> 		rcu_read_unlock();
> 	} else {
> 		read_lock(&tasklist_lock);
> 		do_each_pid_task(pid, type, p) {
> 			send_sigio_to_task(p, fown, fd, band, type);
> 		} while_each_pid_task(pid, type, p);
> 		read_unlock(&tasklist_lock);
> 	}
>
> this way we also avoid tasklist_lock in F_OWNER_TID/F_OWNER_PID case.

I like that.  I updated that code in a different way but that looks
more elegant and I think I will incoporate it.

> To clarify, it is not that I think any sane application can do
> fcntl(F_OWNER_PID, thread_tid) but still this is a user-visible change
> we can easily avoid.

Agreed.

I do think 

Eric

