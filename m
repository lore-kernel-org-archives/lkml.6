Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE47ECDE3C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DEF2148D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="HAkIPBkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60DEF2148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeJRGbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:31:34 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46244 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbeJRGbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:31:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id g32-v6so26368720edg.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gMZtexrmDCCSY/ipZIRBsOGz5pizXdGYv3KGnMsFEt4=;
        b=HAkIPBkmqM+TynGtBXV+KiNW3r1QgJHJhnhDT2MTSAcjPG2RKjcInrHAmbEZEmtZF1
         0DoBc1tRZu2yGXVNI6Ftwgpjfdh2R+PNe7GgB5DFd3GhK06IhQlTmFIbNYWy3I4oquic
         aUyib9+2u1kf1uG6WrCJO367NiRHTOi1eeiNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gMZtexrmDCCSY/ipZIRBsOGz5pizXdGYv3KGnMsFEt4=;
        b=arnmseXFmsCZ3VwCNZrVctcIFw7DV1NqAizPhRfeDs+PrMgx38y5hDIj5zk1JuEyUc
         1bLYkjT7cuIwcQbBiuUZwNeobjeZRHLyrORchFiDAXYfBIWNoLE+DN7OUvv4p3J8jd07
         h0qBrWwe4ftSTp9xedHi5i2jRl0d1n6nNHdrUWSOVE16cbtW2O0Bpnc7kFvy7ZZP4vxs
         KHpP5pli1lZ2devsoIglPrjPM1hiQtp9hSSKHuVTsosTASxiE2LxddkhJBJAtkrcwp7P
         6ZALmx0HE4CEPs63Re4iClKuZzIc1JrQosX4gZW8YpPDsoKXaQ7pb6x5GadhZy+0k5ky
         T/ww==
X-Gm-Message-State: ABuFfojz7Sm+SZUdmXriY4kmNvcJKlLTXLocJvPM72ZMO2cEEehxyuQZ
        GvdWUBIpdLnwvYBRm8uAKUU71Rkih+g=
X-Google-Smtp-Source: ACcGV62cWhVyqi25Oyixmt+MXw2dJiNm7zz/h6KqMo+Xe1uvUXgzKvcTHHdazKF0T0bM8Gi1QShLNQ==
X-Received: by 2002:a50:a7c1:: with SMTP id i59-v6mr1738094edc.296.1539815624800;
        Wed, 17 Oct 2018 15:33:44 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id e30-v6sm7001555edd.25.2018.10.17.15.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 15:33:44 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [POC 06/12] ugly ugly hack
Date:   Thu, 18 Oct 2018 00:33:26 +0200
Message-Id: <20181017223332.11964-6-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181017223332.11964-1-linux@rasmusvillemoes.dk>
References: <20181017223332.11964-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just to have a quick way of seeing that rai-patching works (i.e., once
we implement rai_load, we'd not expect the output to change). Also,
inside virtme we can do a quick "gdb vmlinux /proc/kcode" and
disassemble rai_proc_show to see how the patched function looks.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/x86/kernel/rai.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/x86/kernel/rai.c b/arch/x86/kernel/rai.c
index 2c6ff06f7a34..819d03a025e3 100644
--- a/arch/x86/kernel/rai.c
+++ b/arch/x86/kernel/rai.c
@@ -37,3 +37,43 @@ update_rai_access(void)
 	rai_patch(__start_rai_data, __stop_rai_data);
 	mutex_unlock(&text_mutex);
 }
+
+#if 1
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+
+static int one, two;
+static long three;
+
+static int
+rai_proc_show(struct seq_file *m, void *v) {
+	seq_printf(m, "one: %d, two: %d, three: %ld\n",
+		   rai_load(one), rai_load(two), rai_load(three));
+	one = two = three = -1;
+
+	return 0;
+}
+
+static int
+rai_proc_open(struct inode *inode, struct  file *file) {
+	return single_open(file, rai_proc_show, NULL);
+}
+
+static const struct file_operations rai_proc_fops = {
+	.owner = THIS_MODULE,
+	.open = rai_proc_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int __init rai_proc_init(void) {
+	one = 1;
+	two = 2;
+	three = 3;
+
+	proc_create("rai", 0, NULL, &rai_proc_fops);
+	return 0;
+}
+late_initcall(rai_proc_init);
+#endif
-- 
2.19.1.6.gbde171bbf5

