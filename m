Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E50ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DA320834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="GDX8SeHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DA320834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbeJ0IDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 04:03:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34533 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbeJ0IDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 04:03:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id w19-v6so2652970eds.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 16:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pVRxhKtb8XboHITPYUnwwo0MNpKyrQ9Wfk3OyfG1beI=;
        b=GDX8SeHsuj8OaF1T2I3Sr5cy6fxFDVgeMmTQdpMXOiq8eYbCUjxfy9kOd2NSBN6rym
         advu/9I5KA+muOOwSBy1zkhiCNtnftH4mSDxvvS73wc1cIbtoQZmZ4CGJzsKS1L6gRNe
         tsXRDP5I8OS4NvvWDH+8QNi+nh4NFqszoE9h8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pVRxhKtb8XboHITPYUnwwo0MNpKyrQ9Wfk3OyfG1beI=;
        b=HAK9lRzxXrciB2NeheoK5MHBUBkM5rpN7pqauA3EIP0pHMOdYgpQ4yjBeYMs6M2C5+
         HNApXH59JrLroheeujEzX3Zm1ExpuIVw2MthrSoSCfTVk/Dz+VWDHgIUT34HIigE3py0
         XJv17q0Qs4fXw2AGPCee7djOm8KVosD/BPi8D0HAcnw2n33INU8D1plEGj9ARHiOafGz
         G1boFm/MWv+SSwS278Ad26ULHAMq1XP/qvzMjRt60IFqXvQ/QDsZoWXCSlG1HUqIlEXy
         XZ3pG8GY+ec0JAcmcsu0kC4WoLoJqj2b1pO8+ywQB/TH0iR/pbA2jliWaFOWVP/eFdmB
         KOZw==
X-Gm-Message-State: AGRZ1gJdNakxaob6LTUZATFPbNc19EMjXlkQyR/Edulun7/KGSyvfii8
        htvmE5vDbYQN0LtDPwFEnt2/3Q==
X-Google-Smtp-Source: AJdET5fY1S+C9VGd3XA5orB1TT/w7yxtG2R9hRhPZHU/MaW5MOvuakEHD0hZtdueZhBB4spsxTHWPA==
X-Received: by 2002:a17:906:f6cc:: with SMTP id jo12-v6mr3657013ejb.66.1540596257967;
        Fri, 26 Oct 2018 16:24:17 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id o13-v6sm3986746edc.95.2018.10.26.16.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 16:24:17 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [RFC PATCH 5/7] kernel/kthread.c: do runtime check of format string in kthread_create_on_cpu()
Date:   Sat, 27 Oct 2018 01:24:07 +0200
Message-Id: <20181026232409.16100-6-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181026232409.16100-1-linux@rasmusvillemoes.dk>
References: <20171108223020.24487-1-linux@rasmusvillemoes.dk>
 <20181026232409.16100-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One is supposed to pass in a format string containing (at most) one %u
instance. Use fmtcheck() to enforce that at runtime, WARNing and falling
back to a harmless "kthread/%u" in case verification fails.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 kernel/kthread.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 087d18d771b5..fddfe605632b 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -441,8 +441,8 @@ struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
 {
 	struct task_struct *p;
 
-	p = kthread_create_on_node(threadfn, data, cpu_to_node(cpu), namefmt,
-				   cpu);
+	p = kthread_create_on_node(threadfn, data, cpu_to_node(cpu),
+				   fmtcheck(namefmt, "kthread/%u", 0), cpu);
 	if (IS_ERR(p))
 		return p;
 	kthread_bind(p, cpu);
-- 
2.19.1.6.gbde171bbf5

