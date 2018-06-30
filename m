Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AEFC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 08:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88C624BBE
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 08:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em8Z/MfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88C624BBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932914AbeF3IZU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 04:25:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38318 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752046AbeF3IZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 04:25:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id a5-v6so8501009edt.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 01:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Uxb1w9ysGHxJKjONiAhxIxksllEVmoa5kq7FWHhRlmU=;
        b=em8Z/MfOQizT6fWF9fHAAkP8HrdOrBMhHKTMPWnD9bkO0VbC0frDSjSrQGNBpBuoG2
         fCadxUl7WjB7/3VFtS+hIlmMMsaAeECOVzlqXEJbfrO6/GxNgeUU1b365q4d5iD8YyoU
         IN06/C+HSpyZXtOQ3LsxEIrbVYz5UdxhpOOT2Fqth6wRN1psRnQapzxP8o//L9c5IgsE
         KHw+lBlVF+9XQITBVI3txanwu5YSTld3ABzx+NA5tDG3ja9M70A5iMTvunrhzq0fCNMX
         sTL+p1oNzI4DJljEzSxID4cQOEGwrfLYR2m1krIMS1ka8G8jU+y2ssOqRJypo85nvYja
         zYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Uxb1w9ysGHxJKjONiAhxIxksllEVmoa5kq7FWHhRlmU=;
        b=P/v3drEokjlw4I1lUQbyMhPbftq6+FQGp+kbfak0Oi9J0NUjAl41MQiXupejC9UAWI
         hpuhH6ULzUBDhbHdbkl7AAnlVuHJSWBrJNT+VDY7tX9ICHfmpxSHzTqBiM5+TLhLG1YL
         zLVThsYB13O2DXoS+rGHVWTBIfBwAw6EPcGd7xJXJb8Kcp2Byktv2/bbs8frO4J27sU7
         D2NeHVo2lA42U+mmjE6KBXEvXGWQ8ubnIfjBYeSorGulnEMpLoZIFJcPzEp2LG8cbCkV
         BhcubM03A93fwN+zeMDw9w54JHm6WdrMBWDY13nNCKYRY0xhlgmsO4Ye9dtiUpJNIcJL
         hGUA==
X-Gm-Message-State: APt69E0F2bf18lE+kCbcXcq1Z1PXoOw3mQxuXjkWHwAP9z6Es8D/91b7
        fWAMn6IE04q70KxU7uENSNc=
X-Google-Smtp-Source: AAOMgpcdfeSSdh7GDoQ722PJAHG57BcbrQKAb7qd84OHOIKq+8p8r2tGvupA4M1NIkxTPiujJfVQpQ==
X-Received: by 2002:a50:8ee4:: with SMTP id x33-v6mr15146757edx.175.1530347114571;
        Sat, 30 Jun 2018 01:25:14 -0700 (PDT)
Received: from arch.localdomain (x4db215a8.dyn.telefonica.de. [77.178.21.168])
        by smtp.gmail.com with ESMTPSA id l4-v6sm429233edk.53.2018.06.30.01.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 01:25:14 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: fix line over 80 characters
Date:   Sat, 30 Jun 2018 10:24:52 +0200
Message-Id: <20180630082452.25696-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix line over 80 characters by replacing tab with space.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 3e7c1f07b8b4..edb678190b4b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -36,7 +36,7 @@ void _rtw_init_sta_xmit_priv(struct sta_xmit_priv *psta_xmitpriv)
 	INIT_LIST_HEAD(&psta_xmitpriv->apsd);
 }
 
-s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
+s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 {
 	int i;
 	struct xmit_buf *pxmitbuf;
-- 
2.18.0

