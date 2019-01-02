Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B45C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A07218CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="be3KX7Oc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbfABPhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:37:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46901 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbfABPht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:37:49 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so15313073pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 07:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+j/dgRTDiVSzbUDCRzPGt+zP8/yDGDgaZrkAo6eKseo=;
        b=be3KX7Oc6r/Tmq5hRE+1Jz4USdpfOjv8JT1W/yEWlOGdlLTyOiGIOhANxLn0vA74R0
         JeS1rmYYu29pLbRwpCWepiywrSszaEvA7LZ5YXYvAB40Jv04YawXxBcSFXnNMj/7ma+L
         35GhPfODUNMot2oXhjLP0UJZ+Iq+sxoH9Cw6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+j/dgRTDiVSzbUDCRzPGt+zP8/yDGDgaZrkAo6eKseo=;
        b=jhvg691zqrqB/jfBrdKXnw1NC3s9Yb9Zq3nAnUmd2zq+OHgYgLxHxs99JGXSnBa9Zq
         /UTyFE/Z10iLQd/BhCy7SdcNNb/TgSkOTsxePeYXzkk2PNlc1gUW4iYzeznB2Y5lC0Ze
         kYW8D1MuH7tdGyVCQ9saHNaQ44D9R/027buH1JCv1gF/w5fLLW6kjleF7MSpDbm/AVFI
         I6fw6sPL63Akcrr4s8hEgtER6ZD5ltGrUm7K8EG1oQ/U3L2bWEDYRREGZXDRrUKcn2vJ
         BfvIEZA/UN7FgatzxGvx0zQkjQtMGTRKYd99zqhW7yuADyioNv/wnGI9uki1n6zLIATZ
         XVEA==
X-Gm-Message-State: AA+aEWYsuSWsKMyfVtSuddIHGqAVCugjc0DyJ662Ftr/6f/0wQT7Gekr
        PikoW74pBdf6Bpxz+4kepz9NYfGVy2o=
X-Google-Smtp-Source: AFSGD/U1hf3mI0/IOLQsiMIVzMAa8UrjMhneiLIFPuL6w378zNqymQa9Re4Zax33WLgKjiydMqVvtQ==
X-Received: by 2002:a62:4bcf:: with SMTP id d76mr46817894pfj.170.1546443467760;
        Wed, 02 Jan 2019 07:37:47 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id c4sm108500721pfm.151.2019.01.02.07.37.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 07:37:47 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-sh@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 0/2] sh: Unify the system call scripts
Date:   Wed,  2 Jan 2019 21:07:23 +0530
Message-Id: <1546443445-21075-1-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System call table generation support is provided for
alpha, ia64, m68k, microblaze, mips, parisc, powerpc,
sh, sparc and xtensa architectures. The implementat-
ions are almost similar across all the above archte-
ctures. In order to reduce the source code across all
the above architectures, create common ".sh" files and
keep it in the common directory, script/. This will 
be a generic scripts which can use for all the above
architectures.

This patch depends on;
 https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/

Firoz Khan (2):
  sh: remove nargs from __SYSCALL
  sh: generate uapi header and syscall table header files

 arch/sh/kernel/syscalls/Makefile      | 11 +++++++++--
 arch/sh/kernel/syscalls/syscallhdr.sh | 36 -----------------------------------
 arch/sh/kernel/syscalls/syscalltbl.sh | 32 -------------------------------
 arch/sh/kernel/syscalls_32.S          |  2 +-
 4 files changed, 10 insertions(+), 71 deletions(-)
 delete mode 100644 arch/sh/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/sh/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

