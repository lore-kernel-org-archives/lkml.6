Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4ECC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F14020700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896780;
	bh=6OMHWJARGIz5ndA6wiiDGYEU0FmRjK0nN3O116FWQBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aShQZPQHwqROMp/gZbP3ouPvhSaS0E5+hNdsj6SOoveEdhMz3DGZNsrqqD1DUZkHY
	 fqeLTeT56hUZ/ntKtuzlKZNdQoFrIq1h5C6G5B1ODfTHllmtYZZZLq12EkNONcs6De
	 gNt9N6AWmcESratF70tqL7wh/SMCJNvS19BnXxEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388541AbfBKOw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:52:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:39266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388525AbfBKOwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:52:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE0BF20855;
        Mon, 11 Feb 2019 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896773;
        bh=6OMHWJARGIz5ndA6wiiDGYEU0FmRjK0nN3O116FWQBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qlUhGl0qnu4HHRdpHrFFzLwuXgwhB/PuL11VSOP/lCdzb1aY0bevwdNpiDs5Vr485
         v56rGYH9ky25L7UAl3bhNDXtvuDlAq5VqS1paLCxQofcpUOgWX5CvYfe/3Ct0P7qfA
         oVfas5SSBP9Mkvj9jtzUgdeVDIMggxCLu9V8oYmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Okash Khawaja <okash.khawaja@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 297/313] staging: speakup: fix tty-operation NULL derefs
Date:   Mon, 11 Feb 2019 15:19:37 +0100
Message-Id: <20190211141912.807453080@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

From: Johan Hovold <johan@kernel.org>

commit a1960e0f1639cb1f7a3d94521760fc73091f6640 upstream.

The send_xchar() and tiocmset() tty operations are optional. Add the
missing sanity checks to prevent user-space triggerable NULL-pointer
dereferences.

Fixes: 6b9ad1c742bf ("staging: speakup: add send_xchar, tiocmset and input functionality for tty")
Cc: stable <stable@vger.kernel.org>     # 4.13
Cc: Okash Khawaja <okash.khawaja@gmail.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/speakup/spk_ttyio.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/staging/speakup/spk_ttyio.c
+++ b/drivers/staging/speakup/spk_ttyio.c
@@ -265,7 +265,8 @@ static void spk_ttyio_send_xchar(char ch
 		return;
 	}
 
-	speakup_tty->ops->send_xchar(speakup_tty, ch);
+	if (speakup_tty->ops->send_xchar)
+		speakup_tty->ops->send_xchar(speakup_tty, ch);
 	mutex_unlock(&speakup_tty_mutex);
 }
 
@@ -277,7 +278,8 @@ static void spk_ttyio_tiocmset(unsigned
 		return;
 	}
 
-	speakup_tty->ops->tiocmset(speakup_tty, set, clear);
+	if (speakup_tty->ops->tiocmset)
+		speakup_tty->ops->tiocmset(speakup_tty, set, clear);
 	mutex_unlock(&speakup_tty_mutex);
 }
 


