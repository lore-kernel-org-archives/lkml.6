Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A7BC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DC3215F9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEURkA+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DC3215F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbeHCB4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:56:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40376 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeHCB4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:56:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id e19-v6so1554530edq.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 17:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Hy/vhzZI7bytTDGjBV/F0HLbXdb+2DWQLpHM0L7++BI=;
        b=ZEURkA+6hMOY6CsflbVSGnsU7h1PVIPBkEOhRtlBWN39DMsoLGZlDrGNLB6a/oDTcb
         KyEUIc1mWhX3p9Z5sz6+7tsOZWj2kzFyi9sPRYOjPZivirtuzbD0I4B7xPJZXZKq7uvY
         zeDmzGWR42kCAUBemG06WOJmXh9RHnwk0bRTujEDFGkJgwAXYiEMZeHXg5bEGeQ1n/xk
         jdHiOgJtnnZqQiVcLY4+IbGJA/BhFkBl6lojU3nYmN5EDc4Dbg5Kwxx4nYwmF/xcGJc8
         0No6CyJHobh+bJujb/C1eQLxi9/NDFrG+z88BkP8bUj0Dx2pcQYOlA674rE3b7BZ2sUh
         OshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hy/vhzZI7bytTDGjBV/F0HLbXdb+2DWQLpHM0L7++BI=;
        b=P8+mdHetkWW9n7F1BXoHaNg8LTp2NBWo/5G3HQOM0yDavI02lo4DqI9+nAQwhJKgiI
         E/BlA57UcDB8UvUXPyB7p8CTjoX4Qsavby5diZm5tCW4EUZV406qnXStO8JYvRzFQjf+
         HzbtBaCKVdNFfsGh9oaP1Vpo5T9AijS0xskDjH4VR6hyAEfuEVsIVY+Ma34yguEYip8l
         Q8fOxTzOfPnwex6FUGFwQqo1zZtN4EKJ9N+SEddDdQJaq01tdYpIjT3dKLPiLiNMcFd0
         48A/8PdnlQMvFfH6PA8bEAizdxPcpN632lp7+d2PTK5ZoM+qRg2c6xaVIEjR1OcAT8tp
         WYkA==
X-Gm-Message-State: AOUpUlHMBSuNuED15Ahv8yaD1in9696cF094rGIDZhjpZtZomRfVGK+y
        rJlBxJ1myiD5X3pdtPXBIw+8rSFC
X-Google-Smtp-Source: AAOMgpefmEecCf+y6Ifd+WSxoXMTlAkuaU29BDdQ/Guh5rk5yhvheDjL3rsab7c35aRDGKdFLcUg5w==
X-Received: by 2002:a50:9fe9:: with SMTP id c96-v6mr5125113edf.17.1533254561847;
        Thu, 02 Aug 2018 17:02:41 -0700 (PDT)
Received: from localhost.localdomain ([109.78.209.16])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1310843edo.39.2018.08.02.17.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 17:02:41 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 00/18] staging:rtl8192u: Clean up ofr8192U_dm.h
Date:   Fri,  3 Aug 2018 01:01:53 +0100
Message-Id: <20180803000211.10589-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches is a clean up of the file:
drivers/staging/rtl8192u/r8192U_dm.h

Whilst I consider all the changes to be coding style changes some have
removed structure member variables which were not implementing any
logic, which required them to be a member of a structure. The first
patch removes member variables from two separate structures which
seem to have been intended to add functionality for debugging. Whether
that feature was forgotten about I'm not sure but as it serves no
purpose both member variables were removed.

I hope I've not missed something 

John Whitmore (18):
  staging:rtl8192u: Remove debug member from structures - Style
  staging:rtl8192u: Remove member variable rx_gain_range_max - Style
  staging:rtl8192u: Remove member initialgain_lowerbound_state - Style
  staging:rtl8192u: Rename enum constants - Style
  staging:rtl8192u: Remove unused extern DM_RxPathSelTable - Style
  staging:rtl8192u: Remove member variable Enable - Style
  staging:rtl8192u: Rename cck_Rx_path - Style
  staging:rtl8192u: Remove SS_TH_low - Style
  staging:rtl8192u: Remove member diff_TH - Style
  staging:rtl8192u: Rename member disabledRF - Style
  staging:rtl8192u: Remove member reserved - Style
  staging:rtl8192u: Refactor DCMD_TXCMD_T structure - Style
  staging:rtl8192u: Rename DM_DIG_MIN_Netcore - Style
  staging:rtl8192u: Rename RateAdaptiveTH_High - Style
  staging:rtl8192u: Rename constants RateAdaptiveTH_Low_* - Style
  staging:rtl8192u: Rename constants - Style
  staging:rtl8192u: Rename Register Constants - Style
  staging:rtl8192u: Clean up of spacing - Style

 drivers/staging/rtl8192u/r8192U_core.c |  14 +--
 drivers/staging/rtl8192u/r8192U_dm.c   |  97 +++++++---------
 drivers/staging/rtl8192u/r8192U_dm.h   | 151 +++++++++++--------------
 3 files changed, 115 insertions(+), 147 deletions(-)

-- 
2.18.0

