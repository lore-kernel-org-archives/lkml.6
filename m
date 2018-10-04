Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35233C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB7821470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="USgm8LgZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CUoSZaEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB7821470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeJDOiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:38:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40378 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbeJDOiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:38:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 428BA60C85; Thu,  4 Oct 2018 07:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538639187;
        bh=hPrj+O7jw+NB3lOsFapTmxWa6itS6tw33wUTru/drLQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=USgm8LgZey2bta0sR3HnyRJEjxowN3DnSa807nXIEBwHzuAotIdnwn6TOfX8BWQp5
         EMh+NwA8/bYE0wkMgYR+YyVz7awYsKgtXKYvKXGPCTZy05s1nY8yW1QIlXvwfa6x0X
         2Y7M6+kF3fB7Q5AIDS1m3JQiTi6cg4GC6jpTHoEg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D6CFB60227;
        Thu,  4 Oct 2018 07:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538639186;
        bh=hPrj+O7jw+NB3lOsFapTmxWa6itS6tw33wUTru/drLQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CUoSZaExpx8vZZNal72Mm0+WNBhPgwiPKFcGLAAfEh6I0UCeDWnH4K7Mvdt5L+Atw
         Hzb9u0vk2I2eBNFXdDWdMPQkLRBvom82cDiK4q73vsZ+xEgfUI+8uG8XJDa1Gm4nSj
         zNJu5+8N3GQ2ycD8w1LH6IjwLivc7khyhdHsQ4dA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 04 Oct 2018 13:16:26 +0530
From:   alokc@codeaurora.org
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-i2c-owner@vger.kernel.org
Subject: Re: [PATCH v3 3/3] i2c: i2c-qcom-geni: Simplify irq handler
In-Reply-To: <CAD=FV=WWCrY3Kxa1qXXvYd4FM_8cAtWnKMm4mYU8zxEfQmHmVw@mail.gmail.com>
References: <20180924235235.182649-1-swboyd@chromium.org>
 <20180924235235.182649-3-swboyd@chromium.org>
 <CAD=FV=WWCrY3Kxa1qXXvYd4FM_8cAtWnKMm4mYU8zxEfQmHmVw@mail.gmail.com>
Message-ID: <63135265545c5da50522e346e2a2d311@codeaurora.org>
X-Sender: alokc@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-26 03:19, Doug Anderson wrote:
> Hi,
> 
> On Mon, Sep 24, 2018 at 4:52 PM Stephen Boyd <swboyd@chromium.org> 
> wrote:
>> 
>> We don't need to use goto here, we can just collapse the if statement
>> and goto chain into multiple branches and then combine some duplicate
>> completion calls into one big if statement. Let's do it to clean up 
>> code
>> some more.
>> 
>> Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
>> Cc: Sagar Dharia <sdharia@codeaurora.org>
>> Cc: Girish Mahadevan <girishm@codeaurora.org>
>> Cc: Doug Anderson <dianders@chromium.org>
>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>> ---
>>  drivers/i2c/busses/i2c-qcom-geni.c | 70 
>> +++++++++++++-----------------
>>  1 file changed, 29 insertions(+), 41 deletions(-)
> 
> It doesn't gleam as powerfully the cleanups in patch 2/3 but this does
> have a few nice readability improvements.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

agree.

Reviewed-by: Alok Chauhan <alokc@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,a Linux Foundation Collaborative Project
