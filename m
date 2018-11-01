Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3D8C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB7620840
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kbs9NDsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB7620840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeKBI5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:57:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40647 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbeKBI5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:57:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id g21-v6so108783pfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 16:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=b77sjwg41+2yfyhX+VjCA92/ztAO9N2SzOVjAcFtKpc=;
        b=kbs9NDsfzPnXCuCvOWLCQBdl6udOt3aTptRhB631+mqHMj6XnHs7+0llnExqO5FUj6
         UY1KclvlhSba9IlRnlTSBPLNPjnm1MFJgzS3RvpjXVyn/aOgMXIrfFU+XmTn3AYCOUzA
         Rcl4xFBXC2H9Dxw8tSrZt9RCXmXFK4xAUM10Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b77sjwg41+2yfyhX+VjCA92/ztAO9N2SzOVjAcFtKpc=;
        b=Bb4KDu7Ko8ccdAXYydKQAEYA3DJLFgNQbiBxkeI8FIshNmSbH8DUJlZZ5MOVMxyhvx
         DlJCOhX1HNjWcg38vPjSAFoda9GL+vOO+Cgjq9iu7IpbxFW4N0pwhMLAmPNy6q1xxnCH
         dDqHoPie3pRIt3IBWMY4t3H5kjaWIjDKZmA3l+g3V85s2CWEbLuo1BrgTeb/+Gp9MPdl
         lVVKT4rREiJF7o5kRrYwjy8pfl4ywOVU7D6MFcNyixxXSWPYruxi3BhjPSdmDePlgLBY
         J1013L7CTyaSXyibG0x3BqqHl6khcVsm+A2EVFx+7pxW+BqIXtvbg3uATiCCn2Bspx/T
         DRxg==
X-Gm-Message-State: AGRZ1gIwvqUUSCDJiQEXLcy0Ii1sPaxfdg3yzyzNw9FFhmqztMzjV8NC
        tnx4T2p98VmVSJalZMlUVLhTdw==
X-Google-Smtp-Source: AJdET5ddd9+KGH5nRbHUsaBWSikdlC1cLo4YWIb+7Ntnfz4uCqE2iZDdbl82QoQyJhK0KZOX5Pg+Ig==
X-Received: by 2002:a63:fa02:: with SMTP id y2mr8940934pgh.177.1541116327262;
        Thu, 01 Nov 2018 16:52:07 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id g7-v6sm16710274pfo.139.2018.11.01.16.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 16:52:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 0/8] pstore improvements (pstore-next)
Date:   Thu,  1 Nov 2018 16:51:52 -0700
Message-Id: <20181101235200.28584-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a posting of several patches I've been working on to improve
pstore. Most of it is better comments, output, and naming, but one
bug fix stands out to fix head-truncationg of compressed records.
Details in the individual patches. Review appreciated! :)

-Kees

Kees Cook (8):
  pstore/ram: Standardize module name in ramoops
  pstore: Do not use crash buffer for decompression
  pstore/ram: Report backend assignments with finer granularity
  pstore/ram: Add kern-doc for struct persistent_ram_zone
  pstore: Improve and update some comments and status output
  pstore: Replace open-coded << with BIT()
  pstore: Remove needless lock during console writes
  pstore/ram: Correctly calculate usable PRZ bytes

 fs/pstore/platform.c       | 92 ++++++++++++++------------------------
 fs/pstore/ram.c            | 19 ++++----
 fs/pstore/ram_core.c       | 25 +++++++++--
 include/linux/pstore.h     | 15 ++++---
 include/linux/pstore_ram.h | 46 +++++++++++++++++--
 5 files changed, 116 insertions(+), 81 deletions(-)

-- 
2.17.1

