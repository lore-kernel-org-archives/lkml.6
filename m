Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030433AbeEYVeC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:34:02 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:54717 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030216AbeEYVeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:34:00 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH, net-next 1/2] bpf: btf: avoid -Wreturn-type warning
Date: Fri, 25 May 2018 23:33:19 +0200
Message-Id: <20180525213331.2115471-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:yVV90sA6Eh8UbQLosTBJ/01CrbxUbLoorXerFl+UAztokMLIqJv
 cxSDnSRPlFWZzReHm2e6was45IZFgep7Katd7/9mrV1ihQgKjcjBuJCIy5arpguvUjPBzr5
 /d/uVTbed4+wC3/HmkTGf/rQuV/HpvJSPXn90z8C8HH4l0jWNEXIpVYJjKK6wmq4FnbqM+M
 nK0AFYypmdjCMneg/dp8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mxSvhcuP3FM=:A7fuER43f4DbT1A1l2CCRd
 0JeCOzhe5XybE1vvAItY2x3v+cUO4/0MkS34+OMG2u+9EDwpWILiNKIcJ0oB5rSz7O1yflJIb
 ob+bwfx+CW9QpN+Wme+TWs6K9tx8dDNpGnR1i0SPfjZbsG857hof9ZC8sLNE9/iC+H9ownaTY
 yRvfDY9694ErLHgn3NBJrYc4DQ0dBndNxnnoT2/QH5mCtv2xskufnRekQkUkzhjqsZmkGIopl
 aerZPVqU/6DbAWOUQnIJnvsmIxsEauN+UZjwNbULslwCXhmsvgAI7oC4pN2eHzI7CNykxVrKd
 YWbekrjz2GV5m7sdm9O+ZPirvEZyw99qvexbYxCo5Pbu0vf7STmmF4YLJa7QMLFzDBb7xkYpf
 80HFWXeZQR7Fwjqphetm9rxDdtnkill+eFWl9shq/2+DSVajeYOl+NsNX2t/LWaRzvPgc4xBX
 FXATYxuCo8vlKhr6i/IRCQBNSSjCTaIyM2ddV3aef2abYk1hIMSguGkUELUze+aB6uyByoDF+
 vVVEZxxSx900pGNvy8o0ocWNcIjEYLEQ93s4+dbm384rP9DSCJC/11OG2jmLtVzF2EnZSZKs1
 PkZbACrSRjF85MFDzg/JEdLrAlbjzVYNPTqBDRN+H9DutSi9akT6BthKrPq5YOROpufOBDCAP
 wepCby6aYm9/7yxtt8OvTKj/JC2z6Jl4N6ZfWXNL+LFIF5ikhF2CERUevkubakfjunrg=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc warns about a noreturn function possibly returning in
some configurations:

kernel/bpf/btf.c: In function 'env_type_is_resolve_sink':
kernel/bpf/btf.c:729:1: error: control reaches end of non-void function [-Werror=return-type]

Using BUG() instead of BUG_ON() avoids that warning and otherwise
does the exact same thing.

Fixes: eb3f595dab40 ("bpf: btf: Validate type reference")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9cbeabb5aca3..2822a0cf4f48 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -749,7 +749,7 @@ static bool env_type_is_resolve_sink(const struct btf_verifier_env *env,
 			!btf_type_is_array(next_type) &&
 			!btf_type_is_struct(next_type);
 	default:
-		BUG_ON(1);
+		BUG();
 	}
 }
 
-- 
2.9.0
