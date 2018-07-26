Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EA8C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669D920671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPUy3bvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669D920671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbeGZUnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:43:05 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45249 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbeGZUnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:43:05 -0400
Received: by mail-ed1-f66.google.com with SMTP id s16-v6so2242871edq.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Blv7OhELYJkulCVQLiUaiioCqq2vBeeJks8GG2nsQbU=;
        b=YPUy3bvl4QA7Q3FezBl9x8neEmv7954m85nbGCK5LKYhiEO2Li+RYhIRlO198vcS2t
         NvHmJFPy1TBfIVtzeXhGEzZ+Nw+oI3U3f7GzTk7I6wQSc3JiN6RagaRg8Vrz5XWb0tpj
         DzEirH2RVe9/nK5Yvbs7rF4GA+iuPWALvJFRIe3TOkIjfJNEqUMKwK1FhT78cXBgsmtQ
         lZ69V3VRTTMcdv+Y9T79N1HDrnDdXN+QD0lpdg3tZn4nS0Y72CXP0EJWlQ7OLT2Md2pw
         fZ4SIByWh3WppeNIwXuYErkoK+HnB6xC+9dkX8t5ZV7yQzoeE74U62aqFxRyHQf9wqqs
         NzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Blv7OhELYJkulCVQLiUaiioCqq2vBeeJks8GG2nsQbU=;
        b=d+BUSj/mOXcTNpVu4CY0Qrljl8nOJrnLNnP0CkLkulVJe6nsCgiVjNgZcdJJuSCPmG
         AEQlkz+eTeG162z4WjJtxW2c4255XDskcIJRjm3Aux2urY6JzXxO8oxQ0Hhb6mzSU4pf
         V+WfHnh9iQcD2eh5x7zH9/FAHxWIqxb9/FBC2QIAEimBncwceLYYXjxs0hEPOR2uaexY
         cfQ0K3UM6b9smiscxtg1gwciqwH27VYbtdd8EP/tpsbS8Nf+Ls8QQMuQgA1JxN2xm66g
         DAW+44XbBpFX/b/7dY7zAibnwxu2RXfqE1Ha2+wQnrZQfJFW+SMHV0u/54zfkOYyDz8w
         e7qw==
X-Gm-Message-State: AOUpUlFsyuwIZMkAeY6/EC8Hr8CUduuJLBnOJ9QbflfdjpKaXCRAqWc3
        x7MyQy3AJ1dk+BT99U5qWbLzP4PX
X-Google-Smtp-Source: AAOMgpfgXMqdthsi3joBa0smrUzQWh/JVOjZ0q9Hf61rlxEVt2mExDGBCe+0NxqnO/vaAsiUEl9R0A==
X-Received: by 2002:a50:d2d7:: with SMTP id q23-v6mr4126885edg.183.1532633089355;
        Thu, 26 Jul 2018 12:24:49 -0700 (PDT)
Received: from localhost.localdomain ([109.76.149.40])
        by smtp.gmail.com with ESMTPSA id m20-v6sm1100853eds.5.2018.07.26.12.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 12:24:48 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 00/16] staging:rtl8192u: Proxy Structures?
Date:   Thu, 26 Jul 2018 20:24:10 +0100
Message-Id: <20180726192426.31913-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches contains coding style changes.

There is one type of change, proxy structures, which whilst not flagged
by checkpatch, as an issue, I have changed. I can't see the purpose of
defining a structure, in this case arrays, and then using a #define to
name the structure something else.

This may well be a pattern which I'm not familiar with, in which case
the patches can be rejected, and I'll have learned something, but I thought
I'd better explicitly mention it, as I'm assuming that there is not actual
point to the practice.

Apart from that all the rest are simple coding style changes.

John Whitmore (16):
  staging:rtl8192u: Rename SwChnlCmd - Style
  staging:rtl8192u: Rename CmdID - Style
  staging:rtl8192u: Rename Para1 > para_1 - Style
  staging:rtl8192u: Rename Para2 to para_2 - style
  staging:rtl8192u: Rename msDelay to ms_delay - Style
  staging:rtl8192u: Remove proxy struct rtl819XMACPHY_Array_PG - Style
  staging:rtl8192u: Remove proxy struct rtl819XPHY_REG_1T2RArray - Style
  staging:rtl8192u: Remove proxy array rtl819XAGCTAB_Array - Style
  staging:rtl8192u: Remove proxy rtl819XRadioA_Array - Style
  staging:rtl8192u: Remove proxy rtl819XRadioB_Array - Style
  staging:rtl8192u: Remove proxy rtl819XRadioC_Array - Style
  staging:rtl8192u: Remove proxy rtl819XRadioD_Array - Style
  staging:rtl8192u: Rename HW90_BLOCK_E - Style
  staging:rtl8192u: Rename RF90_RADIO_PATH_E - Style
  staging:rtl8192u: Remove repeated definitions - Style
  staging:rtl8192u: Rename eRFPath - Style

 drivers/staging/rtl8192u/r8190_rtl8256.c |  42 ++---
 drivers/staging/rtl8192u/r8192U_core.c   |   4 +-
 drivers/staging/rtl8192u/r819xU_phy.c    | 230 +++++++++++------------
 drivers/staging/rtl8192u/r819xU_phy.h    |  42 ++---
 4 files changed, 147 insertions(+), 171 deletions(-)

-- 
2.18.0

