Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489D9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC632063F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976485;
	bh=BaRtPItSgDMDn8WNB05+gFqV1vVJ1GNuFTe26hJYJuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v1uInv3SSgW3lGt4qRp8kpQZVUrnXgU6uM5h9ecZEKF1w4swm1jzb2NBir5gjS9pg
	 BzjFXwTiMnw4MVPc5WWhdNxQUCM6CW4oNZfty2inJhidh+PC52yobyLf57trtfscp2
	 3B+zG7e62DUKGTxBgrEBk+TQ6k7gDbkcVA0SKf/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbfAHTlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:41:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731945AbfAHTeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:34:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FB73205C9;
        Tue,  8 Jan 2019 19:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546976059;
        bh=BaRtPItSgDMDn8WNB05+gFqV1vVJ1GNuFTe26hJYJuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pr6I0iSQWtfeiPhXvzLkvg0VC5shSFgYX8jGEfcMyp3E/McMhcE54ZKNgDwFtAOZ6
         wVqLV+vOfK1os7gJIh5KdbH8C7ks03pz6i0mmPRMzftbXuwd2wC8w6T9sS6M+jQxce
         l72JlMrvPvYM2czMM82IRJj2sNyuYwX919Oqqwb0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 21/36] kconfig: fix memory leak when EOF is encountered in quotation
Date:   Tue,  8 Jan 2019 14:33:33 -0500
Message-Id: <20190108193348.123880-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193348.123880-1-sashal@kernel.org>
References: <20190108193348.123880-1-sashal@kernel.org>
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
index 6534dc5ac803..0c7800112ff5 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -191,6 +191,8 @@ n	[A-Za-z0-9_-]
 	}
 	<<EOF>>	{
 		BEGIN(INITIAL);
+		yylval.string = text;
+		return T_WORD_QUOTE;
 	}
 }
 
-- 
2.19.1

