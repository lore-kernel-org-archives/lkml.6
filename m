Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B922C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DB0205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ieRmlfdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99DB0205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeIABBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:01:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42804 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeIABBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:01:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id v17-v6so12338608wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 13:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xA7an3MtvPDHqyv/GmK4u4YNwImf+ORfvSp8ZP9m9CU=;
        b=ieRmlfdrMXXHV9W4zShUk7QQaz6/vDGYOJkJKSEAfqiuLaM8yFUeZGTMS2wCUED/Oe
         MheQ6RWmWqAQCnRe2HKs8Rq2uBBIbeV6eXzHd8RSaHrGFM+qFdB7LBfp/CNS4DZrRVav
         rkcrBn+0YY+sDloPCHPAtqVgA9K1ZnOzLeDWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xA7an3MtvPDHqyv/GmK4u4YNwImf+ORfvSp8ZP9m9CU=;
        b=pVrjHEbuHIWuwoB3LYnxV+sL7u34LufRy7I0CfnjDl1O/SWwbKN+xTjbtbrkUE/T30
         /b1hrcV5Yw6MzJ9cKtE4MHqSjahTajSu6SLT+KxejuDJU/H1cQO+Va5bbd7MCLloYzeZ
         Zr1LXkUJiRsz5/yE47s37u91yq3jv7SOo6pLKmE89jhfRwUK3RymEU37M/3VjqZ6n9PK
         tIfzIaVYWlbT1XhJd7XFQT2CX8FNBzdlw+tiWbpuJmxigMU5HZA/UYlJcEpvMUKEMMll
         e1Atoa5dETQb3jEKTOFWcy8UwLluUGoxpvB3m5fuRSxwquiwSOdI41gu3QI61v0adOur
         1WJg==
X-Gm-Message-State: APzg51AgWZqsYsZHV67+JpDDaDLyhovigHAQBzLnBafb4qipDNRCnrVV
        YZZ1MDqtdo8sFFpsq4kRHv6pjDf7p7k=
X-Google-Smtp-Source: ANB0VdZmJ1LmMCj6aL1/6T+KPd+A3P3zZtSVvHhSjF523+H4PS2BxR4i13eGqmSJhNMnoMIiQhMvaw==
X-Received: by 2002:a5d:608b:: with SMTP id w11-v6mr2037619wrt.193.1535748749046;
        Fri, 31 Aug 2018 13:52:29 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id u4-v6sm7659356wro.47.2018.08.31.13.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 13:52:28 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH 0/5] kdb: Cleanup code to read user input and handle escape sequences
Date:   Fri, 31 Aug 2018 21:51:37 +0100
Message-Id: <20180831205142.23609-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I spend a little time earlier this month looking at kdb_read() and ended
up doing a little light refactoring a bit to make easier to read.

Most of the patches are simple tidy ups although patches 4 and 5
introduce new behaviours. Patch 4 is probably not controversial
but perhaps patch 5 is ;-).

Tested as shown here:
https://github.com/daniel-thompson/kgdbtest/commit/c65e28d99357c2df6dac2cebe195574e634d04dc

Daniel Thompson (5):
  kdb: Tidy up code to handle escape sequences
  kdb: Simplify code to fetch characters from console
  kdb: Remove special case logic from kdb_read()
  kdb: Improve handling of characters from different input sources
  kdb: Tweak escape handling for vi users

 kernel/debug/kdb/kdb_io.c | 218 +++++++++++++++++---------------------
 1 file changed, 99 insertions(+), 119 deletions(-)

--
2.17.1

