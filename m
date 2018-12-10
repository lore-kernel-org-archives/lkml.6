Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E6BC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FA72084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJln4k22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FA72084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbeLJUoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:44:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39571 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbeLJUoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:44:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id f81so32212wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 12:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uefm3ZE9lw/agzNbChLhzjwz+i4T80hrw7kvV4xOP9E=;
        b=lJln4k22QxOVNrMkpYbevGyfZyglumjTz5gy0AEk/ApQB8DI3Tg2PlayvsyFYeobhS
         LexeFZvkj9vENTHQa/Zi88EOwK9VxCCrVCt5pTEnxm1QDSK5bLBcy+cl0Xol3oGTjT7X
         9eBpTkx8028ZiKhbgxO25YXzL9Ck565csW37RW5ofO1yhp3C9ltb5jFPjRx/Wxgfofyn
         McpoC/odSpp2fJ0gOwC04u7ZQsmrV717iyaJvQW709Tq8p37Oq/OGxJ1Je38R7p6IKhj
         DKNPUznvEKSDTJzT8VjHBjUVP16vr70k96kQJk1JzGdQ8i6+KkHqgLiN8qXV+D7MW6Ws
         lCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uefm3ZE9lw/agzNbChLhzjwz+i4T80hrw7kvV4xOP9E=;
        b=XbDz5x8zRf41LlSyt+0bRmyKJGz6NUoujHAa046QXf2Td8FUNrlb9tYCakB3hma110
         Sj+0re92rL6YvigrN9q5ZV3mx9e01IyuEjo0Usr/ZjAvx6fcYRGkKHqx09KkxtWty5nF
         +m4qTuYbevhO5qQiRKt85VTsJLKnhmfAbXePZhYskIX3jtbtWsIPL1EOvRlSms8g1HvI
         5mnvI9pYiYyOKrw86oqOQaxCMNHN6QNs2NORqGujPdd81BtRKdf4tynfzDKA/jmG6Zv3
         shxhi1pOHmj8x9kUbefobWvgC6L/s87IlRWqOcTLoufWg75UCh4Hx8YCV9o9+Bup8zTL
         B/Iw==
X-Gm-Message-State: AA+aEWb9BOSe7yUM9uoQk8IH6DcMehC7FpjxFQEXzMM6z/ZZroFpPmIt
        pkiHRwXKJGluyN7qN0KNhWg=
X-Google-Smtp-Source: AFSGD/UQbKAhV5/68hQccEBYNGPUjlBY6TQUD6heUBa07jLg9Y/PANyeWS3oTL9fp8WXRMYd1Ix3pw==
X-Received: by 2002:a1c:c483:: with SMTP id u125mr11622133wmf.14.1544474639748;
        Mon, 10 Dec 2018 12:43:59 -0800 (PST)
Received: from localhost.localdomain (ip-76.net-89-3-178.rev.numericable.fr. [89.3.178.76])
        by smtp.gmail.com with ESMTPSA id b131sm26985wma.21.2018.12.10.12.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 12:43:58 -0800 (PST)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Subject: [PATCH 0/2] Fix next-audit branch
Date:   Mon, 10 Dec 2018 21:43:53 +0100
Message-Id: <20181210204355.3483-1-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel kbuild test robot reported on Dec 8th, 2018 that next-audit is
broken. This was with riscv-allmodconfig config.

There were two issues found:
- We don't generate functions needed for trace events;
- We are missing NR_syscalls macro used by kernel/trace.

David Abdurachmanov (2):
  riscv: define NR_syscalls in unistd.h
  riscv: define CREATE_TRACE_POINTS in ptrace.c

 arch/riscv/include/asm/unistd.h | 2 ++
 arch/riscv/kernel/ptrace.c      | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.19.2

