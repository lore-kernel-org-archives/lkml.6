Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209A6C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C1F21B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898509;
	bh=cZGFX5Ht4a2et4aDTtyOA8yFoHMmEH30JKSY8aac+Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hz32ROSS0Q6Sz5HSWHdqoFwPo+RkPhshXRAbDowWPQXkmMvYmmO1xWgLA9/wgI19J
	 29g4SwxpTOg9W9mPPN6nU2sSmkantt+BbuLXox3tnGnrayeZVRg3HG4iL4cntniVGY
	 MCNmHDH9UAxMY1WDg+SCQTbQibwKRsOlajFG9Y5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390768AbfBKPEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:04:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390751AbfBKPET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:04:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C389D222AD;
        Mon, 11 Feb 2019 15:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897459;
        bh=cZGFX5Ht4a2et4aDTtyOA8yFoHMmEH30JKSY8aac+Uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cIUWNkG4iAdPStMsX6T/vZyZEY9PZ1STkVa0sAZG0dY6nqzZqklfc427TQirkI1kl
         OBV6fwvwpJIBudcnyc9+jaGphDUi2VeuOHQ8yXEmHbSyAhuFIgj5CHpaAbbyFR1TI/
         pp3cb29ABsNg4p9Irq2EWSqu20jLc1fI3DXwxvdc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Okash Khawaja <okash.khawaja@gmail.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 189/205] staging: speakup: fix tty-operation NULL derefs
Date:   Mon, 11 Feb 2019 15:19:47 +0100
Message-Id: <20190211141840.771814065@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -246,7 +246,8 @@ static void spk_ttyio_send_xchar(char ch
 		return;
 	}
 
-	speakup_tty->ops->send_xchar(speakup_tty, ch);
+	if (speakup_tty->ops->send_xchar)
+		speakup_tty->ops->send_xchar(speakup_tty, ch);
 	mutex_unlock(&speakup_tty_mutex);
 }
 
@@ -258,7 +259,8 @@ static void spk_ttyio_tiocmset(unsigned
 		return;
 	}
 
-	speakup_tty->ops->tiocmset(speakup_tty, set, clear);
+	if (speakup_tty->ops->tiocmset)
+		speakup_tty->ops->tiocmset(speakup_tty, set, clear);
 	mutex_unlock(&speakup_tty_mutex);
 }
 


