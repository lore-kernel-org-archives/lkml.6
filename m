Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE28C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48A420449
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497840;
	bh=vvXfqc4BL/9V5I72sLX9M0RylmO09Z8Cl03jY6Gb2gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dZefsGVsijUuUfP4VfInEjOgiQKLZV9XS7vxgHO/NUUg8kOaXuzDACjsxiMvjN57s
	 f5iAMRzre696UPjZmlIA+8w+4X0jYJIf1JxCOCneQdjskWnA/TWrH9wfr8hxxsq6uM
	 7R/pwMZYep0BUvVXAsM7M030cnU1dAiKGv9EbErY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbfBRNui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:50:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:58216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732236AbfBRNuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:50:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFC7521901;
        Mon, 18 Feb 2019 13:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497832;
        bh=vvXfqc4BL/9V5I72sLX9M0RylmO09Z8Cl03jY6Gb2gI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cpZeA1hALY++SwRbpU/A2tOmhLJTmBnJxl1wuV/JjUeVdPYj//Nw2ZvzePIGzzpTX
         8R44QKFQnBoMQHlAFpn8E5zoVEgoIp660LxW497wPCtyvo6ZU802eUXklFv6SZmgYq
         HSP0Y+UniQhJJO+bSaIxWfRJ8Sx4crhDN+cNXMOo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David A. Long" <dave.long@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 07/85] ARM: 8792/1: oabi-compat: copy oabi events using __copy_to_user()
Date:   Mon, 18 Feb 2019 14:42:33 +0100
Message-Id: <20190218133500.562076164@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

Commit 319508902600c2688e057750148487996396e9ca upstream.

Copy events to user using __copy_to_user() rather than copy members of
individually with __put_user_error().
This has the benefit of disabling/enabling PAN once per event intead of
once per event member.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/sys_oabi-compat.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
index f0dd4b6ebb63..40da0872170f 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -277,6 +277,7 @@ asmlinkage long sys_oabi_epoll_wait(int epfd,
 				    int maxevents, int timeout)
 {
 	struct epoll_event *kbuf;
+	struct oabi_epoll_event e;
 	mm_segment_t fs;
 	long ret, err, i;
 
@@ -295,8 +296,11 @@ asmlinkage long sys_oabi_epoll_wait(int epfd,
 	set_fs(fs);
 	err = 0;
 	for (i = 0; i < ret; i++) {
-		__put_user_error(kbuf[i].events, &events->events, err);
-		__put_user_error(kbuf[i].data,   &events->data,   err);
+		e.events = kbuf[i].events;
+		e.data = kbuf[i].data;
+		err = __copy_to_user(events, &e, sizeof(e));
+		if (err)
+			break;
 		events++;
 	}
 	kfree(kbuf);
-- 
2.19.1



