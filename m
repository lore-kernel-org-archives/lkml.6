Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4665EC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125512082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sweptlaser-com.20150623.gappssmtp.com header.i=@sweptlaser-com.20150623.gappssmtp.com header.b="RCSnBHse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfBDUTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:19:30 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36017 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbfBDUT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:19:29 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so2962152itj.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 12:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sweptlaser-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=t0PM0LA03GPZtzLwsNF/LkFyfHcnbucWv2OXGS0MmVA=;
        b=RCSnBHseI1V85Qv59/aWG+h91o1HFeTrd9Y9/HfrVoTQCIx56KbQ8cpDpffsQ05j5a
         MzxpuUMnoJpqYPMCzKRNpPmjIwIzafri5utjvDxKivc7ZW3tA9AM0ESe77QRqhVXQ1+Y
         aIQiW20QPDW3/q47P/mlbfOig/He9GaEC+KzCAVI6jbAJYxslsb8K17Q/9fuNSWO65KP
         fM7SJG4A9rZQIO3l7iISIvfS4DDuVIGwrccy3kf0pEgm4+EQu2VYapYJ9TSRvZpFBz4o
         EX4TA496/EAQh5O28eHyJqpzLhpcdVfFoYkwUPZ5Owr4szmKGW7VMKouJK74yyuIEvDV
         oNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=t0PM0LA03GPZtzLwsNF/LkFyfHcnbucWv2OXGS0MmVA=;
        b=flWSI750ENFY57KzijJwCcPA+7jb5kUI38bWs5UhHFUtG77NbXnGRyp4KNMMMPD5RN
         jAfZPiFL/kDUrGZ1ZuzcEzIOwJ9Gq699qL7AaPYxcNyRmg6AFSypLVc7vooj04aes2YC
         j+/8vPrLbc96JJLYDPh6v+FNniLaQrpszwOKrLKlyqQWrxJdQJYwfcPpus8OyAYg5cCs
         U/hNSvslY8/KzLKHprAMEgYr8RO9LLc8hIHNfWm4wSnVqkVPc7bsR5ZgVeH1qjr3vlyW
         nIK4qUKX+ScRiV/Xog0GFVkq/MW2Dlr99JQhE9BhuXygacHPsYuDiAFyboB1BzcN3dQi
         rsEg==
X-Gm-Message-State: AHQUAua4YOe4yQGEUM5C5OjGryYy2AHKLehwz7xPWH2jOE28NSZVgsGU
        OHG+SKix3ORWCl7w+0ratyWabw==
X-Google-Smtp-Source: AHgI3IYlfALHXe10y0WK8D+b8jqVTn38tHYRaP1C9OWEhGkAOOd5n52LOMYgXESVEQvdMfsvQH98Hg==
X-Received: by 2002:a24:d745:: with SMTP id y66mr643051itg.18.1549311568912;
        Mon, 04 Feb 2019 12:19:28 -0800 (PST)
Received: from yngvi.hq.sweptlaser.com ([63.147.146.226])
        by smtp.googlemail.com with ESMTPSA id x79sm470003ita.34.2019.02.04.12.19.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 12:19:28 -0800 (PST)
From:   Jeremy Gebben <jgebben@sweptlaser.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] hwmon: (lm85) add LM96000 high freqency pwm support
Date:   Mon,  4 Feb 2019 13:19:02 -0700
Message-Id: <20190204201906.8859-1-jgebben@sweptlaser.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set adds support for the PWM frequencies from 22.5 to 30 kHz
available on the LM96000.

It looks like this chip has been supported for a long time, but wasn't
mentioned in the docs (which I have updated).

I stumbled on to a 10 year old thread discussing a patch which looks
like an early attempt to add support for this chip, which may be of
interest:
https://lm-sensors.lm-sensors.narkive.com/1SIwaMDT/patch-hwmon-lm96000-support

Thanks for reviewing,

Jeremy

Changes since v1:
 - replace freq_map_mask with freq_map_size

Changes since v2:
 - add lm96000 type instead of continuing to use lm85

Jeremy Gebben (4):
  hwmon: (lm85) remove freq_map size hardcodes
  dt-bindings: Add LM96000 as a trivial device
  hwmon: (lm85) support the LM96000
  hwmon: (lm85) add support for LM96000 high frequencies

 .../devicetree/bindings/trivial-devices.yaml  |  2 +
 Documentation/hwmon/lm85                      |  9 +++-
 drivers/hwmon/lm85.c                          | 43 +++++++++++++------
 3 files changed, 41 insertions(+), 13 deletions(-)

-- 
2.17.1

