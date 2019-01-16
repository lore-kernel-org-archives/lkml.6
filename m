Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C41AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBEE20868
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0yVCxcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbfAPT3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:29:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55523 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbfAPT3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:29:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so3254456wmc.5;
        Wed, 16 Jan 2019 11:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5YznP4HaRjlu7wstThG1bBJR4rzVbfoOWu4fBUtSgow=;
        b=D0yVCxcSIoe0Mx5rUY3lh9haHY2OCm/eeN5EpHDGqqX6BRBRHqEGvTlxsr6ioop8Z0
         aHlSY1NrUfEGKvR9XlMRCKuAwqu+8vXIJJ2mOyUNiBNHeqSaatzgsje9X3QCPkJWkB9O
         eb5f2DkVXFSNOzVT9yoW6y3MkVwFH1CynSAApOKQm125HPEcw+nZ6U1F3IyI5Cp8g9BU
         UXrscSqHL6cJz2bEaHme21hYeO8jTt7vkLlkjPuqZuyG71wAJ/OFNTCypmyA0mjyOwOr
         /vAcWxOSca6sla2JPR480lvBKDJgCnlin0IJM4aUZeG7/e0qg1d0o6+LtPvPWxvwSaJo
         +nTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=5YznP4HaRjlu7wstThG1bBJR4rzVbfoOWu4fBUtSgow=;
        b=NoxDuKwX4ESKutA+uTi9Pbadyarz4QoSADwdi+mH3wI8DdeJyjBi9pDfVQV8qpuadE
         qZluWhY+xYx6RdoNkkvzMMXgl0haz1BD45t4t6SEDK10RpY31CMAdYpWvhQnm/XjRoXp
         D7GRvYmo7KEeLIn8X0XWMq6TlrjzlOcrZRD/wpBeTuPzaAUZDtP+1rfNlZNqDFBAJUUU
         IePmyKsFzsz8J8EwuzU8QVdiACFLDL0IZsyhTRyXQSGKXdEHZ9sRuUS6YAbTjegsC2uc
         v4aUp0YKqapzFXwA21gSJwflBMYpg5o3hqj00qbh149G7SSVoj7HvkgUkwf6J1AG+l61
         yaew==
X-Gm-Message-State: AJcUukf3HAOmo/djybtfKZyfDqymllXltEG81KIBEazMiI62paJSw0v0
        fqbq77vTZmmchJHRSGYS7vE=
X-Google-Smtp-Source: ALg8bN4a+4m2KKVyn5kMCLhVZTh+htITdCNnZIRyQW5sE9dndpOxUl01hGUYGQdgyG5NqeD7TifyNQ==
X-Received: by 2002:a1c:5f8a:: with SMTP id t132mr9062388wmb.40.1547666988765;
        Wed, 16 Jan 2019 11:29:48 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id h16sm164728849wrb.62.2019.01.16.11.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 11:29:47 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id B48F511423A3; Wed, 16 Jan 2019 20:29:46 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: Make function btf_name_offset_valid static
Date:   Wed, 16 Jan 2019 20:29:40 +0100
Message-Id: <20190116192940.32104-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initially in commit 69b693f0aefa ("bpf: btf: Introduce BPF Type Format
(BTF)") the function 'btf_name_offset_valid' was introduced as static
function it was later on changed to a non-static one, and then finally
in commit c454a46b5efd ("bpf: Add bpf_line_info support") the function
prototype was removed.

Revert back to original implementation and make the function static.
Remove warning triggered with W=1:

  kernel/bpf/btf.c:470:6: warning: no previous prototype for 'btf_name_offset_valid' [-Wmissing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a2f53642592b..befe570be5ba 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -467,7 +467,7 @@ static const struct btf_kind_operations *btf_type_ops(const struct btf_type *t)
 	return kind_ops[BTF_INFO_KIND(t->info)];
 }
 
-bool btf_name_offset_valid(const struct btf *btf, u32 offset)
+static bool btf_name_offset_valid(const struct btf *btf, u32 offset)
 {
 	return BTF_STR_OFFSET_VALID(offset) &&
 		offset < btf->hdr.str_len;
-- 
2.19.2

