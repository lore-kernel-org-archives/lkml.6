Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EE1ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9F521470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyptY1WX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9F521470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbeJTCIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:08:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45843 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeJTCIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:08:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id f17-v6so6560957wrs.12;
        Fri, 19 Oct 2018 11:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H43jQQ9aoa736fWh0dLvkcGDoxAAPBNJaHKuMmiMVi0=;
        b=ZyptY1WXSkSZSYu/E7p38My6imLq7N31hQxhezwAvh9uhAKhUjm5jL5Q26fuhcH9+v
         W59gB5m04smYl47v05UD5E+KIhVK1VnhlGDGEkKXZBMqmtk7qMWDgOKlhZSnOlNbDUS2
         MAFV4aNGIIl6QDS7pv8EoIHwHud9quJ5XsDFxcBFHrAuJOZg8sCXnQ8E7f6iyfe+Ym6d
         MRAEbZXCoyNULMevbv7Ub0o2WSa7xxgc5JIStWFK5cseLN9g87++AmmjoG9FrirWpXcA
         MPamCU8CCzVs03kqJcuc8nq9xKqQYr1yi0SbxHoXrvLUNIvbQCdLYu39IbWdgbzIh5K5
         PjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H43jQQ9aoa736fWh0dLvkcGDoxAAPBNJaHKuMmiMVi0=;
        b=ay+yjxjOIeOZ7LdhWTyGurEqj3vziO+ZnJFwN0PRmVpC0FR8xu+QxArCwW+gOCXZZy
         6FJK3ExDpthXwD6IC5NhVMzc6nig/ykdbgru+d/pKxIS3cbotvn2/JAyYyxveXFEDu14
         hm0rPz/4vsm3ak90TJQvo22toJ7xqqIt9TXZTeMtMLqSt2ELwMzCPJFU/OPHtJRljrTC
         so1X3K40ayo3CF+5QZ92YsbFLDncSta7HmRAjMe8SbqjbCQyWtCWCz6ysszK4OXFo5im
         wOK/suI7pUqKkEWiu9Awue9n+CwSurc9p88TCqENQIyIpsclMJHLNt/zZ7wrhzu5YAJV
         nCKw==
X-Gm-Message-State: ABuFfoj+VnQraPXdLk/utF7hVduhuELE8CvbXSkw+4oNuZZPFGyXLX+P
        /OWxjlnVeWHeNUju/wIidwM=
X-Google-Smtp-Source: ACcGV63KfQTvGg7KOYLWC8UmJBjqwGrlu1eY7FSqiX49QFnbPDF5rc51eGN6+RRCAH633n/Wh5NvpQ==
X-Received: by 2002:adf:fc8d:: with SMTP id g13-v6mr13929117wrr.172.1539972057653;
        Fri, 19 Oct 2018 11:00:57 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id v184-v6sm2895621wme.3.2018.10.19.11.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 11:00:56 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Karsten Keil <isdn@linux-pingi.de>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] mISDN: Fix type of switch control variable in ctrl_teimanager
Date:   Fri, 19 Oct 2018 11:00:30 -0700
Message-Id: <20181019180030.920-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns (trimmed for brevity):

drivers/isdn/mISDN/tei.c:1193:7: warning: overflow converting case value
to switch condition type (2147764552 to 18446744071562348872) [-Wswitch]
        case IMHOLD_L1:
             ^
drivers/isdn/mISDN/tei.c:1187:7: warning: overflow converting case value
to switch condition type (2147764550 to 18446744071562348870) [-Wswitch]
        case IMCLEAR_L2:
             ^
2 warnings generated.

The root cause is that the _IOC macro can generate really large numbers,
which don't find into type int. My research into how GCC and Clang are
handling this at a low level didn't prove fruitful and surveying the
kernel tree shows that aside from here and a few places in the scsi
subsystem, everything that uses _IOC is at least of type 'unsigned int'.
Make that change here because as nothing in this function cares about
the signedness of the variable and it removes ambiguity, which is never
good when dealing with compilers.

While we're here, remove the unnecessary local variable ret (just return
-EINVAL and 0 directly).

Link: https://github.com/ClangBuiltLinux/linux/issues/67
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/isdn/mISDN/tei.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/isdn/mISDN/tei.c b/drivers/isdn/mISDN/tei.c
index 12d9e5f4beb1..58635b5f296f 100644
--- a/drivers/isdn/mISDN/tei.c
+++ b/drivers/isdn/mISDN/tei.c
@@ -1180,8 +1180,7 @@ static int
 ctrl_teimanager(struct manager *mgr, void *arg)
 {
 	/* currently we only have one option */
-	int	*val = (int *)arg;
-	int	ret = 0;
+	unsigned int *val = (unsigned int *)arg;
 
 	switch (val[0]) {
 	case IMCLEAR_L2:
@@ -1197,9 +1196,9 @@ ctrl_teimanager(struct manager *mgr, void *arg)
 			test_and_clear_bit(OPTION_L1_HOLD, &mgr->options);
 		break;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-	return ret;
+	return 0;
 }
 
 /* This function does create a L2 for fixed TEI in NT Mode */
-- 
2.19.1

