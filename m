Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF0CC6783B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCCE2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gc394AWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCCE2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeLJQDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:03:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45110 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeLJQDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:03:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so5438581plm.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fGIARFtgCjNaTeWMW52dUjZPMdUwiznQnVtKUxB4PtA=;
        b=gc394AWx7F09NXioH7PBgXrqkEArK84xUOSPCjsORTVZZRemod0D0kiA8aAvIibOfA
         IQy8hPrYfT5vveQDaghzKpicTpdii05YtbOucM05eL8oi4FNVbXkp/w767SGLTrf/xoz
         wCxIRkNipz3g/4YZMKjGVNqBkJSK8v3fcIECs0kwH56CDJfSNhge+VqQdwKSidMju8Ke
         Vc4172Hmn+MIOeHWzWTTz4uyXImlkfCSDxWPy+09oi3TwHOqQa3SS2h171aJLMguVn8s
         GtZTvnSZN3eLt+TONU+zqDFrtX6JSxPLtHnQRWRJPEVxUpVdssIxyv4WVKODP76z4VMw
         +fUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fGIARFtgCjNaTeWMW52dUjZPMdUwiznQnVtKUxB4PtA=;
        b=c0cERlK6b/BMABvr80jniKKTQ8g54dxo+ks6ud6TW+tXqyczqWK9Or5ufMWhsic9Nd
         2rd0CObFSy3WDQnfcbGJUUXpsO0A6Fwenpp6s7NHOPtzRlCueOuBkQJ08C9zN1JKQk47
         1It3knm2ZqF9A3yjDhw9wMS1IveYPRHzrGmorwl5Qo0aLmph/nUplJlsqOMAvGrjM0yN
         jn8+n33byfwrpg/MiQYX44D2DhZ8YsJpXsVLw9yQG5CluSoNwMKwqSuQzSOUHa0U04au
         w5EAvgMYW+8X/NRyw/EaiJmHr43dEJLsNbQY6CmmA5o0otdLdWEXKQH0oPSsEIKZcoAG
         IYGA==
X-Gm-Message-State: AA+aEWadCbgtrX2YDJH4918AsdGmBFfM5KvqKg+IqUARFaK4d7Ue1lGo
        DasA/WYPJXbOqbpryoLUYDg=
X-Google-Smtp-Source: AFSGD/VEdttNnqeHddlBWxSHWyH1IzuOHX7eH/gGLuvx7mp0c4zDHgDIAQ9Qgj0PDBI+IWHdPiYziA==
X-Received: by 2002:a17:902:6b84:: with SMTP id p4mr12846814plk.282.1544457809380;
        Mon, 10 Dec 2018 08:03:29 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id o13sm14618751pfk.57.2018.12.10.08.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 08:03:28 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     jakub.kicinski@netronome.com, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] bpf: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Mon, 10 Dec 2018 11:03:27 -0500
Message-Id: <20181210160327.20811-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/net/netdevsim/bpf.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
index cb3518474f0e..14b4d9774708 100644
--- a/drivers/net/netdevsim/bpf.c
+++ b/drivers/net/netdevsim/bpf.c
@@ -48,7 +48,7 @@ struct nsim_bpf_bound_map {
 	struct list_head l;
 };
 
-static int nsim_debugfs_bpf_string_read(struct seq_file *file, void *data)
+static int nsim_bpf_string_show(struct seq_file *file, void *data)
 {
 	const char **str = file->private;
 
@@ -57,19 +57,7 @@ static int nsim_debugfs_bpf_string_read(struct seq_file *file, void *data)
 
 	return 0;
 }
-
-static int nsim_debugfs_bpf_string_open(struct inode *inode, struct file *f)
-{
-	return single_open(f, nsim_debugfs_bpf_string_read, inode->i_private);
-}
-
-static const struct file_operations nsim_bpf_string_fops = {
-	.owner = THIS_MODULE,
-	.open = nsim_debugfs_bpf_string_open,
-	.release = single_release,
-	.read = seq_read,
-	.llseek = seq_lseek
-};
+DEFINE_SHOW_ATTRIBUTE(nsim_bpf_string);
 
 static int
 nsim_bpf_verify_insn(struct bpf_verifier_env *env, int insn_idx, int prev_insn)
-- 
2.17.0

