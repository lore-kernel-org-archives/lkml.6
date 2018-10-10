Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCA7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5352087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7cTuMvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5352087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeJKBfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbeJKBfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:35:07 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E2632087A;
        Wed, 10 Oct 2018 18:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539195109;
        bh=RvvAjvsL79jNdAlmWbWDQYevrjpLJgpg6XWfhDPUVII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E7cTuMvyTrkX38fZ2HR0Z8slqMi1GcU28dOTnRlwNPXgZZpw6qr5J6eQvr6q+Mg72
         AB3Pw8MiPVi8y7UDSqosFQ1WqiExXzNjuroC+Q7PChcqBvxllSaARnxbvTs+XMJXB2
         /CslJ/l/A8P5gDvfzMXP3h6p4Gxb2+Iby4I8VMDc=
Date:   Wed, 10 Oct 2018 14:11:48 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        "3.8+" <stable@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        alexander.levin@microsoft.com
Subject: Re: [PATCH AUTOSEL 4.18 24/58] Input: atakbd - fix Atari CapsLock
 behaviour
Message-ID: <20181010181148.GI32006@sasha-vm>
References: <20181008152523.70705-1-sashal@kernel.org>
 <20181008152523.70705-24-sashal@kernel.org>
 <CAKdAkRSoq_U1rkO+6gbautYpS1fFn3icLY3Dtx0geXNC7MwvbA@mail.gmail.com>
 <bec357b5-09d0-5014-d2a3-0ade83499d15@gmail.com>
 <CAKdAkRSuuv_8BOz2m=DSgnV7a2MNY+6ZPera3ROfV3osMUTStQ@mail.gmail.com>
 <20181010142958.GF32006@sasha-vm>
 <20181010170219.GA47260@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181010170219.GA47260@dtor-ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 10:02:19AM -0700, Dmitry Torokhov wrote:
>On Wed, Oct 10, 2018 at 10:29:58AM -0400, Sasha Levin wrote:
>> On Mon, Oct 08, 2018 at 12:20:26PM -0700, Dmitry Torokhov wrote:
>> > Hi Michael,
>> >
>> > On Mon, Oct 8, 2018 at 12:09 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> > >
>> > > Dmitry,
>> > >
>> > > someone on debian-68k reported the bug, which (to me) indicates that the
>> > > code is not just used by me.
>> > >
>> > > Whether or not a functioning Capslock is essential to have? You be the
>> > > judge of that. If you are OK with applying the keymap patch, why not
>> > > this one?
>> >
>> > I have exactly the same concerns about the keymap patch. This all has
>> > not been working correctly for many many years (and it was not broken
>> > in a subtly way as far as I understand, but rather quite obvious).
>> > Thus I do not understand why this belongs to stable release. It is not
>> > a [recent] regression, nor secutiry bug, nor even enabling of new
>> > hardware, that is why I myself did not mark it as stable.
>> >
>> > I still maintain that we pick up for stable too many patches for no
>> > clear benefit. This is similar to the patch for Atmel controllers that
>> > was picked to stable and I asked why, as it is not clear how many
>> > users might be affected (or if the problem the patch was solving was
>> > purely theoretical, or only affecting hardware that is not in
>> > circulation yet).
>>
>> If you belive that a certain piece of code has no actual users, why do
>> you keep it in the upstream kernel to begin with?
>
>Because obviously there are users. Maybe 5 of them, maybe 10. They do
>not follow upstream very closely (otherwise these fixes would have
>appeared in mainline long time ago) but they still exist. And it is not
>hard to keep the driver in if there are not many changes.

It, similarily, not hard to backport these changes to stable tree
especially if they're in a self-contained driver such as this one.

>>
>> I don't think it makes sense to keep something upstream because it might
>> have users, but not backport fixes because there might not have any
>> users.
>>
>> You haven't seen evidence of anyone using/caring about it for a few
>> years? Great! Remove the code and if someone complains we can always
>> revert. This is how all those orphaned archs got removed a few releases
>> back. I'll even submit the patch if you'd like.
>>
>> It doesn't make sense to have "second class citizens" like how you
>> suggested.
>
>Sure does. Look, one of roles of a mantainer is basically a release
>manager. We need to decide what goes into new release, what goes into
>maintenance release, what stays until later milestone. Each release has
>different criteria. With maintenance release you want to minimize the
>disruption while alleviating most recent and critical/high visibility
>issues, IOW you want to get the most bang for your buck. And these
>particular fixes do not give you any bang, none at all.
>
>Same goes for patches that deal with error handling in probe() functions
>that your AUTOSEL scripts like to pick. Yes, they are fixing bugs. But
>show me actually users affected by them? You encounter these issues with
>probe when you do initial device bringup, but once device is stabilized
>probes are expected to succeed. There won't be duplicate sysfs
>attributes, memory will be allocated, and so on. Fixes to remove() might
>be worthwhile if it is a hot-pluggable bus, but otherwise - no. Yes, the
>box may OOPS if someone manually unbind device through sysfs, but the
>solution is no to patch stable kernels, but simply tell user "dont to
>that [yet]".
>
>When selecting a patch for stable ask yourself: "if I do not pick this
>for stable will a distribution be willing to patch this into their
>kernel on their own"? If the answer is "no" it should be pretty strong
>indicator whether a patch belongs to stable or not.

There is a big difference between distros and the stable trees. Distros
know who their users/customers are, OTOH we have no clue who the users
of stable trees are.

I think Greg's last estimate was that about 1/3 of the kernels in the
wild are custom based on a kernel.org stable kernel, which means that we
have no visibility as to what they do with the kernel. If you don't know
who your users are, how can you prioritize some subsystems over others?

I don't think we can do any of that because we don't know who uses the
kernel and what bugs they hit, or don't hit. This is one of the reasons
we ask everyone to pick everything, if they don't use whatever code we
changed they won't be affected at all.

As a trivial example: we run a few kernels with custom configs in
Microsoft. Can you tell which drivers we use and how many machines use
them? Us not showing up in git log doesn't mean we don't use something,
it just means that the stable process works for us.

--
Thanks,
Sasha
