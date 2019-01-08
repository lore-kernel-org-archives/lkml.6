Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033E3C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C089B20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976151;
	bh=hJ8A4iptrvZx455HkdXaYaLpXDgoU7yauXSrumFXPZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=votu6KOg6l0Au1fsNaHHuehTBqimyMc140mWczEuyHW+Hdvcy6lKasQs/GuKSUvqm
	 YFIP038SOZaqtav/CVuMI6waVsJxZP4Y4chhUbUyZlCRTpI1X9K1XejkMF6zej4xVg
	 dJ8psXUU/Cpx38rlKv3AXhSLc/btpCFj+MGqBK78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbfAHTfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:35:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:44692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732360AbfAHTfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:35:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45E88205C9;
        Tue,  8 Jan 2019 19:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546976146;
        bh=hJ8A4iptrvZx455HkdXaYaLpXDgoU7yauXSrumFXPZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NDWl6IVJDm0s2C1PuAqxO1APrlbN9vjjngvvs1NCXBWUav2wYARvbzcpfTtzeo5rU
         AFaPubIj3sDTjZRI/0cVT41RW2CKk9U0AZ2z2lTn30qcJG5qe74j3RNIVd9s6pUkKw
         yKvAaeGRYu88zf7tFIWCynh3mHjl/fs4fL+BBy/w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 10/19] kconfig: fix memory leak when EOF is encountered in quotation
Date:   Tue,  8 Jan 2019 14:35:22 -0500
Message-Id: <20190108193534.124555-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193534.124555-1-sashal@kernel.org>
References: <20190108193534.124555-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit fbac5977d81cb2b2b7e37b11c459055d9585273c ]

An unterminated string literal followed by new line is passed to the
parser (with "multi-line strings not supported" warning shown), then
handled properly there.

On the other hand, an unterminated string literal at end of file is
never passed to the parser, then results in memory leak.

[Test Code]

  ----------(Kconfig begin)----------
  source "Kconfig.inc"

  config A
          bool "a"
  -----------(Kconfig end)-----------

  --------(Kconfig.inc begin)--------
  config B
          bool "b\No new line at end of file
  ---------(Kconfig.inc end)---------

[Summary from Valgrind]

  Before the fix:

    LEAK SUMMARY:
       definitely lost: 16 bytes in 1 blocks
       ...

  After the fix:

    LEAK SUMMARY:
       definitely lost: 0 bytes in 0 blocks
       ...

Eliminate the memory leak path by handling this case. Of course, such
a Kconfig file is wrong already, so I will add an error message later.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kconfig/zconf.l | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index 6c62d93b4ffb..485b19a461f8 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -180,6 +180,8 @@ n	[A-Za-z0-9_]
 	}
 	<<EOF>>	{
 		BEGIN(INITIAL);
+		yylval.string = text;
+		return T_WORD_QUOTE;
 	}
 }
 
-- 
2.19.1

