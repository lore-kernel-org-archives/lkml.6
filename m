Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB0AC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2968720875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Ujzvu4GO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2968720875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932813AbeGIIly (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:41:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32845 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754580AbeGIIhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:37:12 -0400
Received: by mail-ed1-f66.google.com with SMTP id x5-v6so9594674edr.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 01:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ECSxS/Tu1J8yJoeTNndRt3Ju+K1/adxa0HpIrDBgnIk=;
        b=Ujzvu4GOI7K6XVEjopEXycGdZ9LWKakpFhS/zA0CPD15VmKmAeRsUFb4aUkqG6ANNu
         jJ/xqNqHvQQYhUD5ytsfjzRpbCm0DggwDlTLJWgAxUstiFixoLWxOaKoH+1ZnjKWcmQc
         vq7Q6iAOH+1y9XfDBcIksZUkh/fg17DGudKiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ECSxS/Tu1J8yJoeTNndRt3Ju+K1/adxa0HpIrDBgnIk=;
        b=s926yWkziPsh566qRQ9VAEw1/BQ0Q1NVRn8DC98NFPAAyvBUw1STFXsIJOd8SFnYPq
         b2wFm8vSxgWTQrqvmRXX7GJWH/7TJ/tJCX6VnOINRPs/ezSNnp8XGnjESHPcat7U3yA7
         SL5oHGXDLQepNvk0AGxl2ufY7uker9PQWnt2a47ixJA0wjUhisjBSaai2arfmX9PJH3B
         OdUxtvVJofU4RVcHzpY14SBxNvpZLegvR4Qg/+ydqGZ7RBq5FypswgJlVbEMPiDuQlOI
         nHDdpF5y6Ohw1yBR61FXxkj8vT2IXmBpdWylsmoPrGgqOpWO1/Zlf9fLjl+D/+ZA1dor
         lzmw==
X-Gm-Message-State: APt69E11Ii3UJSiWx/TvHzRcVdo9kLt8BDD4daaPbq+Vt7Gu+PR3dn4o
        AxrHFHZQv/CNnIqpWf8sJbPYvuDa
X-Google-Smtp-Source: AAOMgpfW2YyXQXz+DkEXJ3K+MK75A2gCWsR9Atbs2ObyPxL+jus6EmNmlXfd/mes5dn2XfU7YaXHBQ==
X-Received: by 2002:a50:8e09:: with SMTP id 9-v6mr81843edw.101.1531125430737;
        Mon, 09 Jul 2018 01:37:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id 8-v6sm340067edv.77.2018.07.09.01.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 01:37:10 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 12/12] usb: use for_each_if
Date:   Mon,  9 Jul 2018 10:36:50 +0200
Message-Id: <20180709083650.23549-12-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids the inverted condition compared to the open-coded version.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
---
 include/linux/usb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/usb.h b/include/linux/usb.h
index 4cdd515a4385..a9da7237c619 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -732,7 +732,7 @@ extern struct usb_device *usb_hub_find_child(struct usb_device *hdev,
 	for (port1 = 1,	child =	usb_hub_find_child(hdev, port1); \
 			port1 <= hdev->maxchild; \
 			child = usb_hub_find_child(hdev, ++port1)) \
-		if (!child) continue; else
+		for_each_if (child)
 
 /* USB device locking */
 #define usb_lock_device(udev)			device_lock(&(udev)->dev)
-- 
2.18.0

