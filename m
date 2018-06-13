Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B6DD7C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1E1208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YsL0j84V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1E1208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935716AbeFMTk0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:40:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36209 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935320AbeFMTkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:40:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id v131-v6so7584425wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 12:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0WWGYBQfvXT4sryEBaOvqZgAXX54yKQSK76l3gDnXKM=;
        b=YsL0j84VOsirN0dz8mWPDe+fcStRPmPNBYMt+1pxeZWdk2+oowuktAvBdLgWRM80nc
         cBehVJEcarPz7krXXvQEj4PGUw1gXaAavxIUsROQ+VtSbCL+S8sG0oKOhlGW72Gn+W6/
         vXqj3KtqEx4RWYe/2lKCJxMWQVaUp/pAU4Ti4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0WWGYBQfvXT4sryEBaOvqZgAXX54yKQSK76l3gDnXKM=;
        b=Jo5Iwmek+l9KmUQuU9gxos7j9bJJNbJcLuTMykAAl9fsr/pB6oJu0AJ92d1/P+q84e
         3fXvl3EV9Z+0L0DDYBKsb91UnvwwWSmUNFCNgymBVG80S/VVksI+xRBRqP0bWwwGInqP
         shnLh/JuFMdnE6GLJ5Z3Wt/YEpR6iX7jPvz9ku23s/axPSO3YYruT9Wr6b/EhlGUQ0V1
         QBY+Mo+KRF1LEIyvMRJjstuU15J3+GImATHBAbv+wBSZafiQficG1ra/Bn122sUdXFAD
         GziylQEP14PTYpnC7u85ATPR1oXnRvI75igpiMyFnA7gPxIiWwtsFq2kg/W2UjxB8BXj
         2BaA==
X-Gm-Message-State: APt69E0D35AOkH5GDFUzd7b3cm9oyLeYq2MaNE/uiDoRZoO6QtlXI8fs
        q7+iIbZ7hznAHG/pPUSpIt+xDki7vq26inUVBThrdA==
X-Google-Smtp-Source: ADUXVKKyrf72JIeiQlVE9kCCVsoQyHzdiNA65EBc1bYAYmDzCh7ESK9U/+F4/odOfWd8eu+0fTy9mmZRsju5bhZW5og=
X-Received: by 2002:a1c:40d4:: with SMTP id n203-v6mr4260773wma.101.1528918823684;
 Wed, 13 Jun 2018 12:40:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:8ac3:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 12:40:23
 -0700 (PDT)
In-Reply-To: <20180613043309.GA5531@castle>
References: <CALAqxLXg8ry5hdNXhJRWE0vHuGbtP4xg=DWQ4t0w_Z-6MHmEmA@mail.gmail.com>
 <CALAqxLXf1QtUYQAE3T0sFzzuKh728KGxpY8pkFnnTLML+idbwg@mail.gmail.com> <20180613043309.GA5531@castle>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 13 Jun 2018 12:40:23 -0700
Message-ID: <CALAqxLX1F7ZwXqVm4PDmHmJhKNmox8QL4GL9S03TAhfMxOCOyw@mail.gmail.com>
Subject: Re: OOPSes in mem_cgroup_protected
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 9:33 PM, Roman Gushchin <guro@fb.com> wrote:
> On Tue, Jun 12, 2018 at 09:08:27PM -0700, John Stultz wrote:
>> On Tue, Jun 12, 2018 at 6:02 PM, John Stultz <john.stultz@linaro.org> wrote:
>> > Hey Tejun,
>> >   With the current linus/master, I'm able to fairly regularly trip
>> > OOPSes (two examples below) in mem_cgroup_protected(), which seems to
>> > be new.  I haven't managed to trigger this sort of thing with v4.17.
>> >
>> > I've not had much time to dig in or bisect it - I only know that
>> > enabling most of the memory debuging config options didn't seem to
>> > trip anything prior to the issue. So I wanted to send you a heads up
>> > to see if there was already known, or if there was anything you might
>> > suggest to help chase this down.
>>
>>
>> So the line where we're crashing seems to be in mem_cgroup_protected():
>>   parent_emin = READ_ONCE(parent->memory.emin);
>>
>> where I'm guessing the parent->memory value is null, and emin is at
>> the 0x120 offset in the strucutre.
>>
>> Reverting the following commits seems to avoid the issue.
>> bf8d5d52ffe8 ("memcg: introduce memory.min")
>> 5f93ad67436b ("mm: treat memory.low value inclusive")
>> 230671533d64 ("mm: memory.low hierarchical behavior")
>>
>> I'm guessing I'm tripping over some path where the memory value never
>> gets initialized?
>>
>> Any ideas or suggestions?
>
> Hi, John!
>
> The patch below should fix the problem.
> It's in the mm tree right now, and hopefully will be merged upstream asap.
> Sorry for the inconvenience.

No worries, thanks for the quick fix! The patch you sent seems to be
working well!

Thanks again!
-john
