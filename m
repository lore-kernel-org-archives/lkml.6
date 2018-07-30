Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0B3FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0BB20873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0BB20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeG3HHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 03:07:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33398 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbeG3HHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 03:07:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51E1F1684;
        Sun, 29 Jul 2018 22:33:53 -0700 (PDT)
Received: from mail-it0-f46.google.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30FA63FB21;
        Sun, 29 Jul 2018 22:33:53 -0700 (PDT)
Received: by mail-it0-f46.google.com with SMTP id g141-v6so15184368ita.4;
        Sun, 29 Jul 2018 22:33:53 -0700 (PDT)
X-Gm-Message-State: AOUpUlGb6yCLv7b1wjP7qFPWuCW/++xWGpEyoRX2NlhhVoxEF5YCIJ5w
        LO0otDABTkDToOVMifz/xA9l1Qj0r/4m3L9h+DA=
X-Google-Smtp-Source: AAOMgpdypxGjZVOJp40pbeZV3rvDX8DV+j0wQ01dbBZSGzgl5B0JECUE1VtXQ5sUtylVQfZQySKWWKX+GngmXNAtyZ4=
X-Received: by 2002:a24:9686:: with SMTP id z128-v6mr12220073itd.58.1532928832346;
 Sun, 29 Jul 2018 22:33:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:88b8:0:0:0:0:0 with HTTP; Sun, 29 Jul 2018 22:33:51
 -0700 (PDT)
In-Reply-To: <153270946725.48062.11195853363758024681@swboyd.mtv.corp.google.com>
References: <1532700112-11852-1-git-send-email-amit.kachhap@arm.com> <153270946725.48062.11195853363758024681@swboyd.mtv.corp.google.com>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Date:   Mon, 30 Jul 2018 11:03:51 +0530
X-Gmail-Original-Message-ID: <CADGdYn5T2-B2UE9DX3wFHdvqfF85n0NAbKDBf2KHOQreRi=H+g@mail.gmail.com>
Message-ID: <CADGdYn5T2-B2UE9DX3wFHdvqfF85n0NAbKDBf2KHOQreRi=H+g@mail.gmail.com>
Subject: Re: [PATCH] clk: scmi: Fix the rounding of clock rate
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     LAK <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 27, 2018 at 10:07 PM, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Amit Daniel Kachhap (2018-07-27 07:01:52)
>> This fix rounds the clock rate properly by using quotient and not
>> remainder in the calculation. This issue was found while testing HDMI
>> in the Juno platform.
>>
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
>
> Any Fixes: tag here?
Yes, This patch is tested with Linux v4.18-rc6 tag.
>
>> ---
>>  drivers/clk/clk-scmi.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
>> index bb2a6f2..a985bf5 100644
>> --- a/drivers/clk/clk-scmi.c
>> +++ b/drivers/clk/clk-scmi.c
>> @@ -60,9 +59,9 @@ static long scmi_clk_round_rate(struct clk_hw *hw, unsigned long rate,
>>
>>         ftmp = rate - fmin;
>>         ftmp += clk->info->range.step_size - 1; /* to round up */
>> -       step = do_div(ftmp, clk->info->range.step_size);
>> +       do_div(ftmp, clk->info->range.step_size);
>>
>> -       return step * clk->info->range.step_size + fmin;
>> +       return ftmp * clk->info->range.step_size + fmin;
>
> Good catch.
Thanks.
>
Regards,
Amit
