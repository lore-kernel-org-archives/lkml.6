Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A52FC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 04:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD24F2082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 04:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="nFLBabQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD24F2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeJCLpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 07:45:45 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:51700 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbeJCLpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 07:45:45 -0400
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Oct 2018 07:45:44 EDT
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id E71D710FB
        for <linux-kernel@vger.kernel.org>; Wed,  3 Oct 2018 04:52:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4MUIlEIZmDKn for <linux-kernel@vger.kernel.org>;
        Tue,  2 Oct 2018 23:52:01 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id BB38C10EE
        for <linux-kernel@vger.kernel.org>; Tue,  2 Oct 2018 23:52:01 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id n17-v6so4467216ioa.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 21:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=w/kq/wXawwIfTD6DQ/nzeNHeG55uXt3TKqxAReDz5o8=;
        b=nFLBabQRJHsjfcMZH5glJ003n0pN8nCYN6yTJPucq58nO0xfvE78v8ulunDNEft5XP
         eljV3ss2vV521oT1gFprJWn2E3xK3EGiHBg5eC9x+kMxmguvyX6Gx+r7QtI786y26Am7
         NE5AbQ4GaNLVOW4LRcfW58PEpHAbqtmZvKzhE8DOr3/JazXEEc8QOMkCAs8lDySxrFp5
         pDpxKuHzgtBIX0HYa9q2O1pS+PMjiRpKuE+wGgUh6OUUn4u9GSLy5tEwKzSsx0Epu7kZ
         oH+QCg6vT0h8x8wBJfMta2XQmx7sCVSnBny9ZTtgoErEMcl9u68Mxy5Plpp85kFdg6RE
         LwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w/kq/wXawwIfTD6DQ/nzeNHeG55uXt3TKqxAReDz5o8=;
        b=OXPjy7gqgpGmXroKF9X7Pq1/eP1oVw2gsyRf1xIUv/f9tLyEHZrvJsrtMYoxTcvFmu
         Ky3THiqtrSDjw9XGhId7xGljrgn8iDpLioftCFmrsNnndgdkN1kvjB/UsUrQWLUGrXNF
         LysTRTt2FK7fBQjl9KhluS+PWXHnylMe+q4HEhR0XTtR500HH44uurPATFjRcQSZtlxp
         WvlF+zqmsIjKRBmvj3XQi4KMLAdE5bD6rGgtpH83zUJxGPgGlbhwYuhzy4dGSySS9x8a
         Mtj0J22lSY/7eq4bDSHmbBQg8zjjexZ4xsWWhYFv3yL0boXR73Xjt3m2ulzGRN6syTEA
         ZiQA==
X-Gm-Message-State: ABuFfohSzzSD/pKRvj6WQcuzy18X2oLH6qY696jpk7ch060Y+xrGw/9o
        n1G845WLkCHgpk29otEc1DUEzclf7Hc6bXvVxcEpqt2OkeakxCwENN69WLrwK0u3gnDp+ekJAxv
        cu6CesXQnNmevML4tkIt1sIePNspr
X-Received: by 2002:a6b:9fd1:: with SMTP id i200-v6mr12586575ioe.148.1538542321424;
        Tue, 02 Oct 2018 21:52:01 -0700 (PDT)
X-Google-Smtp-Source: ACcGV61KZXAhz2wPiro2w763zMPt966MLSzJNklIPkAleHisuRDtEB3YRDg2k2tX1WNNd8vbJ+bUYg==
X-Received: by 2002:a6b:9fd1:: with SMTP id i200-v6mr12586569ioe.148.1538542321233;
        Tue, 02 Oct 2018 21:52:01 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id e9-v6sm47374iom.33.2018.10.02.21.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Oct 2018 21:52:00 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] stm class: fix a missing-check bug
Date:   Tue,  2 Oct 2018 23:50:59 -0500
Message-Id: <1538542259-11868-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In stm_char_policy_set_ioctl(), the 'size' field of the struct
'stp_polic_id' is firstly copied from the user space and then checked,
because the length of the 'id' field in this struct, which represents an
identification string, is not fixed. If the 'size' field cannot pass the
check, an error code EINVAL will be returned. However, after the check, the
whole struct is copied again from the user space. Given that the user data
resides in the user space, a malicious user-space process can race to
change the size between the two copies. By doing so, the attacker can
bypass the check on the 'size' field and inject malicious data.

This patch removes the re-copying of the 'size' field in the second copy to
avoid the above issue.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/hwtracing/stm/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 10bcb5d..7617fb4 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -570,11 +570,13 @@ static int stm_char_policy_set_ioctl(struct stm_file *stmf, void __user *arg)
 	if (!id)
 		return -ENOMEM;
 
-	if (copy_from_user(id, arg, size)) {
+	if (copy_from_user(&id->master, (char __user *)arg + sizeof(size),
+				size - sizeof(size))) {
 		ret = -EFAULT;
 		goto err_free;
 	}
 
+	id->size = size;
 	if (id->__reserved_0 || id->__reserved_1)
 		goto err_free;
 
-- 
2.7.4

