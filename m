Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D472C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AC62086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvE7aLoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AC62086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbeKQKBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 05:01:07 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54589 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729498AbeKQKBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 05:01:07 -0500
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so166648wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 15:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M+ItS0Ct7by+utSTjYiMJyoiz5C3I0hzrkG2llfFLX4=;
        b=gvE7aLoU86S66cDkr6SE1lrD2K2jU1c6A3V3DSJDYIx3XXbWZlof/CVCTw0rGR9nJr
         23Fsv9UK7A+cxIMN4AHTlkdwns1Eb//dhCphtiCEfSHLxkoWRFEcY32bMXsgeaaiT8Pj
         51YTT0/MxPygdfvaBSXaIqZqjf/f4AfTDEgXCxxnu8v3Ce2sjrRb7nct/HEgMyxPPoJL
         8C8oqAsE2SAsKTE4pAW/7diGJvjca3o0iSTLGsZGPji4V4mJK3S7GcH2kBOqp/n299Rn
         DmHO1vVZ9HsBtL3icTp9WUn2kXtwN4bDZxvg82+1+BgTWhusZh6tspqeXolT/0wa/vD1
         FGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M+ItS0Ct7by+utSTjYiMJyoiz5C3I0hzrkG2llfFLX4=;
        b=UyemC+AlubYvl4gO4l4JizLuXcA0GzGe1qMlwLfPK7OlsSAaVVxMYc+NPesMWGnmb/
         EUh1KRewH0v20AGJOUhVRDYdF6CWKOFemfqiSJOxPULwkMnWseHk8J7ls/SfgsjFYESt
         ubFfS1iK20uKe6BBPoSRzZAOJqGoteHhSJx2Eb8E/mv6K0vyuvhk7ohKDamuo7JOfR8R
         1f80XcIbubFFmrKY8tWFSP2X2y6wCB5gViTya57F2/BOzz8gsmzwtW9/blnc1DrLu+er
         zqBPXwrRo9H6sDjup4gvTAHwxBedwob9+RJn2wulqFze9+Ye1SvUyUl3eKAUDpAnmuRC
         WNDQ==
X-Gm-Message-State: AA+aEWaZ7PuuyB+pc0O3dY9JYJ+irtbqtqdlAiBREh430EapHUSWMEc5
        ES2zeeT+lDqLgoQ6DAWXS7I=
X-Google-Smtp-Source: AFSGD/U5tgl2chDw12UWEEOisG37X4aMah2hS0szKROw8p462chzP4OV9UJmwNmLNdaOJ4zm+xpp6A==
X-Received: by 2002:a1c:248b:: with SMTP id k133-v6mr173129wmk.148.1542411999249;
        Fri, 16 Nov 2018 15:46:39 -0800 (PST)
Received: from localhost (host102-98-dynamic.181-80-r.retail.telecomitalia.it. [80.181.98.102])
        by smtp.gmail.com with ESMTPSA id n1sm9726843wrs.21.2018.11.16.15.46.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 15:46:37 -0800 (PST)
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carmeli Tamir <carmeli.tamir@gmail.com>,
        Cristian Sicilia <sicilia.cristian@gmail.com>,
        Christopher Diaz Riveros <chrisadr@gentoo.org>,
        Arkadiusz Lis <areklis909@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: emxx_udc: Fixing function naming
Date:   Sat, 17 Nov 2018 00:46:07 +0100
Message-Id: <1542411969-26570-3-git-send-email-sicilia.cristian@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542411969-26570-1-git-send-email-sicilia.cristian@gmail.com>
References: <1542411969-26570-1-git-send-email-sicilia.cristian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix function naming and parenthesis.

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 212 ++++++++++++------------------------
 1 file changed, 70 insertions(+), 142 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 26bd77c..f391abe 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -163,11 +163,8 @@ static void _nbu2ss_ep0_complete(struct usb_ep *_ep, struct usb_request *_req)
 
 /*-------------------------------------------------------------------------*/
 /* Initialization usb_request */
-static void _nbu2ss_create_ep0_packet(
-	struct nbu2ss_udc *udc,
-	void *p_buf,
-	unsigned length
-)
+static void _nbu2ss_create_ep0_packet(struct nbu2ss_udc *udc,
+				      void *p_buf, unsigned int length)
 {
 	udc->ep0_req.req.buf		= p_buf;
 	udc->ep0_req.req.length		= length;
@@ -419,12 +416,8 @@ static void _nbu2ss_ep_dma_abort(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep)
 
 /*-------------------------------------------------------------------------*/
 /* Start IN Transfer */
-static void _nbu2ss_ep_in_end(
-	struct nbu2ss_udc *udc,
-	u32 epnum,
-	u32 data32,
-	u32 length
-)
+static void _nbu2ss_ep_in_end(struct nbu2ss_udc *udc,
+			      u32 epnum, u32 data32, u32 length)
 {
 	u32		data;
 	u32		num;
@@ -462,12 +455,9 @@ static void _nbu2ss_ep_in_end(
 
 #ifdef USE_DMA
 /*-------------------------------------------------------------------------*/
-static void _nbu2ss_dma_map_single(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req,
-	u8		direct
-)
+static void _nbu2ss_dma_map_single(struct nbu2ss_udc *udc,
+				   struct nbu2ss_ep *ep,
+				   struct nbu2ss_req *req, u8 direct)
 {
 	if (req->req.dma == DMA_ADDR_INVALID) {
 		if (req->unaligned) {
@@ -496,12 +486,9 @@ static void _nbu2ss_dma_map_single(
 }
 
 /*-------------------------------------------------------------------------*/
-static void _nbu2ss_dma_unmap_single(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req,
-	u8		direct
-)
+static void _nbu2ss_dma_unmap_single(struct nbu2ss_udc *udc,
+				     struct nbu2ss_ep *ep,
+				     struct nbu2ss_req *req, u8 direct)
 {
 	u8		data[4];
 	u8		*p;
@@ -672,10 +659,8 @@ static int EP0_receive_NULL(struct nbu2ss_udc *udc, bool pid_flag)
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_ep0_in_transfer(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_req *req
-)
+static int _nbu2ss_ep0_in_transfer(struct nbu2ss_udc *udc,
+				   struct nbu2ss_req *req)
 {
 	u8		*p_buffer;			/* IN Data Buffer */
 	u32		data;
@@ -729,10 +714,8 @@ static int _nbu2ss_ep0_in_transfer(
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_ep0_out_transfer(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_req *req
-)
+static int _nbu2ss_ep0_out_transfer(struct nbu2ss_udc *udc,
+				    struct nbu2ss_req *req)
 {
 	u8		*p_buffer;
 	u32		i_remain_size;
@@ -806,12 +789,8 @@ static int _nbu2ss_ep0_out_transfer(
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_out_dma(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_req *req,
-	u32		num,
-	u32		length
-)
+static int _nbu2ss_out_dma(struct nbu2ss_udc *udc, struct nbu2ss_req *req,
+			   u32 num, u32 length)
 {
 	dma_addr_t	p_buffer;
 	u32		mpkt;
@@ -869,12 +848,8 @@ static int _nbu2ss_out_dma(
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_epn_out_pio(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req,
-	u32		length
-)
+static int _nbu2ss_epn_out_pio(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep,
+			       struct nbu2ss_req *req, u32 length)
 {
 	u8		*p_buffer;
 	u32		i;
@@ -928,12 +903,8 @@ static int _nbu2ss_epn_out_pio(
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_epn_out_data(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req,
-	u32		data_size
-)
+static int _nbu2ss_epn_out_data(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep,
+				struct nbu2ss_req *req, u32 data_size)
 {
 	u32		num;
 	u32		i_buf_size;
@@ -958,11 +929,9 @@ static int _nbu2ss_epn_out_data(
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_epn_out_transfer(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req
-)
+static int _nbu2ss_epn_out_transfer(struct nbu2ss_udc *udc,
+				    struct nbu2ss_ep *ep,
+				    struct nbu2ss_req *req)
 {
 	u32		num;
 	u32		i_recv_length;
@@ -1014,13 +983,8 @@ static int _nbu2ss_epn_out_transfer(
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_in_dma(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req,
-	u32		num,
-	u32		length
-)
+static int _nbu2ss_in_dma(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep,
+			  struct nbu2ss_req *req, u32 num, u32 length)
 {
 	dma_addr_t	p_buffer;
 	u32		mpkt;		/* MaxPacketSize */
@@ -1090,12 +1054,8 @@ static int _nbu2ss_in_dma(
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_epn_in_pio(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req,
-	u32		length
-)
+static int _nbu2ss_epn_in_pio(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep,
+			      struct nbu2ss_req *req, u32 length)
 {
 	u8		*p_buffer;
 	u32		i;
@@ -1142,12 +1102,8 @@ static int _nbu2ss_epn_in_pio(
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_epn_in_data(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req,
-	u32		data_size
-)
+static int _nbu2ss_epn_in_data(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep,
+			       struct nbu2ss_req *req, u32 data_size)
 {
 	u32		num;
 	int		nret = 1;
@@ -1169,11 +1125,8 @@ static int _nbu2ss_epn_in_data(
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_epn_in_transfer(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req
-)
+static int _nbu2ss_epn_in_transfer(struct nbu2ss_udc *udc,
+				   struct nbu2ss_ep *ep, struct nbu2ss_req *req)
 {
 	u32		num;
 	u32		i_buf_size;
@@ -1210,11 +1163,10 @@ static int _nbu2ss_epn_in_transfer(
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_start_transfer(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req,
-	bool	bflag)
+static int _nbu2ss_start_transfer(struct nbu2ss_udc *udc,
+				  struct nbu2ss_ep *ep,
+				  struct nbu2ss_req *req,
+				  bool	bflag)
 {
 	int		nret = -EINVAL;
 
@@ -1289,9 +1241,7 @@ static void _nbu2ss_restert_transfer(struct nbu2ss_ep *ep)
 
 /*-------------------------------------------------------------------------*/
 /*	Endpoint Toggle Reset */
-static void _nbu2ss_endpoint_toggle_reset(
-	struct nbu2ss_udc *udc,
-	u8 ep_adrs)
+static void _nbu2ss_endpoint_toggle_reset(struct nbu2ss_udc *udc, u8 ep_adrs)
 {
 	u8		num;
 	u32		data;
@@ -1311,10 +1261,8 @@ static void _nbu2ss_endpoint_toggle_reset(
 
 /*-------------------------------------------------------------------------*/
 /*	Endpoint STALL set */
-static void _nbu2ss_set_endpoint_stall(
-	struct nbu2ss_udc *udc,
-	u8 ep_adrs,
-	bool bstall)
+static void _nbu2ss_set_endpoint_stall(struct nbu2ss_udc *udc,
+				       u8 ep_adrs, bool bstall)
 {
 	u8		num, epnum;
 	u32		data;
@@ -1389,11 +1337,8 @@ static void _nbu2ss_set_test_mode(struct nbu2ss_udc *udc, u32 mode)
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_set_feature_device(
-	struct nbu2ss_udc *udc,
-	u16 selector,
-	u16 wIndex
-)
+static int _nbu2ss_set_feature_device(struct nbu2ss_udc *udc,
+				      u16 selector, u16 wIndex)
 {
 	int	result = -EOPNOTSUPP;
 
@@ -1507,10 +1452,8 @@ static inline enum usb_device_speed _nbu2ss_get_speed(struct nbu2ss_udc *udc)
 }
 
 /*-------------------------------------------------------------------------*/
-static void _nbu2ss_epn_set_stall(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep
-)
+static void _nbu2ss_epn_set_stall(struct nbu2ss_udc *udc,
+				  struct nbu2ss_ep *ep)
 {
 	u8	ep_adrs;
 	u32	regdata;
@@ -1882,10 +1825,9 @@ static inline void _nbu2ss_ep0_int(struct nbu2ss_udc *udc)
 }
 
 /*-------------------------------------------------------------------------*/
-static void _nbu2ss_ep_done(
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req,
-	int status)
+static void _nbu2ss_ep_done(struct nbu2ss_ep *ep,
+			    struct nbu2ss_req *req,
+			    int status)
 {
 	struct nbu2ss_udc *udc = ep->udc;
 
@@ -1916,10 +1858,9 @@ static void _nbu2ss_ep_done(
 }
 
 /*-------------------------------------------------------------------------*/
-static inline void _nbu2ss_epn_in_int(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req)
+static inline void _nbu2ss_epn_in_int(struct nbu2ss_udc *udc,
+				      struct nbu2ss_ep *ep,
+				      struct nbu2ss_req *req)
 {
 	int	result = 0;
 	u32	status;
@@ -1960,10 +1901,9 @@ static inline void _nbu2ss_epn_in_int(
 }
 
 /*-------------------------------------------------------------------------*/
-static inline void _nbu2ss_epn_out_int(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req)
+static inline void _nbu2ss_epn_out_int(struct nbu2ss_udc *udc,
+				       struct nbu2ss_ep *ep,
+				       struct nbu2ss_req *req)
 {
 	int	result;
 
@@ -1973,10 +1913,9 @@ static inline void _nbu2ss_epn_out_int(
 }
 
 /*-------------------------------------------------------------------------*/
-static inline void _nbu2ss_epn_in_dma_int(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req)
+static inline void _nbu2ss_epn_in_dma_int(struct nbu2ss_udc *udc,
+					  struct nbu2ss_ep *ep,
+					  struct nbu2ss_req *req)
 {
 	u32		mpkt;
 	u32		size;
@@ -2010,10 +1949,9 @@ static inline void _nbu2ss_epn_in_dma_int(
 }
 
 /*-------------------------------------------------------------------------*/
-static inline void _nbu2ss_epn_out_dma_int(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req)
+static inline void _nbu2ss_epn_out_dma_int(struct nbu2ss_udc *udc,
+					   struct nbu2ss_ep *ep,
+					   struct nbu2ss_req *req)
 {
 	int		i;
 	u32		num;
@@ -2478,9 +2416,8 @@ static irqreturn_t _nbu2ss_udc_irq(int irq, void *_udc)
 
 /*-------------------------------------------------------------------------*/
 /* usb_ep_ops */
-static int nbu2ss_ep_enable(
-	struct usb_ep *_ep,
-	const struct usb_endpoint_descriptor *desc)
+static int nbu2ss_ep_enable(struct usb_ep *_ep,
+			    const struct usb_endpoint_descriptor *desc)
 {
 	u8		ep_type;
 	unsigned long	flags;
@@ -2568,9 +2505,8 @@ static int nbu2ss_ep_disable(struct usb_ep *_ep)
 }
 
 /*-------------------------------------------------------------------------*/
-static struct usb_request *nbu2ss_ep_alloc_request(
-	struct usb_ep *ep,
-	gfp_t gfp_flags)
+static struct usb_request *nbu2ss_ep_alloc_request(struct usb_ep *ep,
+						   gfp_t gfp_flags)
 {
 	struct nbu2ss_req *req;
 
@@ -2587,9 +2523,8 @@ static struct usb_request *nbu2ss_ep_alloc_request(
 }
 
 /*-------------------------------------------------------------------------*/
-static void nbu2ss_ep_free_request(
-	struct usb_ep *_ep,
-	struct usb_request *_req)
+static void nbu2ss_ep_free_request(struct usb_ep *_ep,
+				   struct usb_request *_req)
 {
 	struct nbu2ss_req *req;
 
@@ -2601,10 +2536,8 @@ static void nbu2ss_ep_free_request(
 }
 
 /*-------------------------------------------------------------------------*/
-static int nbu2ss_ep_queue(
-	struct usb_ep *_ep,
-	struct usb_request *_req,
-	gfp_t gfp_flags)
+static int nbu2ss_ep_queue(struct usb_ep *_ep,
+			   struct usb_request *_req, gfp_t gfp_flags)
 {
 	struct nbu2ss_req	*req;
 	struct nbu2ss_ep	*ep;
@@ -2709,9 +2642,7 @@ static int nbu2ss_ep_queue(
 }
 
 /*-------------------------------------------------------------------------*/
-static int nbu2ss_ep_dequeue(
-	struct usb_ep *_ep,
-	struct usb_request *_req)
+static int nbu2ss_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct nbu2ss_req	*req;
 	struct nbu2ss_ep	*ep;
@@ -3022,10 +2953,8 @@ static int nbu2ss_gad_pullup(struct usb_gadget *pgadget, int is_on)
 }
 
 /*-------------------------------------------------------------------------*/
-static int nbu2ss_gad_ioctl(
-	struct usb_gadget *pgadget,
-	unsigned int code,
-	unsigned long param)
+static int nbu2ss_gad_ioctl(struct usb_gadget *pgadget,
+			    unsigned int code, unsigned long param)
 {
 	return 0;
 }
@@ -3114,9 +3043,8 @@ static void nbu2ss_drv_ep_init(struct nbu2ss_udc *udc)
 
 /*-------------------------------------------------------------------------*/
 /* platform_driver */
-static int nbu2ss_drv_contest_init(
-	struct platform_device *pdev,
-	struct nbu2ss_udc *udc)
+static int nbu2ss_drv_contest_init(struct platform_device *pdev,
+				   struct nbu2ss_udc *udc)
 {
 	spin_lock_init(&udc->lock);
 	udc->dev = &pdev->dev;
-- 
2.7.4

