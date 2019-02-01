Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C938C282DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6409820844
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbfBAUMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:12:10 -0500
Received: from www62.your-server.de ([213.133.104.62]:53170 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfBAUMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 15:12:09 -0500
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gpfAU-0002cl-RF; Fri, 01 Feb 2019 21:12:06 +0100
Received: from [178.197.249.18] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gpfAU-0002k3-Jh; Fri, 01 Feb 2019 21:12:06 +0100
Subject: Re: [PATCH 4.19 095/103] bpf: prevent out of bounds speculation on
 pointer arithmetic
To:     Jann Horn <jannh@google.com>, Alexei Starovoitov <ast@kernel.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
 <20190129113207.223846678@linuxfoundation.org>
 <CAG48ez2KSRFkRCHdvOhZSsNkdWw=jq8yu9OvUPswsA3i6mq73g@mail.gmail.com>
 <20190201140852.GA20335@kroah.com> <20190201144531.GB9864@kroah.com>
 <CAG48ez2NvXwWbQvznDRyftT24NuaTVEh7TTNcu8Xj_aUCzGWxg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7a5382e0-7eff-6f47-4383-d749fd84f518@iogearbox.net>
Date:   Fri, 1 Feb 2019 21:12:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez2NvXwWbQvznDRyftT24NuaTVEh7TTNcu8Xj_aUCzGWxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25347/Fri Feb  1 12:05:35 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2019 06:38 PM, Jann Horn wrote:
> On Fri, Feb 1, 2019 at 3:45 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Fri, Feb 01, 2019 at 03:08:52PM +0100, Greg Kroah-Hartman wrote:
>>> On Fri, Feb 01, 2019 at 03:00:18PM +0100, Jann Horn wrote:
>>>> On Tue, Jan 29, 2019 at 12:47 PM Greg Kroah-Hartman
>>>> <gregkh@linuxfoundation.org> wrote:
>>>>> 4.19-stable review patch.  If anyone has any objections, please let me know.
>>>>>
>>>>> ------------------
>>>>>
>>>>> [ commit 979d63d50c0c0f7bc537bf821e056cc9fe5abd38 upstream ]
>>>>>
>>>>> Jann reported that the original commit back in b2157399cc98
>>>>> ("bpf: prevent out-of-bounds speculation") was not sufficient
>>>>> to stop CPU from speculating out of bounds memory access:
>>>>> While b2157399cc98 only focussed on masking array map access
>>>>> for unprivileged users for tail calls and data access such
>>>>> that the user provided index gets sanitized from BPF program
>>>>> and syscall side, there is still a more generic form affected
>>>>> from BPF programs that applies to most maps that hold user
>>>>> data in relation to dynamic map access when dealing with
>>>>> unknown scalars or "slow" known scalars as access offset, for
>>>>> example:
>>>>
>>>> Is this also going into 4.14 and 4.9? I don't see anything related in
>>>> the stable queue or in stable-rc.
>>>
>>> Ah, the original submitter did not send backported patches, but you are
>>> right, it should go further back.  I'll see how hard it would be to do
>>> the backport, thanks for letting me know.
>>
>> Ok, no, there's no way I can do this backport.  It didn't apply cleanly,
>> and trying to take the patches prior to this resulted in a huge mess.
>>
>> So, it would be wonderful if someone who knows the bpf code stack could
>> do this and send it in.
> 
> Daniel, Alexei: Can one of you do the backports to older stable kernels?

Ok, I'll try to find some cycles for 4.9 / 4.14 backports and see how
complex it gets, might be around next week though.

Thanks,
Daniel
