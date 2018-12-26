Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D49C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE5A2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865150;
	bh=ZJMlxEFFUpKbsVcxGtI4Lz/fTlLNFe4R2jyxfI0G4Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s7YirWe9P8JmBP3jklGX3IYektQUKoQZiiVUOHqKgmXl6+UrxAg0IpKSAoaXkcAJH
	 d+yyl1Ss/WwowiCxG1OdbTEchDmfoC8GCSikS5lIRISp3e4GeVDAXcN6j7AzbEzSLG
	 W/JBU+buKT7AyIMl4OXayGK4zTyoE4Ntqlne4Z2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbeLZW5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:57:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:57942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728997AbeLZW5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:57:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A045218A5;
        Wed, 26 Dec 2018 22:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545865023;
        bh=ZJMlxEFFUpKbsVcxGtI4Lz/fTlLNFe4R2jyxfI0G4Z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZyxLQYfsnJDigCoIDARhn0IEOJB8Ply+Q7W3FnEtGfjISWwiI68IcQz994RNEPjjb
         IJh1Ki+Ra+fYP3/PSrRKDs3WGIecuIfjPRIQy01kSs+ti388Vu4EMFburHmWIXHVNJ
         144/N6HXJrhrPsIsYgxFqXb6bFDIHMj8wgwhtYho=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 04/21] checkstack.pl: fix for aarch64
Date:   Wed, 26 Dec 2018 17:54:42 -0500
Message-Id: <20181226225501.151365-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226225501.151365-1-sashal@kernel.org>
References: <20181226225501.151365-1-sashal@kernel.org>
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

