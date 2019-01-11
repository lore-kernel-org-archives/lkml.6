Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA34C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBC82063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216879;
	bh=Pp7Ogq7LFy84MAgTdaasxQ7HEBWpIArVGtb1+Gx7NTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n8Nhuk9PWtT/9fujs2tm7zcL0lDK+50fawJvFXqdtgQnCDFITbsWtpzjkMzOtifYH
	 GBrUUQU+uHDuFU/fcO3UPe57XgC22F9T4jCr5yQMRuVx56LA4n/v1epfxiSiik7+zK
	 Fezs+0KQvKgYkseBvactNpKddg9eKTjZxOJq2794=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388428AbfAKO16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:27:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:46340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388409AbfAKO1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:27:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB05B2177B;
        Fri, 11 Jan 2019 14:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216874;
        bh=Pp7Ogq7LFy84MAgTdaasxQ7HEBWpIArVGtb1+Gx7NTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cEXhDKON0P5wMGiUgI+qqDHE8Pd7LiogHlptOQWe/ACaV81upuUpqXSuiycWIMcvh
         hjVOVXMx7uk4s/G7qYy74PrcEa+bLjViuDO0TCVT/5nR+oBL419YoOSwyuZpgeVUIq
         6Yq++4KYSjKHVE1Wsx88vH1ifiTNGCznwPEedF9Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 06/63] checkstack.pl: fix for aarch64
Date:   Fri, 11 Jan 2019 15:14:09 +0100
Message-Id: <20190111131047.229562076@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
References: <20190111131046.387528003@linuxfoundation.org>
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



