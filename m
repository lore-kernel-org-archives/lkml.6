Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CB9C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D7F2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="UNpNKE2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D7F2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbeKCG0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:26:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38561 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeKCG0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:26:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id c1-v6so2880846ede.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 14:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=73Yrp2BJa8JllIjkFd7mlwtLDDEyf3BVxMYTOSKf0E0=;
        b=UNpNKE2o354eq6jxDmmf5nBiNgp6Twa8avsFFh21sqqSmNvYMULZGHZMyFwvldylyY
         Ba8naldVgHUFp1Nfri1HqcGFpp9kgl0ly18kUPE7xclMWkpSYN43xQqHNfCmUFl/4wbt
         Lae+7s2SA/sW0pgKUt65unmKieZ4+tNJzgOas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=73Yrp2BJa8JllIjkFd7mlwtLDDEyf3BVxMYTOSKf0E0=;
        b=jO/EGv28gsvvAHu+hIptHOSYIhGyN2eXsGa8dySvuLI9+xGwlvhZxD9+zAPU1NYs/l
         PZwlCMJoOZ9s83eUFv0UofnP55AW215O49JWfoNlKc9a7fRn49TEuaVnfqwS6MwdfOVv
         OEO918ZMMak8lRVRM8qYhduLnosInq1BzQtBjMtCM7jlrvIXkkleFiZ0PqagryGKoJjq
         YizGnZ2OlDfzXeaLqBLsnna6GyB9YbpH2qTPaZxt8iJ9HLS9JFi8Aqt/9HMWncgwoVMd
         ywaQW/pQ0c0mgHgiKy9J315YeD+jNarFQUA+aGIKBc/uUM2sBatObzD4WMcZ35FBDJSU
         OJzg==
X-Gm-Message-State: AGRZ1gJJnlSQo4qD/dhxqcoZIyKgGfKxBY1dG0Qat7KxqovfO0YFvKX8
        qyv/IijHkf7jHC6Uk4YiiapmfLsXQL8m9g==
X-Google-Smtp-Source: AJdET5eHvjN/pe6hdIfSy56WEexwDFL7vsbEJN0RaJwkw9BgBs5iutn/Hgu6ZWhFqHT5pufL42a79w==
X-Received: by 2002:a17:906:6c9:: with SMTP id v9-v6mr7400577ejb.203.1541193435250;
        Fri, 02 Nov 2018 14:17:15 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id h3-v6sm10741825ede.42.2018.11.02.14.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Nov 2018 14:17:14 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] macintosh: ans-lcd: make anslcd_logo static and __initconst
Date:   Fri,  2 Nov 2018 22:17:06 +0100
Message-Id: <20181102211707.10229-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variable has no reason to have external linkage, and since it is
only used in an __init function, it might as well be made __initconst
also.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/macintosh/ans-lcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/macintosh/ans-lcd.c b/drivers/macintosh/ans-lcd.c
index c8e078b911c7..a7a79a935f6a 100644
--- a/drivers/macintosh/ans-lcd.c
+++ b/drivers/macintosh/ans-lcd.c
@@ -147,7 +147,8 @@ static struct miscdevice anslcd_dev = {
 	&anslcd_fops
 };
 
-const char anslcd_logo[] =	"********************"  /* Line #1 */
+static const char anslcd_logo[] __initconst =
+				"********************"  /* Line #1 */
 				"*      LINUX!      *"  /* Line #3 */
 				"*    Welcome to    *"  /* Line #2 */
 				"********************"; /* Line #4 */
-- 
2.19.1.6.gbde171bbf5

