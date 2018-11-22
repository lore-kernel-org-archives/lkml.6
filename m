Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B536AC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F203208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKZcCJK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F203208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437074AbeKWAcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:32:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40838 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405601AbeKWAcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:32:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so9347250wrt.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 05:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s9VHttp+ffVtRO0VFwX12BGnYzhUPOKUTXNzy66oYkg=;
        b=FKZcCJK1fHxpdkkVPrrI5rLRykhn8mbsXA/BcHNMqtZrxUGaN/Ow6+FpKzQoT2hzsA
         giipyfv02FAFJjy1hb16kjouhcn2oCMQdufcwIs8wkaWvXOH6a7m1NC8HIFMDm6aze4j
         8zj6RJbTDjVpUcaWULwzBYDcMyLzWf+OO+bgUDIuiIpM1pmzQoAGBs+AwFCp1DnFcORc
         ZO0waiU7YvphqtEM7BdlwaaNNVZCEkI/pXnBD2kVdPughqBFJ9EL4OxGnXF/34qVwZJy
         uwk672pDxnJRWPllCilM4FsJv28Z70b3drlnd2C/LHQmtnkKVjcr8icVk/QE5roUS+mE
         KJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s9VHttp+ffVtRO0VFwX12BGnYzhUPOKUTXNzy66oYkg=;
        b=azd+RAlemvN7e2d5L461WhNOYca/yJnrP0S/A4mAa/8B46Dg+avQbLwhjTC0ZjlaDP
         ZNdRwzIBuTLY8inCEEKpgqSX6A3fSFEeJaCog72/YjtKyg0ru6nkV31GQqm8P9lIZvGB
         tj5dFA5bjUdf6TKInoKiYDkQP5CV08XUOSDY1VMFsTKcGuCLLnO1S2t7+OAAPRK0NyZE
         Uo6Tmg+HKZNq57aLSdPEoqopepZp37qXcTYUN7xlpfo7Pg/7y9dJe7SXIh7qu4lMAxE4
         WaNOQQQzx5ATUEj7tl36+jbwMev5vJZFw+TYbjvA9rM/Mrh/6oTJ/pom3xPyzK9/EP8H
         r34w==
X-Gm-Message-State: AA+aEWZjzTWuRWfWeDsqthhou0fikaNfaDy//uTnBJNVf8a2NoY5sMyQ
        a0t2r7LxS0juvNu7+SjTvSc=
X-Google-Smtp-Source: AFSGD/WyHp2Q4fODYglZnt6vW0tV2RqVCylnmMT2dLzOiAZUAgpv125tKQEQyTTgtQJoo4FlSTsbbw==
X-Received: by 2002:adf:e8c1:: with SMTP id k1mr9316925wrn.104.1542894752389;
        Thu, 22 Nov 2018 05:52:32 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id c188-v6sm2393285wma.39.2018.11.22.05.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:52:31 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/8] staging: rtl8188eu: use __func__ in usb_ops_linux.c
Date:   Thu, 22 Nov 2018 14:52:11 +0100
Message-Id: <20181122135218.1703-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use __func__ instead of hardcoded function names.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/os_dep/usb_ops_linux.c  | 84 ++++++++++++-------
 1 file changed, 53 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
index d6a499692e96..f8d2b141a6c6 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
@@ -52,14 +52,16 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 
 	do {
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
-			 ("recvbuf2recvframe: rxdesc=offsset 0:0x%08x, 4:0x%08x, 8:0x%08x, C:0x%08x\n",
-			  prxstat->rxdw0, prxstat->rxdw1, prxstat->rxdw2, prxstat->rxdw4));
+			 ("%s: rxdesc=offsset 0:0x%08x, 4:0x%08x, 8:0x%08x, C:0x%08x\n",
+			  __func__, prxstat->rxdw0, prxstat->rxdw1,
+			  prxstat->rxdw2, prxstat->rxdw4));
 
 		prxstat = (struct recv_stat *)pbuf;
 
 		precvframe = rtw_alloc_recvframe(pfree_recv_queue);
 		if (!precvframe) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvbuf2recvframe: precvframe==NULL\n"));
+			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_,
+				 ("%s: precvframe==NULL\n", __func__));
 			DBG_88E("%s()-%d: rtw_alloc_recvframe() failed! RX Drop!\n", __func__, __LINE__);
 			goto _exit_recvbuf2recvframe;
 		}
@@ -83,7 +85,8 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 		pkt_offset = RXDESC_SIZE + pattrib->drvinfo_sz + pattrib->shift_sz + pattrib->pkt_len;
 
 		if ((pattrib->pkt_len <= 0) || (pkt_offset > transfer_len)) {
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("recvbuf2recvframe: pkt_len<=0\n"));
+			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
+				 ("%s: pkt_len<=0\n", __func__));
 			DBG_88E("%s()-%d: RX Warning!,pkt_len<=0 or pkt_offset> transfer_len\n", __func__, __LINE__);
 			rtw_free_recvframe(precvframe, pfree_recv_queue);
 			goto _exit_recvbuf2recvframe;
@@ -121,7 +124,8 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 			memcpy(pkt_copy->data, (pbuf + pattrib->drvinfo_sz + RXDESC_SIZE), skb_len);
 			skb_put(precvframe->pkt, skb_len);
 		} else {
-			DBG_88E("recvbuf2recvframe: alloc_skb fail , drop frag frame\n");
+			DBG_88E("%s: alloc_skb fail , drop frag frame\n",
+				__func__);
 			rtw_free_recvframe(precvframe, pfree_recv_queue);
 			goto _exit_recvbuf2recvframe;
 		}
@@ -143,7 +147,8 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 				update_recvframe_phyinfo_88e(precvframe, pphy_status);
 			if (rtw_recv_entry(precvframe) != _SUCCESS) {
 				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_,
-					("recvbuf2recvframe: rtw_recv_entry(precvframe) != _SUCCESS\n"));
+					 ("%s: rtw_recv_entry(precvframe) != _SUCCESS\n",
+					 __func__));
 			}
 		} else if (pattrib->pkt_rpt_type == TX_REPORT1) {
 			/* CCX-TXRPT ack for xmit mgmt frames. */
@@ -206,7 +211,9 @@ static int usbctrl_vendorreq(struct adapter *adapt, u8 request, u16 value, u16 i
 	int vendorreq_times = 0;
 
 	if ((adapt->bSurpriseRemoved) || (adapt->pwrctrlpriv.pnp_bstop_trx)) {
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usbctrl_vendorreq:(adapt->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n"));
+		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
+			 ("%s:(adapt->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n",
+			  __func__));
 		status = -EPERM;
 		goto exit;
 	}
@@ -348,12 +355,13 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 	struct adapter	*adapt = (struct adapter *)precvbuf->adapter;
 	struct recv_priv *precvpriv = &adapt->recvpriv;
 
-	RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_read_port_complete!!!\n"));
+	RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("%s!!!\n", __func__));
 
 	if (adapt->bSurpriseRemoved || adapt->bDriverStopped || adapt->bReadPortCancel) {
 		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-			 ("usb_read_port_complete:bDriverStopped(%d) OR bSurpriseRemoved(%d)\n",
-			 adapt->bDriverStopped, adapt->bSurpriseRemoved));
+			 ("%s:bDriverStopped(%d) OR bSurpriseRemoved(%d)\n",
+			 __func__, adapt->bDriverStopped,
+			 adapt->bSurpriseRemoved));
 
 		precvbuf->reuse = true;
 		DBG_88E("%s() RX Warning! bDriverStopped(%d) OR bSurpriseRemoved(%d) bReadPortCancel(%d)\n",
@@ -365,7 +373,8 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 	if (purb->status == 0) { /* SUCCESS */
 		if ((purb->actual_length > MAX_RECVBUF_SZ) || (purb->actual_length < RXDESC_SIZE)) {
 			RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-				 ("usb_read_port_complete: (purb->actual_length > MAX_RECVBUF_SZ) || (purb->actual_length < RXDESC_SIZE)\n"));
+				 ("%s: (purb->actual_length > MAX_RECVBUF_SZ) || (purb->actual_length < RXDESC_SIZE)\n",
+				 __func__));
 			precvbuf->reuse = true;
 			usb_read_port(adapt, RECV_BULK_IN_ADDR, precvbuf);
 			DBG_88E("%s()-%d: RX Warning!\n", __func__, __LINE__);
@@ -381,9 +390,11 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 			usb_read_port(adapt, RECV_BULK_IN_ADDR, precvbuf);
 		}
 	} else {
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_read_port_complete : purb->status(%d) != 0\n", purb->status));
+		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
+			 ("%s : purb->status(%d) != 0\n",
+			  __func__, purb->status));
 
-		DBG_88E("###=> usb_read_port_complete => urb status(%d)\n", purb->status);
+		DBG_88E("###=> %s => urb status(%d)\n", __func__, purb->status);
 		skb_put(precvbuf->pskb, purb->actual_length);
 		precvbuf->pskb = NULL;
 
@@ -396,7 +407,8 @@ static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
 			/* fall through */
 		case -ENOENT:
 			adapt->bDriverStopped = true;
-			RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_read_port_complete:bDriverStopped=true\n"));
+			RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
+				 ("%s:bDriverStopped=true\n", __func__));
 			break;
 		case -EPROTO:
 		case -EOVERFLOW:
@@ -426,13 +438,14 @@ u32 usb_read_port(struct adapter *adapter, u32 addr, struct recv_buf *precvbuf)
 	if (adapter->bDriverStopped || adapter->bSurpriseRemoved ||
 	    adapter->pwrctrlpriv.pnp_bstop_trx) {
 		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-			 ("usb_read_port:(adapt->bDriverStopped ||adapt->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n"));
+			 ("%s:(adapt->bDriverStopped ||adapt->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n",
+			  __func__));
 		return _FAIL;
 	}
 
 	if (!precvbuf) {
 		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-			 ("usb_read_port:precvbuf==NULL\n"));
+			 ("%s:precvbuf==NULL\n", __func__));
 		return _FAIL;
 	}
 
@@ -447,7 +460,7 @@ u32 usb_read_port(struct adapter *adapter, u32 addr, struct recv_buf *precvbuf)
 		precvbuf->pskb = netdev_alloc_skb(adapter->pnetdev, MAX_RECVBUF_SZ);
 		if (!precvbuf->pskb) {
 			RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("init_recvbuf(): alloc_skb fail!\n"));
-			DBG_88E("#### usb_read_port() alloc_skb fail!#####\n");
+			DBG_88E("#### %s() alloc_skb fail!#####\n", __func__);
 			return _FAIL;
 		}
 	} else { /* reuse skb */
@@ -590,8 +603,9 @@ static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped ||
 	    padapter->bWritePortCancel) {
 		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-			 ("usb_write_port_complete:bDriverStopped(%d) OR bSurpriseRemoved(%d)",
-			 padapter->bDriverStopped, padapter->bSurpriseRemoved));
+			 ("%s:bDriverStopped(%d) OR bSurpriseRemoved(%d)",
+			  __func__, padapter->bDriverStopped,
+			  padapter->bSurpriseRemoved));
 		DBG_88E("%s(): TX Warning! bDriverStopped(%d) OR bSurpriseRemoved(%d) bWritePortCancel(%d) pxmitbuf->ext_tag(%x)\n",
 			__func__, padapter->bDriverStopped,
 			padapter->bSurpriseRemoved, padapter->bReadPortCancel,
@@ -601,12 +615,15 @@ static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
 	}
 
 	if (purb->status) {
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_write_port_complete : purb->status(%d) != 0\n", purb->status));
-		DBG_88E("###=> urb_write_port_complete status(%d)\n", purb->status);
+		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
+			 ("%s : purb->status(%d) != 0\n",
+			  __func__, purb->status));
+		DBG_88E("###=> %s status(%d)\n", __func__, purb->status);
 		if ((purb->status == -EPIPE) || (purb->status == -EPROTO)) {
 			sreset_set_wifi_error_status(padapter, USB_WRITE_PORT_FAIL);
 		} else if (purb->status == -EINPROGRESS) {
-			RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_write_port_complete: EINPROGRESS\n"));
+			RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
+				 ("%s: EINPROGRESS\n", __func__));
 			goto check_completion;
 		} else if (purb->status == -ENOENT) {
 			DBG_88E("%s: -ENOENT\n", __func__);
@@ -615,15 +632,17 @@ static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
 			DBG_88E("%s: -ECONNRESET\n", __func__);
 			goto check_completion;
 		} else if (purb->status == -ESHUTDOWN) {
-			RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_write_port_complete: ESHUTDOWN\n"));
+			RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
+				 ("%s: ESHUTDOWN\n", __func__));
 			padapter->bDriverStopped = true;
-			RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_write_port_complete:bDriverStopped = true\n"));
+			RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
+				 ("%s:bDriverStopped = true\n", __func__));
 			goto check_completion;
 		} else {
 			padapter->bSurpriseRemoved = true;
 			DBG_88E("bSurpriseRemoved = true\n");
-			RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_write_port_complete:bSurpriseRemoved = true\n"));
-
+			RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
+				 ("%s:bSurpriseRemoved = true\n", __func__));
 			goto check_completion;
 		}
 	}
@@ -650,12 +669,13 @@ u32 usb_write_port(struct adapter *padapter, u32 addr, u32 cnt, struct xmit_buf
 	struct xmit_frame *pxmitframe = (struct xmit_frame *)xmitbuf->priv_data;
 	struct usb_device *pusbd = pdvobj->pusbdev;
 
-	RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("+usb_write_port\n"));
+	RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("+%s\n", __func__));
 
 	if ((padapter->bDriverStopped) || (padapter->bSurpriseRemoved) ||
 	    (padapter->pwrctrlpriv.pnp_bstop_trx)) {
 		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
-			 ("usb_write_port:( padapter->bDriverStopped ||padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n"));
+			 ("%s:( padapter->bDriverStopped ||padapter->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n",
+			  __func__));
 		rtw_sctx_done_err(&xmitbuf->sctx, RTW_SCTX_DONE_TX_DENY);
 		goto exit;
 	}
@@ -703,8 +723,10 @@ u32 usb_write_port(struct adapter *padapter, u32 addr, u32 cnt, struct xmit_buf
 	status = usb_submit_urb(purb, GFP_ATOMIC);
 	if (status) {
 		rtw_sctx_done_err(&xmitbuf->sctx, RTW_SCTX_DONE_WRITE_PORT_ERR);
-		DBG_88E("usb_write_port, status =%d\n", status);
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_write_port(): usb_submit_urb, status =%x\n", status));
+		DBG_88E("%s, status =%d\n", __func__, status);
+		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
+			 ("%s(): usb_submit_urb, status =%x\n",
+			  __func__, status));
 
 		switch (status) {
 		case -ENODEV:
@@ -720,7 +742,7 @@ u32 usb_write_port(struct adapter *padapter, u32 addr, u32 cnt, struct xmit_buf
 
 /*    We add the URB_ZERO_PACKET flag to urb so that the host will send the zero packet automatically. */
 
-	RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("-usb_write_port\n"));
+	RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("-%s\n", __func__));
 
 exit:
 	if (ret != _SUCCESS)
-- 
2.19.1

