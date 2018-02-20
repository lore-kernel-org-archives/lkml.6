Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeBTMbU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 07:31:20 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:36352 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbeBTMbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 07:31:17 -0500
X-Google-Smtp-Source: AH8x225P59gR02Aavfdtc6MqM/mMk0dwDcaSGUpapGApPXIm4GPaaB2cqpc86x2e2rljEH91Ih90dA==
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 1/3] locking/ww_mutex: cleanup lock->ctx usage in amdgpu
To: christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180215141944.4332-1-christian.koenig@amd.com>
 <20180219152421.GQ22199@phenom.ffwll.local>
 <cbfec1ed-d01f-1d4f-c3c0-cc04b93bc58c@gmail.com>
 <20180219161544.GY22199@phenom.ffwll.local>
 <2e696981-6b4a-e292-c16a-0f3477dbf8ce@gmail.com>
 <20180219164354.GB22199@phenom.ffwll.local>
 <f3cef14f-135c-2446-74b5-20e14773b0c4@gmail.com>
 <20180220113318.GN22199@phenom.ffwll.local>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9c0175bd-cd5e-e643-de9b-5b2f6b2449a1@gmail.com>
Date: Tue, 20 Feb 2018 13:31:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220113318.GN22199@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.02.2018 um 12:33 schrieb Daniel Vetter:
> [SNIP]
> Ah, so the ttm_ctx I've spotted was something entirely different and
> doesn't contain the ww_acquire_ctx (I didn't check)? I'd assume you have
> the same ctx passed around to everything in ttm, but if that doesn't exist
> then we can indeed not annotate ww_mutex_trylock_ctx with the right ctx.

Yes, exactly.

I actually tried this approach, e.g. put the ww_acquire_context into the 
ttm_operation_context and then use that with ww_mutex_trylock_ctx.

But a) that turned out to be to much hassle, e.g. at least amdgpu 
doesn't use a ww_acquire context in most cases.

And b) it actually wasn't what I was looking for, e.g. I couldn't 
distinct between the trylocked BOs an everything else any more.

>> [SNIP]
>> But to me it actually looks more like that makes it unnecessary complicated.
>> The use case in amdgpu which could only check the context isn't performance
>> critical.
> Oh I'm not worried about the runtime overhead at all, I'm worried about
> conceptual clarity of this stuff. If you have a ctx there's no need to
> also look at ->owner.
>
> Another idea: We drop the task argument from functions and go with the
> following logic:
>
> ww_mutex_is_owner(lock, ctx)
> {
> 	if (ctx)
> 		return lock->ctx == ctx;
> 	else
> 		return lock->owner == current;
> }
>
> I think that would solve your use case, and gives us the neat interface
> I'm aiming for. Kerneldoc can then explain what's happening for a NULL
> ctx.

Good point, going to adjust the patches this way and resend.

Christian.
