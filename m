Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D48FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A98206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCF5WnaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfANUas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:30:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45088 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfANUaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:30:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so375014wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bl+VSsa/k2JFsJMmLzL5WuyF7dqWgT2jkpk91luYwhc=;
        b=sCF5WnaIJBIfsWb1nd7m5vlYU6EHwl90+LBwtwFcoO+Xbu0B5twXnnnBYowMxeW7w3
         zlc9JMrPdk2MXvi60YrWTYU4BgyNCjje0nG7efgqptuzfwQtD6Abw7aJsrDrNcpWcn1Q
         G1CboBHs5Lou2lGUaMPE5PlSHr24lD3ZEMLrmFABtZT8ctA/RNRmQ7vVP0ArxWQ1C3Hn
         IEluOlaoFsOpDqNc5hh71XafUcWuhP8geqjoW5evB1ClzpS8r3jfjheDrboTYFnQknVI
         uZUNc3BN1bDGUyXUYGGp5HSyrLLvwsueWc3NZEH3jgfz2UZFFNzkO6vUlvLiVr0txpXq
         0VHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Bl+VSsa/k2JFsJMmLzL5WuyF7dqWgT2jkpk91luYwhc=;
        b=b9X0ugU/oFmnY70j432X5IOvkNB1Pcl7c6szpE8h4bATMC1ms3zy/yRQhfyu4NJ3he
         TuJPu4MbvUTUJ2JJjcYBjOvgJOzEiCFf1mpS/PVJ7w1ktgCxs/BUotJD8FxR0MnP82Yr
         Xcs3Yqr6DuxV71V6OwHRuwVqNZdhJtrXlApnnpcX2Bt0f516Bx7N/djcxXU2bDc8AJ5Y
         4+7Wh7nRzQ6PjCacJiDfiTZDyctRqRLB6BxcV57/jq3b0wEJL43X9e2MEhRyKGgTdqPL
         vS2kznmcDFNOtytiUca6Xf24Jq+wXxqfgiNiwbrx6+e3vGB7A86fHM9weQnJP/54ZiU7
         b0tA==
X-Gm-Message-State: AJcUukfQqFAXrP0RHJ5n/pg4gyOkhZymbU4y+HLB0065ozPobgVCKLMl
        Ry07BhefLcHWIN2ca2ZPW4k=
X-Google-Smtp-Source: ALg8bN5OwmOUsIXIsHx0o1wMT450VcHz2mkos4psMXMo/tN51WffDP01QvsF0MuIjIWYaAImHYdoZw==
X-Received: by 2002:adf:9083:: with SMTP id i3mr210218wri.124.1547497844207;
        Mon, 14 Jan 2019 12:30:44 -0800 (PST)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id p12sm36358603wmi.5.2019.01.14.12.30.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:30:43 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 8B6C811422AD; Mon, 14 Jan 2019 21:30:42 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tracing: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:30:38 +0100
Message-Id: <20190114203039.16535-2-malat@debian.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190114203039.16535-1-malat@debian.org>
References: <20190114203039.16535-1-malat@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

This commit remove the following warning:

  kernel/trace/trace_events_filter.c:494:8: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 kernel/trace/trace_events_filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 27821480105e..eb694756c4bb 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -495,6 +495,7 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 					ptr++;
 					break;
 				}
+				/* fall through */
 			default:
 				parse_error(pe, FILT_ERR_TOO_MANY_PREDS,
 					    next - str);
-- 
2.19.2

