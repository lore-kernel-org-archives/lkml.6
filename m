Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E238C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADF725008
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQ03qZCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADF725008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755345AbeFXPgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:36:01 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:36640 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbeFXPf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:35:56 -0400
Received: by mail-wr0-f171.google.com with SMTP id f16-v6so11145545wrm.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 08:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PW+yxyBU5D0Iu40cV3hIgn5JkIkfLp+iVML6xXKQUJA=;
        b=KQ03qZCgHQKs22pRRiIC3ZKzdP//Fcsc5nCDQ8Nq0lW7b54Cqf+3Y+xgNrUNKjwJqp
         ik9FjzHEfAR5aEIxY7uo47SQqyzlnn99tayYvZZZVJtvzDsLHVunMG+1bQ/7w5BglmzH
         9LScfZpXuZ/42UCuif2fKey1/zQJdoYH4ehktt2wFPUnV5qXlbWU+jyxAmuKNloU5BsZ
         a1ViqdhfI5QXvb5JqDR4rq9m5tqJBBDhTSDwX+ajaOTbyGGB2SKKFGd1bRNT47cp+CQ3
         8ojtwkFujPr5M7NTZWoJ+LSDZ0/69HItLdZVQu26hMeGSxYlEP6TWd5Zv16GzTsXdc6v
         o1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PW+yxyBU5D0Iu40cV3hIgn5JkIkfLp+iVML6xXKQUJA=;
        b=p6Ag+s4Z671iMX5E/bj2TXYTPqUqjb9HopCx0ctY41XGAyfDmvagRzwaAZQyG3g0Jr
         hezSapy4SJhZWnK84LMqtdNJEglERmrOTrvzwVq5ILhc8vutTJ/8rb/6hqn2SG0F719+
         j/T+ty5ffyL0E21aSyRfcB1uZ5Bu6AwovNoCLSPzC28gYxrH6Px0l36jFwOs/Hfikowz
         poOvBMPGo6JgZVVN+HDwaOZ+z/SFCMgf8lT7E4Md7r2SR80DBXs8Joz/ygwHBiUbwFWR
         RbMDwEqLX9E05X87PPR4XE+CcQu+TAUaMuVpK2yHqZpcTsIpEDRxaCtzLVbCQJMiglB6
         Znnw==
X-Gm-Message-State: APt69E2puYCI7N+XyXT8p3Ige78QrLEN0zpyQQQKi/XSJMWE6T6IgRys
        DqLRkLI9E9hYpZz8Sb/CfS+DWQ==
X-Google-Smtp-Source: AAOMgpd8Bja5ilIAdgbxpAYQNkYCFltG1bJfZRbxVRfIQ49zluwAy733fz5Gg4gr89eAeUVHpEY4xw==
X-Received: by 2002:adf:f90d:: with SMTP id b13-v6mr7251554wrr.38.1529854555363;
        Sun, 24 Jun 2018 08:35:55 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id j10-v6sm1505813wro.53.2018.06.24.08.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 08:35:54 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org
Subject: staging: rtl8192u: v3 Coding style changes. Plus one change to use memset()
Date:   Sun, 24 Jun 2018 16:34:46 +0100
Message-Id: <20180624153454.27356-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple coding style changes to single file drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c

Given feedback on some of the comments, I truncated to the 80 character limit,
in code, (as opposed to function block comments). I have left a number of the
contentious comments as they are.

Another piece of feedback suggested using memset() instead of a loop to
initialise memory so I've added that change to the set.


