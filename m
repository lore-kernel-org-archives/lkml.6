Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3975DECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEAB8204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yhox9GUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAB8204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbeKDXM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:12:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731628AbeKDXJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:09:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5166020868;
        Sun,  4 Nov 2018 13:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339655;
        bh=6wcQqKmpTN/0KAslgC8sMtn+EH0X3bqFgwJSJ4Ikd5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yhox9GUFMGag7UC4SJYfdo3WxsuriFIHcKrS5xD95JTuZd3tLvgnz1owX3tS0otOp
         gXiYWQn8P9Ik3Nsp65ivoRHqKnYI+wuBYEPJZ5nKgd991SBObUDVb3vyanRsKyZw5P
         IbYjVWwr5AFctbDWX26viRM6WLu2JFXhMQCNkQcw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Breno Leitao <leitao@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 19/21] powerpc/selftests: Wait all threads to join
Date:   Sun,  4 Nov 2018 08:53:53 -0500
Message-Id: <20181104135355.88602-19-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135355.88602-1-sashal@kernel.org>
References: <20181104135355.88602-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 693b31b2fc1636f0aa7af53136d3b49f6ad9ff39 ]

Test tm-tmspr might exit before all threads stop executing, because it just
waits for the very last thread to join before proceeding/exiting.

This patch makes sure that all threads that were created will join before
proceeding/exiting.

This patch also guarantees that the amount of threads being created is equal
to thread_num.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/powerpc/tm/tm-tmspr.c | 27 ++++++++++++-------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-tmspr.c b/tools/testing/selftests/powerpc/tm/tm-tmspr.c
index 2bda81c7bf23..df1d7d4b1c89 100644
--- a/tools/testing/selftests/powerpc/tm/tm-tmspr.c
+++ b/tools/testing/selftests/powerpc/tm/tm-tmspr.c
@@ -98,7 +98,7 @@ void texasr(void *in)
 
 int test_tmspr()
 {
-	pthread_t 	thread;
+	pthread_t	*thread;
 	int	   	thread_num;
 	unsigned long	i;
 
@@ -107,21 +107,28 @@ int test_tmspr()
 	/* To cause some context switching */
 	thread_num = 10 * sysconf(_SC_NPROCESSORS_ONLN);
 
+	thread = malloc(thread_num * sizeof(pthread_t));
+	if (thread == NULL)
+		return EXIT_FAILURE;
+
 	/* Test TFIAR and TFHAR */
-	for (i = 0 ; i < thread_num ; i += 2){
-		if (pthread_create(&thread, NULL, (void*)tfiar_tfhar, (void *)i))
+	for (i = 0; i < thread_num; i += 2) {
+		if (pthread_create(&thread[i], NULL, (void *)tfiar_tfhar,
+				   (void *)i))
 			return EXIT_FAILURE;
 	}
-	if (pthread_join(thread, NULL) != 0)
-		return EXIT_FAILURE;
-
 	/* Test TEXASR */
-	for (i = 0 ; i < thread_num ; i++){
-		if (pthread_create(&thread, NULL, (void*)texasr, (void *)i))
+	for (i = 1; i < thread_num; i += 2) {
+		if (pthread_create(&thread[i], NULL, (void *)texasr, (void *)i))
 			return EXIT_FAILURE;
 	}
-	if (pthread_join(thread, NULL) != 0)
-		return EXIT_FAILURE;
+
+	for (i = 0; i < thread_num; i++) {
+		if (pthread_join(thread[i], NULL) != 0)
+			return EXIT_FAILURE;
+	}
+
+	free(thread);
 
 	if (passed)
 		return 0;
-- 
2.17.1

