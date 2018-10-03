Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA298C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6FD2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="emK9JBRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6FD2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeJCXeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:34:13 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:49844 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJCXeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:34:12 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 980A31092
        for <linux-kernel@vger.kernel.org>; Wed,  3 Oct 2018 16:45:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id C4ZbVRHtBfrw for <linux-kernel@vger.kernel.org>;
        Wed,  3 Oct 2018 11:45:01 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 6B4FE3F4
        for <linux-kernel@vger.kernel.org>; Wed,  3 Oct 2018 11:45:01 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id e9-v6so7680696itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 09:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PemJYHw+e75fr6kQcUtX1daABnbmVS8tH6kXhT42xcU=;
        b=emK9JBRFp01Bi8X5ZJ7eufxaQBpiAQdrSZxPiQg3EbnYd8Fzj1Bjl/1RtiGSv8lHVr
         kD3UG3Wyw+/FUhPcSkTtn8k9nYzhPAMK3rFZOmszCzQVcki5oneMqQlzPwsK6+Pb9iMT
         SUq/b7ZdQ+TbwEQ3USjL8kNH9a3gKhGzGdeTbRscDnioVk0L1n4C6c76hto8BPmouMA8
         MalAdWi3qlovAb5Rxc8q1Eyfnnqgax+UZv74WNfaW2+jrJnPq+ET7bQgVaUQhBncEpvj
         c0lur2SGRm2dku/ahAb9AsNcV7Wvbv8J3y/cbMOd+vYLiYrpycbGdye1c+Q0n8Yi/PQL
         cfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PemJYHw+e75fr6kQcUtX1daABnbmVS8tH6kXhT42xcU=;
        b=ZoRc/Ogo0+/KLGO5DRZgdTL9TMC2eZn26oyXeS7eKzcZbhzsfmo0Luq5IlkqrM+hZY
         Vz8+jmkAvJO9ceAiQqK6J4LU0B/bCFrJT+c5sMONKB0nU2suBKcGkpKnMAjLnoKlov2z
         pfjgCUBkiXWgbZrDQUMC5oDt4yvbonQ1BakSDPnhsA1UnztDkNVF88oQ7nUPytytzilu
         jj3z6EBmnSi/CqMxyqFDEat9S6r7R0ZWXPP/4tD55PWJ3aHxiKw/bxkuG1QE4utq80wZ
         ZuS+jbCKOQWIhQIOvsUKjojhFlHkzHQvRDp0cy0Zj1MehKMPvTD0curYuM+GXWjzJaZ4
         cQag==
X-Gm-Message-State: ABuFfoiEyOm8WrvxY8VaU1VUf8nADASzIFWs2mlihrR2Z+C1Y2bUtKx0
        6VjK04GDgxsC7hpeAI46Q05jlk4c5GCUip9+SES2egP09YMmEvblF2tF2Olj4xym48tS8OAAjLm
        q4SbdmtEHeufb4CUW0972ZoxohJq/
X-Received: by 2002:a24:6907:: with SMTP id e7-v6mr1949245itc.113.1538585101071;
        Wed, 03 Oct 2018 09:45:01 -0700 (PDT)
X-Google-Smtp-Source: ACcGV60Pa90oPaofgV4Oau56sPUQvzDooIg/GmboAmy2p3HqlxblDmIo+bHwcDN9m3fbNRO7jgMIMg==
X-Received: by 2002:a24:6907:: with SMTP id e7-v6mr1949232itc.113.1538585100890;
        Wed, 03 Oct 2018 09:45:00 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id d12-v6sm807188itf.25.2018.10.03.09.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Oct 2018 09:45:00 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com (maintainer:DEVICE-MAPPER (LVM)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dm ioctl: fix a missing-check bug
Date:   Wed,  3 Oct 2018 11:43:59 -0500
Message-Id: <1538585040-13872-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In copy_params(), the struct 'dm_ioctl' is firstly copied from the user
space buffer 'user' to 'param_kernel' and the field 'data_size' is checked
against 'minimum_data_size'. If the check fails, an error code EINVAL will
be returned. Otherwise, the 'data_size' is used to do the second copy,
which copies from the same user-space buffer to 'dmi'. After the second
copy, only 'dmi->data_size' is checked against 'param_kernel->data_size'.
Given that the buffer 'user' resides in the user space, a malicious
user-space process can race to change the content in the buffer between the
two copies. This way, the attacker can inject inconsistent data in
'param_kernel' and 'dmi'.

This patch removes the redundant part in the second copy and reuses the
result in the first copy. It also remove the check of 'data_size' after the
second copy because it is unnecessary with this patch.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/md/dm-ioctl.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index b810ea7..b708c69 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1762,18 +1762,13 @@ static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kern
 
 	*param_flags |= DM_PARAMS_MALLOC;
 
-	if (copy_from_user(dmi, user, param_kernel->data_size))
+	if (copy_from_user(&dmi->data, (char __user *)user + minimum_data_size,
+				param_kernel->data_size - minimum_data_size))
 		goto bad;
 
-data_copied:
-	/*
-	 * Abort if something changed the ioctl data while it was being copied.
-	 */
-	if (dmi->data_size != param_kernel->data_size) {
-		DMERR("rejecting ioctl: data size modified while processing parameters");
-		goto bad;
-	}
+	memcpy(dmi, param_kernel, minimum_data_size);
 
+data_copied:
 	/* Wipe the user buffer so we do not return it to userspace */
 	if (secure_data && clear_user(user, param_kernel->data_size))
 		goto bad;
-- 
2.7.4

