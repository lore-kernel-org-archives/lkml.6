Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ACCECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E540A2150E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jab+GCgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E540A2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbeITW5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:57:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44069 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeITW5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:57:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so4664224pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 10:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xQY7mFdQeRnR/YFxDm54sbwL700e7hLiYG01pg5+/Pg=;
        b=Jab+GCgRErR2OmKG7MB2RqQeKdfKKhW8IfiYDwg6Z3mWtxUJq/roDUtp5dhmHe9LGD
         en4q2E8eTTO4Ukaw2oIC4yiI749mk5J9HHaGrkxbVrle3yUfufmPV4AX8GV138G+O9Du
         +FnHEUjnJDcl4Utd7Fha67Q+CSHyzRcFUy02k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xQY7mFdQeRnR/YFxDm54sbwL700e7hLiYG01pg5+/Pg=;
        b=Qu8IttEFZauEA4MoCJQj8eiDxRIIuwI/tjqJmGD6hxVTTWnPXSTojnF+yYSVL4DsdG
         XQ2cYoFjlR0ECFnRMUM1/mKECzYY67F/WVdGDdBj1dJMuMUUY+cE1l9PjsCzFg7p0BfE
         feXVIO02lwGBgwoQ9FEuXXJPXK1ULNeR6EESUAedX3fAZP/ebarU0FdOKFH/nU0BB2oL
         amaJaHxs+U1c3c+rTB0sj5ZkY6Vss/PHgPStpclGzfL0xNwH4gIMQ21KtIRcOka2drBV
         PctYNWPYkbLZeE2X73UiLw0qQot9S3bAP6PdWeogDqT/6o/vWxuH0PcjVUOiYjRhUrJE
         Vl6w==
X-Gm-Message-State: APzg51Asg5p3f4cj/ad7hRCVercuHP5dz4LL5G4ioTos7Lb6sxa6oYYv
        Fr3d8d5M4fJfWr0IT6uvXqm3Rw==
X-Google-Smtp-Source: ANB0VdZuojRSJoE/CoWs8dmDwR5ZCHVjJd7IdvAlNPqgV0rGW0rA6jsF+rMnfD8XAL/L27EyFvhrMA==
X-Received: by 2002:a62:411a:: with SMTP id o26-v6mr42631888pfa.111.1537463585972;
        Thu, 20 Sep 2018 10:13:05 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id u11-v6sm11737998pgj.71.2018.09.20.10.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:13:05 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] sysrq: Use panic() to force a crash
Date:   Thu, 20 Sep 2018 10:12:53 -0700
Message-Id: <20180920171253.115372-1-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysrq_handle_crash() currently forces a crash by dereferencing a
NULL pointer, which is undefined behavior in C. Just call panic()
instead, which is simpler and doesn't depend on compiler specific
handling of the undefined behavior.

Remove the comment on why the RCU lock needs to be released, it isn't
accurate anymore since the crash now isn't handled by the page fault
handler (for reference: the comment was added by commit 984cf355aeaa
("sysrq: Fix warning in sysrq generated crash.")). Releasing the lock
is still good practice though.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/tty/sysrq.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 06ed20dd01ba..d779a51499a0 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -134,17 +134,10 @@ static struct sysrq_key_op sysrq_unraw_op = {
 
 static void sysrq_handle_crash(int key)
 {
-	char *killer = NULL;
-
-	/* we need to release the RCU read lock here,
-	 * otherwise we get an annoying
-	 * 'BUG: sleeping function called from invalid context'
-	 * complaint from the kernel before the panic.
-	 */
+	/* release the RCU read lock before crashing */
 	rcu_read_unlock();
-	panic_on_oops = 1;	/* force panic */
-	wmb();
-	*killer = 1;
+
+	panic("sysrq triggered crash\n");
 }
 static struct sysrq_key_op sysrq_crash_op = {
 	.handler	= sysrq_handle_crash,
-- 
2.19.0.444.g18242da7ef-goog

