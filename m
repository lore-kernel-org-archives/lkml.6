Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E6FC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A229208EA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgZiGCWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A229208EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754956AbeFRG0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:26:10 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33041 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754884AbeFRG0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:26:08 -0400
Received: by mail-pf0-f195.google.com with SMTP id b17-v6so7642485pfi.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 23:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vC65JADnzVAHmxdvB5u1dRuunRY8QlF03TJZLf7NlQE=;
        b=rgZiGCWj6JlDpNWJZLY3Cvue2utoVdfnMUyMIG7aTjJgSPR8lG5ktpH2UwXvdGWZ7z
         /kMdyD9BDN5k6i9dPKHgQ6olZ/L8hxjW2ORmUs/nMVS9u9owfzRxCXa20hIoz0s2+ZGg
         +a33jJyvlQVz4kRtvi/uSsReuWCbCOhDugCMyvuo0wKju1mpjDlKO+7yJZlDUgNqgJPx
         OaWBxZkcml/qSuMJFEoRzEfOPAXfTIotrWDLJRpF4xP0lzku5siz2D1247IQfK9/oT4T
         9dTXwB0d6NkEVls5sa+c8/dnmQmhw8BjW7CI2oQo9mzgwMSyyGJ/z9x40jQJMUh4Q9Se
         Om0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vC65JADnzVAHmxdvB5u1dRuunRY8QlF03TJZLf7NlQE=;
        b=R80V5M+eqbFsfiqMUooTC6eT4gGGJLdGljd2k0aBchHle/V3dWAA+TkWUUouwy1+Dw
         NFSlv/eH3yWGVNR1G0zyBKGxtK5yJ4cW8dBi28bSLkluqD6hBeJlQXGokSwujHxRrHBb
         KcDLEZXL3ol/CG6WyzUA9Z+cgIKDn9M+fGwLoZDXLsiPAR6VpcWcN2knhgpPs54P53Cw
         UnIqxSxuPVGjppLGwXTrsFsbN+0rCiTdrEmMzEhI/Aps1m872YxpUNiBUcXp0mtq4OvH
         CDSgyoGclY/rH2JkmllTmrA3pL5wpw/bJyBujGXtBu0h/1YH0ERUb89lH5XpVb0d61ff
         b8Hg==
X-Gm-Message-State: APt69E3w2v07jOm2Q1qpxK3S8ueUinl/AnpszVUT8QKHd4OaeyqGvKqC
        ODIOk0nsSWpwwm/puheB53Q=
X-Google-Smtp-Source: ADUXVKIUmj+W3VfVJt1eQqGkE7CIPaEhHOu7nJYgmPn2TEX+YJ7qWve3Mv34aOzL+poXME4Wb35Drg==
X-Received: by 2002:a62:121a:: with SMTP id a26-v6mr12158361pfj.104.1529303168227;
        Sun, 17 Jun 2018 23:26:08 -0700 (PDT)
Received: from localhost.localdomain ([106.208.157.247])
        by smtp.gmail.com with ESMTPSA id l15-v6sm29830130pfg.88.2018.06.17.23.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jun 2018 23:26:07 -0700 (PDT)
From:   Janani Sankara Babu <jananis37@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     johannes.berg@intel.com, davem@davemloft.net,
        keescook@chromium.org, Rene.Hickersberger@gmx.at,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Janani Sankara Babu <jananis37@gmail.com>
Subject: [PATCH 3/3] Staging:rtl8192e Cleanup comparison to NULL
Date:   Mon, 18 Jun 2018 12:05:45 -0400
Message-Id: <1529337945-8996-1-git-send-email-jananis37@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces the comparison of var to NULL with !var

Signed-off-by: Janani Sankara Babu <jananis37@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index c6de34a..7ea9271 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -83,7 +83,7 @@ static struct sk_buff *rtllib_ADDBA(struct rtllib_device *ieee, u8 *Dst,
 	netdev_dbg(ieee->dev, "%s(): frame(%d) sentd to: %pM, ieee->dev:%p\n",
 		   __func__, type, Dst, ieee->dev);

-	if (pBA == NULL) {
+	if (!pBA) {
 		netdev_warn(ieee->dev, "pBA is NULL\n");
 		return NULL;
 	}
--
1.9.1
