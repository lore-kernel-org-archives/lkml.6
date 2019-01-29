Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E65C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F0020856
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="lIZCE47Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbfA2WF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:05:56 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43241 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbfA2WFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 17:05:55 -0500
Received: by mail-qt1-f194.google.com with SMTP id i7so24084092qtj.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 14:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WkHarLW31VHhafsMLD+STTdwmaZxaox2qI9bgB04JG0=;
        b=lIZCE47QO4ruAuG7mEKE5RqYOEDbqoMi9pdEVriPnR6HZHSISlyGSkUpCn8Tlo7u5n
         +h9EjXiZyXJpxNVRBYD2C4iMmB/PIxJvAShetPIW7NpIOamXMale0E/g/ambvX9n2BMh
         0b6beIHUOb5b2zrAUzTIUCPQx+qL3VScwUZkj4XuiCQSSr836TwLj2PvY5wVVcuPlBOM
         9ftXuddhSyiJrk1qsECUwAb1igl0TNeo0XvZD0HZ1Ljl08J1h59KIRX6vq5/j5JajU/+
         g8gtsCyncbMlQElLCJJ+6k3dhZXsqT3k/N4MKFxNnJ7dYkBoOjBmijfXZ7pT8QmGmllD
         Fh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WkHarLW31VHhafsMLD+STTdwmaZxaox2qI9bgB04JG0=;
        b=Pj8UWl/SQhcJqTGItruvEQ8xvAwJkGB+9aSKP/7KlcFMo8KZJAMhCJDNJCuaAxbgVX
         rLsn7pc2BzeZIe3kUJyLnWkHCNBj1/XKaEo/Lz/DVsujExRiFZXhZYnaB+p/Lm3lX0ZW
         76GftQNwJAkotulll67NiXgg5j5+YrKFcmM8fjZBzkw9PuScz5SCwl4vzHZ9fSgqUBJ2
         a8Qu/rMSuqlh52oq6w35M8JSGqdimE3j6dhU7UDecBKW/oaAnkmfbGCIxYDgF7A4U5jq
         7j8ZRD88TgfJ/NxaTYLFhq3yvqw8toJPLKgynrkBu9LU+/fPw5v9eK5SbFlc26u2ludm
         Sqbg==
X-Gm-Message-State: AJcUukdioytl9e/7gQEVDxnxS8OR+VaAkA1bmi/zaso5nH8XbW+9KM/x
        3blCkClTCgtMrUx/9i+9Y+ZJ9w==
X-Google-Smtp-Source: ALg8bN4pOMBy+u8RtCDsgTP+6S2tW5CUY+fHPGfE1S5MDdPzMFEaii/GCYnhrowG6p2EuPoapC4BSw==
X-Received: by 2002:a0c:e105:: with SMTP id w5mr25952350qvk.234.1548799554220;
        Tue, 29 Jan 2019 14:05:54 -0800 (PST)
Received: from localhost.localdomain ([205.153.92.177])
        by smtp.gmail.com with ESMTPSA id w52sm93299565qtc.51.2019.01.29.14.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 14:05:53 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH] rcu docs: repair some whitespace damage
Date:   Tue, 29 Jan 2019 15:05:46 -0700
Message-Id: <20190129220546.12934-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While reading the docs I noticed some whitespace damage in diagram. Let's
fix it up to be consistent with elsewhere in the document: use one leading
tab, followed by spaces for any additional whitespace required.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 Documentation/RCU/whatisRCU.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
index 4a6854318b17..419ec18b87bd 100644
--- a/Documentation/RCU/whatisRCU.txt
+++ b/Documentation/RCU/whatisRCU.txt
@@ -310,7 +310,7 @@ reader, updater, and reclaimer.
 
 
 	    rcu_assign_pointer()
-	    			    +--------+
+	                            +--------+
 	    +---------------------->| reader |---------+
 	    |                       +--------+         |
 	    |                           |              |
@@ -318,12 +318,12 @@ reader, updater, and reclaimer.
 	    |                           |              | rcu_read_lock()
 	    |                           |              | rcu_read_unlock()
 	    |        rcu_dereference()  |              |
-       +---------+                      |              |
-       | updater |<---------------------+              |
-       +---------+                                     V
+	    +---------+                 |              |
+	    | updater |<----------------+              |
+	    +---------+                                V
 	    |                                    +-----------+
 	    +----------------------------------->| reclaimer |
-	    				         +-----------+
+	                                         +-----------+
 	      Defer:
 	      synchronize_rcu() & call_rcu()
 
-- 
2.19.1

