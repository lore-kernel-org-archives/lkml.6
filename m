Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753412AbeDSBfW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 21:35:22 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43204 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753131AbeDSBed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 21:34:33 -0400
X-Google-Smtp-Source: AIpwx4/EPoKbMlBl6w0peX21BOxYfW34mclKaKHdVRB4BvJDSOe7PUdDQLwPykbRNSukkFzI469ehQ==
From: Leo Yan <leo.yan@linaro.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH bpf-next 3/5] samples/bpf: Use NULL for failed to find symbol
Date: Thu, 19 Apr 2018 09:34:04 +0800
Message-Id: <1524101646-6544-4-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524101646-6544-1-git-send-email-leo.yan@linaro.org>
References: <1524101646-6544-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ksym_search() is used to parse address and return the symbol
structure, when the address is out of range for kernel symbols it
returns the symbol structure of kernel '_stext' entry; this introduces
confusion and it misses the chance to intuitively tell the address is
out of range.

This commit changes to use NULL pointer for failed to find symbol, user
functions need to check the pointer is NULL and get to know the address
has no corresponding kernel symbol for it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 samples/bpf/bpf_load.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/bpf_load.c b/samples/bpf/bpf_load.c
index c2bf7ca..0c0584f 100644
--- a/samples/bpf/bpf_load.c
+++ b/samples/bpf/bpf_load.c
@@ -726,7 +726,7 @@ struct ksym *ksym_search(long key)
 		/* valid ksym */
 		return &syms[start - 1];
 
-	/* out of range. return _stext */
-	return &syms[0];
+	/* out of range. return NULL */
+	return NULL;
 }
 
-- 
1.9.1
