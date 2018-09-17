Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D5DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B9320883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ARDaUBFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B9320883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbeIQU2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:28:36 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37724 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbeIQU2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:28:35 -0400
Received: by mail-yw1-f67.google.com with SMTP id x83-v6so5553146ywd.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 08:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fP3Uw0tF4eC/l47fFNzyMQvJUZGZZWWeg2w+r20OQVg=;
        b=ARDaUBFyMIz+jj6WTFmmqW3s0zkNbPCCYxtsFsRCE7lHsFMPG/VBlc4eRSsbryJf5b
         DHI+UE51XEjvSplEC2swJUYWGu5bql8QTExKWZo8jmj2aj/mHtLIEMNp2a912bJPof4e
         +JMPa5dWX2fTNwZK1gzOEbFpgXnirdamckoio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fP3Uw0tF4eC/l47fFNzyMQvJUZGZZWWeg2w+r20OQVg=;
        b=gxd9j6N3mbzk4jjNKNAVkse/ImsIQJl1pVAOi6xNo3gKQuZZKaRCXP7mkOnwPInZRH
         pVpdFShIi7rhPTB/kt8Hd2WjzWf+Vdwj1ts8uXBJSB4WTmQiSmBFq/9LZi4l80L2gUzt
         r761zMw5jrtH6a1tKlAjoW7VHwtC2rDgPhlk1dsFG1yZUMc+tgta9YZbSlqq4nEXLIeC
         gK5ItXmFRwED2nI42B1emjDZF8lKUl9VO0tb16O2dL5rv6C70A363UCH+A6iRakSxkxI
         YxSqVJGBkurXJLlnTnyONfNwChZqANzHOqo4ZrUB8ctMzaP6oraRPApRU9c74N1gXFhV
         lbDw==
X-Gm-Message-State: APzg51CCdZ6UmUj7Ey7TrIKV2Xm9ffueaBWYCnZPW2WcsqoDcJgcP5nY
        OA0n6hR3LuPEkvwWHGpoyZ+C937ozGI=
X-Google-Smtp-Source: ANB0VdYxwI6funGLS9wqHkPlZ3kiyweYKajLyMGWydPaP2eLk0bd4OewnU0IEsMlPXin9n2Nk83Nzw==
X-Received: by 2002:a81:e801:: with SMTP id a1-v6mr10255550ywm.170.1537196451594;
        Mon, 17 Sep 2018 08:00:51 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id r84-v6sm9163890ywe.10.2018.09.17.08.00.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 08:00:51 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id y20-v6so7831805ybi.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 08:00:51 -0700 (PDT)
X-Received: by 2002:a25:5c87:: with SMTP id q129-v6mr10882611ybb.403.1537196090449;
 Mon, 17 Sep 2018 07:54:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 07:54:49
 -0700 (PDT)
In-Reply-To: <CAEXW_YSPNqVgoYWjVAMvGg_WoRV4SC2xDH1wQWTdQfBUOMQbbQ@mail.gmail.com>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <141901b8-0a9a-2e7a-f7a4-cdefd157f4c6@codeaurora.org> <CAEXW_YSPNqVgoYWjVAMvGg_WoRV4SC2xDH1wQWTdQfBUOMQbbQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 17 Sep 2018 07:54:49 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLkE+mZkVSFPeOq75im0Kozm+NzfqL9CD-OMe7b7=3O5g@mail.gmail.com>
Message-ID: <CAGXu5jLkE+mZkVSFPeOq75im0Kozm+NzfqL9CD-OMe7b7=3O5g@mail.gmail.com>
Subject: Re: [PATCH 2/6] pstore: Add event tracing support
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, Bryan Huntsman <bryanh@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 6:55 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Sun, Sep 16, 2018, 12:08 AM Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>>
>> On 9/9/2018 1:57 AM, Sai Prakash Ranjan wrote:
>> > Currently pstore has function trace support which can be
>> > used to get the function call chain with limited data.
>> > Event tracing has extra data which is useful to debug wide
>> > variety of issues and is heavily used across the kernel.
>> >
>> > Adding this support to pstore can be very helpful to debug
>> > different subsystems since almost all of them have trace
>> > events already available. And also it is useful to debug
>> > unknown resets or crashes since we can get lot more info
>> > from event tracing by viewing the last occurred events.
>>
>> Anyone here?
>
> Sorry for the top post. I've been wanting to do this as well for some time.
> It's quite useful. I am out of office this week and away from work machine.
> I will take a look at your patches next week once I'm back at work. Thanks.

If Steven agrees this shouldn't live in ftrace directly and Joel
reviews these patches, I think it should be fine. I'm travelling, but
I can review it hopefully later this week.

-Kees

-- 
Kees Cook
Pixel Security
