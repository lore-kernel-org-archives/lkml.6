Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9D9F2C004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D412086D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="V0dLBdCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D412086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934648AbeFKVv0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 17:51:26 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:32807 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934508AbeFKVvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 17:51:24 -0400
Received: by mail-pl0-f66.google.com with SMTP id n10-v6so13084704plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 14:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=nbRfi1DqzuU2+C610KN0oKbD2xVholLrrhMtfij4Q64=;
        b=V0dLBdCriLigGV9ZC3WwUeaEQuZLN8Vm4PnnZrHb4B0sAIRFmgGUR/7MqpEWtI1rLw
         5bKiFvJJaouxJRMOq0wUbPp4wcn++ETB62/bKPY4Dvj6zZXd9QwxIkWcI+O67BfYB7K5
         D8VPXKms6YUX5+LtU3uOuzKBvFLfI5N5582HZKAQdV7OtbR5cmHqgGbH3khcCJJAMzbB
         R8fjKCcNolKuBtAChV1FSWctLzyHC+oRWGP38UiyRSDISfbtht/mYQbhberpMmRucZMH
         M58pkEw9m5W0Lb/XXFIGmRcu1dyMMMf9lzoJQM2L5NI22se6ZuOX5nlHJM0oYxSpsxVq
         aNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nbRfi1DqzuU2+C610KN0oKbD2xVholLrrhMtfij4Q64=;
        b=Z7uTwzQ50U+qVRCfMEsTXQ8hLjY28dxJN7shAiT37Q377ZtL5J005nB7kMCmHBf1Vd
         sSczPgXRK3L62WD+b9M6T4ybmsGoBDXuoC4EjnNWvoAiz51g4T6fSb4Fo7CwOklcLydr
         LXfhrpS2xZbnFFnNtk7cIvCm2Rmd3t8V78anvrI1fl8brLskSiqHw4KDkM1yo0F8Ck/W
         zEq8prgUHiWb2X8lxHCGTVEV+KKZ+LUmb2RruI7/T5hKsIGMipKrG6nVjwBXvcOJgpyG
         OOHbFs14ZfeduyqrJoI1QUDrbCQzYdNUuGl3ETkGy2i8baE/65rCiXV8g+YlKChLYamk
         vhbg==
X-Gm-Message-State: APt69E0LE6y5qlhqHrOLXkw1apjyLjDcHX91yjElu4L2TuqXXJm2qvqu
        ux6fq/IeSsoQe6hyZzsLWG4J5A==
X-Google-Smtp-Source: ADUXVKJN9mUx+8OcQeTS/EX2fT7xkzpT9RFJHuWvot7voJaoUqiEhocIu8sRD5/KUuEtyawCOThefA==
X-Received: by 2002:a17:902:530e:: with SMTP id b14-v6mr948989pli.316.1528753883858;
        Mon, 11 Jun 2018 14:51:23 -0700 (PDT)
Received: from rohan.internal.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id d9-v6sm72740859pfg.183.2018.06.11.14.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 14:51:22 -0700 (PDT)
From:   Jim Wilson <jimw@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     jimw@sifive.com, Oleg Nesterov <oleg@redhat.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] RISC-V: Fix PTRACE_SETREGSET bug.
Date:   Mon, 11 Jun 2018 14:48:22 -0700
Message-Id: <20180611214822.8539-1-jimw@sifive.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In riscv_gpr_set, pass regs instead of &regs to user_regset_copyin to fix
gdb segfault.

Signed-off-by: Jim Wilson <jimw@sifive.com>
---
 arch/riscv/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index ba3e80712797..9f82a7e34c64 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -50,7 +50,7 @@ static int riscv_gpr_set(struct task_struct *target,
 	struct pt_regs *regs;
 
 	regs = task_pt_regs(target);
-	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &regs, 0, -1);
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, regs, 0, -1);
 	return ret;
 }
 
-- 
2.17.1

