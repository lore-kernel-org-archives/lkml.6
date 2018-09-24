Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65CDC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 05:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F06A21480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 05:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IzYGAyaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F06A21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeIXLti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 07:49:38 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:34880 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIXLti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 07:49:38 -0400
Received: by mail-wr1-f46.google.com with SMTP id o16so5011822wrx.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 22:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=6sZrjJHNdJSkaxnnqwVLkeYakGjMOQyqs0pZhiRL3iI=;
        b=IzYGAyaEiOeI45wVGvkGIueV82CMnHts8V4ngvugAJB+hXMO0Ded6zPnBbxFAotF5N
         hsz6i9rQvtb8PFTz7/h1zas4y3H1hD0urJki5nbynjlmzGjMsbYvAFvEfLuoqMT0LRI2
         F0j6wKeLwvKqkAy8rrVX0b+Pao4+oi0b8Jn4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6sZrjJHNdJSkaxnnqwVLkeYakGjMOQyqs0pZhiRL3iI=;
        b=cBGgKHXoitgSJhFLRsVdmxHHVbMLbP094Wubz+HJza78AAvWt6gBaZL+R+pkc67yaf
         1R9yOJDhkV/97c38A4/s4szEJQEMYTbU9FusArBJNVuQount+4TIcFYxD3Vji1K/JfxS
         y8AJrltDYMDYfWWExUGWsesQ8+H1wGSGXkhIg3zUxf/JGK129U7x6q1AHPS82p0EyPuQ
         M6cndM6h0ScJ3GChhsnIwqqMl0aq3rAM7gpk/HJPupCG0rCdCfk+J4h5vh7whvCeBc5X
         f8Wq0711QogP+Ixcj3rqkZ9fk3DCSlVfUh0KLF5m+Vqb1sxtLe6uxaQrFtKEziIB9Err
         f36Q==
X-Gm-Message-State: ABuFfogAf2L7q4nNErVWLeub30oPu0JimmElKrB7d4vxDbMRZlPvKqGt
        ja4cifHBYWqNDTFpvZ6r5cEppA==
X-Google-Smtp-Source: ACcGV63deirmRxSLFWdIsVXJwEvUz5YZiLRXGuc1ZJT0wKaGwmA2Y2uqfjZKz2Fhb5sWRQl6rZuHjQ==
X-Received: by 2002:adf:b34e:: with SMTP id k14-v6mr6854516wrd.207.1537768152009;
        Sun, 23 Sep 2018 22:49:12 -0700 (PDT)
Received: from [192.168.0.41] (89.154.136.77.rev.sfr.net. [77.136.154.89])
        by smtp.googlemail.com with ESMTPSA id k63-v6sm31963193wmd.46.2018.09.23.22.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 22:49:11 -0700 (PDT)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Tao Ren <taoren@fb.com>, Keerthy <j-keerthy@ti.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] clocksource fixes for 4.19-rc
Message-ID: <f2ad506a-e537-97cf-465a-593361116b10@linaro.org>
Date:   Mon, 24 Sep 2018 07:49:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas, Ingo,

This pull request for clockevents / clocksource contains two fixes and
is based on tip/timers/urgent:

 - Add the CLOCK_SOURCE_SUSPEND_NONSTOP for non-am43 SoCs (Keerthy)

 - Fix set_next_event handler for the fttmr010 (Tao Ren)


Thanks !

  -- Daniel


The following changes since commit e2c631ba75a7e727e8db0a9d30a06bfd434adb3a:

  clocksource: Revert "Remove kthread" (2018-09-06 23:38:35 +0200)

are available in the git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git
clockevents/4.19-fixes

for you to fetch changes up to 4451d3f59f2a6f95e5d205c2d04ea072955d080d:

  clocksource/drivers/fttmr010: Fix set_next_event handler (2018-09-24
06:13:31 +0200)

----------------------------------------------------------------
Keerthy (1):
      clocksource/drivers/ti-32k: Add CLOCK_SOURCE_SUSPEND_NONSTOP flag
for non-am43 SoCs

Tao Ren (1):
      clocksource/drivers/fttmr010: Fix set_next_event handler

 drivers/clocksource/timer-fttmr010.c | 18 +++++++++++-------
 drivers/clocksource/timer-ti-32k.c   |  3 +++
 2 files changed, 14 insertions(+), 7 deletions(-)




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

