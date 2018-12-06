Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C925C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C8020878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgYR5qqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C8020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbeLFP0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:26:46 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:36568 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeLFP0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:26:46 -0500
Received: by mail-wm1-f52.google.com with SMTP id a18so1492740wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 07:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Df89ShnVMJ3g32KsmL3/WIJp0fqIMhGz/JOKXa1E7N0=;
        b=HgYR5qqHYJ88Jw0lrpdCJLyOSbdv9FO4vXWCM8pGwOJUcIajn2CVUH2xH8ILXDlcce
         ZsNpfMKcbpMzlgFdRDfY3kaNuzvCeeSVc6mShCLHyjbfTfMg3tXOFGKViuGLhP1ce5S1
         KE+liupyaMvB2llW58kMia7wN77xeC9B6ma7C0JYFKUZN/eZarIEOzj93DKDutZgKck1
         oKqzq67NCLPItwgTse48gWirDiqjKtC1cukDR/e+JUt+uE4MBDCvwxPuE5VketHWaFRe
         UYy7IL+qte/VmfvxSUW3LtB/jpLnvRIKbDA00CyRTeJMwb4Q5fYkcv+GfHBbw8fAMOgi
         fUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Df89ShnVMJ3g32KsmL3/WIJp0fqIMhGz/JOKXa1E7N0=;
        b=S9LOYaupJfqV7FFJ/8Po8ZugG/Y50WgRyKXXImXj6koJhhUZ9+DhaNoOSOPc0BITkA
         b83BAzuw8M7PAQQWHXr3RU8xxoyAyK5wInqMnjrbEr0kyWrlu2DqJV+yh1103I44JW08
         iKz09TRYhb1jsSbsmApl2yqcj4LGj8mZZ7goUrwZHc7gx5WkFEljxUCsvPGAs4cwgzNL
         figZmeXSoMDT5Q+fez4+hJFhARiQHu5HfjV95ZXNb2cuxduARc9K2CTCcyncHbbBNYh+
         PWY80HgBgaJRha0dJnJxrxm8UC4qfG52L25YEEGk9jvxB3iHDPoo2Kpz2cHJukBLSfjw
         A33Q==
X-Gm-Message-State: AA+aEWYpibhrnSmjc5QueCZApYQpPp8JR5Ma7mt8zs24E8QkxXgT8GZh
        aRiG9N2QEGLjw9+pWm2NiJQ=
X-Google-Smtp-Source: AFSGD/UOAUAGUC4dUY3JpbXxrLhfh0pDjbKlj/Ler+5blQfm/vgD33jlVslq/Htqh+UfOdMg4qhpDg==
X-Received: by 2002:a1c:868a:: with SMTP id i132mr16024907wmd.49.1544110004282;
        Thu, 06 Dec 2018 07:26:44 -0800 (PST)
Received: from localhost.localdomain (ip-76.net-89-3-178.rev.numericable.fr. [89.3.178.76])
        by smtp.gmail.com with ESMTPSA id w6sm529728wme.46.2018.12.06.07.26.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 07:26:43 -0800 (PST)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Subject: [PATCH 0/2] riscv: enable syscalls tracepoints
Date:   Thu,  6 Dec 2018 16:26:33 +0100
Message-Id: <20181206152635.1869-1-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depends on audit patch:
http://lists.infradead.org/pipermail/linux-riscv/2018-October/001931.html

audit patch is already merged into linux-next.

This simply fixes compilation error in do_syscall_trace_exit() and
enables syscalls tracepoints.

David Abdurachmanov (2):
  riscv: fix trace_sys_exit hook
  riscv: add HAVE_SYSCALL_TRACEPOINTS to Kconfig

 arch/riscv/Kconfig         | 1 +
 arch/riscv/kernel/ptrace.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.19.2

