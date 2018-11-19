Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D4FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB81B208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB81B208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeKTF1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:27:13 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:52570 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeKTF1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:27:12 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gOooJ-0008VP-6i; Mon, 19 Nov 2018 12:02:15 -0700
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gOooH-0004yY-LG; Mon, 19 Nov 2018 12:02:14 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian@brauner.io>
Cc:     Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <20181119103241.5229-1-christian@brauner.io>
        <20181119103241.5229-3-christian@brauner.io>
        <CAKOZueshQ2DAwUYp+dLpmfYG6FtvCqeRQxH41SjNS+WqY3e0Fw@mail.gmail.com>
        <20181119182902.fadw6qiu3eepndm3@brauner.io>
Date:   Mon, 19 Nov 2018 13:02:06 -0600
In-Reply-To: <20181119182902.fadw6qiu3eepndm3@brauner.io> (Christian Brauner's
        message of "Mon, 19 Nov 2018 19:29:05 +0100")
Message-ID: <87o9ak28nl.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gOooH-0004yY-LG;;;mid=<87o9ak28nl.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/IAgxHXFWsW3kF6a7EpuFZNuQYr3Siskc=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian@brauner.io> writes:

> On Mon, Nov 19, 2018 at 07:59:24AM -0800, Daniel Colascione wrote:
>> You never addressed my comment on the previous patch about your use of
>
> Sorry, that thread exploded so quickly that I might have missed it.
>
>> private_data here. Why can't you use the struct pid reference that's
>> already in the inode?
>
> If that's what people prefer we can probably use that. There was
> precedent for stashing away such data in fs/proc/base.c already for
> various other things including user namespaces and struct mm so I
> followed this model. A prior version of my patch (I didn't send out) did
> retrive the inode via proc_pid() in .open() took an additional reference
> via get_pid() and dropped it in .release(). Do we prefer that?

If you are using proc/<pid>/ directories as your file descriptors, you
don't need to add an open or a release method at all.  The existing file
descriptors hold a reference to the inode which holds a reference the
the struct pid.

The only time you need to get a reference is when you need a task
and kill_pid_info already performs that work for you.

So using proc_pid is all you need to do to get the pid from the existing
file descriptors.

Eric

