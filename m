Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8793C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 04:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF49021104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 04:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EAo0zrcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF49021104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeKUOsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:48:11 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42409 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbeKUOsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:48:11 -0500
Received: by mail-pl1-f194.google.com with SMTP id x21-v6so3491247pln.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 20:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Q4rLs1xwUkJJoCNmd9R+D8EGVqXDXjKKFNZC7DR7zE=;
        b=EAo0zrcXNNyVw42R/DHkW1K0BNeWGp3sbueBXAGfyEZViuZKuDLXzRhnqKVgIUrrJK
         O2imOmVoq5HMUiLilwFNzbQNfJ9kLPZSli3JhG21HHTDfZqp0C6NOlKvVqVFuxgbdGcf
         fTmYKbwDPgCG65eDhbXOSGwcbH8kSEYwe4B18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Q4rLs1xwUkJJoCNmd9R+D8EGVqXDXjKKFNZC7DR7zE=;
        b=VzbEIy/FuRRFXy22pQpSrYgrcZZ08So9azdn8skXIQvjATHjxyPS901/VOYQhXTS3Z
         U0rERnvOEBDmX/jzwOVmk6ZuLpxvD4Wh+AGCRjQIN+FrGARSGTNy/BAA36R3g8nkQa9t
         iPDvwkUzIsUms6bY3+1NpEIjBTG+4PmX4DYuv3KPFUAb0DcqqVZ8l74/VW8DRi+ypTyD
         bsWi6kzF9sn0qaNrXCa1oB5qxSAKH122bgm1hm//wYjB7IjrJwQmWCVoP/Jl1kcsZ4K9
         TDcZ8zAzuaNazAsT6axmcJiNLamQCfW3ihG67xBkh6BIkiJmcLWVqZsgqKFd+bU/Jvx9
         Hq0A==
X-Gm-Message-State: AA+aEWZ1TrohICEdL65UCGxKDU3Vk/XEYo+iInitnLmkqOhSxsywr7Hz
        wk7xBw9zVRhfrhMB+JV7HKidpQ==
X-Google-Smtp-Source: AJdET5czCNq6jKpuM6nHZQAd4QxFkISL5k54CUNiVfH1bwq14fuQ+atvj62NTSoaZ0tObcCXA/FfPg==
X-Received: by 2002:a63:2f07:: with SMTP id v7mr4239582pgv.368.1542773728740;
        Tue, 20 Nov 2018 20:15:28 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id v124-v6sm10818712pfb.182.2018.11.20.20.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Nov 2018 20:15:28 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v8 6/6] parisc: syscalls: ignore nfsservctl for other architectures
Date:   Wed, 21 Nov 2018 09:44:30 +0530
Message-Id: <1542773670-25460-7-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542773670-25460-1-git-send-email-firoz.khan@linaro.org>
References: <1542773670-25460-1-git-send-email-firoz.khan@linaro.org>
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
Acked-by: Helge Deller <deller@gmx.de>
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

