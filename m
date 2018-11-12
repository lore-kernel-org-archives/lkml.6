Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8E3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63092241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VE7Ex/6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63092241E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbeKMIoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:44:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38407 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeKMIoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:44:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id f2-v6so9620276wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 14:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=N45uGwJI7bHihKcV0BSRFkJtCHSHOvuo/6e+W8z1m9k=;
        b=VE7Ex/6/9kTry+sUeRPNrbVWcMCQHBvanVnF/I29kPdrBnPUbVfU/cJa1yfIXMqkOg
         gxjzyWDoy1ji5drwL4SNSg9RO1tPvUNZC+Wy0jLZ3/fqqFwTlq6jYt1WLcLprfUR4wYo
         wJgPWPgQuEUG70tidTRUH4pM0uncHeYtmZNZ+mqYAyi5jxsZAExHO2vm2wSzgPD2D8Gh
         4I6TQ7IMXJKDCmRH4aLf0ZADYIi/UVylaU6iY7Xcjh++dtxZYN8su11XZZgnnF+kmyGF
         Anc709ADrjzkTE6+p9POJ/WrTObdG1dqIYoHE9V/zG9UPXEOPuvIHX1cKXvay1kavO4b
         TjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N45uGwJI7bHihKcV0BSRFkJtCHSHOvuo/6e+W8z1m9k=;
        b=obyT2xwfQk2zE0N4Qa9/cqm8Fn0G/sZyj5vluOMcpxj8Yd19e5zTqN37VedUPEPFuV
         C7qDCC+QxddCROzvLO7D2zWoOmQMp15FRdQrbDAW0MNdAdCN94/R4qWRsfruvxxAwN+O
         D96as086M4PLoS0t3M7l7vj2fql4FoYkMbPhFp6vmDmpxpdYH9qMfBf+BwyyudpTi9dY
         Q3Hr4geMdbrRUaF+SwGd7D2A1kayfeKv8gTdzEqaHdejYM8xzI/UzqDBy7uuaFDGEVd2
         VUB1vSvrr8hSoQ5bYbheWhu0xcrSKU3RpcvMTZnK5Wn+3At0moHSKrhN004kqwarAXiB
         c3mQ==
X-Gm-Message-State: AGRZ1gLObOpRiFqKPGoRebgaNY7/fr2pKsxIMSX8QiubGvE9nyeKdSMM
        79nuvgUvVep+7KCFNvV9nGI=
X-Google-Smtp-Source: AJdET5eWnGdYgDnqmP7j0I6B440pl8eI0fGd7u6Rn9hq0/ZgaHOqCDwsK18mw9CeRkWDf50qP6oCoQ==
X-Received: by 2002:a1c:df05:: with SMTP id w5mr1250343wmg.37.1542062950089;
        Mon, 12 Nov 2018 14:49:10 -0800 (PST)
Received: from localhost ([95.239.98.134])
        by smtp.gmail.com with ESMTPSA id u14-v6sm20357818wrs.27.2018.11.12.14.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 14:49:09 -0800 (PST)
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Cristian Sicilia <sicilia.cristian@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] staging: rtlwifi: Add spaces to match open parenthesis
Date:   Mon, 12 Nov 2018 23:48:48 +0100
Message-Id: <1542062928-27168-1-git-send-email-sicilia.cristian@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added before parameters some spaces to match open parenthesis
on previous line.

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/rtlwifi/ps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtlwifi/ps.c b/drivers/staging/rtlwifi/ps.c
index 0ca0532..5118773 100644
--- a/drivers/staging/rtlwifi/ps.c
+++ b/drivers/staging/rtlwifi/ps.c
@@ -245,7 +245,7 @@ void rtl_ips_nic_off_wq_callback(void *data)
 			/* call before RF off */
 			if (rtlpriv->cfg->ops->get_btc_status())
 				rtlpriv->btcoexist.btc_ops->btc_ips_notify(rtlpriv,
-									ppsc->inactive_pwrstate);
+									   ppsc->inactive_pwrstate);
 
 			/*rtl_pci_reset_trx_ring(hw); */
 			_rtl_ps_inactive_ps(hw);
@@ -291,7 +291,7 @@ void rtl_ips_nic_on(struct ieee80211_hw *hw)
 				rtlpriv->phydm.ops->phydm_reset_dm(rtlpriv);
 			if (rtlpriv->cfg->ops->get_btc_status())
 				rtlpriv->btcoexist.btc_ops->btc_ips_notify(rtlpriv,
-									ppsc->inactive_pwrstate);
+									   ppsc->inactive_pwrstate);
 		}
 	}
 	mutex_unlock(&rtlpriv->locks.ips_mutex);
-- 
2.7.4

