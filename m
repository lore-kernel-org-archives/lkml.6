Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1039C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A61420875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SMLgLTTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A61420875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932898AbeGIIl6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:41:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41401 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754577AbeGIIhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:37:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id b12-v6so13262173edt.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 01:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dxw7RhKH32bD9BwdC11ASS4OlqJNJtzr01eI+q5TI6I=;
        b=SMLgLTTu5+hQr6yOhjlEqAE/Kw3hUCs+f2+3Sl9kkce73Ohe0sloq2FIh8TnyqP73T
         /13/ZZYMl+ayfPOWpjb7IxeNUAoj+gUuzbYsQEev7skz6vgEVXFFblmwmReuVMIxxtqf
         uEfVHbBknjf2jVorbuYc6FZkEwC9dKdNR6hy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dxw7RhKH32bD9BwdC11ASS4OlqJNJtzr01eI+q5TI6I=;
        b=SROhLwxtV1IYs9FNq014ilFpbDTeWWkZCLkvqdvIG0klMSbwfVSImrieM5mIgvlv1r
         UvImZnHXQP7hWBCrzZKdV2agdx9sh7A6vVYP2VzcuCOA1y8Nv/Tzzb720xyc/taJRU+r
         U7u/kFShCRYxuZ27nlkV4V1wyJGvG6tulwZLGLS7C2E5fFbmQmsPeDpIDHJ7IlX6zWi5
         wsmWyb+Y6MDkEnxBuFP4aAwY9DMVV9CN+W56EZ4PuDp+SEGjO0X6LLUtjgRBFGcM02PN
         M41YS6m27XZ64Wkhe1bW9QO/HK5QzU8N0faZmkj7zE6eWPF9H1msi/xrN6wEoEbGRp2N
         44tg==
X-Gm-Message-State: APt69E3WGhCqGnLh/5RdJFpcMzrkclawv942ee7dPO/bFdtZ0J3Xhn2K
        4Ieww6eJtkcJt0IomVEIzA1JN+oc
X-Google-Smtp-Source: AAOMgpdKhJPy6E4pM2fGyj8fcKRRtaFsBgT4QS7CFskpjK4dAnKPcK+Fjr1unwIdaHM1bwzq6R3D3A==
X-Received: by 2002:a50:9dcb:: with SMTP id l11-v6mr5248265edk.234.1531125428474;
        Mon, 09 Jul 2018 01:37:08 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id 8-v6sm340067edv.77.2018.07.09.01.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 01:37:07 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH 10/12] pci: use for_each_if
Date:   Mon,  9 Jul 2018 10:36:48 +0200
Message-Id: <20180709083650.23549-10-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids the inverted condition compared to the open-coded version.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 include/linux/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b2fb38..1484471ed048 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -601,7 +601,7 @@ static inline bool pci_is_bridge(struct pci_dev *dev)
 
 #define for_each_pci_bridge(dev, bus)				\
 	list_for_each_entry(dev, &bus->devices, bus_list)	\
-		if (!pci_is_bridge(dev)) {} else
+		for_each_if (pci_is_bridge(dev))
 
 static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
 {
-- 
2.18.0

