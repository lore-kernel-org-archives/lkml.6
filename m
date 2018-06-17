Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D517FC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 21:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF9620891
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 21:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBMRhLPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF9620891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753921AbeFQV5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 17:57:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52579 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbeFQV5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 17:57:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id p126-v6so11042288wmb.2;
        Sun, 17 Jun 2018 14:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BgSxMDBVktEkGcVazF3tevAnRuEr84foMtBxjvM2NqI=;
        b=LBMRhLPEr+ThnX3KtvrryRe+MMt5/95Hrbr0r1w9+KocQaLXcZeGqayaDD31CBrdjH
         ezRbv+T6H/RJ2+0XwLMNp7FjFNZvN/4EBGaJReVwZD4/JOQ30+AWiwC74RQaETQCWYLA
         XEzDAPnALQlsQguJLVXd1pyjyj03fZSlCBFTR8NTprQ05uvGeEy3MSNJHK9X2VX45qwv
         fV71wBqxnbQOBo8up6f2645pQ0VXhead0DfCnB/5aOU6w2okl7b4GazheafazrATADbl
         +SS/t7a/Rv8TFy9hYmQjGaicmCyJ1k3ckgW06RLYAZNySFHlIlNVu64wUW0pqA7zz6fg
         uhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BgSxMDBVktEkGcVazF3tevAnRuEr84foMtBxjvM2NqI=;
        b=K2AuzY9BAOUM/47xZQIDBV6ES1dHHg/b7FVzxBrTqpuIgzsatLxITv5zTDwCavKtZg
         f1TL+n31/9gji+XxM1NWSU0emA0tXp4tiYbP1NvxGJ7acRRF4t/vAKBK02jRmEsrI7Xb
         +8nHmaEVqX4jUywmtq5qSYYLsgTWGlVxUSYCnqeuTWqTS7dvfBhukGAOz1HH3kx5rusb
         GoPe6TNRZRtm/MwxjxAq1QFzNM9jVjTj49dEsx/jkEu8zW7x+6BD69VWWbzec9HkDMct
         xotBiUiJOlXEcHhUNhei+sZkwLdh+yOAHKiBpFkxJhegxeaVYtAv2Tu4w2J0w2pKheWh
         i1YQ==
X-Gm-Message-State: APt69E19veNZ37GEmcS94H/yTV/I6ohSeRKPyEHXAaVme2mtq7vdVFVA
        esG7EHS8GDfl6V5EpeEvNw==
X-Google-Smtp-Source: ADUXVKJL2Sb2OjXSQyLCTm77lTrP/oy2SngmNJ17nLI86SaFIhUcBLJEhaGYxXWU6k8O4klarK7alA==
X-Received: by 2002:a1c:d287:: with SMTP id j129-v6mr6315720wmg.106.1529272655812;
        Sun, 17 Jun 2018 14:57:35 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id v2-v6sm14575755wrm.84.2018.06.17.14.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 14:57:35 -0700 (PDT)
Date:   Mon, 18 Jun 2018 00:57:33 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] proc: fixup PDE allocation bloat
Message-ID: <20180617215732.GA24688@avx2>
References: <20180614200956.GB7137@avx2>
 <15003.1529008242@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15003.1529008242@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 24074a35c5c975c94cd9691ae962855333aac47f
("proc: Make inline name size calculation automatic")
started to put PDE allocations into kmalloc-256 which is unnecessary as
~40 character names are very rare.

Put allocation back into kmalloc-192 cache for 64-bit non-debug builds.

Put BUILD_BUG_ON to know when PDE size is gotten out of control.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/inode.c    |    6 ++++--
 fs/proc/internal.h |   17 +++++++----------
 2 files changed, 11 insertions(+), 12 deletions(-)

--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -105,8 +105,10 @@ void __init proc_init_kmemcache(void)
 		kmem_cache_create("pde_opener", sizeof(struct pde_opener), 0,
 				  SLAB_ACCOUNT|SLAB_PANIC, NULL);
 	proc_dir_entry_cache = kmem_cache_create_usercopy(
-		"proc_dir_entry", SIZEOF_PDE_SLOT, 0, SLAB_PANIC,
-		OFFSETOF_PDE_NAME, SIZEOF_PDE_INLINE_NAME, NULL);
+		"proc_dir_entry", SIZEOF_PDE, 0, SLAB_PANIC,
+		offsetof(struct proc_dir_entry, inline_name),
+		SIZEOF_PDE_INLINE_NAME, NULL);
+	BUILD_BUG_ON(sizeof(struct proc_dir_entry) >= SIZEOF_PDE);
 }
 
 static int proc_show_options(struct seq_file *seq, struct dentry *root)
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -65,16 +65,13 @@ struct proc_dir_entry {
 	char inline_name[];
 } __randomize_layout;
 
-#define OFFSETOF_PDE_NAME offsetof(struct proc_dir_entry, inline_name)
-#define SIZEOF_PDE_SLOT					\
-	(OFFSETOF_PDE_NAME + 34 <= 64 ? 64 :		\
-	 OFFSETOF_PDE_NAME + 34 <= 128 ? 128 :		\
-	 OFFSETOF_PDE_NAME + 34 <= 192 ? 192 :		\
-	 OFFSETOF_PDE_NAME + 34 <= 256 ? 256 :		\
-	 OFFSETOF_PDE_NAME + 34 <= 512 ? 512 :		\
-	 0)
-
-#define SIZEOF_PDE_INLINE_NAME (SIZEOF_PDE_SLOT - OFFSETOF_PDE_NAME)
+#ifdef CONFIG_64BIT
+#define SIZEOF_PDE	(sizeof(spinlock_t) <= 4 ? 192 : 256)
+#else
+#define SIZEOF_PDE	(sizeof(spinlock_t) <= 4 ? 128 : 192)
+#endif
+
+#define SIZEOF_PDE_INLINE_NAME (SIZEOF_PDE - sizeof(struct proc_dir_entry))
 
 extern struct kmem_cache *proc_dir_entry_cache;
 void pde_free(struct proc_dir_entry *pde);
