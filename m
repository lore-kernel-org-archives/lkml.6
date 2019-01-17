Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B167FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D33D20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547747608;
	bh=oGSbA/x08rz7g6/JrlG3s9Uhwr3/YpRmY7H+bDLS6D4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ZSulgIpuXN9XSJ6h7MybDslgI3TiWCT34JTq5rG1LsRCxPmoSBRhjWa7PtMUJI1vr
	 IVimUJ4GjX8/SNJrGOoIZ0WDeNTBMQL1E8cDADW7X4YQmkh+iviXuJyj1vERwXLqm+
	 RLljspvnTt7nqkxHM2WPQVhL3isJpJvhcbU/OhrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfAQRx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:53:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:58482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfAQRxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:53:24 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9C9720652;
        Thu, 17 Jan 2019 17:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547747604;
        bh=oGSbA/x08rz7g6/JrlG3s9Uhwr3/YpRmY7H+bDLS6D4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=y5/CYVKElAeOtxgIN4cUppBbN6yVTie6IPDv+ocdHKPB9+svsc7MQ7++17yDK8ix0
         NePjSz7tw20eVss4LP5R6ASef0r0Wfn1olTXrE6hsy/s8jclZ2lhjdxf5i7WycpJDP
         E3G054FCEHjRJDRlHlwI1oGhBb8FlsHa7Y/Jq4BY=
Subject: Re: Linux 5.0-rc2 seccomp_bpf user_notification_basic test hangs
To:     Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>
References: <7cd7d5bc-1d69-57f5-4a98-81b036f81682@kernel.org>
 <CAGXu5jLGqXstRCmM1_fxUxn4djs1YLUun2Fc8ExcaN4-CKyELQ@mail.gmail.com>
 <20190117004416.GA17449@cisco>
 <f665bb74-293b-d627-2605-5b8de7671743@kernel.org>
 <CAGXu5jJ0VK4UiOeKTqv_TZSn5aZAVsXjUZgiXD=KFbZ-Ng_+KQ@mail.gmail.com>
 <20190117162703.GC17449@cisco>
 <CAGXu5jJOGO1UWdYdGmnnUEZOm-DaMUqR3UVSi+gnSc7q3KE8xA@mail.gmail.com>
 <20190117164531.GD17449@cisco>
From:   shuah <shuah@kernel.org>
Message-ID: <bc944bc9-65aa-d00e-a2b5-ec6d769dae9a@kernel.org>
Date:   Thu, 17 Jan 2019 10:53:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190117164531.GD17449@cisco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/19 9:45 AM, Tycho Andersen wrote:
> On Thu, Jan 17, 2019 at 08:41:59AM -0800, Kees Cook wrote:
>> On Thu, Jan 17, 2019 at 8:27 AM Tycho Andersen <tycho@tycho.ws> wrote:
>>>
>>> On Thu, Jan 17, 2019 at 08:12:50AM -0800, Kees Cook wrote:
>>>> On Wed, Jan 16, 2019 at 5:26 PM shuah <shuah@kernel.org> wrote:
>>>>> I am running Linux 5.0-rc2 and not an older kernel.
>>>>
>>>> Weird. I couldn't reproduce this on 5.0-rc2, but I did see it on a
>>>> kernel without seccomp user_notif. Does the patch I sent fix it for
>>>> you? (And if so, can you take it in your tree?)
>>>
>>> I can reproduce it; you have to run it as non-root. I think your patch
>>> is necessary to get it to at least fail. The question is: what should
>>> we do about these tests that require real root? Skip them if we're not
>>> real-root, I guess?
>>
>> Hm, maybe use the XFAIL() bit of the harness?
>>
>> Perhaps it's time to make it a root-only test and do internal
>> priv-dropping to test the nnp-requiring parts? I'll add it to the TODO
>> list...
> 

Yup that is a good way to handle it. Please skip the test with ksft skip
code for non-root runs.

> Ok, I'll try to send a couple of patches soon to fix some of this up.
> But at least yours should should stop things from hanging for now.
> 

I am going to take Kees's patch to prevent hangs right away.

thanks,
-- Shuah

