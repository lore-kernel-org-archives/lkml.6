Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CDDC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D463D20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="LuDu2+/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D463D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeJDVxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:53:30 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:52788 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbeJDVxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:53:30 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 702F1DC7
        for <linux-kernel@vger.kernel.org>; Thu,  4 Oct 2018 14:59:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZqlCzItrYSTX for <linux-kernel@vger.kernel.org>;
        Thu,  4 Oct 2018 09:59:49 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49226CF5
        for <linux-kernel@vger.kernel.org>; Thu,  4 Oct 2018 09:59:49 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id v125-v6so10813993ita.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 07:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KgOOqyF0sYgd10fuDGON9f0ufK6sIlu+JI7XXVK630U=;
        b=LuDu2+/iCj4pxWq/zMTZoTz6rLQhtUmrYVZwtlJuW0RMpiayudT7h+VebufnHKZ4Qc
         y0hczb2SzC1+7VjzXgCKw9irnqavgbqoHgDoP6uggEraEH0TCJ0iE3kuRT5NnI9USEO4
         7aWi/aLYyAXTVo/zhm4G+qXQ7W7+jpmfwqkwvT7f7TCD5G0bG8hRWtQHtzxkNtz2gsLl
         Ptta/+q30e2Mq7LaiZeABWsqIZXIE7gi3LUN7cnSECgI23dnHOKzm3mK09rhWm9KoruL
         rw+c6TVpwtHhaI78LcUtkB3MQoC2MeQFCig/isLMehjKvbotYx2LWkawcfiNkMBn+avy
         XbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KgOOqyF0sYgd10fuDGON9f0ufK6sIlu+JI7XXVK630U=;
        b=CRIH6EYKWHril+loiCuMIUXsCvckVmCSqtzTgbT/LdW2luDtN5/SB7Ab0saZoWgwG2
         lvBm4GZsRb1HGi9sQv4isPEMovEQWI+WdSfrEpFzC6iLAIAfPmtgeTyalMOtLySWUmhl
         HsvGgK9+7S7ro8kRJYGmlBrkdx4Ph5ZpeKMPoDROkbK+mKFc++oAAdYmpRhbPlc2k2sT
         MlsbG4x+F1MZexNzvDyCu0UjgZG8V17vimcIj/HPTE6nOEDGnh7lIYYjTwHbGrhYM277
         JGiOqSbYsPDX7XPTJAXOJPpyEo7t6rT3mWmsLsuIMOVKxJsftWUlNuEAj5Gzzj1SPj8E
         qPaQ==
X-Gm-Message-State: ABuFfoh7HzqFka9af9Mji80QJ0eQG2xiNpeeOjYH8QKfozm2k6mvofcd
        i8qy8cWuHvkCoK3b61GKu/a+92pq+5NvczjjEe9mzAF3Qm5w5xHx7qAxSiZSTUgBbq4XFeE3BvX
        mal2MHsPju8EEwMcwdG/MK5986eFr
X-Received: by 2002:a24:4386:: with SMTP id s128-v6mr4832546itb.151.1538665188911;
        Thu, 04 Oct 2018 07:59:48 -0700 (PDT)
X-Google-Smtp-Source: ACcGV613fWT7EqjhpFZK653TJZen7IibkvSjeh8hS1nwjjEWR1qi3a2YRwZwW46IKUqvgXLU8bZfnw==
X-Received: by 2002:a24:4386:: with SMTP id s128-v6mr4832525itb.151.1538665188729;
        Thu, 04 Oct 2018 07:59:48 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id f74-v6sm2218755itf.20.2018.10.04.07.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Oct 2018 07:59:48 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] media: dvb: fix a missing-check bug
Date:   Thu,  4 Oct 2018 09:59:36 -0500
Message-Id: <1538665177-17604-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dvb_video_write(), the first header byte of the buffer 'buf' supplied by
the user is checked to see whether 'buf' contains a TS packet, which
always starts with 0x47 for synchronization purposes. If yes, ts_play() is
called. Otherwise, dvb_play() will be called. Both of these two functions
will copy 'buf' again from the user space. However, no check is enforced
on the first byte of the copied content after the second copy. Since 'buf'
is in the user space, a malicious user can race to change the first byte
after the check in dvb_video_write() but before the second copy in
ts_play(). By doing so, the user can supply inconsistent data, which can
lead to undefined behavior in the driver.

This patch adds the required check in ts_play() to make sure the header
byte in the second copy is as expected. Otherwise an error code EINVAL will
be returned.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/media/pci/ttpci/av7110_av.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/pci/ttpci/av7110_av.c b/drivers/media/pci/ttpci/av7110_av.c
index ef1bc17..1ff6062 100644
--- a/drivers/media/pci/ttpci/av7110_av.c
+++ b/drivers/media/pci/ttpci/av7110_av.c
@@ -468,6 +468,8 @@ static ssize_t ts_play(struct av7110 *av7110, const char __user *buf,
 		}
 		if (copy_from_user(kb, buf, TS_SIZE))
 			return -EFAULT;
+		if (kb[0] != 0x47)
+			return -EINVAL;
 		write_ts_to_decoder(av7110, type, kb, TS_SIZE);
 		todo -= TS_SIZE;
 		buf += TS_SIZE;
-- 
2.7.4

