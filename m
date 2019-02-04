Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAE6C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB4C217FA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276692;
	bh=+5PbrGunI+2oV4w5WSiflID9I3F9IIP6wNVd8jSspjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gIjSIyjXpq98O/cHu+gTxhDoGGG7YGUSmkOftdWrBueDsb8h3Q87S5nbrECObMkRe
	 yCPM5skLIYHQaT0sFti5uQ0T04r9Bjz3DVKby+//ho09sY5QiXlxnzOHGG037z7D5h
	 CGMUoepWqrP6Ku6ma7NS/3qKN9y/5PBPZ9eWDOpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfBDKiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:38:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729077AbfBDKiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:38:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEDF7214DA;
        Mon,  4 Feb 2019 10:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276685;
        bh=+5PbrGunI+2oV4w5WSiflID9I3F9IIP6wNVd8jSspjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dskZYmB5H3si8rBiZ6vb2ok285sCMdsZNjg/Pyy/WF5ejT1C00gUjfXaRZRx+g5ih
         zUeGBIVt/LhXIwux0LdFTIA+zHIX1AFL1v4pp1WvNbmiIKyPMs0Qt9n1VE81ytJHU0
         ISXY9OOWTN05UhlQGR9MaN/KebJpYyNKt0V8Dmq4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Pitre <nico@linaro.org>
Subject: [PATCH 3.18 13/31] vt: invoke notifier on screen size change
Date:   Mon,  4 Feb 2019 11:36:28 +0100
Message-Id: <20190204103600.640912914@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103557.903263774@linuxfoundation.org>
References: <20190204103557.903263774@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -949,6 +949,7 @@ static int vc_do_resize(struct tty_struc
 	if (CON_IS_VISIBLE(vc))
 		update_screen(vc);
 	vt_event_post(VT_EVENT_RESIZE, vc->vc_num, vc->vc_num);
+	notify_update(vc);
 	return err;
 }
 


