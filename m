Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD573C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B3D20824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvOMZWey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B3D20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbeJ3ENd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:13:33 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41123 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbeJ3ENc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:13:32 -0400
Received: by mail-yw1-f67.google.com with SMTP id c126-v6so3861611ywd.8;
        Mon, 29 Oct 2018 12:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Cx7LRpCbK0t68q5q4RBqh9Dn5V/BhNKc+ydKX4pEr30=;
        b=EvOMZWeySDdWTZ0nJpWpuu9hinUvs3CPt8F93wj7wgfCrj5WNlk1ugRbxZmBz4+PZH
         Sj3tK+oIrigti7lV+FiJ/2faf/33/xkk0tsPt6kizkfwYH3c3m3is8yrazzwRbCN1bVW
         npswefSA2YYwzN9XBBiqN3mHEbelZmL57H47KGUJHr+Ft6faI2krdQWl50QZinKHA9L4
         /D0cr5WZFGnZS/gvKBX/AWntzMpnQNJqsaO2MhNHxLibCw5P1kzEIMQbZD2W49B7ftk2
         lwqZUgbxPPXTAYe+p6pSh/0GMWlfT2AyTGBhD77LB9k8eJkW/uEQFg2Iy6GP0SxJX9ZR
         r1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Cx7LRpCbK0t68q5q4RBqh9Dn5V/BhNKc+ydKX4pEr30=;
        b=WM2r2wcvxWC78CnWh18PlFYAFq8J2XqGNGyqKMkL4GbozV3dWM5ApRozgOspDJ5Rwk
         6l//fWrJpqR36UyBF43LQz2O4WEIV79NJAfls6Q1Hac04kIrlAhh+eJv16WjzwdpSBvf
         lYoKXXPZEdESY9nW9IHOgrMZe+mpgp8+rXGQfnD1EoLEFW+RgIP2SWlAp+On2eI4/GGf
         P3tJ0YVoM+32BKPNGB480155YHCfTLVA8VFdnBu/affKqPUA5ASSwY0EY6QOGcJ+CB7y
         x+R7LDsS5z8OsRK1C98nSw/PtuLJ/2j8ZkhDpiINO6WBIy4mnQZpHrDDpMiiOmP/jNEd
         PddQ==
X-Gm-Message-State: AGRZ1gKjaigj7FtnLU4iIU5HTnE/UUlfFKxUXANASpKgWzC0/LVH9pLG
        fXlyGchbUNJyQp3f4HQWIENzctbe
X-Google-Smtp-Source: AJdET5eqwJmuvwFmaV6yzFaVUJNpHx07hIm3pVH0m0FwJc52o1IbaP+8NWa4iBiV+AZkXqRRK+fNcg==
X-Received: by 2002:a0d:f6c7:: with SMTP id g190-v6mr15369214ywf.103.1540841008882;
        Mon, 29 Oct 2018 12:23:28 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id k85-v6sm5410014ywa.76.2018.10.29.12.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 12:23:27 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Greg Hackmann <ghackmann@android.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), rppt@linux.ibm.com, linux@armlinux.org.uk
Subject: [PATCH 0/2 v5] arm64: Get rid of __early_init_dt_declare_initrd()
Date:   Mon, 29 Oct 2018 12:00:12 -0700
Message-Id: <20181029190014.6455-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I numbered this v5 because this is still revolving around the same
initial desire to cut the build time of an ARM64 kernel when toggling
CONFIG_BLK_DEV_INITRD. This 4th version is basically the 3rd possible
way to just get rid of __early_init_dt_declare_initrd() for ARM64.

I previously mentioned that I was working on making
phys_initrd_start/phys_initrd_size generic across architectures that
make use of it, which would cover ARM (32-bit), unicore32 and possibly
arm64, but upon second glance, this does not necessarily help, or rather
this patch series actually helps make a smoother conversion in the
future.

Previous discussions/submissions list here:

v3:
https://www.spinics.net/lists/arm-kernel/msg683566.html
v2:
https://lkml.org/lkml/2018/10/25/4

Changes in v5:

- incorporate Mike's version which properly takes care of command-line
  specified and FDT specified initrd location

Changes in v4:

- perform the physical to virtual initrd conversion straight within
  arm64_memblock_init() to get the correct memblock reservation to occur

Changes in v3:
- attempt to change drivers/of/fdt.c to absorb ARM64's specific behavior

Changes in v2:

- put an /* empty */ comment in the asm-generic/initrd.h file
- trim down the CC list to maximize the chances of people receiving this

Florian Fainelli (2):
  arm64: Get rid of __early_init_dt_declare_initrd()
  of/fdt: Remove definition check for __early_init_dt_declare_initrd()

 arch/arm64/include/asm/memory.h |  8 -------
 arch/arm64/mm/init.c            | 42 +++++++++++++++++++++------------
 drivers/of/fdt.c                |  2 --
 3 files changed, 27 insertions(+), 25 deletions(-)

-- 
2.17.1

