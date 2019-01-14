Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BBAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C3F20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBtJ/YOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfANUao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:30:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34813 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfANUao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:30:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so456264wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RYHA0OJUM2RnoBzeN3vOyH/VQDfLT/qGbJMLzreBAr8=;
        b=LBtJ/YOUj9ZGuEm7VW64TLOkmJBHV1LeN5ztBY7vQ6XvgnEXyFRGqRijCQ4Jbggl9g
         WGdgMmD5EfVFwIulTe3RBtsRHcfAPTn7dYIT01PBlutqSYypi6gO6KaU1NMMz4uPN22m
         g0amtxFSpvPLTH74ulfKNk1y+F1AzrIp5mV8XV+vJDVwZMsZfPMtt1UAztxCOCCF7sgI
         mW/zBSgQ90n1FOuSrphxjsmKwyvABYhzN88HwBJpgO7MEZ+5Fs12XUTmAimzW24xcl+2
         drog32yPczZ/s62nF/reGMi8s3J13WSb3h7HcXxXcmKlIgZoyji0EL3pMitQY9nqJadw
         CKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=RYHA0OJUM2RnoBzeN3vOyH/VQDfLT/qGbJMLzreBAr8=;
        b=puEh4REy/H7xo1rzskk2I1B9YDwiDYPMPcSF8bIoQ4tKuAzVQLXIIwut9qZB9VNfmX
         BfuIIw8JssKQSQuPwJKf7WZUmpcqxYXVQ+u4x9/Yp5OzQsTwcPQsF1SDnDBjM04jnvzl
         o9BLNU+Ati72TZxyflfhHss+tyeIp4ISYiNXvAMp7lqpYh8+QnvuAAU/H1gjlMLS44sy
         KJrQCKHJvsNtZBRPjyYTeWOdZa59cIxdeYURsJeTw350eSNIvVhdn1fEk9Kmmu/Rt8p6
         AqwDld/S3NcyttOlxsJEd2WYXthDnU/fsp6EF0r/jOJONxZNd6MinJG8KveCAO3VQvlb
         PmvA==
X-Gm-Message-State: AJcUukcrd2V/RT9bTcbgGcI0/yYMH9xEPgWqEao+QHei3/wpNzZFv2er
        xLQ1Yc5DpsPz7vDG/pAxsG4=
X-Google-Smtp-Source: ALg8bN5vdbh5VXA5f3b5WmfZQvtdk9Y76KhHL9CuYNKa1TFoUEw4Aie1WpsHm5nPfywsDqA//1ZB5g==
X-Received: by 2002:adf:97d1:: with SMTP id t17mr174009wrb.283.1547497842485;
        Mon, 14 Jan 2019 12:30:42 -0800 (PST)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id g16sm68943671wru.41.2019.01.14.12.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:30:41 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id DA79411422AD; Mon, 14 Jan 2019 21:30:40 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tracing: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:30:37 +0100
Message-Id: <20190114203039.16535-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

This commit remove the following warning:

  kernel/trace/trace_probe.c:302:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 kernel/trace/trace_probe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 9962cb5da8ac..89da34b326e3 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -300,6 +300,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 
 	case '+':	/* deref memory */
 		arg++;	/* Skip '+', because kstrtol() rejects it. */
+		/* fall through */
 	case '-':
 		tmp = strchr(arg, '(');
 		if (!tmp)
-- 
2.19.2

