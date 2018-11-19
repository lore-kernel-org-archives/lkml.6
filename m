Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58143C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211F0206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOq2AE3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211F0206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390644AbeKTDQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:16:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:54982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389075AbeKTDQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:16:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D207206BA;
        Mon, 19 Nov 2018 16:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646360;
        bh=fSbK18cmV5qB2QUHf6jvLNCgFf2xB+Mv18yj/GnEXkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kOq2AE3W+WXTnZ8/t/7XCWd2DAXuacuwBXdfE1QGbghOSa9zExLyuZBN3MH5HK90w
         aj8X1eOFIuG8rQ7w4rtbKQ+PCuVLQX3tSD/DfmQVUouUh5dPn3Gar7LSLywQp1tEve
         VtrT++KMQTkMT3Jml8DxY4z4jTeFl7jKigRezR1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Breno Leitao <leitao@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 12/83] powerpc/selftests: Wait all threads to join
Date:   Mon, 19 Nov 2018 17:28:38 +0100
Message-Id: <20181119162614.346589579@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.046511542@linuxfoundation.org>
References: <20181119162612.046511542@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/powerpc/tm/tm-tmspr.c |   27 ++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

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


