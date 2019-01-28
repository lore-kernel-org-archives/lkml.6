Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B552C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F6D20881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kg0Gf4/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387520AbfA1QNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:13:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46986 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387491AbfA1QNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:13:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so18631549wrt.13;
        Mon, 28 Jan 2019 08:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1zfoc6CoBhTv79t1tVnJWGGdH9udjSmsd+rMCNx1WR0=;
        b=Kg0Gf4/2msvShoD5YIrJ53NWsRTrporTZyCnFfSqPX5kahvwtrRIBeSzcg3R7G028y
         cEun3loSxKs/5IeRgKxgCq37y/p7GGkG7VlNjkU+opoWHHOjoZABCNWgF9RvhBh/sEYA
         EGv5kiVA51/Pwdgh3Gpk/y+eViJKweY15MXngM5ASBERzekan5CO3edeeK1WhmP8p95B
         sTsjqQFg9ell8Wfc1uPxDiwAwaiK8bSGJlSfubjdBequUULcoXydsilBB+BhztdbSziw
         BP6O8C9PaYzjlbVPohpXNog2tpUtFP/hCn3YuCk9kbcZcyUUVnlwWDIqHUz3dbcafpEh
         8mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=1zfoc6CoBhTv79t1tVnJWGGdH9udjSmsd+rMCNx1WR0=;
        b=Mv3Q3Nuix+e4pkU+LOjmvQyFLi+Qf1Bve65bcVw/xacYNI+cxHhigjkttdg+OMXo6H
         THqNfne+w+M+GnDwQurNZrNe/bqmlTb+0R+3rm+IpCJdSAg0CZRwCpARKwWb6RPMtlla
         ROZja9ZGrs8bV9Yi2QQNSYTCSbYvwSW462lyTBBsBuTa4oIEmq/Uep9ud4Btofd98/iZ
         dGcMRqEqxSdsZ4IuRdVIV37nJHyDk8rE/1HWH2SbTJEVUghEQEGQgz9Bid8FufIoWAVw
         HGqmD0tavMr/V8nYOxo+O08ISwyqBEncGq440I4I/vDZdbkLKN2ZR1BbxGbzhnhc7PTi
         k5zA==
X-Gm-Message-State: AJcUukePDrKA5FPOeLeCwhXpelZ+s8k9rU83jw8m4EfcRK+ebXTnus/O
        xL5femnVRCx/JmUStsRW/qI=
X-Google-Smtp-Source: ALg8bN75uN+qIYmUdIl09AGHrB3vPkV/b5pMzaXkadQqJV9MQZi55toiIsYm156ySHFijMWczG2pbA==
X-Received: by 2002:a5d:664a:: with SMTP id f10mr22109476wrw.311.1548692028868;
        Mon, 28 Jan 2019 08:13:48 -0800 (PST)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id l20sm246445944wrb.93.2019.01.28.08.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 08:13:48 -0800 (PST)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     linux-lpwan@lists.infradead.org,
        Ben Whitten <ben.whitten@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH lora-next 03/11] net: lora: sx130x: add CHRS to volatile register list
Date:   Mon, 28 Jan 2019 16:12:57 +0000
Message-Id: <20190128161306.27805-4-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128161306.27805-1-ben.whitten@lairdtech.com>
References: <20190128161306.27805-1-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Whitten <ben.whitten@gmail.com>

The CHRS register is used in transactions to the MCU within the SX130x,
we need to always write to it.

Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
---
 drivers/net/lora/sx130x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/lora/sx130x.c b/drivers/net/lora/sx130x.c
index 70cfb4532b51..529ca6622878 100644
--- a/drivers/net/lora/sx130x.c
+++ b/drivers/net/lora/sx130x.c
@@ -134,6 +134,7 @@ static bool sx130x_volatile_reg(struct device *dev, unsigned int reg)
 	case SX1301_MPD:
 	case SX1301_AGCSTS:
 
+	case SX1301_CHRS:
 	case SX1301_MCU_CTRL:
 
 	case SX1301_RADIO_A_SPI_DATA_RB:
-- 
2.17.1

