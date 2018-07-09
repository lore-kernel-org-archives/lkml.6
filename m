Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B61C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021AB2084A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FcwgnvN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021AB2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754593AbeGIIhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:37:16 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40406 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbeGIIhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:37:06 -0400
Received: by mail-ed1-f65.google.com with SMTP id e19-v6so13258828edq.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 01:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ov/SM/leutMGGo1KhNLwkwH7jDC356hbqJVFsDFnB1w=;
        b=FcwgnvN6iMjZ/GRxJWkY8r9Vj131lz2tzNhy0iLYniJL7pQzzYg7WU0sCZO4xvSBtI
         +vjWyH4ZGvLRfBBI8rpLIFmxdJHt+bhU+50V6Nlmqa33zZWiCTg+u3JFBiG9zUiMalVI
         1oqj4sgdOMSFrkzKuxveVffBZKcxtEtWKFw1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ov/SM/leutMGGo1KhNLwkwH7jDC356hbqJVFsDFnB1w=;
        b=GzHJzfk6xrv6MsnCzqb3VRw7ay7w87+JzutvkYkou46pIj+BLW35lYq0+6TTz2sItx
         +tz8+GCX+pClrr3BZjIYLH5eJSVxc5M6gXuRYyo1UiGCzSdHhIOhNKaqmIcrjClKfjRy
         RwgJ71loTXVS+/juYJCBuq4d8fEid8h6KqtZd6x7XIucBoUrjeCgFxkS1FXGO6fwxZP5
         rth/bbL60JgBovh2Iz3X0V+iYqFMlN7q8hwLX2Wq9NZrsmX7P/ZGj2bc7vQ/Mo764dg1
         EIMcJEA9WnnhLvtiJLiIS7et5uXwF9cpuZBYi0w8IoMmC7TNAo1NrC+WDHZedfERRGRu
         PZOA==
X-Gm-Message-State: APt69E2NFY4yWCXWEw3OpcDOdXkamqFJqr5O6Yc3uY8Jz4ogRGfryWyQ
        WVjA7HXBPOVw3eLFsaZBD34WGiD1
X-Google-Smtp-Source: AAOMgpcNv4NGli2xb/MoJSgsPLPjMgHFstz2Xu3Ni+xp8WCuQiQGWZfVY1UAmTiiDLC9VbyK3PFVGQ==
X-Received: by 2002:aa7:da9a:: with SMTP id q26-v6mr20937602eds.115.1531125424993;
        Mon, 09 Jul 2018 01:37:04 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id 8-v6sm340067edv.77.2018.07.09.01.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 01:37:04 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org
Subject: [PATCH 07/12] ide: use for_each_if
Date:   Mon,  9 Jul 2018 10:36:45 +0200
Message-Id: <20180709083650.23549-7-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids complaints from gcc about ambigious else clauses. Not that any
of those are likely to show up in ide ...

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org
---
 include/linux/ide.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ide.h b/include/linux/ide.h
index c74b0321922a..1530d81319ef 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1601,7 +1601,7 @@ static inline void ide_set_drivedata(ide_drive_t *drive, void *data)
 
 #define ide_port_for_each_present_dev(i, dev, port) \
 	for ((i) = 0; ((dev) = (port)->devices[i]) || (i) < MAX_DRIVES; (i)++) \
-		if ((dev)->dev_flags & IDE_DFLAG_PRESENT)
+		for_each_if ((dev)->dev_flags & IDE_DFLAG_PRESENT)
 
 #define ide_host_for_each_port(i, port, host) \
 	for ((i) = 0; ((port) = (host)->ports[i]) || (i) < MAX_HOST_PORTS; (i)++)
-- 
2.18.0

