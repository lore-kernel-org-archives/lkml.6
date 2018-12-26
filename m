Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BEDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABAF218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864840;
	bh=ZJMlxEFFUpKbsVcxGtI4Lz/fTlLNFe4R2jyxfI0G4Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fuTQvm5fHVTPMZ8CC1tX7kMJh1FbBUKzW8IZSyaPtyFNUXK1Gr5qBQrwSQUer8OMG
	 yTAarkM6N+AfJMe+jci6Cy5+FpgHjjDod+cw9fC2AAFYJrQoyB5f0acZHbhh6L7PHn
	 F0EhcL/pMIZJcFinxOVRnC2hJOfNE7LiyuEwS+bE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbeLZWyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:54:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:55296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729901AbeLZWx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:53:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E9A921901;
        Wed, 26 Dec 2018 22:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864836;
        bh=ZJMlxEFFUpKbsVcxGtI4Lz/fTlLNFe4R2jyxfI0G4Z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uXuAtWjX6agjtUOthbxNI7gJWrDroBAeJujdbORNCDPPldNuM2SOp3+Nn5UvAb2k9
         vuM/k2OqFnjr2q78A5PSXoPmpxdBUDkWTCLTwRO0cdp/yApE5okEMkULHF194SGouV
         hzrLV16ZskmAkd94GfnJ5JVmQGU6J/6Flog2Jm/M=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 06/35] checkstack.pl: fix for aarch64
Date:   Wed, 26 Dec 2018 17:41:13 -0500
Message-Id: <20181226224142.150866-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226224142.150866-1-sashal@kernel.org>
References: <20181226224142.150866-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>

[ Upstream commit f1733a1d3cd32a9492f4cf866be37bb46e10163d ]

There is actually a space after "sp," like this,

    ffff2000080813c8:       a9bb7bfd        stp     x29, x30, [sp, #-80]!

Right now, checkstack.pl isn't able to print anything on aarch64,
because it won't be able to match the stating objdump line of a function
due to this missing space.  Hence, it displays every stack as zero-size.

After this patch, checkpatch.pl is able to match the start of a
function's objdump, and is then able to calculate each function's stack
correctly.

Link: http://lkml.kernel.org/r/20181207195843.38528-1-cai@lca.pw
Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/checkstack.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index dd8397894d5c..12a6940741fe 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -46,8 +46,8 @@ my (@stack, $re, $dre, $x, $xs, $funcre);
 	$xs	= "[0-9a-f ]";	# hex character or space
 	$funcre = qr/^$x* <(.*)>:$/;
 	if ($arch eq 'aarch64') {
-		#ffffffc0006325cc:       a9bb7bfd        stp     x29, x30, [sp,#-80]!
-		$re = qr/^.*stp.*sp,\#-([0-9]{1,8})\]\!/o;
+		#ffffffc0006325cc:       a9bb7bfd        stp     x29, x30, [sp, #-80]!
+		$re = qr/^.*stp.*sp, \#-([0-9]{1,8})\]\!/o;
 	} elsif ($arch eq 'arm') {
 		#c0008ffc:	e24dd064	sub	sp, sp, #100	; 0x64
 		$re = qr/.*sub.*sp, sp, #(([0-9]{2}|[3-9])[0-9]{2})/o;
-- 
2.19.1

