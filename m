Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752665AbeDTQQk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:16:40 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:33703 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeDTQQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:16:37 -0400
X-Google-Smtp-Source: AIpwx493AKxSQPq8bsV4FzfeX5F2Cig+5nitdIORGvFg9PSROMcQk81MneVwQQbecXSnB8eXj/k9pVKpHw==
MIME-Version: 1.0
Date: Fri, 20 Apr 2018 18:16:30 +0200
Message-Id: <20180420161630.233178-1-jannh@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Subject: [PATCH net] bpf: sockmap remove dead check
From: Jann Horn <jannh@google.com>
To: ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.fastabend@gmail.com,
        jannh@google.com
Cc: linux-kernel@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dead code that bails on `attr->value_size > KMALLOC_MAX_SIZE` - the
previous check already bails on `attr->value_size != 4`.

Signed-off-by: Jann Horn <jannh@google.com>
---
 kernel/bpf/sockmap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/bpf/sockmap.c b/kernel/bpf/sockmap.c
index 8dd9210d7db7..a3b21385e947 100644
--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -1442,9 +1442,6 @@ static struct bpf_map *sock_map_alloc(union bpf_attr *attr)
 	    attr->value_size != 4 || attr->map_flags & ~SOCK_CREATE_FLAG_MASK)
 		return ERR_PTR(-EINVAL);
 
-	if (attr->value_size > KMALLOC_MAX_SIZE)
-		return ERR_PTR(-E2BIG);
-
 	err = bpf_tcp_ulp_register();
 	if (err && err != -EEXIST)
 		return ERR_PTR(err);
-- 
2.17.0.484.g0c8726318c-goog
