Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E413DC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E4A2176F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276722;
	bh=WZsFjzZrAnje9tgt/9878oBgIRlo4XHrGfTatQtET5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=upW0RPJlDrfLbMIXlb2qIe/WDuic74dQVgzI+C7Mla+7icabNoiG60FFZ2hXBTSiJ
	 tH97fg3C7i2VL80clm5f6rXZi9+Hrvz1zqFOqNslOBQQS+mknJPwHP2r4WF66KMuWk
	 uSQ5quBB2lfJ8la4gw2C/okpwFkTcDpddReTLPNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfBDKil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:38:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729404AbfBDKij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:38:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F0122070C;
        Mon,  4 Feb 2019 10:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276718;
        bh=WZsFjzZrAnje9tgt/9878oBgIRlo4XHrGfTatQtET5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gs3Y/jLAPAP4CxXZzu7nQ6hCKdMD/Aycrzdk9GgTVGs2bbk/3VQuEM5u5efrgXSYz
         u5a1u61uLuWkX0i03HPAeGjWjb39WKElnrFVWiVv8MYr5WLNposjPUQGX6WbvSa2Fs
         KVc1h/IJW8fsZcBSIvvFgD96buhmmawHvXnistiY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: [PATCH 3.18 06/31] tty: Handle problem if line discipline does not have receive_buf
Date:   Mon,  4 Feb 2019 11:36:21 +0100
Message-Id: <20190204103559.307272764@linuxfoundation.org>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 27cfb3a53be46a54ec5e0bd04e51995b74c90343 upstream.

Some tty line disciplines do not have a receive buf callback, so
properly check for that before calling it.  If they do not have this
callback, just eat the character quietly, as we can't fail this call.

Reported-by: Jann Horn <jannh@google.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/tty_io.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2243,7 +2243,8 @@ static int tiocsti(struct tty_struct *tt
 		return -EFAULT;
 	tty_audit_tiocsti(tty, ch);
 	ld = tty_ldisc_ref_wait(tty);
-	ld->ops->receive_buf(tty, &ch, &mbz, 1);
+	if (ld->ops->receive_buf)
+		ld->ops->receive_buf(tty, &ch, &mbz, 1);
 	tty_ldisc_deref(ld);
 	return 0;
 }


