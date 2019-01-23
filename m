Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4CAC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9513A2184B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548251793;
	bh=qmtj3Oc/RNbqvAvdhTKsPoLiEUvVXQFuGQ1MKtl3rdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pDkAW8s/t+2RGxRWBoiVK1gOru0zuMhxt5gaDWKNSJ3SBamc0AKfsqwIoIv4WmMX0
	 rUQin0i4BoF/6qaU1GXgVGfvYc2GHA8T4Zd6BQb43PzzAF7wvKdpBS21KMiHkp93uQ
	 7dwZoeChl9q9wMlS//HFbSSPqhUTSVDvo0wl/exg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfAWN4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 08:56:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfAWN4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 08:56:32 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69A592184B;
        Wed, 23 Jan 2019 13:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548251790;
        bh=qmtj3Oc/RNbqvAvdhTKsPoLiEUvVXQFuGQ1MKtl3rdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HXwVeENUHHxoQOBGMcC2+dkLBMoCtr6A2RbNK2AbwbtTSSrrv7giEKO51vNB9Iw9+
         Q0oBAGnaG0yY9t8xZ7o9tTCTuMb9VCguK1vfXDdA29+tbKB2aTeYcv14Nfs8XeZMru
         fzSLRCiAHOj5Y2ynxQ5MS43atz2Xna+ASLUuj4RM=
Date:   Wed, 23 Jan 2019 08:56:29 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 4.20 016/117] fanotify: return only user
 requested event types in event mask
Message-ID: <20190123135629.GH202535@sasha-vm>
References: <20190108192628.121270-1-sashal@kernel.org>
 <20190108192628.121270-16-sashal@kernel.org>
 <CAOQ4uxgwZjyoEOeRRj0eRsPR2+QmyUht0sErtZV=meKcPTDVcA@mail.gmail.com>
 <20190109113242.GE15397@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190109113242.GE15397@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:32:42PM +0100, Jan Kara wrote:
>On Wed 09-01-19 08:50:33, Amir Goldstein wrote:
>> On Tue, Jan 8, 2019 at 10:11 PM Sasha Levin <sashal@kernel.org> wrote:
>> >
>> > From: Matthew Bobrowski <mbobrowski@mbobrowski.org>
>> >
>> > [ Upstream commit 2d10b23082a7eb8be508b3789f2e7250a88a5ddb ]
>> >
>> > Modify fanotify_should_send_event() so that it now returns a mask for
>> > an event that contains ONLY flags for the event types that have been
>> > specifically requested by the user. Flags that may have been included
>> > within the event mask, but have not been explicitly requested by the
>> > user will not be present in the returned value.
>> >
>> > As an example, given the situation where a user requests events of type
>> > FAN_OPEN. Traditionally, the event mask returned within an event that
>> > occurred on a filesystem object that has been marked for monitoring and is
>> > opened, will only ever have the FAN_OPEN bit set. With the introduction of
>> > the new flags like FAN_OPEN_EXEC, and perhaps any other future event
>> > flags, there is a possibility of the returned event mask containing more
>> > than a single bit set, despite having only requested the single event type.
>> > Prior to these modifications performed to fanotify_should_send_event(), a
>> > user would have received a bundled event mask containing flags FAN_OPEN
>> > and FAN_OPEN_EXEC in the instance that a file was opened for execution via
>> > execve(), for example. This means that a user would receive event types
>> > in the returned event mask that have not been requested. This runs the
>> > possibility of breaking existing systems and causing other unforeseen
>> > issues.
>> >
>> > To mitigate this possibility, fanotify_should_send_event() has been
>> > modified to return the event mask containing ONLY event types explicitly
>> > requested by the user. This means that we will NOT report events that the
>> > user did no set a mask for, and we will NOT report events that the user
>> > has set an ignore mask for.
>> >
>> > The function name fanotify_should_send_event() has also been updated so
>> > that it's more relevant to what it has been designed to do.
>> >
>> > Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
>> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>> > Signed-off-by: Jan Kara <jack@suse.cz>
>> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>> > ---
>>
>> I have no objection to applying this patch to 4.20, but FYI, it does not
>> fix anything.  Before introducing FAN_OPEN_EXEC in 5.0-rc1, this patch
>> has no visible effect.
>
>Yes, the patch is just a code refactoring useful for the FAN_OPEN_EXEC
>feature.
>
>> I don't mind if you apply it. It will make stable code closer to
>> mainline, which is always a good thing IMO. And FWIW, I think that patch
>> is quite trivial and low risk.
>
>I don't think applying code refactoring to stable is a good idea. Every
>change has a risk of regression and this particular one brings users no
>benefit. So I'd prefer to drop this patch from stable queue.

No objections there, dropping it. Thank you.

--
Thanks,
Sasha
