Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F8BECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4256E21477
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="LYDlXNte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4256E21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeJRGbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:31:53 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:45660 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeJRGbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:31:39 -0400
Received: by mail-ed1-f50.google.com with SMTP id m6-v6so2898407eds.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 15:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6rgQ6bIlMcKdK5lsuZfadRhVGb0kYfqajrvvilOX7k=;
        b=LYDlXNteWGRAFHSpSCMFxozI4XEkmeJ+2I12jekPOJImqcaKhCu9RZHHgO6jMgCEmS
         7n35g0VsG2YWkDXv0EeD460HIU3swLrKyKgY6/MNBZeVtAMciYUxocpKb+RH6r4PPWbW
         zy1ESPzv9wt0NsF3mFe1EcXDJMcUZPCmE6YmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6rgQ6bIlMcKdK5lsuZfadRhVGb0kYfqajrvvilOX7k=;
        b=Am/8vmA3MwMwDZzkU/Bwgcr9mmmYDuwl6d73BJrIRaCQzGvGyRGG4t3b9SR6BB/VKk
         wV/JFCMMnV54YSDxRHSFW+eJgzIAaPKSjdIllmvZrirU8OHG8nK7dx/czgyjjmUXs77S
         U1Jwd0aMwuKmfrwxyovACa1y1SYi7w2ZP+21y2wJgE9tWSuUAfJi1gHHgWuWaIKMf9SW
         eHUQ+3qHTkAqt+l5lwiAQi7DKy16CtDN3H3D8uyMcRhqn9GtDGZ5uHMMLVZjEm6nl0W6
         VdZ4v3E4IfLTAX+yh7wArf8drJreZ5WOJV+EuRXCbAGKYHmDOGRwtwE+jTx6JVu3foxU
         gpDw==
X-Gm-Message-State: ABuFfoj8XX8lUYfzBoqbWBFRYivBm02Ka4D81I1ui1MAwXRnwALeCzrG
        W8dBPJpO45W6srJyL8D53gaPahqlirA=
X-Google-Smtp-Source: ACcGV63vqaDgvDiz9WTcP6FTlvBINKZMPuYevVgVNUPGg3SHjR3t1aS0DaJTWZy/BuAGTjYlgmdA+g==
X-Received: by 2002:a50:89f1:: with SMTP id h46-v6mr1775479edh.252.1539815630819;
        Wed, 17 Oct 2018 15:33:50 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id e30-v6sm7001555edd.25.2018.10.17.15.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 15:33:50 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [POC 12/12] fs/dcache.c: use rai_bucket_shift for dentry hashtable
Date:   Thu, 18 Oct 2018 00:33:32 +0200
Message-Id: <20181017223332.11964-12-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181017223332.11964-1-linux@rasmusvillemoes.dk>
References: <20181017223332.11964-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this, the disassembly of __d_lookup_rcu begins

   0x2d10 <__d_lookup_rcu>:     push   %r15
   0x2d12 <__d_lookup_rcu+2>:   push   %r14
   0x2d14 <__d_lookup_rcu+4>:   push   %r13
   0x2d16 <__d_lookup_rcu+6>:   push   %r12
   0x2d18 <__d_lookup_rcu+8>:   push   %rbp
   0x2d19 <__d_lookup_rcu+9>:   push   %rbx
   0x2d1a <__d_lookup_rcu+10>:  sub    $0x18,%rsp
   0x2d1e <__d_lookup_rcu+14>:  mov    (%rsi),%r12
   0x2d21 <__d_lookup_rcu+17>:  mov    0x0(%rip),%ecx        # 0x2d27 <__d_lookup_rcu+23>
   0x2d27 <__d_lookup_rcu+23>:  mov    0x8(%rsi),%r13
   0x2d2b <__d_lookup_rcu+27>:  mov    %r12d,%eax
   0x2d2e <__d_lookup_rcu+30>:  shr    %cl,%eax
   0x2d30 <__d_lookup_rcu+32>:  mov    0x0(%rip),%rcx        # 0x2d37 <__d_lookup_rcu+39>
   0x2d37 <__d_lookup_rcu+39>:  lea    (%rcx,%rax,8),%rax
   0x2d3b <__d_lookup_rcu+43>:  mov    (%rax),%rbx
   0x2d3e <__d_lookup_rcu+46>:  and    $0xfffffffffffffffe,%rbx
   0x2d42 <__d_lookup_rcu+50>:  je     0x2df3 <__d_lookup_rcu+227>
   0x2d48 <__d_lookup_rcu+56>:  mov    %r12,%rax
   0x2d4b <__d_lookup_rcu+59>:  mov    %r12d,%r10d
   0x2d4e <__d_lookup_rcu+62>:  mov    %rdx,%r15

After this, and after the patching of the run-time values of
dentry_hashtable and d_hash_shift, gdb on /proc/kcore says that we now
have

   0xffffffff8902e8d0:  push   %r15
   0xffffffff8902e8d2:  push   %r14
   0xffffffff8902e8d4:  push   %r13
   0xffffffff8902e8d6:  push   %r12
   0xffffffff8902e8d8:  push   %rbp
   0xffffffff8902e8d9:  push   %rbx
   0xffffffff8902e8da:  sub    $0x18,%rsp
   0xffffffff8902e8de:  mov    (%rsi),%r12
   0xffffffff8902e8e1:  mov    0x8(%rsi),%r13
   0xffffffff8902e8e5:  mov    %r12d,%eax
   0xffffffff8902e8e8:  movabs $0xffff959b80007000,%rcx
   0xffffffff8902e8f2:  shr    $0x12,%eax
   0xffffffff8902e8f5:  lea    (%rcx,%rax,8),%rcx
   0xffffffff8902e8f9:  mov    (%rcx),%rbx
   0xffffffff8902e8fc:  and    $0xfffffffffffffffe,%rbx
   0xffffffff8902e900:  je     0xffffffff8902e9b1
   0xffffffff8902e906:  mov    %r12,%rax
   0xffffffff8902e909:  mov    %r12d,%r10d
   0xffffffff8902e90c:  mov    %rdx,%r15

The shr $0x12, %eax is consistent with

[    0.300676] Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)

and nothing seems to explode.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 fs/dcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1d54dfb38c9d..226298c3a599 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -100,7 +100,7 @@ static struct hlist_bl_head *dentry_hashtable __read_mostly;
 
 static inline struct hlist_bl_head *d_hash(unsigned int hash)
 {
-	return dentry_hashtable + (hash >> d_hash_shift);
+	return rai_bucket_shift(dentry_hashtable, d_hash_shift, hash);
 }
 
 #define IN_LOOKUP_SHIFT 10
-- 
2.19.1.6.gbde171bbf5

