Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeEEBQA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 21:16:00 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:50482 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751808AbeEEBP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 21:15:58 -0400
From: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/24] selftests: ipc: return Kselftest Skip code for skipped tests
Date: Fri,  4 May 2018 19:13:16 -0600
Message-Id: <20180505011328.32078-12-shuah@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180505011328.32078-1-shuah@kernel.org>
References: <20180505011328.32078-1-shuah@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ipc test is skipped because of unmet dependencies and/or
unsupported configuration, it exits with error which is treated as
a fail by the Kselftest framework. This leads to false negative
result even when the test could not be run.

Change it to return kselftest skip code when a test gets skipped to
clearly report that the test could not be run.

Change it to use ksft_exit_skip() when the test is skipped.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
---
 tools/testing/selftests/ipc/msgque.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
index ee9382bdfadc..dac927e82336 100644
--- a/tools/testing/selftests/ipc/msgque.c
+++ b/tools/testing/selftests/ipc/msgque.c
@@ -196,10 +196,9 @@ int main(int argc, char **argv)
 	int msg, pid, err;
 	struct msgque_data msgque;
 
-	if (getuid() != 0) {
-		printf("Please run the test as root - Exiting.\n");
-		return ksft_exit_fail();
-	}
+	if (getuid() != 0)
+		return ksft_exit_skip(
+				"Please run the test as root - Exiting.\n");
 
 	msgque.key = ftok(argv[0], 822155650);
 	if (msgque.key == -1) {
-- 
2.14.1
