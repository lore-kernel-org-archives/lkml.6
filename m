Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D542C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B1820989
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NG8A+5zD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfBVIrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:47:08 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33456 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfBVIrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:47:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id z7so873171lji.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 00:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ETZpFB6qJCxlI0IxAQXLgBRS8xsxl7FpE0AKXNpfHcc=;
        b=NG8A+5zD+mICdf4JNSR355725NfBQRGbY4mWguL8wD5XfuQVzTnbFppbDUY1Yt30du
         ujPTECWNc43+reiXYYD6j2Uutnc23objJ2gZH6Y8cahbS12DVm061xXlJf15AAeOh31f
         R7/p88kS3bpBD5ngNcpr3ldlcIE/2dwfuZl/Mj9he2Q8So8/5KcZRGdDso2Ly992dmX0
         peADa74zD+FZJTSE2N9oM2J8/2UnfDv15anoNydIQRqxCJ129gLQulwMbBgMFpf/jQDF
         tznKGpDsny73cAn9pUMnlNS0pbBrPL6U5PSwEVmf0jJXeK3UkGENYV5G0gT8rNj7KY+v
         1EvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ETZpFB6qJCxlI0IxAQXLgBRS8xsxl7FpE0AKXNpfHcc=;
        b=Ik3tnMF5f+H2cTn1oEZJw2VgxlCY0ciOCXmx2B2NQBGlotHvR/mku8zw2SXbzH9H9l
         tWIfB4aQAwzsIssok4MGUZYEI5+bsQYC0/XTB07zOkgNKIWZiYxY7i9b+O0LEh1UgKKi
         1VDclg4ulsJocVnJ33Pz96LQYqm63ckr68iLgZP21v+sRFZnrr6+dAT8ii2vpnPQa5My
         inGrB7Nr/aDyHD6rjUP6JH/LU6+JztKollxDPP+2Hkfb6Oay35LdzJi9hl009fHKmZL2
         3B6tCYMtnZ5S63GSM20HxuE0tSkOCElkXvf9cDaUuTmitZ6DToySmmAclnAxaeOBcDrz
         C/oQ==
X-Gm-Message-State: AHQUAuZE+3qOaf7rSfvPPfkZncmGl8Vbd7fI5bjIIRjQi6PzuLBs7HVj
        Du3ozEPGeMVIwp+7RttsxHKFqg==
X-Google-Smtp-Source: AHgI3IYP4YhphgWkL3qFtaMKSd1L6SRbv8qoccee+JkeAF4jcfFl+xk19AcJeGLf9TMNtqDiy2usXQ==
X-Received: by 2002:a2e:b1d1:: with SMTP id e17mr1716300lja.120.1550825225616;
        Fri, 22 Feb 2019 00:47:05 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id z26sm284506lja.33.2019.02.22.00.47.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 00:47:05 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] bpf: test_bpf: turn of preemption in function __run_once
Date:   Fri, 22 Feb 2019 09:46:52 +0100
Message-Id: <20190222084652.1326-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running BPF test suite the following splat occurs:

[  415.930950] test_bpf: #0 TAX jited:0
[  415.931067] BUG: assuming atomic context at lib/test_bpf.c:6674
[  415.946169] in_atomic(): 0, irqs_disabled(): 0, pid: 11556, name: modprobe
[  415.953176] INFO: lockdep is turned off.
[  415.957207] CPU: 1 PID: 11556 Comm: modprobe Tainted: G        W         5.0.0-rc7-next-20190220 #1
[  415.966328] Hardware name: HiKey Development Board (DT)
[  415.971592] Call trace:
[  415.974069]  dump_backtrace+0x0/0x160
[  415.977761]  show_stack+0x24/0x30
[  415.981104]  dump_stack+0xc8/0x114
[  415.984534]  __cant_sleep+0xf0/0x108
[  415.988145]  test_bpf_init+0x5e0/0x1000 [test_bpf]
[  415.992971]  do_one_initcall+0x90/0x428
[  415.996837]  do_init_module+0x60/0x1e4
[  416.000614]  load_module+0x1de0/0x1f50
[  416.004391]  __se_sys_finit_module+0xc8/0xe0
[  416.008691]  __arm64_sys_finit_module+0x24/0x30
[  416.013255]  el0_svc_common+0x78/0x130
[  416.017031]  el0_svc_handler+0x38/0x78
[  416.020806]  el0_svc+0x8/0xc

Rework so that preemption is disabled when we loop over function
'BPF_PROG_RUN(...)'.
Commit 568f196756ad ("bpf: check that BPF programs run with preemption disabled")
highlighted the issue.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 lib/test_bpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index f3e570722a7e..0845f635f404 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -6668,12 +6668,14 @@ static int __run_one(const struct bpf_prog *fp, const void *data,
 	u64 start, finish;
 	int ret = 0, i;
 
+	preempt_disable();
 	start = ktime_get_ns();
 
 	for (i = 0; i < runs; i++)
 		ret = BPF_PROG_RUN(fp, data);
 
 	finish = ktime_get_ns();
+	preempt_enable();
 
 	*duration = finish - start;
 	do_div(*duration, runs);
-- 
2.20.1

