Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E375C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 17:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6907F21741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 17:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QY+a5UjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbeL0Rp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 12:45:57 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41105 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeL0Rp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 12:45:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so9008125plm.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 09:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yev7m4B2M10EsjSBd6b2yI5+9OujsX/kg7Dboym9xos=;
        b=QY+a5UjMzi2ZAhzy69B7B9hV2u+wwpvCG4ojs1HsH6F77vTB1oMseGdANsjFIUm562
         vQcJhZ1y2MQCOFpy6Ta4ddsA5PWqRndI/zbjJrOYdtO9ee4bm3CV85pPcst9IZ2JfEwj
         vm85ukqDB48+295OwotXbKx/Z2qe6f6OwEyD2FlikBbX/0qDqYTnGTRz+DvpEYrUsKjd
         PHlMkfPINfwpYpQSYsSp+51HX4UfsRQcT4BAybJU2KT5dcSvrwA5M5etrx+xuIDwkBfV
         rqDmkSLmn9TF02H6yHh+5NzpOeg+FTs0pf2uorxJnQyrIN5/wb624KM5fOir81Bnfeez
         MNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yev7m4B2M10EsjSBd6b2yI5+9OujsX/kg7Dboym9xos=;
        b=MvtFZ/yzwcA39YAtuRO9DKe0JPoD8xOOdv/ao7ruSiJp2NbYUEJHonbm7c2rUWGWDj
         0xNM5G01BC7iwFdQshGN4dUoXUjKEHaBlzeiW3ERsEBq5S7tmgGk2kg3/U315x7wdN1h
         dsdYypBsMA/QN/Ks2AV4ZW/rfGIEiyB7CPcbcCjNCtFBJCGXACuaPjxfsm9SGDJwbENe
         5qN605boXKFHNNKV0ecF3HdHDHg7Gm6gUOC9c2PFSZMAZqcUfe7ki+fBfbcTfyJ9NtpV
         0Id+BpmllUIPREUUzwuttxOSSZPMJ27Hle5U/t0Yi5JqCDAohKbe9Qmi/zxzjXL2Fco3
         VnGg==
X-Gm-Message-State: AJcUukfKFewVRY1ehqHEx6JrIvcjcj2eehIh1ORi72yMIesqF0vycx6y
        oFawWiI/zMJ+Atf/MjL5zx8=
X-Google-Smtp-Source: ALg8bN52m01cJw/LLTP7QLOeSlEsiLIkG2SJLKWKfE80HWU2cMiKEswqdLBhLxrU7bQWc+RQcyLI5A==
X-Received: by 2002:a17:902:6b46:: with SMTP id g6mr24478516plt.21.1545932755446;
        Thu, 27 Dec 2018 09:45:55 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id l85sm73271898pfg.161.2018.12.27.09.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 09:45:54 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] csky: Don't leak device tree node reference
Date:   Thu, 27 Dec 2018 12:45:51 -0500
Message-Id: <20181227174551.7564-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_type() acquires a reference to the node returned by it
and that reference needs to be dropped by its caller. setup_smp()
doesn't do that, so fix it by converting to for_each_of_cpu_node().

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/csky/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 36ebaf9834e1..74d627300c55 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -138,7 +138,7 @@ void __init setup_smp(void)
 	struct device_node *node = NULL;
 	int cpu;
 
-	while ((node = of_find_node_by_type(node, "cpu"))) {
+	for_each_of_cpu_node(node) {
 		if (!of_device_is_available(node))
 			continue;
 
-- 
2.17.0

