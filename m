Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C810EC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983CA2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276874;
	bh=0n9Zpp9Bm41F/3l95dbF6y+n3WZrMa/9x4EusQ9Yhg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gEXl5/W0Y/J9iVKSZmUAPCbuKHpPpQRqQaXhOtXt0TP01O1VZwa+BdPwglrNEb6r4
	 U9+poUmM8gcWVaWemr7JLmYzNiRKlIMyuBLhCInkuy/KA/vPsG+KhQBMb2R9YCJtZX
	 lrcQyozMVxeZ6oE/7h5sG/k49qeO2nJSgOzleGpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfBDKlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:41:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729407AbfBDKlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:41:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 843B02070C;
        Mon,  4 Feb 2019 10:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276869;
        bh=0n9Zpp9Bm41F/3l95dbF6y+n3WZrMa/9x4EusQ9Yhg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J13S53UEALaD9i5wGWKlRdeOtsRD1hc67MbhWtXAI/MSXQCnPIrIOPdlNf3Rku2+Y
         +5BrXBI+K0wIcfHehlPODy0PIq4b483QNTvhY0XUkihT/GbjBJeEXh46bAmuFLmYfv
         aQsyfyhav0zl0jnV5Sf9osU24pPDjqI/yWGWQqtk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Pitre <nico@linaro.org>
Subject: [PATCH 4.4 23/65] vt: invoke notifier on screen size change
Date:   Mon,  4 Feb 2019 11:36:16 +0100
Message-Id: <20190204103614.564140447@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -958,6 +958,7 @@ static int vc_do_resize(struct tty_struc
 	if (CON_IS_VISIBLE(vc))
 		update_screen(vc);
 	vt_event_post(VT_EVENT_RESIZE, vc->vc_num, vc->vc_num);
+	notify_update(vc);
 	return err;
 }
 


