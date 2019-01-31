Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F1EC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B8F218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548964013;
	bh=mL75MUWX0EzwHFR0vEbi2cpf3Z9Ck55SReRBF2hyCHA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xtujpILQAnF/DZ2Y1dN7/92KEP1rKXogMSpz6i0aduMketl6/T7Yi5nOWcAamPyOk
	 37lIUuPnZkkPsMbZwvphpHgzmOGEjIRLzAC+DpuJWPrunkfhhRyZfganwzIBrZ9x9+
	 IXUwQb4QnvuMvX79omFIpo6PW4qgx55voDLV3TiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfAaTqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:46:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:59032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbfAaTqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:46:51 -0500
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45FE1218AF;
        Thu, 31 Jan 2019 19:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548964010;
        bh=mL75MUWX0EzwHFR0vEbi2cpf3Z9Ck55SReRBF2hyCHA=;
        h=From:To:Cc:Subject:Date:From;
        b=cJNWpQ+IyQqvmtIoypknAenKmtCcrtS+wPdauqXqtbtES6xLJhQSInicCHy6ZG0mi
         7Ju90zauvChCtgCwtPnhOhOPho7O0J61MQ0ef2jnkwHopc5Di9BscH1fOR5p3/5Ahr
         ohePegSicA2eFgy2KxS3N79Rrn70X24ceKTLzjpU=
From:   Shuah Khan <shuah@kernel.org>
To:     shuah@kernel.org, sean@mess.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: ir: skip when non-root user runs the test
Date:   Thu, 31 Jan 2019 12:46:49 -0700
Message-Id: <20190131194649.19248-1-shuah@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip instead of fail when non-root user runs the test.

Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/ir/ir_loopback.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/ir/ir_loopback.sh b/tools/testing/selftests/ir/ir_loopback.sh
index 0a0b8dfa39be..b90dc9939f45 100755
--- a/tools/testing/selftests/ir/ir_loopback.sh
+++ b/tools/testing/selftests/ir/ir_loopback.sh
@@ -4,6 +4,11 @@
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
+if [ $UID != 0 ]; then
+	echo "Please run ir_loopback test as root [SKIP]"
+	exit $ksft_skip
+fi
+
 if ! /sbin/modprobe -q -n rc-loopback; then
         echo "ir_loopback: module rc-loopback is not found [SKIP]"
         exit $ksft_skip
-- 
2.17.1

