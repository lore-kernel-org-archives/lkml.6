Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB15C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DC3217B9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M54wSS+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DC3217B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeHUTdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 15:33:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38366 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbeHUTdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 15:33:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id x17-v6so8727429pfh.5;
        Tue, 21 Aug 2018 09:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sFaPtY6nI7qDQThR+HnBM/AIrP7kAf9zPQVSwd4WFro=;
        b=M54wSS+HLqZ8tZ7/AlZlC38i6CkbvrfchoRTiGzzrLfk3X5guCfM4ze6TftX6yn7EB
         GAgY1Z5HXPM8rOl1lf2KTf3Ww/PoiAKkfLOfwnffUWnkDq9+xwB2H+gmGYHzC9Mrvi5o
         0WAmRqtAFy2QSyLfrc1kYpOLffIZm4MGkFmgaZ/6e/I74VUz1vEc2mCroj69BlZI08B5
         ajWk6dRcZfIhRYqcaRjXvq4LdpMMZP8E5zJqO+YKMyJVkUCQjUZlyLL8AP01ssNauR1E
         dINFhZHLTUT6ZqhAn/Kdj3r84/brZzSMuvbPzAPv+ftWP8TW4+Fw0rx+IA6j1jO1ADuW
         O6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sFaPtY6nI7qDQThR+HnBM/AIrP7kAf9zPQVSwd4WFro=;
        b=WyKw9PRQS/q+bUYls6e4Sc5JAUi431Pp+I+hMTHmlBnkmfEBk35G3Wfn1JPwaIJq7t
         8ADDJpHDqPHOHmNT1iDx2CDQqNIM06UPHxHYEwSzg5jq7ZEKpWVhlJ3S0JVkiiu+z0kI
         ZO6h1CEyajSDTVtu5a6NBSfxF9hCaRJqxvaJt0t3bWjevk2v9CJQeX0MtqVVeZaJPrs1
         /yw5fRCQuzSf6y0edDz72CwD7T1Y9fTQQnlGb8Vl8qi8pRFWUy0WqXdQHld6L1lFfaYH
         b9VupOyA5kgYFRMyUI9aJjx/11hkoqI2+qBjjHNVYGs5l9xmF2+akBbWRDw6oTYCsmLs
         pCeA==
X-Gm-Message-State: APzg51D8mYU/Up4Ts+DtgYK2jQXLSpTm/cN8/prXiq7x70se/mBlXk6z
        2+m85Ncutpi+guiapwXYjsM=
X-Google-Smtp-Source: ANB0VdamInDKTi9OXiUBbcLKjV2Yugeqm0CN27cwmHjBmBICaN6a5vSuXEyq2iJ1nQJwjnEgwfSCYw==
X-Received: by 2002:a65:65c6:: with SMTP id y6-v6mr2378035pgv.436.1534867989805;
        Tue, 21 Aug 2018 09:13:09 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id n29-v6sm18049183pgl.30.2018.08.21.09.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 09:13:08 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH] libbpf: Remove the duplicate checking of function storage
Date:   Wed, 22 Aug 2018 01:12:58 +0900
Message-Id: <20180821161258.19718-1-treeze.taeung@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commit eac7d84519a3 ("tools: libbpf: don't return '.text'
as a program for multi-function programs"), bpf_program__next()
in bpf_object__for_each_program skips the function storage such as .text,
so eliminate the duplicate checking.

Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2abd0f112627..8476da7f2720 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2336,7 +2336,7 @@ int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
 		bpf_program__set_expected_attach_type(prog,
 						      expected_attach_type);
 
-		if (!bpf_program__is_function_storage(prog, obj) && !first_prog)
+		if (!first_prog)
 			first_prog = prog;
 	}
 
-- 
2.17.1

