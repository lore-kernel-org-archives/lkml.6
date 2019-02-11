Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18819C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3738222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898074;
	bh=6Nq3SdJ6BlFOxXAybQG7EbTP4ps7hom1CTmLor+Dsko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uQl9YvwR47O+uKJO0f3caKRjdH2ZWYkaIeII+V0Yu2OJNlQq+5Qe/phO3kmMw7phU
	 G+5SUaOgiUx2L9OuhS6QoW+OB6L+gMP2VKy0Ixg0dXn5YfsTepKMWoDvICKWUju3zj
	 GD1V1zZB6pvcPk7aetXxv4PPvJVaAFvudQ6moG+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403885AbfBKPIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:08:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:58444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730110AbfBKPIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:08:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84AF1222A7;
        Mon, 11 Feb 2019 15:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897714;
        bh=6Nq3SdJ6BlFOxXAybQG7EbTP4ps7hom1CTmLor+Dsko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1gnFTN7EQKvGEyZoq1HTWAU6q0OEChvP9f6csH9E9oBnYAto9oYhy+77/+eKC5HVz
         roaZcAk/VCqdMEjvbevYzvLFD85sdfxsgo45haDdyHMhIj1xp9PhoMzMf1F+eAWOjx
         wM13CeLFRIBjF+0ptID1r3Xq8LmO/W9uelgRPjKw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 091/137] scripts/decode_stacktrace: only strip base path when a prefix of the path
Date:   Mon, 11 Feb 2019 15:19:32 +0100
Message-Id: <20190211141820.492761385@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



