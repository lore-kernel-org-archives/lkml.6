Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B489C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F532063F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D58yz0fe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbfABPCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:02:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43910 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfABPCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:02:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so14687649pgk.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 07:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7nqJrGCWoJ/xXa+0vawBxQXEAZNobDoLmrZscFMVjZY=;
        b=D58yz0feqYH8p3MlPzWJ5O4HNTeru3ubYuxTOOx+nCouyEc2r0hnaS1C8V5BQ7pGQg
         a3HQOzV5zGyVLLq1ybFKsEZHnnowIgRh/ji0d86VV8K2PRO8bJhgI66Zlf450SQXQRtL
         HD4ZiT+jnqnf3zdmSp+5fds0S0Kri2KexHxCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7nqJrGCWoJ/xXa+0vawBxQXEAZNobDoLmrZscFMVjZY=;
        b=YgLJapmvWWPSP4WAVrGr25iHfxaAx1HcgFvRIdSB4yXQHi1QmqnkIekikdimK9uyHz
         fSpmEyShKvM75uoit/5Q8V4MHxKPAQNWs7PZGH+7QYQ6WhauVpRolU6QYjJckX5YZjbo
         lEg6PUXtSEeR+JbfQOYaSWE3ta9lA1LEO/ENx2GS3zgE536sTCEvKRKAB9e4uRBFm1/O
         usLwCbWiPNZWFJF0OAmMRn607to4tI7P1cmFE0bPSadYX4BKySOWKmm+05eDyXmKuC66
         IjCDmRo2UHM5BLdgvLWmp3WSr7IksjnD8C0Tu2zS2HF6XkflN1O9XDHuUMxtaEUmHBhe
         yqwQ==
X-Gm-Message-State: AJcUukdHMjcdEST151ubMPnhXohmo8nUtb/2bKRgoewoRU6u0DZwAXir
        +n2xtuCkolHAcsWBIYXHKmrelA==
X-Google-Smtp-Source: ALg8bN4klezGJ0qRyQtepbOyLk5xRK2fQc0VFDcWdh/7XU4H1sqDnuGGKSe5lk39u0CFM5YuqhtlBA==
X-Received: by 2002:a63:4456:: with SMTP id t22mr14012658pgk.0.1546441352610;
        Wed, 02 Jan 2019 07:02:32 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id z14sm66180213pgv.47.2019.01.02.07.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 07:02:31 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linuxppc-dev@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 0/2] powerpc: Unify the system call scripts
Date:   Wed,  2 Jan 2019 20:32:02 +0530
Message-Id: <1546441324-19774-1-git-send-email-firoz.khan@linaro.org>
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
  powerpc: remove nargs from __SYSCALL
  powerpc: generate uapi header and system call table files

 arch/powerpc/kernel/syscalls/Makefile       | 11 +++++++--
 arch/powerpc/kernel/syscalls/syscallhdr.sh  | 37 -----------------------------
 arch/powerpc/kernel/syscalls/syscalltbl.sh  | 36 ----------------------------
 arch/powerpc/kernel/systbl.S                |  6 ++---
 arch/powerpc/platforms/cell/spu_callbacks.c |  2 +-
 5 files changed, 13 insertions(+), 79 deletions(-)
 delete mode 100644 arch/powerpc/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/powerpc/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

