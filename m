Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560CDC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E786D21A2F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E786D21A2F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeHQV1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 17:27:20 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:55724 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeHQV1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 17:27:19 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fqjOg-0000Bf-GN; Fri, 17 Aug 2018 12:22:54 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fqjOQ-0004qD-Ts; Fri, 17 Aug 2018 12:22:54 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzbot <syzbot+1f371ca19b341a276761@syzkaller.appspotmail.com>,
        jlayton@kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <0000000000007f59610573509684@google.com>
        <000000000000f4136d0573512103@google.com>
        <20180814191129.GN7906@fieldses.org>
        <CACT4Y+YujnbvrgRU6xc+=8rHLctrjQbRP+wq-08UmbH_oOfAKA@mail.gmail.com>
        <87o9e3gdtg.fsf@xmission.com>
        <CACT4Y+Yjj-n5BQvZhhM41fxxm57ABP1azEnrodmjZ65VrOcoxA@mail.gmail.com>
Date:   Fri, 17 Aug 2018 13:22:31 -0500
In-Reply-To: <CACT4Y+Yjj-n5BQvZhhM41fxxm57ABP1azEnrodmjZ65VrOcoxA@mail.gmail.com>
        (Dmitry Vyukov's message of "Fri, 17 Aug 2018 10:26:58 -0700")
Message-ID: <87d0ugc0pk.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fqjOQ-0004qD-Ts;;;mid=<87d0ugc0pk.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19RM6ezQkXV4F6Ej3djQ7NVGUxG2Nk5/q0=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: general protection fault in send_sigurg_to_task
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov <dvyukov@google.com> writes:

> On Wed, Aug 15, 2018 at 9:01 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> Dmitry Vyukov <dvyukov@google.com> writes:
>>
>>> On Tue, Aug 14, 2018 at 12:11 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
>>>> On Mon, Aug 13, 2018 at 06:33:02AM -0700, syzbot wrote:
>>>>> syzbot has found a reproducer for the following crash on:
>>>>>
>>>>> HEAD commit:    5ed5da74de9e Add linux-next specific files for 20180813
>>>>> git tree:       linux-next
>>>>
>>>> I fetched linux-next but don't have 5ed5da74de9e.
>>>
>>> Hi Bruce,
>>>
>>> +Stephen for the disappeared linux-next commit.
>>>
>>> On the dashboard link you can see that it also happened on a more
>>> recent commit 4e8b38549b50459a22573d756dd1f4e1963c2a8d that I do see
>>> now in linux-next.
>>>
>>>> I'm also not sure why I'm on the cc for this.
>>>
>>> You've been pointed to by "./scripts/get_maintainer.pl -f fs/fcntl.c"
>>> as maintainer of the file, which is the file where the crash happened.
>>
>> You need to use your reproducer to bisect and find the commit that
>> caused this.  Otherwise you will continue to confuse people.
>>
>> get_maintainer.pl is not a good target for automated reporting
>> especially against linux-next.
>
> Hi Eric,
>
> We will do bisection.
> But I afraid it will not give perfect attribution for a number of reasons:
>  - broken build/boot which happens sometimes for prolonged periods and
> prohibits bisection
>  - elusive races that can't be reproduced reliably and thus bisection
> can give wrong results
>  - bugs introduced too long ago (e.g. author email is not even valid today)
>  - reproducers triggering more than 1 bug, so base bisection commit
> can actually be for another bug, or bisection can switch from one bug
> to another
>  - last but not least, bugs without reproducers
> Bisection will add useful information to the bug report, but it will
> not necessary make attribution better than it is now.
>
> Do you have more examples where bugs were misreported? From what I see
> current attrition works well. There are episodic fallouts, but well,
> nothing is perfect in this world. Humans don't bisect frequently and
> misreport sometimes. I think we just need to re-route bugs in such
> cases.

I have yet to see syzbot make a good report.  Especially against
linux-next.

Eric

