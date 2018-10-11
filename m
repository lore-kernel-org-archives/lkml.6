Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC71CC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A6021470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="meifHFW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A6021470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbeJKXKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:10:08 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E03721470;
        Thu, 11 Oct 2018 15:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272544;
        bh=vlEI7C2xmgST6LlMa6vcZeBTmNCpFXHinT0DpnKRn6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=meifHFW+b8ZHGBHfaObwNwP/Rd7HRSo0ZQTtEhzpbBEFaZDWuXagpdGU4Zlpwd1/4
         2xGPj7IIq8jNU9mmDa6fRc1E/EiGbecCdXxxz7GOhFUtaohE0rOf+9pg6RtYLP6u+W
         ZzRHg5pzHzuCFHaXwAD+L+80KT47jFAezLZ9qbf8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhi Chen <zhichen@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 4.4 26/27] ath10k: fix scan crash due to incorrect length calculation
Date:   Thu, 11 Oct 2018 17:35:13 +0200
Message-Id: <20181011152535.288570689@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152534.014964888@linuxfoundation.org>
References: <20181011152534.014964888@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhi Chen <zhichen@codeaurora.org>

commit c8291988806407e02a01b4b15b4504eafbcc04e0 upstream.

Length of WMI scan message was not calculated correctly. The allocated
buffer was smaller than what we expected. So WMI message corrupted
skb_info, which is at the end of skb->data. This fix takes TLV header
into account even if the element is zero-length.

Crash log:
  [49.629986] Unhandled kernel unaligned access[#1]:
  [49.634932] CPU: 0 PID: 1176 Comm: logd Not tainted 4.4.60 #180
  [49.641040] task: 83051460 ti: 8329c000 task.ti: 8329c000
  [49.646608] $ 0   : 00000000 00000001 80984a80 00000000
  [49.652038] $ 4   : 45259e89 8046d484 8046df30 8024ba70
  [49.657468] $ 8   : 00000000 804cc4c0 00000001 20306320
  [49.662898] $12   : 33322037 000110f2 00000000 31203930
  [49.668327] $16   : 82792b40 80984a80 00000001 804207fc
  [49.673757] $20   : 00000000 0000012c 00000040 80470000
  [49.679186] $24   : 00000000 8024af7c
  [49.684617] $28   : 8329c000 8329db88 00000001 802c58d0
  [49.690046] Hi    : 00000000
  [49.693022] Lo    : 453c0000
  [49.696013] epc   : 800efae4 put_page+0x0/0x58
  [49.700615] ra    : 802c58d0 skb_release_data+0x148/0x1d4
  [49.706184] Status: 1000fc03 KERNEL EXL IE
  [49.710531] Cause : 00800010 (ExcCode 04)
  [49.714669] BadVA : 45259e89
  [49.717644] PrId  : 00019374 (MIPS 24Kc)

Signed-off-by: Zhi Chen <zhichen@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ath/ath10k/wmi-tlv.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -1459,10 +1459,10 @@ ath10k_wmi_tlv_op_gen_start_scan(struct
 	bssid_len = arg->n_bssids * sizeof(struct wmi_mac_addr);
 	ie_len = roundup(arg->ie_len, 4);
 	len = (sizeof(*tlv) + sizeof(*cmd)) +
-	      (arg->n_channels ? sizeof(*tlv) + chan_len : 0) +
-	      (arg->n_ssids ? sizeof(*tlv) + ssid_len : 0) +
-	      (arg->n_bssids ? sizeof(*tlv) + bssid_len : 0) +
-	      (arg->ie_len ? sizeof(*tlv) + ie_len : 0);
+	      sizeof(*tlv) + chan_len +
+	      sizeof(*tlv) + ssid_len +
+	      sizeof(*tlv) + bssid_len +
+	      sizeof(*tlv) + ie_len;
 
 	skb = ath10k_wmi_alloc_skb(ar, len);
 	if (!skb)


