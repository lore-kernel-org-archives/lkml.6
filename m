Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C61CC0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9C920818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0/otd1zV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9C920818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387669AbeKLJfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:35:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:39860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731062AbeKLITG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:06 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12EC321104;
        Sun, 11 Nov 2018 22:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975350;
        bh=Q/tCQmPKm/EEwK6NOQ4BvNLya+tSlo8rO2pzwW2/IaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0/otd1zV83SLP5bVfqzKb2M0uNjVIKIke0bTnqfjQcytvUktB1Avl/+1g50LEla/P
         8tw65IUTxnNTBEPH5uHj9BDV2KzmSvTdVNednskTlowCH5BsZo1XTBrei7dUjR0XTi
         DH5WX7QJFU681/diwAds9UxRCI0qkDlrIogeWZr4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 361/361] vga_switcheroo: Fix missing gpu_bound call at audio client registration
Date:   Sun, 11 Nov 2018 14:21:48 -0800
Message-Id: <20181111221702.369421762@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit fc09ab7a767394f9ecdad84ea6e85d68b83c8e21 upstream.

The commit 37a3a98ef601 ("ALSA: hda - Enable runtime PM only for
discrete GPU") added a new ops gpu_bound to be called when GPU gets
bound.  The patch overlooked, however, that vga_switcheroo_enable() is
called only once at GPU is bound.  When an audio client is registered
after that point, it would miss the gpu_bound call.  This leads to the
unexpected lack of runtime PM in HD-audio side.

For addressing that regression, just call gpu_bound callback manually
at vga_switcheroo_register_audio_client() when the GPU was already
bound.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201615
Fixes: 37a3a98ef601 ("ALSA: hda - Enable runtime PM only for discrete GPU")
Cc: <stable@vger.kernel.org>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/vga/vga_switcheroo.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/vga/vga_switcheroo.c
+++ b/drivers/gpu/vga/vga_switcheroo.c
@@ -380,6 +380,9 @@ int vga_switcheroo_register_audio_client
 			mutex_unlock(&vgasr_mutex);
 			return -EINVAL;
 		}
+		/* notify if GPU has been already bound */
+		if (ops->gpu_bound)
+			ops->gpu_bound(pdev, id);
 	}
 	mutex_unlock(&vgasr_mutex);
 


