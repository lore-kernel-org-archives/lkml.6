Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96909C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4227B20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGKweX7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4227B20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbeG3VHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:07:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731852AbeG3VHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:07:32 -0400
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EAA220894
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 19:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532979063;
        bh=GYFPhZGe8FBZ4X/3kUFQT63F+37Gz6S3QUTd3gcx91g=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=PGKweX7sCxCYkkFTmZHHOcjoMslvVacrFMt3wy+RJA3TgUt12R/Uo0jXXP6CJXKnK
         y2n3iiYMJyO062WQtxXOYLn/oN5eATVOquBggNm+DsP8qTrabSnFmhoDQWy11KAhOF
         Z9lIqk1hBzaMIITwujFlKgVA/M8RUHLPG3nLim4Q=
Received: by mail-wm0-f46.google.com with SMTP id s14-v6so592843wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 12:31:03 -0700 (PDT)
X-Gm-Message-State: AOUpUlHrrpvyG6bcevA09WQ3Yb48Qht2+j7YkvxjDhRbZxBv9H+G414E
        QAjmaa/J0lXE4NscsK4I5JjOb74JyLEaxxAY9ALZ8w==
X-Google-Smtp-Source: AAOMgpcn0mEclURKhA7By5oZAlUlHuk/ba4SmbS8ZizuV8vrqwYELyaLQZTg+puwNsTr/kb7nRgsc9DMR7gNaIyswvo=
X-Received: by 2002:a1c:f30d:: with SMTP id q13-v6mr368459wmq.36.1532979061874;
 Mon, 30 Jul 2018 12:31:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 12:30:41 -0700 (PDT)
In-Reply-To: <1532978146.28585.32.camel@surriel.com>
References: <20180728215357.3249-1-riel@surriel.com> <20180728215357.3249-11-riel@surriel.com>
 <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com>
 <20180729155452.37eddc11@imladris.surriel.com> <20180730095502.GG2494@hirez.programming.kicks-ass.net>
 <1532961011.28585.30.camel@surriel.com> <20180730162653.GM2494@hirez.programming.kicks-ass.net>
 <1532978146.28585.32.camel@surriel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 30 Jul 2018 12:30:41 -0700
X-Gmail-Original-Message-ID: <CALCETrXZPN6Lt55siHM__YW4jFfoy5w+Hd2aJtEi8qhsro6RMA@mail.gmail.com>
Message-ID: <CALCETrXZPN6Lt55siHM__YW4jFfoy5w+Hd2aJtEi8qhsro6RMA@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] mm,sched: conditionally skip lazy TLB mm refcounting
To:     Rik van Riel <riel@surriel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 12:15 PM, Rik van Riel <riel@surriel.com> wrote:
> On Mon, 2018-07-30 at 18:26 +0200, Peter Zijlstra wrote:
>> On Mon, Jul 30, 2018 at 10:30:11AM -0400, Rik van Riel wrote:
>>
>> > > What happened to the rework I did there? That not only avoided
>> > > fiddling
>> > > with active_mm, but also avoids grab/drop cycles for the other
>> > > architectures when doing task->kthread->kthread->task things.
>> >
>> > I don't think I saw that. I only saw your email from
>> > July 20th with this fragment of code, which does not
>> > appear to avoid the grab/drop cycles, and still fiddles
>> > with active_mm:
>>
>> Yeah, that's it. Note how it doesn't do a grab+drop for kernel-
>> >kernel,
>> where the current could would have.
>>
>> And also note that it only fiddles with active_mm if it does the
>> grab+drop thing (the below should have s/ifdef/ifndef/ to make more
>> sense maybe).
>
> I'll kick off a test with your variant. I don't think we
> will see any performance difference on x86 (due to not
> using a refcount at all any more), but unless Ingo is in
> a hurry I guess there's no issue rewriting this part of
> the patch series :)
>
> Do the other patches look ok to you and Andy?
>

The whole series other than the active_mm stuff looked okay to me.
