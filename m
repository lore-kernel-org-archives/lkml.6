Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42C9C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896E221755
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vF5/2nGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896E221755
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeJUGfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 02:35:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36517 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbeJUGfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 02:35:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so40966100wrw.3;
        Sat, 20 Oct 2018 15:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=RWiArh2hS1wXwjmyYMZMynOTmVpcrRnX76eAIdAErZY=;
        b=vF5/2nGRqtg9hFjMHUDP+4xIMhquOx7Wc2ig3FVa9eyWLXeakvyv+cPWGdI0uadhdk
         8BQfoDmD+TFkDcK/kSGMFuMT5zhm6eMi1lQOnDQ7T/Gm6O5YIUekInLJPgws6caokH57
         1QN4zJE28Zkuu+WTKyodRvvXuHoK+QmpbeazlyjCGYPdrTOqf0icMlUBGeM7PGaXJTdF
         oU4qNj3xSTpJR3CSmacC5IQHKiXy+NyQjPD9N5MDkxFeEIqOQ9Xlm+OgHA4qpy3tPXC5
         lDph7LztAL423jsXzQQChok6xPZF2GUdbP5Z/JVQS5/kL6YpaE8WVn4JW+Rpe+gjyWkt
         Fzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=RWiArh2hS1wXwjmyYMZMynOTmVpcrRnX76eAIdAErZY=;
        b=fycpf3F/b7PSncGCvHVZVxX5fPPS5QbzhJRW2AToTz/4VSvBHu26Nx9E+8NK/Nlcl9
         z1+MaSjJfe9rM0OZOddYuqRxJNhqLlhjFKAiCVsLWAQynKssJ5v65/s1tZmG07XuBIHv
         nSh8jtxXofrTnVhiF1C7MH0hT5092xomxSEBZ9AVl0sQaxNOYW3mdr5gGjOsMt5vOmFY
         iFwPrs12Ihb+YBj4goRKAFe0tiVCBDQOkYNwziNTZ9YN1kJ/4VYcTB0zizpJ1kxHawlJ
         km55/LisJ4MVq9cuU6iJKLPy3MTXLIQG9CFAyspTbCii+tNCOT2dUdeLg0CBUsRU6Icp
         L6pQ==
X-Gm-Message-State: ABuFfogg4odR9SFm//roywbdT0+O8Yj0hwuXcjCHkAKnUv6dHzPZeZjV
        cr37OYXqTT1iBllGa+osqyU=
X-Google-Smtp-Source: ACcGV62sPgDQQ34lHfcuH5vxjYVwB/noaqbyNO3NCB237JXYctPyZePbBRuDnsTV6cJKmuNeW6tKgw==
X-Received: by 2002:adf:a201:: with SMTP id p1-v6mr39365860wra.89.1540074183681;
        Sat, 20 Oct 2018 15:23:03 -0700 (PDT)
Received: from localhost.localdomain ([156.213.155.51])
        by smtp.gmail.com with ESMTPSA id o81-v6sm5013746wmo.38.2018.10.20.15.23.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 15:23:03 -0700 (PDT)
From:   Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahmedsoliman0x666@gmail.com, Ovich00@gmail.com,
        kernel-hardening@lists.openwall.com, nigel.edwards@hpe.com,
        Boris Lukashev <blukashev@sempervictus.com>,
        Hossam Hassan <7ossam9063@gmail.com>,
        Ahmed Lotfy <A7med.lotfey@gmail.com>
Subject: [PATCH V4 1/5] KVM: X86: Memory ROE documentation
Date:   Sun, 21 Oct 2018 00:21:23 +0200
Message-Id: <20181020222127.6368-2-ahmedsoliman0x666@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181020222127.6368-1-ahmedsoliman0x666@gmail.com>
References: <20181020222127.6368-1-ahmedsoliman0x666@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following up with my previous threads on KVM assisted Anti rootkit
protections.
The current version doesn't address the attacks involving pages
remapping. It is still design in progress, nevertheless, it will be in
my later patch sets.

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
---
 Documentation/virtual/kvm/hypercalls.txt | 31 ++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/virtual/kvm/hypercalls.txt b/Documentation/virtual/kvm/hypercalls.txt
index da24c138c8d1..8af64d826f03 100644
--- a/Documentation/virtual/kvm/hypercalls.txt
+++ b/Documentation/virtual/kvm/hypercalls.txt
@@ -141,3 +141,34 @@ a0 corresponds to the APIC ID in the third argument (a2), bit 1
 corresponds to the APIC ID a2+1, and so on.
 
 Returns the number of CPUs to which the IPIs were delivered successfully.
+
+7. KVM_HC_ROE
+----------------
+Architecture: x86
+Status: active
+Purpose: Hypercall used to apply Read-Only Enforcement to guest memory and
+registers
+Usage 1:
+     a0: ROE_VERSION
+
+Returns non-signed number that represents the current version of ROE
+implementation current version.
+
+Usage 2:
+
+     a0: ROE_MPROTECT	(requires version >= 1)
+     a1: Start address aligned to page boundary.
+     a2: Number of pages to be protected.
+
+This configuration lets a guest kernel have part of its read/write memory
+converted into read-only.  This action is irreversible.
+Upon successful run, the number of pages protected is returned.
+
+Error codes:
+	-KVM_ENOSYS: system call being triggered from ring 3 or it is not
+	implemented.
+	-EINVAL: error based on given parameters.
+
+Notes: KVM_HC_ROE can not be triggered from guest Ring 3 (user mode). The
+reason is that user mode malicious software can make use of it to enforce read
+only protection on an arbitrary memory page thus crashing the kernel.
-- 
2.18.1

