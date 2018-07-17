Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910A6ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41301206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nfg+UUNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41301206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbeGQVEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:04:09 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43959 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbeGQVEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:04:09 -0400
Received: by mail-pf0-f196.google.com with SMTP id j26-v6so1047300pfi.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zvtg/FXFnUvoC+vpDxQVg2kOnsVOVh6I6ylRjZlGwao=;
        b=Nfg+UUNSK1Ghg5gsaZ+MtCct+na6Ty8lfjAC+4qsXrzbqO4gg3D6RbfTo8rmldjy4Y
         j2Wl7mSWvwtXyyMzMOfnUiJROeCPh8bOTIypUJ8tGGDBBnkaz/AutPtsB57OtFas8oZW
         zV7FNEzB8iKWyeG3eKTCaqgD42Zz3TOueOK48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zvtg/FXFnUvoC+vpDxQVg2kOnsVOVh6I6ylRjZlGwao=;
        b=ASiu6qnO86aNF/MCxW7++XQzwrsjuoXh7eCXX36Q1wb4QkgCVUQXHfO3psoMm+GA/U
         tJXEsKz6zTofRwekgmpGQFOhpV5QL5cdZ2ti9phLVCKtvZNaCOTVy0jQNd/tr4Or0KZ5
         pE9+PJ4a+RQFjqEAGo+NiejYrb4aoKulYINRt/mFBi2IIMUJ38eyt8I2ZFvuL9g4BVV1
         kI+qs+OrYLxor+A7pmIlQK0x3cA2BKi7ZWjyUqIZW3Ay0ukyB3nSp4iOVb4RmRCXZBqB
         o5toJb+wLfievEZoHm3Kg995JpGCa7luXLtfdgA13hTV8MaK0TV9sW388NIoTj9ElgC0
         mLvg==
X-Gm-Message-State: AOUpUlFIR940SXnkeujxHODHcB5tD5vA8Jo1yLRnKvqgnNBSfMEt6ici
        tuvIhqdNe/iD+wMjHpb5v9ABVg==
X-Google-Smtp-Source: AAOMgpcBbDVMIfuEgvu5fnqxVG5FYElGTD8MsiXq7iXQsLQbYPBYgUI9GN1VRo7aWoHj9NG0nEJ+xg==
X-Received: by 2002:a63:951e:: with SMTP id p30-v6mr2995421pgd.318.1531859390410;
        Tue, 17 Jul 2018 13:29:50 -0700 (PDT)
Received: from swboyd.mtv.corp.google.com ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id a20-v6sm2563426pfi.124.2018.07.17.13.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 13:29:49 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH 0/2] qcom: remove memcpy()ing from cmd-db driver
Date:   Tue, 17 Jul 2018 13:29:45 -0700
Message-Id: <20180717202947.197922-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some changes to the cmd-db code to not do any more copying
of memory. Instead, we'll just hand out pointers to things
inside cmd-db. Merging the second patch will cause problems
for any in-flight users of the cmd-db APIs that are modified
and/or removed. Probably that patch can wait until later, or 
I can provide the fixes for any patches in-flight that get
wrecked when it's applied.

Cc: Mahesh Sivasubramanian <msivasub@codeaurora.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Evan Green <evgreen@chromium.org>

Stephen Boyd (2):
  soc: qcom: cmd-db: Remove memcpy()ing from cmd_db_get_header()
  soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()

 drivers/soc/qcom/cmd-db.c | 93 ++++++++++++---------------------------
 include/soc/qcom/cmd-db.h | 12 ++---
 2 files changed, 32 insertions(+), 73 deletions(-)

-- 
Sent by a computer through tubes

