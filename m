Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CAFC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADDE208D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ADDE208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeH0PMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:12:55 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41611 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbeH0PMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:12:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id f38-v6so10178514edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 04:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p42iIwbTrGPV1JR8A37slGiCspSWLnuG5EvrzB1+OHU=;
        b=aLaDao71hB6FYohHPZc1KCuGGm51jPZ6i/d2pwEcsu8VCUXJsapfYfctifTGKOAd76
         fYmUJzE0V3PftjOKd9K328FXjWJQMsAljb2NERVmgrYmRgXMu9dwpnxHUGvf0GwyFZkl
         fhYPbzoOsCsS4sbNhBZj9Epl2EmLx8+F6CthtDm7lk599lcELQiX9qhzgNGnFZKN6aYc
         qNOK5wJfaeGGrxDnDk+ALjdQVKHXwQwr4BQpQ6Rt8z0jIznXHxRXWFKvcpaCiHRqRuTA
         9b3f13RhJNQEaD1CropSJQaDw/10eBt8NLEzNA4hW1akhShxx3ExYV9s+cb+6At/ZEOB
         B/1w==
X-Gm-Message-State: APzg51DC1OAfSuqGi5Gt6aE9um5ff3jgdE61cGWf8cBofAorsZDPUu/6
        0ExxrzDKighsFNWC5cs6BN8=
X-Google-Smtp-Source: ANB0Vdb+xhM1ZEfgBmnXBkQhjlEm3WnBtjEDd4mK7LV/prYXDFQUQPWSlF4l3/5siWgQYhK3nC8wiw==
X-Received: by 2002:a50:f297:: with SMTP id f23-v6mr16804558edm.40.1535369197863;
        Mon, 27 Aug 2018 04:26:37 -0700 (PDT)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id v1-v6sm6454416edf.3.2018.08.27.04.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 04:26:37 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH 2/3] mm, mmu_notifier: be explicit about range invalition non-blocking mode
Date:   Mon, 27 Aug 2018 13:26:22 +0200
Message-Id: <20180827112623.8992-3-mhocko@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827112623.8992-1-mhocko@kernel.org>
References: <20180827112623.8992-1-mhocko@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

If invalidate_range_start is called for !blocking mode then all
callbacks have to guarantee they will no block/sleep. The same obviously
applies to invalidate_range_end because this operation pairs with the
former and they are called from the same context. Make sure this is
appropriately documented.

Cc: Jerome Glisse <jglisse@redhat.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/mmu_notifier.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 133ba78820ee..698e371aafe3 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -153,7 +153,9 @@ struct mmu_notifier_ops {
 	 *
 	 * If blockable argument is set to false then the callback cannot
 	 * sleep and has to return with -EAGAIN. 0 should be returned
-	 * otherwise.
+	 * otherwise. Please note that if invalidate_range_start approves
+	 * a non-blocking behavior then the same applies to
+	 * invalidate_range_end.
 	 *
 	 */
 	int (*invalidate_range_start)(struct mmu_notifier *mn,
-- 
2.18.0

