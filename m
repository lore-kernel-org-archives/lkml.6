Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C141C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A4B20823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="GNVyQ8Gz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A4B20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbeJ3OIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 10:08:04 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35881 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeJ3OIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 10:08:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id y11-v6so4933520plt.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 22:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCjkjiTRGgZL2A0FAx+5895V+sW9tiOmXxjM8S1+Okk=;
        b=GNVyQ8GzCCVBM1NJCSEfq4Bm326e+VrzHWmgMhoAJezYXjDP8IUpn54S3Sb+zJhluJ
         MdQxMQmVSSn+awqE+9t+lGJKkXioUY7Spu+NGWaqFG+3qmue9ISpd7Tjrhcd5qqoAM2l
         yQm8BTLKG9NQ5NRC+meC6wARIB1NwrCvvfrkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCjkjiTRGgZL2A0FAx+5895V+sW9tiOmXxjM8S1+Okk=;
        b=OVL8cDG1N2ZvR0v1EuAZvbTLaSD+hTny6OeMtzDmFlx93CVotNMoKDZSfeIx4Hl2R/
         2h4anQoKCHAxZKwDPkV+p9Nb5hhDk4fqv4+aHvHt4owNhsFyvSIYO8k8V+2yLQyfl8PO
         dzAwEkEq/2A1u16HCfyoOR3OPL2JwaeLF2B8SttLLfFrniSoQjDcA774Op3zZjUH6glx
         8SKWBhSYsN3Yb+eXh9mAMm5qFmq7g8Qx4MmI5sNXjw6nKbke9VXB+rYBWPBvhDIVZohX
         mxba63oCYRke7VGNZuGLSy9RRNXaJprmHymsQpS9jfiVsNHIcCSP85y2gI1ew5HHi+S2
         AeaQ==
X-Gm-Message-State: AGRZ1gLGnMnoFv/ByTuCWMeLpNnqHZSPPv4RsurS8D0J+NF1KE3fLrv9
        NFseEYLvqCciR73Yb/86M1OHkO/Aw6g=
X-Google-Smtp-Source: AJdET5cWH6adaZ7h00vBqggqtZi5Jsrk89KgOWTNBib8G9swlcmGiAVqqNPYH5mdCIDHyePBDL0lMA==
X-Received: by 2002:a17:902:b486:: with SMTP id y6-v6mr8530983plr.263.1540876566028;
        Mon, 29 Oct 2018 22:16:06 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id n64-v6sm28398742pfi.185.2018.10.29.22.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 22:16:04 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH] doc: correct parameter in stallwarn
Date:   Mon, 29 Oct 2018 22:15:59 -0700
Message-Id: <20181030051559.256849-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stallwarn document incorrectly mentions 'fps=' instead of 'fqs='.
Correct that.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/RCU/stallwarn.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/stallwarn.txt b/Documentation/RCU/stallwarn.txt
index b01bcafc64aa..073dbc12d1ea 100644
--- a/Documentation/RCU/stallwarn.txt
+++ b/Documentation/RCU/stallwarn.txt
@@ -205,7 +205,7 @@ handlers are no longer able to execute on this CPU.  This can happen if
 the stalled CPU is spinning with interrupts are disabled, or, in -rt
 kernels, if a high-priority process is starving RCU's softirq handler.
 
-The "fps=" shows the number of force-quiescent-state idle/offline
+The "fqs=" shows the number of force-quiescent-state idle/offline
 detection passes that the grace-period kthread has made across this
 CPU since the last time that this CPU noted the beginning of a grace
 period.
-- 
2.19.1.568.g152ad8e336-goog

