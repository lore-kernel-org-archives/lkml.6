Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC78C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84333214C5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiFv/pf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84333214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732650AbeJICGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:06:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729209AbeJICGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:06:07 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C9E720645;
        Mon,  8 Oct 2018 18:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024779;
        bh=cXXS+IJyM7zlxLrLtvq7uoZx1gmNtnKwhO0KAdXR3tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kiFv/pf/QK9r8KTQBAfVkS/HdKqmhIYEkZyJa2Ar/4+v7T8n9S+dKriJbDOFpkNuD
         Jt4GmAjg1H9VLO/7bPNt5Wgg6tDwcxcgzMtPcmUEUWH5bFi0Zu8ln/T9i/RmOWeinZ
         h/e6LXm+ZrSmUKf9k7/QD5+2K9iFE/f4Ynw2oPX8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taketo Kabe <kabe@sra-tohoku.co.jp>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.18 151/168] b43: fix DMA error related regression with proprietary firmware
Date:   Mon,  8 Oct 2018 20:32:11 +0200
Message-Id: <20181008175625.778877427@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Larry Finger <Larry.Finger@lwfinger.net>

commit 2823c8716c687d6c7e261a3a02b3cab43809fe9c upstream.

In commit 66cffd6daab7 ("b43: fix transmit failure when VT is switched"),
a condition is noted where the network controller needs to be reset. Note
that this situation happens when running the open-source firmware
(http://netweb.ing.unibs.it/~openfwwf/), plus a number of other special
conditions.

for a different card model, it is reported that this change breaks
operation running the proprietary firmware
(https://marc.info/?l=linux-wireless&m=153504546924558&w=2). Rather
than reverting the previous patch, the code is tweaked to avoid the
reset unless the open-source firmware is being used.

Fixes: 66cffd6daab7 ("b43: fix transmit failure when VT is switched")
Cc: Stable <stable@vger.kernel.org> # 4.18+
Cc: Taketo Kabe <kabe@sra-tohoku.co.jp>
Reported-and-tested-by: D. Prabhu <d.praabhu@gmail.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/broadcom/b43/dma.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/broadcom/b43/dma.c
+++ b/drivers/net/wireless/broadcom/b43/dma.c
@@ -1518,13 +1518,15 @@ void b43_dma_handle_txstatus(struct b43_
 			}
 		} else {
 			/* More than a single header/data pair were missed.
-			 * Report this error, and reset the controller to
+			 * Report this error. If running with open-source
+			 * firmware, then reset the controller to
 			 * revive operation.
 			 */
 			b43dbg(dev->wl,
 			       "Out of order TX status report on DMA ring %d. Expected %d, but got %d\n",
 			       ring->index, firstused, slot);
-			b43_controller_restart(dev, "Out of order TX");
+			if (dev->fw.opensource)
+				b43_controller_restart(dev, "Out of order TX");
 			return;
 		}
 	}


