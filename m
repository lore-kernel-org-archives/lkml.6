Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FF0C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6652063F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976732;
	bh=BaRtPItSgDMDn8WNB05+gFqV1vVJ1GNuFTe26hJYJuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QPUPlbYScryIscubFTJv68XmH0RdZJFyK8HTeo0SbmFR8CUigFpXcmnie6O7j9PV9
	 4teXHyDulnIz5gj5ljNVt2WCJl/zmImVRV1kfnqrBJIeH8Elquch3zOQ/n+VUVxqFc
	 y4FN0qjpT/ZYYCU1FdTXq0GXYso2aN6F8e/MyszQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbfAHTdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:33:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731593AbfAHTdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:33:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CA1F20645;
        Tue,  8 Jan 2019 19:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975992;
        bh=BaRtPItSgDMDn8WNB05+gFqV1vVJ1GNuFTe26hJYJuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=te3MFP6JLXkM2yOGNQzKuYS75beiOJTB+l0pO055FBKuwLi1WyqcwpPI6C22eNJTM
         apnnHrG1jPs8dHUY52+xO1TLuAeoSFDmeERgj4NCDYa0rU1AfgQAFQMbVidifEYszH
         jQmviY1KQc/xEgGQTQJXyBU02wVvBL2Jjnu7E0nE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 30/53] kconfig: fix memory leak when EOF is encountered in quotation
Date:   Tue,  8 Jan 2019 14:31:58 -0500
Message-Id: <20190108193222.123316-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193222.123316-1-sashal@kernel.org>
References: <20190108193222.123316-1-sashal@kernel.org>
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

