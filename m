Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23746C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0B22084A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693781;
	bh=9x6g9g1icZqQ9xYPQ5YSCfe+ecsy2NFom/8JB5KqBhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U96+ybpTfQnNVkX31WETAc9nwEnKNdtS/XFgwXsiObBfOMuGwA+aNmkIQAhcTKSIj
	 NJRNF07lgGNab4aMcsKNnEHG3AGjE2b58yPYjEiE0trh0kMZRCAcFb8cDHZpk3Yx3I
	 L2LUww6fvuEQ4MjgC6q3EXEINm/Hm7W3OxIcRZZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389993AbfA1QnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:43:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389466AbfA1QXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:23:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DCA521920;
        Mon, 28 Jan 2019 16:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692614;
        bh=9x6g9g1icZqQ9xYPQ5YSCfe+ecsy2NFom/8JB5KqBhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZipzLv457sxvN9dy+zP/uFvz8EQjEJvzmnXReQ5yk+9rDlDhsmuKt6z2X0+nrvGO0
         5dhCrZubTyp9JE2ZwQL9CrAwOtLqD5wkdInn5xlRwjOI/0mCf81zRKXz7QhvzYEJkV
         5XlP8nW1BpTPQvjkcJf3tVRRp1t7lmia9KKvu+ZM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 094/107] scripts/decode_stacktrace: only strip base path when a prefix of the path
Date:   Mon, 28 Jan 2019 11:19:34 -0500
Message-Id: <20190128161947.57405-94-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <marc.zyngier@arm.com>

[ Upstream commit 67a28de47faa83585dd644bd4c31e5a1d9346c50 ]

Running something like:

	decodecode vmlinux .

leads to interested results where not only the leading "." gets stripped
from the displayed paths, but also anywhere in the string, displaying
something like:

	kvm_vcpu_check_block (arch/arm64/kvm/virt/kvm/kvm_mainc:2141)

which doesn't help further processing.

Fix it by only stripping the base path if it is a prefix of the path.

Link: http://lkml.kernel.org/r/20181210174659.31054-3-marc.zyngier@arm.com
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/decode_stacktrace.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index c332684e1b5a..edde8250195c 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -77,7 +77,7 @@ parse_symbol() {
 	fi
 
 	# Strip out the base of the path
-	code=${code//$basepath/""}
+	code=${code//^$basepath/""}
 
 	# In the case of inlines, move everything to same line
 	code=${code//$'\n'/' '}
-- 
2.19.1

