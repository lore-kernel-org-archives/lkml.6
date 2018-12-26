Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2ECC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D9A21741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863789;
	bh=wiFyz5wbEJuZo6BSqI3FVPqGpcxcYoTkUChEwNQaaoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wCPdDBHlxdXojradPY7aSWsiSoK5LkvZdGic+EM1F2oc4vE4ksj/chgjMas5NdVQw
	 o8spBFuMzu4ATEeiZfUKwnSCB54zDFI1jZlmLq1E1NCC6gg0bz6MLyP26S5Wvg1zqd
	 LA3Un3jmMdpPouRZ4OAJWXPtIacxhiNl+uBL39/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeLZWg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:36:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:36316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727186AbeLZWgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8344E218E2;
        Wed, 26 Dec 2018 22:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863784;
        bh=wiFyz5wbEJuZo6BSqI3FVPqGpcxcYoTkUChEwNQaaoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KtmcHt24iv16MhyUI/a89LZ6AkHXuShezYcbMdh+2Tyl0EQYiE6TlK8XPzSVh4z3i
         T9wKwi+1FHq+7U3br/PQGqGJpVU9oLSqpvpHWn3W2juNTXz6ILGQtxQHM98Ico4hL1
         9nWANgGAFKpvgjh5KIXTv9eF7uzo5gBhl2WJIX1A=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 15/97] checkstack.pl: fix for aarch64
Date:   Wed, 26 Dec 2018 17:34:35 -0500
Message-Id: <20181226223557.149329-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
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
index 8081b6cf67d2..34414c6efad6 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -47,8 +47,8 @@ my (@stack, $re, $dre, $x, $xs, $funcre);
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

