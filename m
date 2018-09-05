Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0680FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC8E20658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG0Pg1D6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC8E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeIEQpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:45:03 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44299 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIEQpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:45:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id ba4-v6so3211703plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 05:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+gydDs/fd0WfSZF/djiR8zUnuMeG1y3hOzS6hqPIHh8=;
        b=UG0Pg1D6A1+hHrEwwiwtlv3nXfMCUjP/d7cxUgs3MIoZonDe32/oxWsTAP/9HTxfXg
         wp3/QAFx7jkwGbcy3xGdc0c1sq8w2/hWAE55grX6puMUSgJQq2Q1J9ple5cERELMe6Vy
         OS0aybTPy/CNIanrTjdXXFs14VsJjyStIf1q5kjVuOCPCJ6mF3deC2nvG4P7IaFP0a6P
         RvbNu+14VUqN5e4xqomwYLeahjasmD2FxhrLIU6O7gpypGQQ4uCZ4tftcB2oqn3jTdqr
         tdFYqtsEYIjk9zKLZkZJJ0AOtpKq3sm1CGea3d1aG2GCJS2jvopkMCLmGpKiEQ+vo9Yi
         He7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+gydDs/fd0WfSZF/djiR8zUnuMeG1y3hOzS6hqPIHh8=;
        b=rpYA67jcf9ot+UAApZqWiLZbs2ahvSswETJfaNBVxLN15TTlVxjm9KKT6K8xLRgM9u
         +fJZ27mUKOKCTeZXA0M1O4m3YbTyya8eIUsctNuyo+4lv0RqxBITPCony3mZeJ9s2iMT
         8oc2+Ik2W3sl2XYh6zB4En4D1orAo0LMs2cHzOZkHk4z+R6MneShrUPJlxQfg798BrsQ
         u5CF6Ky6D2mP/lE9wWz7GYj9LVpHNF7cdS5MA4syn5KVVRREXpYh4BeudjvNm2sEUNpG
         Ly+BAIT/P+gkXJ9d/fBhKR11q/iwThMfwUqJl/L8w0cTVoSeFcYZkPMRSn9dAloEKlYM
         vdBw==
X-Gm-Message-State: APzg51BF4mDSFcogHXjtRG3DHft7eyPX6x+Frk41aWo1uuPwepwuP6uU
        8G4SMxzdbQBUrfvVzXIJL3I=
X-Google-Smtp-Source: ANB0VdaHYShp8lGBrOR9QLJXCjKnjv42131P7JonTqQREE461ZS7rLwWFrDaLxMST8/pI1EaS1XqrQ==
X-Received: by 2002:a17:902:2e01:: with SMTP id q1-v6mr38604056plb.40.1536149703647;
        Wed, 05 Sep 2018 05:15:03 -0700 (PDT)
Received: from roar.local0.net (59-102-81-67.tpgi.com.au. [59.102.81.67])
        by smtp.gmail.com with ESMTPSA id w5-v6sm2496227pfn.44.2018.09.05.05.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 05:15:03 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Jiri Slaby <jslaby@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Matteo Croce <mcroce@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org (op)
Subject: [PATCH 3/3] tty: hvc: hvc_write() fix break condition
Date:   Wed,  5 Sep 2018 22:14:39 +1000
Message-Id: <20180905121439.23809-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180905121439.23809-1-npiggin@gmail.com>
References: <20180905121439.23809-1-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 550ddadcc758 ("tty: hvc: hvc_write() may sleep") broke the
termination condition in case the driver stops accepting characters.
This can result in unnecessary polling of the busy driver.

Restore it by testing the hvc_push return code.

Fixes: 550ddadcc758 ("tty: hvc: hvc_write() may sleep")
Tested-by: Matteo Croce <mcroce@redhat.com>
Tested-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index bacf9b73ec98..c09a38fb0d66 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -522,6 +522,8 @@ static int hvc_write(struct tty_struct *tty, const unsigned char *buf, int count
 		return -EIO;
 
 	while (count > 0) {
+		int ret;
+
 		spin_lock_irqsave(&hp->lock, flags);
 
 		rsize = hp->outbuf_size - hp->n_outbuf;
@@ -537,10 +539,13 @@ static int hvc_write(struct tty_struct *tty, const unsigned char *buf, int count
 		}
 
 		if (hp->n_outbuf > 0)
-			hvc_push(hp);
+			ret = hvc_push(hp);
 
 		spin_unlock_irqrestore(&hp->lock, flags);
 
+		if (!ret)
+			break;
+
 		if (count) {
 			if (hp->n_outbuf > 0)
 				hvc_flush(hp);
-- 
2.18.0

