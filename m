Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BADDC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016AE20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107533;
	bh=ibbxT192Ni6+FysnUDx/0+KhUMPYGHjBUB+iM8R4V0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S5kZTcJ0K6ZSq3CiOWnQ4Ip6pJWWDG2UlGGTcCv+5HLMyHRCPhQmK3ZbMerOmB7FL
	 aliGS8aL1sk8jpBAM1VxFDlW+zP3m45yop14qWf25vRo6LGQEDkq9lZa4UezOM2FZo
	 twCqAo8JN8lLH3jETHc4nVef7Ur/xErOAgYegfuY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016AE20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbeLFOpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:45:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:50182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbeLFOp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:45:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3819620892;
        Thu,  6 Dec 2018 14:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107528;
        bh=ibbxT192Ni6+FysnUDx/0+KhUMPYGHjBUB+iM8R4V0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nXSz/mYLSFnOzJgmKI4+1Wyq6idv1g0tHHbdvEP+JKmpDbxTFiyIMMWrpHxjFvrKt
         8anV6Ft0Dc1hflb4HEwu0aVrXnFoU0uEGUI0B3n7JbovNQVhkcR9trbSuV4EAgsnJu
         OIeWBYwkWkB9aN1yGEa1xl4m6xEZijIamenTb8vI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.9 008/101] drm: gma500: fix logic error
Date:   Thu,  6 Dec 2018 15:38:07 +0100
Message-Id: <20181206143012.071271445@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit 67a3b63a54cbe18944191f43d644686731cf30c7 upstream.

gcc-8 points out a condition that almost certainly doesn't
do what the author had in mind:

drivers/gpu/drm/gma500/mdfld_intel_display.c: In function 'mdfldWaitForPipeEnable':
drivers/gpu/drm/gma500/mdfld_intel_display.c:102:37: error: bitwise comparison always evaluates to false [-Werror=tautological-compare]

This changes it to a simple bit mask operation to check
whether the bit is set.

Fixes: 026abc333205 ("gma500: initial medfield merge")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20170905074741.435324-1-arnd@arndb.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/gma500/mdfld_intel_display.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/gma500/mdfld_intel_display.c
+++ b/drivers/gpu/drm/gma500/mdfld_intel_display.c
@@ -99,7 +99,7 @@ void mdfldWaitForPipeEnable(struct drm_d
 	/* Wait for for the pipe enable to take effect. */
 	for (count = 0; count < COUNT_MAX; count++) {
 		temp = REG_READ(map->conf);
-		if ((temp & PIPEACONF_PIPE_STATE) == 1)
+		if (temp & PIPEACONF_PIPE_STATE)
 			break;
 	}
 }


