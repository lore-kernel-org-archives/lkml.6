Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2438DECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4A020842
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4A020842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389386AbeIXSr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:47:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59852 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730401AbeIXSrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:47:55 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B3F80109A;
        Mon, 24 Sep 2018 12:45:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Pintu Agarwal <pintu.ping@gmail.com>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 212/235] selftests/android: initialize heap_type to avoid compiling warning
Date:   Mon, 24 Sep 2018 13:53:18 +0200
Message-Id: <20180924113124.916353987@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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

From: Li Zhijian <lizhijian@cn.fujitsu.com>

[ Upstream commit cc7c673032fc7427087e74b75f732b43db38a256 ]

Initialize heap_type to ION_HEAP_TYPE_SYSTEM to avoid "used uninitialized"
compiler warning. heap_type gets used after initialization, this change is
to just keep the compiler happy.

root@vm-lkp-nex04-8G-7 ~/linux-v4.18-rc2/tools/testing/selftests/android# make
make[1]: warning: jobserver unavailable: using -j1.  Add '+' to parent make rule.
make[1]: Entering directory '/root/linux-v4.18-rc2/tools/testing/selftests/android/ion'
gcc  -I. -I../../../../../drivers/staging/android/uapi/ -I../../../../../usr/include/ -Wall -O2 -g    ionapp_export.c ipcsocket.c ionutils.c   -o ionapp_export
ionapp_export.c: In function 'main':
ionapp_export.c:91:2: warning: 'heap_type' may be used uninitialized in
this function [-Wmaybe-uninitialized]
  printf("heap_type: %ld, heap_size: %ld\n", heap_type, heap_size);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CC: Shuah Khan <shuah@kernel.org>
CC: Pintu Agarwal <pintu.ping@gmail.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/android/ion/ionapp_export.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/testing/selftests/android/ion/ionapp_export.c
+++ b/tools/testing/selftests/android/ion/ionapp_export.c
@@ -51,6 +51,7 @@ int main(int argc, char *argv[])
 
 	heap_size = 0;
 	flags = 0;
+	heap_type = ION_HEAP_TYPE_SYSTEM;
 
 	while ((opt = getopt(argc, argv, "hi:s:")) != -1) {
 		switch (opt) {


