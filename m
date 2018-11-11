Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B426C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596F821527
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+mWqPO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596F821527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387800AbeKLITd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731689AbeKLITc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:32 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D054421508;
        Sun, 11 Nov 2018 22:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975375;
        bh=Ni/kXdSfU9WcuFdVCgeeLO+ctIT5Tv5ZIOyEiThMhuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r+mWqPO3dWC+niUcDlxOagi0g30YzS6OBjt7FQBHdsl2l9scoyT63eqU3cO8yooHY
         cxU3LqMruajjOfBfU1+hQPr/gAec+WdQY2dfuwZYrrsK49kQU6deDQheitHIoKeio0
         kInQ9YRG0R4WKCghxFfeXax8f9YgRW55q3sp8fIk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Sperbeck <jsperbeck@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 043/350] bpf: do not blindly change rlimit in reuseport net selftest
Date:   Sun, 11 Nov 2018 14:18:27 -0800
Message-Id: <20181111221708.971515083@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 262f9d811c7608f1e74258ceecfe1fa213bdf912 ]

If the current process has unlimited RLIMIT_MEMLOCK,
we should should leave it as is.

Fixes: 941ff6f11c02 ("bpf: fix rlimit in reuseport net selftest")
Signed-off-by: John Sperbeck <jsperbeck@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/reuseport_bpf.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/tools/testing/selftests/net/reuseport_bpf.c
+++ b/tools/testing/selftests/net/reuseport_bpf.c
@@ -437,14 +437,19 @@ void enable_fastopen(void)
 	}
 }
 
-static struct rlimit rlim_old, rlim_new;
+static struct rlimit rlim_old;
 
 static  __attribute__((constructor)) void main_ctor(void)
 {
 	getrlimit(RLIMIT_MEMLOCK, &rlim_old);
-	rlim_new.rlim_cur = rlim_old.rlim_cur + (1UL << 20);
-	rlim_new.rlim_max = rlim_old.rlim_max + (1UL << 20);
-	setrlimit(RLIMIT_MEMLOCK, &rlim_new);
+
+	if (rlim_old.rlim_cur != RLIM_INFINITY) {
+		struct rlimit rlim_new;
+
+		rlim_new.rlim_cur = rlim_old.rlim_cur + (1UL << 20);
+		rlim_new.rlim_max = rlim_old.rlim_max + (1UL << 20);
+		setrlimit(RLIMIT_MEMLOCK, &rlim_new);
+	}
 }
 
 static __attribute__((destructor)) void main_dtor(void)


