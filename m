Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1F2C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D540F2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T5VTiLca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D540F2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbeJHM1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 08:27:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36870 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeJHM1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 08:27:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id j23-v6so7792844pfi.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 22:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0PBH0SiDBTS5A/xCIVzOHbzcxzD+kYNUD3TokR7YxPA=;
        b=T5VTiLca1EGUj+3AJFZFnOthdXFHzbAnLsMnSpLXxd4nMxlH+YtNSdodPKXrYk5QCk
         4hp61K72KrQFWlqMaoByZe36XInIa/CZS+xXLB2QzFwf7MfxWDCGBoZ4V1ZR1xsI8nSe
         aM13Vs1a08R4qGPlwpcCcReizaoYSyv+mdp+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0PBH0SiDBTS5A/xCIVzOHbzcxzD+kYNUD3TokR7YxPA=;
        b=sVpDvpeSygXbAYDjMlP7PoPvbXkhze5QtiiRV73tz2YqiRFWPy5qFXgOdJTIxk+msK
         yGjwpgexwoyl7zQVAnnKzSsplvrhPc8vjTjcNw+QASdLQhuNc60VnmjvU45X0+Ay+4BB
         tZcUmj8pREkcCmVyaS4VflBCGq5E2lm+oVd9a7B696aGwpaUL1aqL/A526sl/IUe9jQE
         yYaHfxc3N8Zg1ad9T5nzDO/eJlTOeBL1visYbcqt8rv96X0NgK5tTxQ19fiGqM0Ffa7u
         VMbr3Gavc1/Ga4LunE8p5CzNgS/AfBsDDVGIApcHFV9HlT5G/KXOTZsGD65VI77JsWNK
         dyUA==
X-Gm-Message-State: ABuFfoi1lZX60PhFyJ3ewi2AzX3+PZogYaHEMgrmf2P1cq7pQMsdRU+B
        6u/atE9uHS+hZIz1SnhrsTn/aA==
X-Google-Smtp-Source: ACcGV61gIb13f11m2lvteGZ5TbUdCPD1+SnDvXyHWIHqDEBHuBAva2Urjc+XP3t9n70KtT8Q8DHICQ==
X-Received: by 2002:aa7:8598:: with SMTP id w24-v6mr23863842pfn.77.1538975868367;
        Sun, 07 Oct 2018 22:17:48 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id j19-v6sm1875919pfi.137.2018.10.07.22.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Oct 2018 22:17:47 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v3 6/6] parisc: syscalls: Ignore nfsservctl for other architectures
Date:   Mon,  8 Oct 2018 10:46:41 +0530
Message-Id: <1538975801-13735-7-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an exception to the syscall table checking script.

nfsservctl entry is only provided on x86, and there is no
reason to add it elsewhere. However, including it on the
syscall table caused a warning for most configurations on
non-x86.

<stdin>:696:2: warning: #warning syscall nfsservctl not implemented [-Wcpp]

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 scripts/checksyscalls.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index ee3dfb5..cf93100 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -150,6 +150,7 @@ cat << EOF
 #define __IGNORE_uselib
 #define __IGNORE__sysctl
 #define __IGNORE_arch_prctl
+#define __IGNORE_nfsservctl
 
 /* ... including the "new" 32-bit uid syscalls */
 #define __IGNORE_lchown32
-- 
1.9.1

