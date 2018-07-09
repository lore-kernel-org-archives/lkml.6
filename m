Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2964C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90B020875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GaZ/7hxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90B020875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932903AbeGIImg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:42:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44239 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754574AbeGIIhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:37:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id d17-v6so1198828eds.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 01:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=607ngiR7GJWd54iJ6atEwnm5vRYqqMJLNDix3AgXbFU=;
        b=GaZ/7hxFzI6K9iamP/xdHcDDiWTvfssU1O4o5GYO4bz4p/kcmHVgqKegVNKuiXIr2y
         L55wkfPDqUeiQQIBLIJ2ZLcFyA6w29NLNMDoSvlMC30TsiTFztRQLFfbAz6w2pu+b6Z3
         omSEGA5WCPOXcFTVqdzFA++YnE+qviIOmI4Gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=607ngiR7GJWd54iJ6atEwnm5vRYqqMJLNDix3AgXbFU=;
        b=i0IKJ+IbHqlEQy1sho/aP8Tbz3c8REIRY6d0hx+zklgfo92ht1WSK5KnU5pEiFYGcl
         knNNKR+YcB5FhEph5ky7ZHe0stlT6++9xkCd2Ozg+3gGb6gBEk13C+s+L7skiM9lY0Rj
         UVkprwHhdi2ImqQ6Z5M8mkuIJNRpoIFlxXaypUR7Wy3ok9fZWFa1cXx61rQSIy3QCx4W
         /vii9QWR/e38PXDffY8GA0xsF8pdJoKsmzUBTUjFDnJRgha1CYLh/MufEshDfc+NcRN5
         vzQB3EfqiVe6P/xpDW8yGUcoToV1X1nDZTUKtn5vjoj/+2aldQSbztCJ3tConMAf/Cs8
         Td8w==
X-Gm-Message-State: APt69E3BJsPdwA4DeNEZWB8Fg/1DKWieYQR3yGXlqngZeSFUcN0RQ44R
        5XHIUhyyP06aQtCaAdzSrSbP678B
X-Google-Smtp-Source: AAOMgpfeaLpsMczLfb2+MPzhVByFaFPUEvju+zfZpTgqnTGbTnML0cZbDHcgpRYfP5OQeJ/+GPivfg==
X-Received: by 2002:a50:a2e5:: with SMTP id 92-v6mr19989986edm.106.1531125427354;
        Mon, 09 Jul 2018 01:37:07 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id 8-v6sm340067edv.77.2018.07.09.01.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 01:37:06 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH 09/12] nubus: use for_each_if
Date:   Mon,  9 Jul 2018 10:36:47 +0200
Message-Id: <20180709083650.23549-9-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids the inverted check compared to the open-coded version.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Finn Thain <fthain@telegraphics.com.au>
Cc: linux-m68k@lists.linux-m68k.org
---
 include/linux/nubus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nubus.h b/include/linux/nubus.h
index eba50b057f6f..17fd07578ef7 100644
--- a/include/linux/nubus.h
+++ b/include/linux/nubus.h
@@ -127,7 +127,7 @@ struct nubus_rsrc *nubus_next_rsrc_or_null(struct nubus_rsrc *from);
 	for (f = nubus_first_rsrc_or_null(); f; f = nubus_next_rsrc_or_null(f))
 
 #define for_each_board_func_rsrc(b, f) \
-	for_each_func_rsrc(f) if (f->board != b) {} else
+	for_each_func_rsrc(f) for_each_if (f->board == b)
 
 /* These are somewhat more NuBus-specific.  They all return 0 for
    success and -1 for failure, as you'd expect. */
-- 
2.18.0

