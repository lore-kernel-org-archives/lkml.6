Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259ACC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B707020866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dmm8w90a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B707020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeIMJcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 05:32:51 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34175 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeIMJcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 05:32:51 -0400
Received: by mail-yb1-f194.google.com with SMTP id t10-v6so2768868ybb.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 21:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7oaRrgCH8FMgYqgf5wQKl/zFZfk1zkIZLePlt6j1oKI=;
        b=Dmm8w90aXdR9ZS4WLQHZx8Lfpacik8uNqAU9HuAcV2AxAY9QlPRbZi0xM7sKaUuDmV
         bPy0ZzlFcMULnN6d8SH/0/zwtpO0ICxJiiu8e0PPzqBH3On5YPddngIo976ZuJBBNXoa
         J4HcDOD0+Cgh2JT/vZxO9+/BEgOCKd8f+M3uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7oaRrgCH8FMgYqgf5wQKl/zFZfk1zkIZLePlt6j1oKI=;
        b=AF4xb6kF4r0R7Mx2U0kWxPsaTVs5dXx8ngDpmG4QwCGEMOiPdiCmOYRNuUOJlS5JR5
         Q338IJNYXRedSxmUIkg0RyEGajPsHum3C0SmlcvpydtxquE+Uvczi3JLgxDffHIaw30o
         Z0edUFbD2iwEeHz4FBJe1aQNEkk53DGQlxAU3ra2tAbQUKHGBTW24BTiHH7fYCgLRUpW
         aB9iQwavox6KRD184HNSl9G5vAY+CPUUL5PsD7yiLgImKZ4KL7n5sV7xJdNVZJi/gVeN
         aarLhJqwRkfev7TMEsa/sfiDET8vKQHyi4t27ydaGaNzX/Ny5nW6KjeOBcLjHZqUmuMd
         5viQ==
X-Gm-Message-State: APzg51AsdGU3UPgG2mm6lAS9v8LlNBWCZ9NrobpEzn6F3BZnieB0ZeMF
        3KRjsnKGynj29mcx1tiWrkSyjFQMv34=
X-Google-Smtp-Source: ANB0VdZEPQmidF7Fu3hdc69EeP3tXdG13EQXnr3BGrAeYIyp/C14tGuDkR2oMiKwwQrSOY8yMeycUg==
X-Received: by 2002:a25:1543:: with SMTP id 64-v6mr2656984ybv.468.1536812708283;
        Wed, 12 Sep 2018 21:25:08 -0700 (PDT)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id u191-v6sm978139ywc.0.2018.09.12.21.25.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 21:25:07 -0700 (PDT)
Received: by mail-yw1-f53.google.com with SMTP id i144-v6so646272ywc.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 21:25:06 -0700 (PDT)
X-Received: by 2002:a81:9fd6:: with SMTP id w205-v6mr2623549ywg.288.1536812706455;
 Wed, 12 Sep 2018 21:25:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 21:25:05
 -0700 (PDT)
In-Reply-To: <41ab11ba9fa03940d129f478109d048b197d9a59.camel@intel.com>
References: <1536723394-14616-1-git-send-email-bin.yang@intel.com>
 <CAGXu5j+C9pApyP4ab6usOudFFFBqX5WpZQYaH6m2BpmABB2W6w@mail.gmail.com> <41ab11ba9fa03940d129f478109d048b197d9a59.camel@intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 12 Sep 2018 21:25:05 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJigfeAgzoHRR-sny651kcB5fQEGF_X5n+Wi02EfwP9iA@mail.gmail.com>
Message-ID: <CAGXu5jJigfeAgzoHRR-sny651kcB5fQEGF_X5n+Wi02EfwP9iA@mail.gmail.com>
Subject: Re: [PATCH] pstore: fix incorrect persistent ram buffer mapping
To:     "Yang, Bin" <bin.yang@intel.com>
Cc:     "ccross@android.com" <ccross@android.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anton@enomsg.org" <anton@enomsg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 6:21 PM, Yang, Bin <bin.yang@intel.com> wrote:
> On Wed, 2018-09-12 at 10:44 -0700, Kees Cook wrote:
>> On Tue, Sep 11, 2018 at 8:36 PM, Bin Yang <bin.yang@intel.com> wrote:
>> > persistent_ram_vmap() returns the page start vaddr.
>> > persistent_ram_iomap() supports non-page-aligned mapping.
>>
>> Oh, yes, good catch. This should probably be explicitly mentioned in
>> comments for these functions.
>>
>> > persistent_ram_buffer_map() always adds offset-in-page to the vaddr
>> > returned from these two functions, which causes incorrect mapping of
>> > non-page-aligned persistent ram buffer.
>>
>> How did you find this problem, and/or how was the problem manifesting?
>
> By default, ftrace_size is 4096 and max_ftrace_cnt is nr_cpu_ids. The
> zone_sz in ramoops_init_przs() is 4096/nr_cpu_ids which might not be
> page aligned. If the offset-in-page > 2048, the vaddr will be in next
> page. If the next page is not mapped, it will cause kernel panic.
>
> I just wanted to enable this driver on my board and did not change the
> default value of ftrace_size. It resulted kernel panic as below:
>
>
> [    0.074231] BUG: unable to handle kernel paging request at
> ffffa19e0081b000

Perfect, thanks! I've updated your commit log to include these details
now. Should be in linux-next shortly.

-Kees

-- 
Kees Cook
Pixel Security
