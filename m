Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76027C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 22:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C13208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 22:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C13208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbeKKHwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 02:52:11 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36624 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbeKKHwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 02:52:11 -0500
Received: by mail-lf1-f66.google.com with SMTP id h192so3740620lfg.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 14:05:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=pYkHvT7Kj+Of9cWYDNEc04Shp+/KNmHnxms8QJaJZYM=;
        b=G21tSs6h5mH7hn2llo3ElqUfhO/5D3S/xXwLToLO9BgT/xM1IzVCuG7tJJurbFy6bb
         bsh1gUpP+WMTE1JtOZ9h9dC15StTRvKM5Nw73ovX2XoGB+G/i7kIeIO2uljo7YeU6I8H
         NsWeaFTn6Ydk3Yvetv5fQzUQdkhPvOxqkuoSiYh6+uOtUIMlvHoD+CVd5TIlyhGXf64N
         l194mx+bA9/CK0NyymQiy4GGwugQWwkDXcWimRD/FsNzZFRppd+bN7at/45ona5JURgG
         kOBaYKCfO0XMVQvXWKvAOhTHpVNKQF/xeoW/ta6WQRC5UOXsmhClGWuSawhIBjqyYv6d
         /o1A==
X-Gm-Message-State: AGRZ1gLZ84mnZvEc2UN6mfptq6UZ3XX6yGRB0CtSckl5G6N49rpicrjI
        ax5a72m/9gbkiTMYK89XpKU=
X-Google-Smtp-Source: AJdET5f7i2ZruZqnmoYdoVVrHEZsYq/Rp2mHAvgHHhVMqp/NRJd0HoiMI47tYh4edKTdAA72FeqSzg==
X-Received: by 2002:a19:920a:: with SMTP id u10mr8101431lfd.122.1541887540432;
        Sat, 10 Nov 2018 14:05:40 -0800 (PST)
Received: from hobbit.lan (128-68-186-150.broadband.corbina.ru. [128.68.186.150])
        by smtp.gmail.com with ESMTPSA id o25sm2058679lfd.29.2018.11.10.14.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Nov 2018 14:05:39 -0800 (PST)
From:   Alexander Popov <alex.popov@linux.com>
To:     kernel-hardening@lists.openwall.com,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        alex.popov@linux.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] stackleak: Disable ftrace for stackleak.c
Date:   Sun, 11 Nov 2018 01:05:30 +0300
Message-Id: <1541887530-16610-1-git-send-email-alex.popov@linux.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stackleak_erase() function is called on the trampoline stack at the
end of syscall. This stack is not big enough for ftrace operations,
e.g. it can be overflowed if we enable kprobe_events for stackleak_erase().

Let's disable ftrace for stackleak.c to avoid such situations.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexander Popov <alex.popov@linux.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 kernel/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/Makefile b/kernel/Makefile
index 7343b3a..0906f6d 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_MULTIUSER) += groups.o
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace internal ftrace files
 CFLAGS_REMOVE_irq_work.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_stackleak.o = $(CC_FLAGS_FTRACE)
 endif
 
 # Prevents flicker of uninteresting __do_softirq()/__local_bh_disable_ip()
-- 
2.7.4

