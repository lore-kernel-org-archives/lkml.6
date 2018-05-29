Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932902AbeE2Jzw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:55:52 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:39205 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932517AbeE2Jzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:55:49 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "David S. Miller" <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>,
        Alexei Starovoitov <ast@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bpfilter: fix building without CONFIG_INET
Date: Tue, 29 May 2018 11:55:06 +0200
Message-Id: <20180529095535.81934-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:94rEkWMq9Yz8JonxE8X9K3bm1jr1JHvXuPeupWCGFwbf9Fb0QtQ
 wN/eqJeyx4RFNJJJZwaFsjHvpTA9lkL/gff6LvRNrBCwOB9urmsVyco6JAfh0LZTspcD+Bg
 trTpLyCi1ciTR0cqtYWePGA1FDdUph6w7bup0VBgInlzIACSE4tV7gAdh5vQHBdSlowxC+Z
 nCBlz56MHggaM0uVnBx2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eUc6/7KvtEA=:FgC8/8nh6dv8pJJWr3x1ne
 PsR0QrWASMJ7z5Ps7bY3kq5vvaiW7J1rlNBPk+Der4XUiwBeHT2Ly3qw271xTbZnen7Zy2Eaa
 jPryH12KK+nVLenUeQ6u4viulrZGeoijW7ubIQsrPnwwYbZtPTPDRHngZF1yWy/0Ig6Xs6ZP1
 FgQ3Bq1YehBR0goNNPQoV/iCedm/NivXa10yq0Axx11bTyq5FGaHI6jNajSkLiDFkGlQdYsbe
 cbl7GUjief8KmmlB30JiMzhW3rfjy9xYZa2dcZp/tKXkIxFejGVnGIiKO00IEYD2/LLRiJpS9
 O/kqHwgh3UMgAXbH8lcFgUBu8r3HxsYGLUu07iK5AzMLf4zW3fXPXFk4ChDmr2lSeffOtYDw1
 76faCC9n0Rkb3Btii1r2w4XrYf8Bb3SraeSKUfI8Ejqly5JQmAc8sCpCjA4Lna8UtxIgVo6JY
 xzeXnC7TbRZaglo/1MbIp0QOYO0x566EDCG39OBjZ76czFJEZiMi5+a1kZrVTxKbXmDdz9wdA
 reebS6DJ7ZlhLJlan1fCWOMwM6Im9AOfJePrLEgZnwjdmNLXBJdeF0Eqojq65D+6HC38d7JL6
 gX3tlSjuj+g2QgVnkiJMqNUkfij0ATTuNyr/8OI/7pvO1LrhvE+0POew5NU8wDbv6ICTtyEkR
 DKSywJA4nwYqAQRcvf2CavW/O2eyL4mgQ4tiuHwJc83uVExDszs68excygRq4TNxyl/A=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bpfilter_process_sockopt is a callback that gets called from
ip_setsockopt() and ip_getsockopt(). However, when CONFIG_INET is
disabled, it never gets called at all, and assigning a function to the
callback pointer results in a link failure:

net/bpfilter/bpfilter_kern.o: In function `__stop_umh':
bpfilter_kern.c:(.text.unlikely+0x3): undefined reference to `bpfilter_process_sockopt'
net/bpfilter/bpfilter_kern.o: In function `load_umh':
bpfilter_kern.c:(.init.text+0x73): undefined reference to `bpfilter_process_sockopt'

Since there is no caller in this configuration, I assume we can
simply make the assignment conditional.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This happened on last week's linux-next tree. Since there hasn't
been an update since, it's possible that this is fixed in another
tree already.
---
 net/bpfilter/bpfilter_kern.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index 7596314b61c7..b13d058f8c34 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -33,7 +33,8 @@ static void shutdown_umh(struct umh_info *info)
 
 static void __stop_umh(void)
 {
-	if (bpfilter_process_sockopt) {
+	if (IS_ENABLED(CONFIG_INET) &&
+	    bpfilter_process_sockopt) {
 		bpfilter_process_sockopt = NULL;
 		shutdown_umh(&info);
 	}
@@ -98,7 +99,9 @@ static int __init load_umh(void)
 		stop_umh();
 		return -EFAULT;
 	}
-	bpfilter_process_sockopt = &__bpfilter_process_sockopt;
+	if (IS_ENABLED(CONFIG_INET))
+		bpfilter_process_sockopt = &__bpfilter_process_sockopt;
+
 	return 0;
 }
 
-- 
2.9.0
