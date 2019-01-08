Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DBEC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F502087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P89XOnYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfAHNCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:02:37 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37691 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfAHNCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:02:37 -0500
Received: by mail-pg1-f195.google.com with SMTP id c25so1721121pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 05:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mJcX5d1XMrN5lc+M722F+UGsS/DWe5m0ZtCCqy2ujyE=;
        b=P89XOnYxWY26toFcuVi4K2iHibaKAKClwKbmAWLiwy1Ik7U3rPz6BNn4dCMbnLX/v1
         aijws8EnLGpT9zycb1z4HUD6M3t/bVRM5w8k5Ezdl/P4AgyC2hHI5BlKL3mAzxPVwvh0
         JuGj1xc4tgxMJ4TBqyQTmR7jTbW5y9PfVSs45zrESwSb7RSBIlNeLQOGicgVKvldaD/L
         HwMIJRt63Lnxf4oDcPPLbjgdjsqVSUceAo8Ec1nYAtvXrY3ep5Eh9onh5+sQcdl3SgTr
         bWPt8FwMbfNgR+7tzuqLzLjS6WY0TfyhcBZ1wVX+5dHYK/cz9wI7mvrZ1qDAtBHd7kMw
         W1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mJcX5d1XMrN5lc+M722F+UGsS/DWe5m0ZtCCqy2ujyE=;
        b=RNujvTEmBV2eaNb3vtUT1Iie/eD4PabUYUa1exZuf3iKY5vVUmkS5GaaA7wuf8ZQQh
         ytkkVxvtE0jFJKdTJm3f6IGJULkNTReUZ3C85CZ+OXIENvZUyVlblXcDTFVQqXVcOWyC
         JJd+568/SGr/WLeZs+16TaEYbf4o+/7PHzY00cQnFWH/IpahEwf3U7SJSWMKkskbOO6y
         LUsXhlLOyxT4gxtQ5Q4+eoiB7kq8MXgNNNTwaHcqsx8ZZ3n5+IGZ8nH+5XcoCeHP1vya
         NFD/mA3zBeQSfyIE4NrRN4b2GXg06Z8V20dvRW1re4F2yeyH82mtcA9ePvDyQQmcpSfR
         iBGw==
X-Gm-Message-State: AJcUukdjg7zYRJJNL2NTNOR7zWibfkC6OangdD49TjpKJsC7IdJY6vjN
        sNFWXuW9D5SHvNnFIuHdrLk=
X-Google-Smtp-Source: ALg8bN438Js6+5iglZZ4U9TIl9YwZH4bkJfEkt2fxTNh/5XMBv6A9S1XsBsZa7Yg4K8vLvhsV5T9TA==
X-Received: by 2002:a63:c748:: with SMTP id v8mr1504855pgg.108.1546952556318;
        Tue, 08 Jan 2019 05:02:36 -0800 (PST)
Received: from localhost.localdomain ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id n21sm100678648pfg.84.2019.01.08.05.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 05:02:35 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] x86/cpu_entry_area: move percpu_setup_debug_store() to __init section
Date:   Tue,  8 Jan 2019 22:02:24 +0900
Message-Id: <20190108130225.5066-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: vmlinux.o(.text.unlikely+0x498d): Section mismatch in reference
         from the function percpu_setup_debug_store() to the function
         .init.text:cea_map_percpu_pages()

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 arch/x86/mm/cpu_entry_area.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 12d7e7fb4efd..19c6abf9ea31 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -52,7 +52,7 @@ cea_map_percpu_pages(void *cea_vaddr, void *ptr, int pages, pgprot_t prot)
 		cea_set_pte(cea_vaddr, per_cpu_ptr_to_phys(ptr), prot);
 }
 
-static void percpu_setup_debug_store(int cpu)
+static void __init percpu_setup_debug_store(int cpu)
 {
 #ifdef CONFIG_CPU_SUP_INTEL
 	int npages;
-- 
2.20.1

