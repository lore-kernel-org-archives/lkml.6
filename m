Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BF4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D65120989
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vB+l9lTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D65120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732995AbeKTDEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:04:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:37588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732128AbeKTDEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:04:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BAF6206BA;
        Mon, 19 Nov 2018 16:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645622;
        bh=Kntf7m0BxvnEQmBrZoFpwW+KiIoXkNl5reO3DtNPhwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vB+l9lTRWQN8cadxrOKvPeBiy+LhZWs/4JEPI3S/U7P6DFN6tLUwdQTBQwPAoULZ+
         CHoBAcAxY/ahRUAs/1CXmkE46gKPmFqRh1aGemdEIvlNPTR38Td9WDKOpklR6jV+Ta
         hE+px2gO70lCP5aZ50o7byGsGASSI7fGqSATUhRE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Breno Leitao <leitao@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 026/171] powerpc/selftests: Wait all threads to join
Date:   Mon, 19 Nov 2018 17:27:02 +0100
Message-Id: <20181119162624.016139641@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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


