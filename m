Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B21C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE75121871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="LJf6Tdgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfAEFrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 00:47:39 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42918 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfAEFrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 00:47:39 -0500
Received: by mail-qk1-f196.google.com with SMTP id 68so22702704qke.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 21:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6m7fySNpjdl7eoTvvjN4S8dxL+B3FXHosc+eNdoBz4A=;
        b=LJf6TdgcY8QPZDIUSsTDFgpTtxRkr0Qkc+ZAeNHc1pCXKkWX9f3imfrby5pFq3RVQ4
         pTUGfekMdIQPNX6Gd2ssV71ZBH4OFxnEnbq6RYdxulo/CXGPKNwr9O4VDML9BmOnjraH
         jvnLeZrZbzdQsMeoRi1ZUr2f4ZzD0ZtE/WKEvBxPyGBmjmhUbluZ5rvRKvIYO5Obh/fE
         mE3mbKOrj3+BjQMfM58gLxvXmDeMYq7z7kp0jH5tEx/uZBIxKwbiC9e2hxt5u7S6D2MV
         LChnMJu7moQ0oHKp9rC118a27lB9bPPnMNisvRdbTx+HQKLdzRyOkHHNR/3y/YIKuhLF
         esuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6m7fySNpjdl7eoTvvjN4S8dxL+B3FXHosc+eNdoBz4A=;
        b=IrheK1mY9eye0cfU/NcpSghHhrAfwenO3brzg7Iks2EcMjuInxqVq+OTbB9o2ebRa2
         Fv1fPWS+eEX0X78kwAuwO8a+f/Ibyia9jZKeQs7/rUxxWW7Pos2I6246HCIUjY23NPpC
         RnK+TD00JQ/Ni+LyC1fG0kd8uvFnTvOOstz7bmh0rB76psB/tlSjZZVMuaejXMFbHXfM
         Hr0VvrzP8qAHhh700Jr0rvJ5xnv9PIWvPm5Si44/LEISTlw6myWtZwO8Hb9ij5pTuS71
         Lh8u6glD+Sl2A11WKXyJVVYrhcmJgdKa1NJJhsK0Kh2O61oWiwauP7GG1bL1n0ZijAm1
         PfMw==
X-Gm-Message-State: AJcUukdMkkz/aDCCUu9LG8Lz48WWlI5TvhVOdt8YkoBwbi5Pkh/ll372
        J3S3ujzYWNcRciv1rFrEEdgpFw==
X-Google-Smtp-Source: ALg8bN5L+wtOajHJzEC5RrnqTnaOKur6ODokvhAYq/L4QVDm00nWsw8IAbC/5MinkvWTRxPbLYaJDw==
X-Received: by 2002:a37:4a87:: with SMTP id x129mr49437904qka.142.1546667258411;
        Fri, 04 Jan 2019 21:47:38 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a192sm7126324qkg.63.2019.01.04.21.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 21:47:37 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] signal: allow the null signal in rt_sigqueueinfo()
Date:   Sat,  5 Jan 2019 00:47:29 -0500
Message-Id: <20190105054729.40397-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running the trinity fuzzer triggered this,

UBSAN: Undefined behaviour in kernel/signal.c:2946:7
shift exponent 4294967295 is too large for 64-bit type 'long unsigned
int'
[ 3752.406618]  dump_stack+0xe0/0x17a
[ 3752.419817]  ubsan_epilogue+0xd/0x4e
[ 3752.423429]  __ubsan_handle_shift_out_of_bounds+0x1d6/0x227
[ 3752.447269]  known_siginfo_layout.cold.9+0x16/0x1b
[ 3752.452105]  __copy_siginfo_from_user+0x4b/0x70
[ 3752.466620]  do_syscall_64+0x164/0x7ea
[ 3752.565030]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

This is because signo is 0 from userspace, and then it ends up calling
(1UL << -1) in sig_specific_sicodes(). Since the null signal (0) is
allowed in the spec, just deal with it accordingly.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index e1d7ad8e6ab1..970bb36837a9 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2943,7 +2943,7 @@ static bool known_siginfo_layout(unsigned sig, int si_code)
 	if (si_code == SI_KERNEL)
 		return true;
 	else if ((si_code > SI_USER)) {
-		if (sig_specific_sicodes(sig)) {
+		if (sig && sig_specific_sicodes(sig)) {
 			if (si_code <= sig_sicodes[sig].limit)
 				return true;
 		}
-- 
2.17.2 (Apple Git-113)

