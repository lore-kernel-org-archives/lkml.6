Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFDAC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38148206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/pqeyJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38148206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbeILCg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:36:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37031 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbeILCg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:36:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so27478390wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 14:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=k6bNcvrEpvYwfD6lwywfSFT9bkDQukByG9H66Zc9JUo=;
        b=Z/pqeyJmgawyMISPmcuq/edO2/c5Yo8mr8Z318izaYYzN1bqRSezhVKeGJn3Ry8QIy
         U2b9nYMV+vZJ6ri89eMLEFUl/czqu0PhlzCVQjBs/YbUWcgMiKsQa/9iPD0cw/S4PvVC
         Qxkvc9aLzhMJriPogrmwQHcjgxo2Zn7GxEgG1PhtZm0TeG8zaAdTa0xazSGi9RLpwQJs
         kDxIuFQBm8hVgBgh0VqZgL2Pjw6qwmmAynEBt0o3bDF1aXcuPqtVvtgIUH5esw9KuzcS
         b9VogEVgoXfw0j0j3vDORdFApIGMR5TX/0SW+dnDNDQCQYTcaB5EmVdsFglPEUtIeryI
         bLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k6bNcvrEpvYwfD6lwywfSFT9bkDQukByG9H66Zc9JUo=;
        b=qQizrPmXolNXaZkEbgeX9stgGxHN3bqibIGcMdd/kl+qXNfx62yDJ83xPL6uoOe8HI
         cbbYe4iQjlzGFCGA/u+hHVpiZ96gyOvTnFpMzzUIE6X+ns1OqLmwo/ZxkFV1RSbjhlxr
         35afjbfaq6DAWAPiLO4RYx4Kw+2QtumuY4V5/PgbmLxQZvicV28pW1rK1XPy5TnI/ilf
         EBWcpYpd0NbjjwUTCknr8JKwIjUFGseY0656/tlhAkMyrBJKH67gydUwvfIs8W+59s+8
         qcAuslf6+NlF4Q8LPjd/8e1nE83awD0c9LaqMkOzoriSxyPaqSsiX/iewmXbn/oGuq9u
         Hjlg==
X-Gm-Message-State: APzg51DYhv1U8mp+FmiUK/8QhJZ9Wzz5YJSYt5ukazJMAEAc3YXHlfmZ
        xGX4e45S/VYJ0oXLTO9xiXhxMoRXz0M=
X-Google-Smtp-Source: ANB0VdYmzeCAKp3mGRgItRN4OaU9maKW3KwAQFMgeFTE6UiTAJgQhb1AvY5GPboJjHQ+HMWsX4wkGg==
X-Received: by 2002:adf:a599:: with SMTP id g25-v6mr20216302wrc.88.1536701711273;
        Tue, 11 Sep 2018 14:35:11 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id d22-v6sm44180839wra.80.2018.09.11.14.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 14:35:10 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ocfs2/dlm: Remove unnecessary parentheses
Date:   Tue, 11 Sep 2018 14:34:01 -0700
Message-Id: <20180911213401.23925-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when more than one set of parentheses is used for a
single conditional statement:

fs/ocfs2/dlm/dlmthread.c:534:18: warning: equality comparison with extraneous
      parentheses [-Wparentheses-equality]
        if ((res->owner == dlm->node_num)) {
             ~~~~~~~~~~~^~~~~~~~~~~~~~~~
fs/ocfs2/dlm/dlmthread.c:534:18: note: remove extraneous parentheses around the
      comparison to silence this warning
        if ((res->owner == dlm->node_num)) {
            ~           ^               ~

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 fs/ocfs2/dlm/dlmthread.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/dlm/dlmthread.c b/fs/ocfs2/dlm/dlmthread.c
index 838a06d4066a..074d5de17bb2 100644
--- a/fs/ocfs2/dlm/dlmthread.c
+++ b/fs/ocfs2/dlm/dlmthread.c
@@ -531,7 +531,7 @@ void __dlm_dirty_lockres(struct dlm_ctxt *dlm, struct dlm_lock_resource *res)
 	assert_spin_locked(&res->spinlock);
 
 	/* don't shuffle secondary queues */
-	if ((res->owner == dlm->node_num)) {
+	if (res->owner == dlm->node_num) {
 		if (res->state & (DLM_LOCK_RES_MIGRATING |
 				  DLM_LOCK_RES_BLOCK_DIRTY))
 		    return;
-- 
2.18.0

