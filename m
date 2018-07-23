Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD5CECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EDA320779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EDA320779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387954AbeGWI4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:56:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54250 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387794AbeGWI4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:56:09 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 557EA2730FF
Subject: Re: [RFC PATCH] drm/atomic: add ASYNC_UPDATE flag to the Atomic
 IOCTL.
To:     Gustavo Padovan <gustavo.padovan@collabora.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     David Airlie <airlied@linux.ie>, dnicoara@chromium.org,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        alexandros.frantzis@collabora.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, tomasz Figa <tfiga@chromium.org>,
        kernel@collabora.com, Ezequiel Garcia <ezequiel@collabora.com>
References: <20180627212506.24061-1-enric.balletbo@collabora.com>
 <20180628133514.GK20518@intel.com>
 <cf850e8863b401673b7a8f65e32f0393795044c5.camel@collabora.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <71a2f451-030c-7413-2e9d-c679f4f1041c@collabora.com>
Date:   Mon, 23 Jul 2018 09:56:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <cf850e8863b401673b7a8f65e32f0393795044c5.camel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ville,

On 06/07/18 12:54, Gustavo Padovan wrote:
> Hi Ville,
> 
> On Thu, 2018-06-28 at 16:35 +0300, Ville Syrjälä wrote:
>> On Wed, Jun 27, 2018 at 11:25:06PM +0200, Enric Balletbo i Serra
>> wrote:
>>> From: Gustavo Padovan <gustavo.padovan@collabora.com>
>>>
>>> This flag tells core to jump ahead the queued update if the
>>> conditions
>>> in drm_atomic_async_check() are met. That means we are only able to
>>> do an
>>> async update if no modeset is pending and update for the same plane
>>> is
>>> not queued.
>>>
>>> It uses the already in place infrastructure for async updates.
>>
>> I still dislike the name. On Intel hw "async flip" means "flip
>> asap and tear". Whereas the legcay cursor thing i915 has is a normal
>> sync flip. "unthrottled" or something like that would be less
>> confusing.
> 
> Maybe "amend"? However if we submit an amend commit when no commit is
> pending it will become a regular atomic commit. 
> 

This has been following the names we introduced one year ago [1], basically to
solve the legacy cursor hack, some platforms are already using the async funcs
and there is another patch at least in the ML. I agree that async is not the
best name,

>>
>> As far as introducing this flag, at least i915 totally lacks a
>> mechanism for deferring the buffer unpinning after the vblank. Hence
>> this can't be used by i915 currently. I think the only reason we get
>> away with the cursor hack is that we unbind the vma lazily and it's
>> unlikely that the small cursor vma is going to get knocked out before
>> the next vblank. For larger buffers that risk grows. We would
>> probably
>> want a stress test that smashes the gtt hard while doing "async
>> updates" to catch this.
> 
> Right. We'll look into more detail to this in i915.
> 

We only have one use case for this api/flag, it is used to get cursor updates to
bypass pending atomic updates without having to rely on the legacy API for that.
The current behaviour is to amend the pending atomic update to get the cursor on
the next vblank. I believe intel on intel we would do the same despite having
the chance update right away and tear? Or do you see we doing this differently?
Do you have an usecase for flip asap and tear?

Do you see here a need for 2 apis/flags and have a usecase for both? (one for
updating the plane on the hw asap and tear and another one to wait the next vblank).

>>
>> There's also the question of how out fences work with the async
>> updates. I see that you disallow such an update if there's a previous
>> sync update still pending. That simplifies things a little bit I
>> suppose. But still you would need to track the fences per-plane and
>> signal the old fence ones as soon as the new update overrides the
>> pending update. And if you want to allow multiple planes in one async
>> update then I think the uapi would need to be changed to have
>> per-plane fences as well because subsequent updates could override 
>> only a part of a previous update.
> 
> The only usecase (and userspace) we have on our side for now is for
> cursors. I'm not sure an uAPI that only work for cursor in the first
> stage would be acceptable. That would make things easier.
> 
> For updates on other planes or multiples planes I agree with you on
> having per-plane fences - but I guess we need a userspace usecase for
> it first.
> 

<snip>

Best regards,
  Enric

[1] fef9df8b59453 ("drm/atomic: initial support for asynchronous plane update")

