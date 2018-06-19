Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807DBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1BA20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ce5/RJdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1BA20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966670AbeFSPMV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:12:21 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45353 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966646AbeFSPMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:12:18 -0400
Received: by mail-wr0-f196.google.com with SMTP id o12-v6so10829wrm.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W6uYmgHxTWzfDftIQnpPK6qurtIUOyuIABrSN4ITJSQ=;
        b=ce5/RJdR3pNVxMlHnERNXWfif1AYgYKckpJtyvmy0LtmaouRGnMtjAeuCHBpiykJBm
         /g/eo/yprnu+rFq9aqVrnoHJuiideiPNTO68AqKL3cubW/hJB1USuTeiuz/8Bia7Be0H
         m55rR5KmCidedEhGsSisGMeehiI1id254hoZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W6uYmgHxTWzfDftIQnpPK6qurtIUOyuIABrSN4ITJSQ=;
        b=HIsd8B1Ex3koHqhG80GCUo0dDB/Pn1xPooafyUYSQqM9dJf17d6Xz82i7vexYx8XPC
         OhS4o0ZSOZm/hql7CSQM4qUPcLxNwjQqLHE6Ib0aJ7IUwGjO3R5mCCeBj77Zr6a0PZu8
         AGNbNV6JW64oR6kk7L+ChC4mV3Mqba97HgMGQoMs7zcKPITe1FBgXDwtZ5++BotwFpge
         Mh1owQlvyY1mK8M6Rud5BACzmdaybpYUGkPUrOC0pJ5NNKJRICSH23bqlPcdLYmU6DTo
         LjUppK/T3C78G9b93UD7phh7xi0ynDacsbcXfJ+4hQlJ40bFfNvC10fhvynuVd22Sk/3
         a98g==
X-Gm-Message-State: APt69E3ICi/K8vFpnMCMBT/IBxjd0bpDu54jZ5LtDvKzqX8RhSD1taYa
        sibfv1ooyZQ+hCAMoxZGHZtpvA==
X-Google-Smtp-Source: ADUXVKKZCDuyA1KmBRFrv1ziAQK+a4Ehlu/QDowWYWaVfL5M/lc5HenEfqAJjm81Wl3SYfmCc39Zmg==
X-Received: by 2002:adf:96c4:: with SMTP id u62-v6mr14917454wrb.204.1529421137418;
        Tue, 19 Jun 2018 08:12:17 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id f81-v6sm473599wmh.32.2018.06.19.08.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jun 2018 08:12:16 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/4] slimbus: messaging: remove multiple calls to pm_runtime_mark_last_busy
Date:   Tue, 19 Jun 2018 16:12:03 +0100
Message-Id: <20180619151205.11300-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180619151205.11300-1-srinivas.kandagatla@linaro.org>
References: <20180619151205.11300-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a multiple calls to pm_runtime_mark_last_busy(),
which looks like a typo.
Fix this by properly adding pm_runtime_put_autosuspend to put controller
in auto suspend state.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 5a2ff01b394c..1c57b631031a 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -139,7 +139,7 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 		 * if there was error during this transaction
 		 */
 		pm_runtime_mark_last_busy(ctrl->dev);
-		pm_runtime_mark_last_busy(ctrl->dev);
+		pm_runtime_put_autosuspend(ctrl->dev);
 	}
 	return ret;
 }
-- 
2.16.2

