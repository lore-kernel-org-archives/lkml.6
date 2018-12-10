Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303B7C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D6E2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D6E2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbeLJEaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 23:30:24 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:39460 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbeLJEaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 23:30:23 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 370F772CC66;
        Mon, 10 Dec 2018 07:30:21 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 2C60B7CEFE9; Mon, 10 Dec 2018 07:30:21 +0300 (MSK)
Date:   Mon, 10 Dec 2018 07:30:21 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 15/25] parisc: define syscall_get_error()
Message-ID: <20181210043020.GO6131@altlinux.org>
References: <20181210042352.GA6092@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscall_get_error() is required to be implemented on all
architectures in addition to already implemented syscall_get_nr(),
syscall_get_arguments(), syscall_get_return_value(), and
syscall_get_arch() functions in order to extend the generic
ptrace API with PTRACE_GET_SYSCALL_INFO request.

Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <jejb@parisc-linux.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: linux-parisc@vger.kernel.org
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/parisc/include/asm/syscall.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/parisc/include/asm/syscall.h b/arch/parisc/include/asm/syscall.h
index 8bff1a58c97f..477511ff7546 100644
--- a/arch/parisc/include/asm/syscall.h
+++ b/arch/parisc/include/asm/syscall.h
@@ -43,6 +43,13 @@ static inline void syscall_get_arguments(struct task_struct *tsk,
 	}
 }
 
+static inline long syscall_get_error(struct task_struct *task,
+				     struct pt_regs *regs)
+{
+	unsigned long error = regs->gr[28];
+	return IS_ERR_VALUE(error) ? error : 0;
+}
+
 static inline long syscall_get_return_value(struct task_struct *task,
 						struct pt_regs *regs)
 {
-- 
ldv
