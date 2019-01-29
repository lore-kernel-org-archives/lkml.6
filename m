Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E417C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DF52086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762377;
	bh=tqAJGrhMA90Yf4s/2CacRgUZ33F+3yz4+OFZ0HbtTks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z9x+M25vXO1rj0CiU3dsfYQlxd6zTOm1Gb9iqUR7upLAoD1ogthkt1frlh6idSmgG
	 Fy6zT6xQcd9IVNGxijwPsu5mHxntx1l/nk+CbZTjOhb83HtBsCO1PzZrKBEZitldJi
	 HScOS1oaB7OEUkacG9tN1ClsRnfB46OtIdXJGarw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbfA2LqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:46:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:36712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730946AbfA2LqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:46:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6742B2083B;
        Tue, 29 Jan 2019 11:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762368;
        bh=tqAJGrhMA90Yf4s/2CacRgUZ33F+3yz4+OFZ0HbtTks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZI+NHYMxcLJO3vhKWPsx4rq/ox0cmcsu+COIBFQbjw1HtC300BhUopRBMH0uZvnjt
         adV8XuoXj1/QI9ne7kuH+X0l2AlrI7y+00c4Zb6ITnHRkV1EWqkNMjyQiuit/O3AC7
         IEgqxRn9Y+CELjQc0uow+GEISuXt4Ozc1A0YOArE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Pitre <nico@linaro.org>
Subject: [PATCH 4.19 084/103] vt: invoke notifier on screen size change
Date:   Tue, 29 Jan 2019 12:36:01 +0100
Message-Id: <20190129113206.528632879@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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
@@ -1275,6 +1275,7 @@ static int vc_do_resize(struct tty_struc
 	if (con_is_visible(vc))
 		update_screen(vc);
 	vt_event_post(VT_EVENT_RESIZE, vc->vc_num, vc->vc_num);
+	notify_update(vc);
 	return err;
 }
 


