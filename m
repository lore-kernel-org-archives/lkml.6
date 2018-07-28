Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22343C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B560C20842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkaQ7swv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B560C20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbeG2AbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:31:15 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38574 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbeG2AbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:31:15 -0400
Received: by mail-wm0-f44.google.com with SMTP id t25-v6so9477106wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 16:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=79UtRc+M1bf3ti2KNhtYK5LKM+IjJn0q8i4f+TkHPCM=;
        b=rkaQ7swvjt1V3biGdNyVoFxMV+rSlLcqKdtbucJ338S9C129RIGJNJFxioAqtYUZxy
         vWLTa2G2xmZeNy997qDCphaaJyqxK4RyKmtETFloeHNVC4BEm+cg5qksx3B7KoGezfmz
         nUZ+0GoO5MR1cKVU1HJYHM//bzZeTYPPO7BhO7jHYwSC2gT26DQR3zzt6tQHPJw3KQEw
         An6OqkM6YJQyfzAblNlDSt8wvI57XMBcSYmqLJlw6bxj0HWnTt+MwrTEo3Rjn/s9xxVq
         lQ8lJShX6r8Lp0QQgf54PtHhwWz1VR14D95OyXMLesaKuzjFmGB2NqOcx5wzP42xrZ/T
         zLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=79UtRc+M1bf3ti2KNhtYK5LKM+IjJn0q8i4f+TkHPCM=;
        b=ps22FZeCs+aoKQ1z+f6MCVMKf/AFcWR8i9eO2szg4nGuFoOXR9oj7mD/Mj/l5GFJ4c
         AGxJHvwUQJvnMysq8FEyUdOa/pFGzlpe0V12C47TEm+7FuCkURrska/pMSaXTXbKSvuB
         hYEUEWLSmrK1gYrLDQOEw7giEXPQL/wwnRQ3/AEmxVTfU60vrsGWlkLRsG4Ho0oAi3FV
         AgXnxT9fBsJC/sk8YWNVoy3RI9ApEBkG15c/NRxC5J4VchOQnsQOmzi9AwzviexiPNkC
         6BaRLwCADA9QTtsfm59IjwVX9knLOmdM3WnmMazdUaSK+boKfYOEJurmhTYsJ/kkvmT0
         SGJw==
X-Gm-Message-State: AOUpUlEsYToL/MB3Vfs7TB2//3KQM+u9eoG9wAhBhzwvMc+xJLqih63v
        RW3TzhUPbV87s2kGCtIZn9HWNr+e
X-Google-Smtp-Source: AAOMgpeI2e7lvgfb/7E1wiQLwKmpn8ZKKD8fva46Dwlb/d9A6lIz8ZNm7QyOq5/LrFGDPqmdzoP9FQ==
X-Received: by 2002:a1c:13ca:: with SMTP id 193-v6mr9176140wmt.127.1532818985764;
        Sat, 28 Jul 2018 16:03:05 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id m207-v6sm11490569wma.31.2018.07.28.16.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:03:04 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 00/08] staging:rtl8192u: cleanup of rtl819x_Qos.h - Style
Date:   Sun, 29 Jul 2018 00:02:52 +0100
Message-Id: <20180728230300.19732-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are a few coding style changes to the file
drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
I had more patches in the list but had to dump some of the later
patches as I made a mistake. Thought I'd send these 8.

John Whitmore (8):
  staging:rtl8192u: Add spaces around operators - Style
  staging:rtl8192u: Rename ACI_AIFSN - Style
  staging:rtl8192u: Rename member variables - Style
  staging:rtl8192u: Remove unused  union AC_PARAM - Style
  staging:rtl8192u: Remove unused union ECW -Style
  staging:rtl8192u: Rename enum DIRECTION_VALUE - Style
  staging:rtl8192u: Rename union QOS_TSINFO - Style
  staging:rtl8192u: Remove unused constants - Style

