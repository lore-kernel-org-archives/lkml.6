Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F97C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611C82192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUd0vBaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbfBOSQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:16:47 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:48336 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732053AbfBOSQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:16:46 -0500
Received: by mail-qt1-f201.google.com with SMTP id q3so9771489qtq.15
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 10:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=itwLbsehldOHq4BvzPhFpRMdV9CEOHnEXNws1hWrhOE=;
        b=VUd0vBaWN4gjiuRFzqX5KcYMN3W5psj+AA5mje6U8Ozc0VXNvvoqX0Z6FeEmUB3D/x
         a6vMHQkmm54nK4QmNCzpb/vuYWHI3NX7kPgaJD4fB2n35NHIrXCXyBed3e49vXoZn/Wp
         +OFooR1I+yPqeAtFHEFly8bwNxXApGh5qjBYTdw5pETFON4Naik3DQ2xQxFmFC4AEARB
         teNiP8k1ONjmSUfy4/MQOlXUVkA3zDJo0dJ6djjsC5yn25u3x94OYZM7RVCopRPvsJor
         Bz5uDcNEmpDZapi0adxRxoypBowMkHlirmY2VkSwn64ZrCiBgSb/syp6FiTymtqt8T6a
         w1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=itwLbsehldOHq4BvzPhFpRMdV9CEOHnEXNws1hWrhOE=;
        b=QZqPsPgGI37xtnexRjVhFfTkJkn1Q1cf5UFt/hUewnOQ2vLHrVEYqgyBuksySyiAPA
         L5zt+CQEqlfGnKQ3J1mFMQp4bW5jdV/tmmfo+ad7QE3cc+WU4c2TWpFq5y8+9PPlogmu
         OTira9yaZDJwuoOJDS+3Wjv8ti8YWCUAzZP237AE1+/SzCZshPpKYg1sdhSeBTmftWJS
         NscAb3sw48ThldHLz58iDxxU6tqWIc6ndlkr5mqlEeMo/J1upEXul22iBKMyEbwengwR
         hHuLM2I5qKKYte6rhFITh2KMbf4zgQCYycL8YsURXpy/tk/L8janxwe7CwttEBSv2bED
         PKhA==
X-Gm-Message-State: AHQUAube7iDwo4f/J2qcdFqdLDTXVHk9KG5+TkKLn0Ue7HmHAriimwKM
        ZlJQpM1w3zP6V4Gu1I+FLhh8SpVpPw==
X-Google-Smtp-Source: AHgI3IakPg+6M72bjwxImV0q5P/GiVeypaAn2r8Q1w7Lr7oD0DCMX6REkHdRxNzl01HJIOcBklgaxOO9Eg==
X-Received: by 2002:a0c:ae1d:: with SMTP id y29mr6067413qvc.12.1550254605689;
 Fri, 15 Feb 2019 10:16:45 -0800 (PST)
Date:   Fri, 15 Feb 2019 19:16:16 +0100
Message-Id: <20190215181616.151855-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH] visornic: use skb_put_zero() instead of open-coded version
From:   Jann Horn <jannh@google.com>
To:     David Kershner <david.kershner@unisys.com>,
        sparmaintainer@unisys.com, jannh@google.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace an open-coded version of skb_put_zero() with a call to the helper.
This is a cleanup and is also useful for potentially adding KASAN
integration to SKBs in the future.

Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/staging/unisys/visornic/visornic_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/unisys/visornic/visornic_main.c b/drivers/staging/unisys/visornic/visornic_main.c
index 5eeb4b93b45b..1c1a470d2e50 100644
--- a/drivers/staging/unisys/visornic/visornic_main.c
+++ b/drivers/staging/unisys/visornic/visornic_main.c
@@ -896,9 +896,7 @@ static netdev_tx_t visornic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	    ((skb_end_pointer(skb) - skb->data) >= ETH_MIN_PACKET_SIZE)) {
 		/* pad the packet out to minimum size */
 		padlen = ETH_MIN_PACKET_SIZE - len;
-		memset(&skb->data[len], 0, padlen);
-		skb->tail += padlen;
-		skb->len += padlen;
+		skb_put_zero(skb, padlen);
 		len += padlen;
 		firstfraglen += padlen;
 	}
-- 
2.21.0.rc0.258.g878e2cd30e-goog

