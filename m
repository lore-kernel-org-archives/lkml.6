Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DA8C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D025420868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D025420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbeLFVrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:47:08 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:55062 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeLFVrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:47:08 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gV1U9-0007R4-K9; Thu, 06 Dec 2018 14:47:05 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gV1U8-0007rG-U8; Thu, 06 Dec 2018 14:47:05 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luto@kernel.org, arnd@arndb.de, serge@hallyn.com, jannh@google.com,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        dancol@google.com, timmurray@google.com, linux-man@vger.kernel.org,
        keescook@chromium.org, fweimer@redhat.com, tglx@linutronix.de,
        x86@kernel.org
References: <20181206121858.12215-1-christian@brauner.io>
        <87sgzahf7k.fsf@xmission.com>
        <D372C766-572C-4897-8F02-2FD0E72CCFAC@brauner.io>
        <875zw6bh2z.fsf@xmission.com>
        <20181206193017.wpxls5p3zgjd6rv2@brauner.io>
        <871s6u9z6u.fsf@xmission.com>
        <20181206213152.gvci7ijr3dokew7w@brauner.io>
Date:   Thu, 06 Dec 2018 15:46:53 -0600
In-Reply-To: <20181206213152.gvci7ijr3dokew7w@brauner.io> (Christian Brauner's
        message of "Thu, 6 Dec 2018 22:31:57 +0100")
Message-ID: <87o99y72gi.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gV1U8-0007rG-U8;;;mid=<87o99y72gi.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX197I2lOQZMKRcTAyanx2Fb6HkXUcekaDDY=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v4] signal: add taskfd_send_signal() syscall
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian@brauner.io> writes:

>> Your intention is to add the thread case to support pthreads once the
>> process case is sorted out.  So this is something that needs to be made
>> clear.  Did I miss how you plan to handle threads?
>
> Yeah, maybe you missed it in the commit message [2] which is based on a
> discussion with Andy [3] and Arnd [4]:

Looking at your references I haven't missed it.  You are not deciding
anything as of yet to keep it simple.  Except you are returning
EOPNOTSUPP.  You are very much intending to do something.

Decide.  Do you use the flags parameter or is the width of the
target depending on the flags.

That is fundamental to how the system call and it's extensions work.
That is fundamental to my review.

Until that is decided.
Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

There are a lot of fundamental maintenance issues and you can very easily
get them wrong if you are not clear on the job of the file descriptor
and the job of the flags argument.

I want don't want new crap that we have to abandon that has a nasty set
of bugs because no one wanted to think through the system call all of
the way and understand the corner cases.

Eric
