Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8FEF7C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44AF9208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTiZw4UQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44AF9208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933153AbeFLEly (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:41:54 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33474 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933032AbeFLElu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:41:50 -0400
Received: by mail-pl0-f66.google.com with SMTP id n10-v6so13617150plp.0;
        Mon, 11 Jun 2018 21:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=f4m7qOyaTR8jMyJ06iiLVjF3E3BsAYkyrEs4pmCan1U=;
        b=nTiZw4UQwL+3kBUopBe2mFsbm3W4+noSqpnXI8H1PfPeTxYxgChk+2qjgoSx4eqrac
         FQUsd7yI/t7/b/2YVOY9DCFADz2IUOwugccMPUQ9Hz8SxTT6OV3U7TL/LpeuRl4k30tN
         nTbXsHSSHHVuyypTlKlW6JjdtiFZyshvfy035WU0tPX6UBkdZaB2U6SwAcz5WGO0w1ee
         28Z7c9+u88k6HAY+wgEarEkdHDkPhAvgD2WqsEIaZaDhtPyInj2ArPRZeJLx43LTMTFt
         IycZVT+CYDWYZDhWXXVOdiW4vxFO41ppSSSVjqP45wkjuUfEgcGJ3B5BYOuLeqtDFdWg
         SCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f4m7qOyaTR8jMyJ06iiLVjF3E3BsAYkyrEs4pmCan1U=;
        b=q0gaUO/zCfSDlS9U6SZorFgi5nk3JO6uKBNvQ3oDVriRV3onFdhBTwBba3MHy244tC
         yYhVack4Z2BHDrfBUrr9r7D/nry/EaPMNcX+bwXHK7o7CnUUk4fKhfJi3CmnEY9zRYC5
         VnVyE9tu4W1DYdLPv6FgPf+UiUacLQq02R6B1/TBvnNo3W/H65TWR/0DOeLBXgHYFtPP
         6qVtBpmQrCrgD+igG9l5JVQNyUXheG2JFeeSoGvhVYHRimydWzURp5A2Gpt3KYX+RHXP
         LnYcgz/9nLSczk4I8njeLsCdnAwNmssvkxntAPoQgBTF1rLJmyOVStMj9OkLkqTkWbif
         zu0w==
X-Gm-Message-State: APt69E1jO8k7A5a/o2q3zZZSaIL9Auf0R3JjfIUEpvOHwoHxtBtQxtu/
        BK75lYfnNq/kZZCWhjurdoY=
X-Google-Smtp-Source: ADUXVKInm489ooTjwK86eOc4TXMWBvbQbcBK1jDunLJpvtKngCPT8yNgD30K/1mExHnlzcupsJC7qA==
X-Received: by 2002:a17:902:1023:: with SMTP id b32-v6mr2287037pla.145.1528778509759;
        Mon, 11 Jun 2018 21:41:49 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id c12-v6sm41445781pfi.177.2018.06.11.21.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 21:41:49 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        David Lechner <david@lechnology.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: add error handling for skb_realloc_headroom
Date:   Tue, 12 Jun 2018 12:41:41 +0800
Message-Id: <1528778503-41615-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When skb_realloc_headroom fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling skb_realloc_headroom.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/usb/gadget/function/f_rndis.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/function/f_rndis.c b/drivers/usb/gadget/function/f_rndis.c
index d48df36..17c164b 100644
--- a/drivers/usb/gadget/function/f_rndis.c
+++ b/drivers/usb/gadget/function/f_rndis.c
@@ -374,6 +374,9 @@ static struct sk_buff *rndis_add_header(struct gether *port,
 		return NULL;
 
 	skb2 = skb_realloc_headroom(skb, sizeof(struct rndis_packet_msg_type));
+	if (!skb2)
+		return NULL;
+
 	rndis_add_hdr(skb2);
 
 	dev_kfree_skb(skb);
-- 
2.7.4

