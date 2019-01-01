Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906F6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 14:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510D8218AE
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 14:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlGdaEbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfAAOFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 09:05:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33666 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfAAOFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 09:05:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so14136039pfb.0;
        Tue, 01 Jan 2019 06:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kqhujvgReB4vtcOUAgUjvrtfVqaQxe9agDi83YeRN+E=;
        b=mlGdaEbK1yIl6+fLTIgHMITrZz1MqjLlmKI5HM7e1D8cOBR1CCPw4DwSGa30/PLuxq
         kehbo8Yd8y0GK+4WjZKNXEynU6gkRH2p646udtkPE5PKIqp66Koxxb85IL+L0YnrmRx+
         Rg1DSL4fz3hPmGxG/TB7nA3joyWdhIQI0d+T17PbsJSMq+RqPXoJ8CrXT7W8BZJ/hWJk
         mHJYuukn+rmiLxFUb/hvM+ilAfxCTFRWSaOvHu4IpQudoWQFIfHylhsB/GY0CVw2KCPs
         Nn4tjBN+1DsiRXyHD0IYPf24nk7emhuXVX2gQpIszpWupgzXaykAKDN7JShdhmlFZ/KH
         iEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kqhujvgReB4vtcOUAgUjvrtfVqaQxe9agDi83YeRN+E=;
        b=sPxMHqN0cOqSKYU0gpsYzckypWgOPunYpsoj3E4iff20CTnq2fdeLqG836wfnMIcOG
         JIbJyAFM9FdqOeVlTa5SNYBZQu8B6xFHVkgha+3pyiKj4DJhETzjOGBPReANUFFEGah9
         UIJkSggIMvi42hvNvUPg29j2svcoll6+68ipcT1lzXJzpqsnoTrtIG47k/FdGn8mw/Hx
         qPv4PryXlbo0ajh4E1YY/b3GPCiiQhmBL7A9hpjTJSxSOnag7pCsYk7VVLSuzGtaWzYU
         Mv+bB0ABFKeMM6x/wkRIZZDxbaantAfXHgygkdSBXB5WyJ5k5O+wPdC5620x9O2VY1TZ
         ZqfQ==
X-Gm-Message-State: AJcUukf+wx+fzWnIyPq2smmLKCJl/NUErYdobp+pJ4Zo05H77bsOg7RS
        pIoFDyJ7MSkt3IKhEwqlMQ==
X-Google-Smtp-Source: ALg8bN7+JL/vsnsafPRu8frJgEqE4x8J274XFMiZkEpHDxtcFkYIixk0ek+1GWrv0EfD4JvsnuHW+w==
X-Received: by 2002:a63:1204:: with SMTP id h4mr10621476pgl.51.1546351504860;
        Tue, 01 Jan 2019 06:05:04 -0800 (PST)
Received: from localhost.localdomain (li1566-229.members.linode.com. [139.162.86.229])
        by smtp.gmail.com with ESMTPSA id v14sm121117477pgf.3.2019.01.01.06.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Jan 2019 06:05:04 -0800 (PST)
From:   Junchang Wang <junchangwang@gmail.com>
To:     dave@stgolabs.net, paulmck@linux.ibm.com, josh@joshtriplett.org,
        corbet@lwn.net, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Junchang Wang <junchangwang@gmail.com>
Subject: [PATCH 2/2] torture.txt: update the list of supported torture types
Date:   Tue,  1 Jan 2019 22:03:20 +0800
Message-Id: <1546351400-16389-3-git-send-email-junchangwang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546351400-16389-1-git-send-email-junchangwang@gmail.com>
References: <1546351400-16389-1-git-send-email-junchangwang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Torture types "rcu_bh" and "sched" were removed in commit "c770c82a23".
The name of torture type "rcu_busted" was changed to "busted" in commit
"b3c983142d". Two other types, "srcud" and "busted_srcud" were added in
commits "ca1d51ed98" and "2397d072f7", respectively. This patch updates
torture.txt accordingly.

Signed-off-by: Junchang Wang <junchangwang@gmail.com>
---
 Documentation/RCU/torture.txt | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/Documentation/RCU/torture.txt b/Documentation/RCU/torture.txt
index 55918b5..6395f0b 100644
--- a/Documentation/RCU/torture.txt
+++ b/Documentation/RCU/torture.txt
@@ -155,20 +155,19 @@ torture_type	The type of RCU to test, with string values as follows:
 			along with expedited, synchronous, and polling
 			variants.
 
-		"rcu_bh": rcu_read_lock_bh(), rcu_read_unlock_bh(), and
-			call_rcu_bh(), along with expedited and synchronous
-			variants.
-
-		"rcu_busted": This tests an intentionally incorrect version
+		"busted": This tests an intentionally incorrect version
 			of RCU in order to help test rcutorture itself.
 
 		"srcu": srcu_read_lock(), srcu_read_unlock() and
 			call_srcu(), along with expedited and
 			synchronous variants.
 
-		"sched": preempt_disable(), preempt_enable(), and
-			call_rcu_sched(), along with expedited,
-			synchronous, and polling variants.
+		"srcud": A second form of srcu that dynamically allocates
+			and frees srcu_struct to test srcu cleanup code path.
+
+		"busted_srcud": This torture type verifies rcutorture's ability
+			to detect extensions of RCU read-side critical sections
+			that are not handled.
 
 		"tasks": voluntary context switch and call_rcu_tasks(),
 			along with expedited and synchronous variants.
-- 
2.7.4

