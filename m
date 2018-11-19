Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D08C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA7A20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/PqeYFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA7A20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeKSVlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:41:49 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45604 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbeKSVlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:41:49 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so9849067plm.12;
        Mon, 19 Nov 2018 03:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kfBH9F4i189EQmuJ9zt541sD4dDToCzdMjhZOHZ6HC8=;
        b=q/PqeYFxYW7n0hg/0nt/qJPwu8fNLsijnBWaWXy9g2XmL2oa+RkBdbE8w3IyDe+p8E
         ubaPuxkFO1krq/kmlTJBQMoNu9jr7HPkK+IvL0M/TGnWCEh4KoDGBVgsGAXJ88iMXL3S
         NU0OIVzeoCmnajh+/DqoecoKMHGcY0ecOvLpUpSMxadDnKj9dTxullvdz9ZiiUB/0ByH
         HtVssyFuyVcthHJ1xAqzq7fyBC7SnXtpe92HIMs4jUapepu0vsEuM31U22f5Rk459LNx
         K5MiG52LOB+n65p9jTdhTG8EkIDNHuUl3gpN2kE3+kk4y9QOhIem0ttmCMTn2GrWfH8i
         m1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kfBH9F4i189EQmuJ9zt541sD4dDToCzdMjhZOHZ6HC8=;
        b=X2SO20jkr5FWedvYUmoMZuRoSROa4jIiZhjRGzSIxg4Xe3KVChL6JgA+FYjWOTIs8r
         s45QmCRtXbQtxTuxD7a0tpa4HKbQ70Qli6mkG9j9mvaaMdpBG3u378YwTVes5kzrX0EL
         Va4zvxw5tZUqLtU6qanIA/4o66h8qJ/7N8ROrVOFJr1ECHXJaqctBi38ixNODSGKvZRY
         l2s2qzJpMajWolMqfJ4DguUVgNIclXl5mhhxM3UIWU7mJRJrb4kTimxqAT6JQZIvgUev
         p1AuylbcODDxvamt2G5e6C+eFgingZCyEG7TiOiRw9K29f7JiVaDdzjWh9H1CYDrTOal
         DP5w==
X-Gm-Message-State: AGRZ1gKjPk19mIImzXRa6TiS6fjhdF6ttNjzF6lp70kbQ0RLDao9jJyb
        lOIu+0Kt0lsa/lG3ngiDyio=
X-Google-Smtp-Source: AJdET5cFJXyIHULMYVKJJuO6PCFnXHF/HJ/Pexw8P/20V6LDePHVM/DSBQSgIgC6H7+Z+KzoiKhdww==
X-Received: by 2002:a17:902:24e7:: with SMTP id l36-v6mr21908996plg.243.1542626310346;
        Mon, 19 Nov 2018 03:18:30 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id m9sm34825716pgd.32.2018.11.19.03.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 03:18:29 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, keescook@chromium.org, orcunov@openvz.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] procfs: fix the output format in /proc/PID/wchan
Date:   Mon, 19 Nov 2018 19:17:52 +0800
Message-Id: <1542626272-29129-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just add the missing newline.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/proc/base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ce34654..d7f49fb 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -370,11 +370,12 @@ static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
 	wchan = get_wchan(task);
 	if (wchan && !lookup_symbol_name(wchan, symname)) {
 		seq_puts(m, symname);
+		seq_putc(m, '\n');
 		return 0;
 	}
 
 print0:
-	seq_putc(m, '0');
+	seq_puts(m, "0\n");
 	return 0;
 }
 #endif /* CONFIG_KALLSYMS */
-- 
1.8.3.1

