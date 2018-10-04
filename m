Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0477AC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC0220877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukosLPqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC0220877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeJDXaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:30:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38911 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeJDXaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:30:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id r77-v6so3410534pgr.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 09:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FaLwhzpFRHrxVakZcosrdGYbcbYP37d0WLXLHWWU/t4=;
        b=ukosLPqoSijCRw9BSiUOaiBW70zfkAbFK2xjfiETTnDQQMmy4ckuEGeMiMc8ri+v80
         FI9bimPNpqWQ7N+f9rMWpyVxx6ggRGsuxRr0DuZ5COJX2jIcb2Nurx54nfPsoPaueQpH
         Sj1NQmwhWtx0Myh4bJfY0UXBvk9wEc3B/jxCEEXT59zGBBlY4PtBtoWOx8l1/nohKidk
         +N2BDOa4TxV7HZHEJXpYWwTtoYZsDBt5tOcTkV6tOdDn2cqDKIrJP61cmR9KJ1GnhWOy
         /wlu/XcAmMc9TLHFgCv33zstLoSPW6WfsZU54Pu7ucXtBaK0x1vNfJruGOEUMjR6CD4l
         wwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FaLwhzpFRHrxVakZcosrdGYbcbYP37d0WLXLHWWU/t4=;
        b=jEYoUPNd1Kv1V4jHyLQfQNH9k23y7OEZACfUumLYpVv5XVEHk08HVrHhx92BzKUUzr
         7507l7VYAIh52/ijojIE9vTZuECRu2XtNyMwfaZQObdKpekNAS3HLdhHpUS2nEcw13Lt
         NP3gHP56Zr2ilNV8dxKoFWSUi4TQIcj8hxHsn29uwjURA52rEO2HBvQghWH3y2MqHyxt
         78LGaePDPF7TZfVhnu6VVeEvh27AZby7DWAk/D55C14vgAzKlmqkaWDCc+P+Yblc/k89
         ap2xLW/G8Ma6BYCzWImi96ytgpVxOuiw9WA9qldqqKgJzHmP/9NiKgcFjHxHjNPIUery
         b9sQ==
X-Gm-Message-State: ABuFfogq5nW5hmbhybivTpt8JIJprDWRcsvfwX+s5jM9iNzU8CnQW8zJ
        LWD0Wf9iaDQecFPAAR6doyU=
X-Google-Smtp-Source: ACcGV60cnzY7fcJdKC8x2jt/15PYzetmTBx8Fz9fXOVSw5yObzQ5ZchBhHe93zjbp0Zo/C1739o5IQ==
X-Received: by 2002:a63:5b14:: with SMTP id p20-v6mr6433347pgb.56.1538671002986;
        Thu, 04 Oct 2018 09:36:42 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id b18-v6sm9108507pgk.15.2018.10.04.09.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 09:36:42 -0700 (PDT)
Date:   Thu, 4 Oct 2018 22:06:36 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     NeilBrown <neil@brown.name>, devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v6 2/3] staging: mt7621-mmc: Remove #if 0 blocks in dbg.c
Message-ID: <c9c61e56e39db596ef69a6c7806e899b3ea119b2.1538670306.git.nishadkamdar@gmail.com>
References: <cover.1538670306.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1538670306.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes #if 0 code blocks and usages of
functions defined in the #if 0 blocks in dbg.c

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/mt7621-mmc/dbg.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.c b/drivers/staging/mt7621-mmc/dbg.c
index 4fe4d2fd111e..2bafb3bd026e 100644
--- a/drivers/staging/mt7621-mmc/dbg.c
+++ b/drivers/staging/mt7621-mmc/dbg.c
@@ -66,23 +66,6 @@ u32 sdio_pro_enable;   /* make sure gpt is enabled */
 u32 sdio_pro_time;     /* no more than 30s */
 struct sdio_profile sdio_perfomance = {0};
 
-#if 0 /* --- chhung */
-void msdc_init_gpt(void)
-{
-	GPT_CONFIG config;
-
-	config.num  = GPT6;
-	config.mode = GPT_FREE_RUN;
-	config.clkSrc = GPT_CLK_SRC_SYS;
-	config.clkDiv = GPT_CLK_DIV_1;   /* 13MHz GPT6 */
-
-	if (GPT_Config(config) == FALSE)
-		return;
-
-	GPT_Start(GPT6);
-}
-#endif /* end of --- */
-
 u32 msdc_time_calc(u32 old_L32, u32 old_H32, u32 new_L32, u32 new_H32)
 {
 	u32 ret = 0;
@@ -268,10 +251,8 @@ static ssize_t msdc_debug_proc_write(struct file *file,
 		}
 	} else if (cmd == SD_TOOL_SDIO_PROFILE) {
 		if (p1 == 1) { /* enable profile */
-			if (gpt_enable == 0) {
-				// msdc_init_gpt(); /* --- by chhung */
+			if (gpt_enable == 0)
 				gpt_enable = 1;
-			}
 			sdio_pro_enable = 1;
 			if (p2 == 0)
 				p2 = 1;
-- 
2.17.1

