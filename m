Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C345AC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E28260C7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E28260C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934992AbeFYUPO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 16:15:14 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:60138 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754532AbeFYUPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 16:15:12 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fXXtH-0001Cs-AF; Mon, 25 Jun 2018 14:15:11 -0600
Received: from 97-119-124-205.omah.qwest.net ([97.119.124.205] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fXXtF-0003uX-Ph; Mon, 25 Jun 2018 14:15:11 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        astrachan@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
References: <87muvr58ak.fsf@xmission.com>
        <CA+55aFxTtemhGJweOKfATojapGzD-riaowDUSh65OA2pCB+w6Q@mail.gmail.com>
Date:   Mon, 25 Jun 2018 15:14:49 -0500
In-Reply-To: <CA+55aFxTtemhGJweOKfATojapGzD-riaowDUSh65OA2pCB+w6Q@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 20 Jun 2018 10:16:43 +0900")
Message-ID: <87d0wetyh2.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fXXtF-0003uX-Ph;;;mid=<87d0wetyh2.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Hsha9jgDR8wAFFgGIVLiPonOrvAfkxyA=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [GIT PULL] userns fixes for 4.17-rc2
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Jun 19, 2018 at 8:24 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> I stared at this code for quite a while and I finally concluded that the
>> best course forward is to simply things and remove the internal kernel
>> mount of proc.  The internal mount of proc is directly responsible for
>> this regression and it has been the source of pain over the years.
>
> This is not the kind of patch that I'm willing to take outside the
> merge window. This is *way* too subtle, and making sysctl do a
> kern_mount()/kern_umount() seems odd.

I understand the feedback about breaking up the patch and the concern
about the race with pid->count.

I don't understand the feedback about only accepting something like this
during the merge window.  The entire point of my change was to remove
subtlety.  The code was very straight forward to test.

This is a silent regression of a security feature so it is possible some
people have upgraded their kernel and not noticed the regression but are
affected by the information leak not honoring hidepid introduces.  That
seems to me to be a candidate for stable and thus an rc kernel.

Would you prefer a patch that does less towards fixing the root cause
for now and to be backported to stable?

> The pid->count test also looks potentially racy to me.

The function proc_flush_task is already racy, it is just an optimization
that needs to work the vast majority of the time or we get lots of stale
useless cached dentries in proc.  So I don't think a little race
between testing pid->count and someone accessing a proc inode matters.
They could always perform the access after proc_flush_task is done
and before unhash_process runs, and achieve the same effect.

Though in retrospect my testing showed processes acessing proc self
from libc or something so the pid->count optimization never really
hit.  So it is probably better just to remove it.


The kern_mount/kern_umount are definitely odd and not my favorite.  But
the code does work.  It is my intention and hope that they can both the
uml and the sysctl(2) code can both be removed.  I need to double check
but I don't think there are even any enterprise kernels that enable
sysctl(2) support in the kernel any more.

Eric
