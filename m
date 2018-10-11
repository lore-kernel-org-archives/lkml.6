Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2028C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D7B2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2fW4laK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D7B2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbeJKXNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:13:51 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9582B21476;
        Thu, 11 Oct 2018 15:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272766;
        bh=pFh0cmYqQtvHgO6cy/AB0/Y0F6Ks8uWZYGbTZN20ieA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W2fW4laKYBO9aLOMtTRCTLbu1T5DSxMlsxo5iBeRQMpGAzmgOgN3k5rndG9HtWq8K
         hsq5yLS20PmE0chjFiPxWt0ttI8WjNdD2/5JK/jh3kMbh67YKtkuKuRFhHCpKcvGBe
         UTZZ9MYoxmY4169M8ogjlapp+9MBm5cOVB2b5r/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Carl Huang <cjhuang@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.14 30/45] ath10k: fix use-after-free in ath10k_wmi_cmd_send_nowait
Date:   Thu, 11 Oct 2018 17:39:57 +0200
Message-Id: <20181011152510.203844200@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152508.885515042@linuxfoundation.org>
References: <20181011152508.885515042@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Carl Huang <cjhuang@codeaurora.org>

commit 9ef0f58ed7b4a55da4a64641d538e0d9e46579ac upstream.

The skb may be freed in tx completion context before
trace_ath10k_wmi_cmd is called. This can be easily captured when
KASAN(Kernel Address Sanitizer) is enabled. The fix is to move
trace_ath10k_wmi_cmd before the send operation. As the ret has no
meaning in trace_ath10k_wmi_cmd then, so remove this parameter too.

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Tested-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ath/ath10k/trace.h |   12 ++++--------
 drivers/net/wireless/ath/ath10k/wmi.c   |    2 +-
 2 files changed, 5 insertions(+), 9 deletions(-)

--- a/drivers/net/wireless/ath/ath10k/trace.h
+++ b/drivers/net/wireless/ath/ath10k/trace.h
@@ -152,10 +152,9 @@ TRACE_EVENT(ath10k_log_dbg_dump,
 );
 
 TRACE_EVENT(ath10k_wmi_cmd,
-	TP_PROTO(struct ath10k *ar, int id, const void *buf, size_t buf_len,
-		 int ret),
+	TP_PROTO(struct ath10k *ar, int id, const void *buf, size_t buf_len),
 
-	TP_ARGS(ar, id, buf, buf_len, ret),
+	TP_ARGS(ar, id, buf, buf_len),
 
 	TP_STRUCT__entry(
 		__string(device, dev_name(ar->dev))
@@ -163,7 +162,6 @@ TRACE_EVENT(ath10k_wmi_cmd,
 		__field(unsigned int, id)
 		__field(size_t, buf_len)
 		__dynamic_array(u8, buf, buf_len)
-		__field(int, ret)
 	),
 
 	TP_fast_assign(
@@ -171,17 +169,15 @@ TRACE_EVENT(ath10k_wmi_cmd,
 		__assign_str(driver, dev_driver_string(ar->dev));
 		__entry->id = id;
 		__entry->buf_len = buf_len;
-		__entry->ret = ret;
 		memcpy(__get_dynamic_array(buf), buf, buf_len);
 	),
 
 	TP_printk(
-		"%s %s id %d len %zu ret %d",
+		"%s %s id %d len %zu",
 		__get_str(driver),
 		__get_str(device),
 		__entry->id,
-		__entry->buf_len,
-		__entry->ret
+		__entry->buf_len
 	)
 );
 
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -1741,8 +1741,8 @@ int ath10k_wmi_cmd_send_nowait(struct at
 	cmd_hdr->cmd_id = __cpu_to_le32(cmd);
 
 	memset(skb_cb, 0, sizeof(*skb_cb));
+	trace_ath10k_wmi_cmd(ar, cmd_id, skb->data, skb->len);
 	ret = ath10k_htc_send(&ar->htc, ar->wmi.eid, skb);
-	trace_ath10k_wmi_cmd(ar, cmd_id, skb->data, skb->len, ret);
 
 	if (ret)
 		goto err_pull;


