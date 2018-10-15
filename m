Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD12C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42055208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42055208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeJPBx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:53:57 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:45637 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbeJPBx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:53:56 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gC7HE-0002Cg-83; Mon, 15 Oct 2018 12:07:36 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gC7HD-0006lS-KC; Mon, 15 Oct 2018 12:07:36 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jann Horn <jannh@google.com>
Cc:     Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Serge Hallyn <serge.hallyn@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andy Lutomirski <luto@amacapital.net>
References: <1539623427-10789-1-git-send-email-nagarathnam.muthusamy@oracle.com>
        <CAG48ez2cHT1U5nn+dNCAg3Lk5047=Tr20T8HkKhBUt1Mv+gNeg@mail.gmail.com>
Date:   Mon, 15 Oct 2018 13:07:21 -0500
In-Reply-To: <CAG48ez2cHT1U5nn+dNCAg3Lk5047=Tr20T8HkKhBUt1Mv+gNeg@mail.gmail.com>
        (Jann Horn's message of "Mon, 15 Oct 2018 19:22:12 +0200")
Message-ID: <87o9bvm6cm.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gC7HD-0006lS-KC;;;mid=<87o9bvm6cm.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/UAhEtWZXa/np3flMs4hZDRHZCrCRgDMo=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC] Allow user namespace inside chroot
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn <jannh@google.com> writes:

> On Mon, Oct 15, 2018 at 7:10 PM <nagarathnam.muthusamy@oracle.com> wrote:
>> @@ -1281,7 +1285,7 @@ static int userns_install(struct nsproxy *nsproxy, struct ns_common *ns)
>>                 return -ENOMEM;
>>
>>         put_user_ns(cred->user_ns);
>> -       set_cred_user_ns(cred, get_user_ns(user_ns));
>> +       set_cred_user_ns(cred, get_user_ns(user_ns), 0);
>
> This looks bogus. With this, I think your restriction can be bypassed
> if process A forks a child B, B creates a new user namespace, then A
> enters the user namespace with setns() and has full capabilities. Am I
> missing something?

Nope.  I feel silly for missing that angle.

Even without the full capabilities the userns_install angle will place
you at the root of the mount namespace outside of the chroot.

At which point I have visions of the special cases multiplying like
bunnies make this work.  Without a very strong case I don't like this at all.

Eric



