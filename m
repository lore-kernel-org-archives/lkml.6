Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C038C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96852151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96852151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeHUQAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:00:31 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:49033 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbeHUQAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:00:31 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fs5xU-0002ys-H8; Tue, 21 Aug 2018 06:40:28 -0600
Received: from [105.224.248.17] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fs5xE-0000nD-Jo; Tue, 21 Aug 2018 06:40:28 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Simon Horman <horms@verge.net.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        natechancellor@gmail.com,
        "the arch\/x86 maintainers" <x86@kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
References: <20180801210804.175176-1-ndesaulniers@google.com>
        <CAKwvOd=WZB=x86zqu=vFDoJgpWnfCj0K3qXv14vtysfv3ioi1w@mail.gmail.com>
        <CAKwvOd=qGTv1F3CsEeNjuJ93BD9zTnUekUHgvw4Ttpx7us5JdA@mail.gmail.com>
        <CAKwvOd=U0aMsUmBytK7vq=ORj+Npw7FqZ50EMEJPnmTG15N7dg@mail.gmail.com>
        <CA+55aFxHtbq=X9Jaes1qwVAhu5mx0eTahUjd7ijxgW44JjFaYQ@mail.gmail.com>
Date:   Tue, 21 Aug 2018 14:40:02 +0200
In-Reply-To: <CA+55aFxHtbq=X9Jaes1qwVAhu5mx0eTahUjd7ijxgW44JjFaYQ@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 20 Aug 2018 16:48:38 -0700")
Message-ID: <87bm9v28rh.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fs5xE-0000nD-Jo;;;mid=<87bm9v28rh.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.224.248.17;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX183i7m6VAJKDbk/tSZH55UsXBjfKw/gkXQ=
X-SA-Exim-Connect-IP: 105.224.248.17
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] x86/kexec: prefer _THIS_IP_ to current_text_addr
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Aug 20, 2018 at 10:58 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>>
>> + akpm, Linus
>>
>> Bumping for review.
>
> Ugh. I am not personally a huge fan of this endless "fix up one at a time".
>
> Just do a patch that removes current_text_addr() entirely and be done
> with it, if that's what we want the end result to be.
>
> Don't bother with these small "let's remove the remaining ones one by
> one". Just get it over and done with.

One is generic code the other is assembly but the both appear to do the
same thing without unexpected complexity.

That said the patch earlier in this thread has clearly never been
compiled as it is using THIS_IP instead of _THIS_IP_ and there is not
a define of THIS_IP in the kernel.

Eric

