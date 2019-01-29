Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E86EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07DD20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762059;
	bh=Yqg+HVTJg5VyAG6umEGHUwComdluFpuJTg/49LyQ0hU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FlOMXVc/qGpWWzW8dAI7GdXhwek1+4LF2NgV6cr4bqOKRiv99FvrIIxHEXtI1lxvR
	 nAf/3+JwyDWO9wpm0BYRE+Hx38f8WQ7INFQFFEgTtELmAArJULBWtE9MTYgMZ85L88
	 yfbICk6RXenJvQBRTvqPqHnR167CHeD8DJL1uDO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbfA2Lk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:40:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:58098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbfA2Lkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:40:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 082D220857;
        Tue, 29 Jan 2019 11:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762055;
        bh=Yqg+HVTJg5VyAG6umEGHUwComdluFpuJTg/49LyQ0hU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gog5YJEsGi1YWAGL/AYSGZBdoqEGm5L+QZfQaQHHZoBXPSk2oHEe1oWrWY6Rc5noV
         L6YV45iz3SIl2njIsED/w1y+o+u56LqmNWMOxeSouhHtnrkMfBi1lc4UiQZXwEqFLU
         3wz0Zx2kiBXs5aAeCORtJFI0Z1y3II9oHf+r/uMQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Pitre <nico@linaro.org>
Subject: [PATCH 4.20 092/117] vt: invoke notifier on screen size change
Date:   Tue, 29 Jan 2019 12:35:43 +0100
Message-Id: <20190129113211.966953996@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Pitre <nicolas.pitre@linaro.org>

commit 0c9b1965faddad7534b6974b5b36c4ad37998f8e upstream.

User space using poll() on /dev/vcs devices are not awaken when a
screen size change occurs. Let's fix that.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/vt/vt.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1272,6 +1272,7 @@ static int vc_do_resize(struct tty_struc
 	if (con_is_visible(vc))
 		update_screen(vc);
 	vt_event_post(VT_EVENT_RESIZE, vc->vc_num, vc->vc_num);
+	notify_update(vc);
 	return err;
 }
 


