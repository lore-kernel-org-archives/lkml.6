Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6024C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624132184F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Fp5QBosY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624132184F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeHRQYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 12:24:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35637 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbeHRQYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 12:24:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id e6-v6so5965982edr.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 06:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lmTWYIQQOtE4/5RY0etly6z3cOLAqH7ynCF1mxwixHA=;
        b=Fp5QBosYnh+BPVlpc484bgRtqNY5VALr9ETlM7jIGnQI9H+OHBBjzykXubzaQlUqwu
         q/SVQRTTrS5WG1MsnmRVWp5KSjzZ0Y7jLkz2yX5/CtETaLb8QbJJQ2afc6v73agMHcbj
         aiA9Y7ZYwZLLwWIIEG+BXnI4UF8KwlLzDJPUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lmTWYIQQOtE4/5RY0etly6z3cOLAqH7ynCF1mxwixHA=;
        b=UW3DNX82zPxBUNlqTjP4aYZuYhii4leyPXhVl+5sXVnYTjUMjbbWA7YlukPnAIE2Y8
         OxJI4DZiPQ80cqgXxrLYKgqAwtsknwmN9ADZaFecJs+U2ijRtwNc1PdmeQi0+6QijKOU
         jKaRpQHP9CbsQ67Wk8huqZquEQrqcEo/Cd2Hy7M5A9J880nbRQSmDSXQRGXn2evigT58
         u+7OPCXU04gm9w7sG7qaEyXiipW8KK2q4CxifZb+B+c59sn0qvfZ7quBwgAOnSFuvPeG
         tJl/UIrY66YLZVxDm3Yn1dzy/ALYBGCv54jetEAujGThS/h2/CVpJyy/8FxxP4chIN+g
         dKBg==
X-Gm-Message-State: AOUpUlFm00Wj55d69rpZLXztMYHaLsMH9TeMCj3Uw1jxiE/jdOIoSi6y
        rUSL1T/a9GZfP9iHgsX6jSy+AA==
X-Google-Smtp-Source: AA+uWPxXfYn5Eh8xxqfCYA6Zdan/h7WlTvK8NP4OzDvGBX/Nd2Hpz6TcxaKBPFb1C6ttYQNDExGtDw==
X-Received: by 2002:a50:8921:: with SMTP id e30-v6mr46828364ede.213.1534598192287;
        Sat, 18 Aug 2018 06:16:32 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-212.cgn.ip.fibianet.dk. [5.186.114.212])
        by smtp.gmail.com with ESMTPSA id r11-v6sm2821403edp.60.2018.08.18.06.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Aug 2018 06:16:31 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] linux/bitmap.h: fix type of nbits in bitmap_shift_right()
Date:   Sat, 18 Aug 2018 15:16:20 +0200
Message-Id: <20180818131623.8755-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180818131623.8755-1-linux@rasmusvillemoes.dk>
References: <20180818131623.8755-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most other bitmap API, including the OOL version __bitmap_shift_right,
take unsigned nbits. This was accidentally left out from 2fbad29917c98.

Fixes: 2fbad29917c98 (lib: bitmap: change bitmap_shift_right to take unsigned parameters)
Reported-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/bitmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index a7a8b5017d62..e34c361f4a92 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -383,7 +383,7 @@ static __always_inline void bitmap_clear(unsigned long *map, unsigned int start,
 }
 
 static inline void bitmap_shift_right(unsigned long *dst, const unsigned long *src,
-				unsigned int shift, int nbits)
+				unsigned int shift, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		*dst = (*src & BITMAP_LAST_WORD_MASK(nbits)) >> shift;
-- 
2.16.4

