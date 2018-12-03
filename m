Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD5AC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF8B20834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF8B20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeLCQ6I convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:58:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbeLCQ6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:58:08 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 100E230BA1E8;
        Mon,  3 Dec 2018 16:58:05 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-35.ams2.redhat.com [10.36.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67B0960610;
        Mon,  3 Dec 2018 16:58:01 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
References: <20181120105124.14733-1-christian@brauner.io>
        <87in0g5aqo.fsf@oldenburg.str.redhat.com>
        <746B7C49-CC7B-4040-A7EF-82491796D360@brauner.io>
        <20181202100304.labt63mzrlr5utdl@brauner.io>
Date:   Mon, 03 Dec 2018 17:57:51 +0100
In-Reply-To: <20181202100304.labt63mzrlr5utdl@brauner.io> (Christian Brauner's
        message of "Sun, 2 Dec 2018 11:03:06 +0100")
Message-ID: <8736rebl9s.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 03 Dec 2018 16:58:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Christian Brauner:

> Ok, I finally have access to source code again. Scratch what I said above!
> I looked at the code and tested it. If the process has exited but not
> yet waited upon aka is a zombie procfd_send_signal() will return 0. This
> is identical to kill(2) behavior. It should've been sort-of obvious
> since when a process is in zombie state /proc/<pid> will still be around
> which means that struct pid must still be around.

Should we make this state more accessible, by providing a different
error code?

Will the system call ever return ESRCH, given that you have a handle for
the process?

>> >Looking at the rt_tgsigqueueinfo interface, is there a way to implement
>> >the “tg” part with the current procfd_signal interface?  Would you use
>> >openat to retrieve the Tgid: line from "status"?
> 
> Yes, the tg part can be implemented.

I meant on top of the existing interface.

> As I pointed out in another mail my I is to make this work by using
> file descriptors for /proc/<pid>/task/<tid>.  I don't want this in the
> initial patchset though.  I prefer to slowly add those features once
> we have gotten the basic functionality in.

Do you want to land all this in one kernel release?  I wonder how
applications are supposed to discover kernel support if functionality is
split across several kernel releases.  If you get EINVAL or EBADF, it
may not be obvious what is going on.

What happens if you use the new interface with an O_PATH descriptor?

Thanks,
Florian
