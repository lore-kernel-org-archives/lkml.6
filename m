Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936995AbeE1K1K (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936888AbeE1K1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:27:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhongjiang <zhongjiang@huawei.com>,
        Oleg Nesterov <oleg@redhat.com>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Xishi Qiu <qiuxishi@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.9 020/329] kernel/signal.c: avoid undefined behaviour in kill_something_info
Date: Mon, 28 May 2018 11:59:09 +0200
Message-Id: <20180528100243.999594826@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: zhongjiang <zhongjiang@huawei.com>

commit 4ea77014af0d6205b05503d1c7aac6eace11d473 upstream.

When running kill(72057458746458112, 0) in userspace I hit the following
issue.

  UBSAN: Undefined behaviour in kernel/signal.c:1462:11
  negation of -2147483648 cannot be represented in type 'int':
  CPU: 226 PID: 9849 Comm: test Tainted: G    B          ---- -------   3.10.0-327.53.58.70.x86_64_ubsan+ #116
  Hardware name: Huawei Technologies Co., Ltd. RH8100 V3/BC61PBIA, BIOS BLHSV028 11/11/2014
  Call Trace:
    dump_stack+0x19/0x1b
    ubsan_epilogue+0xd/0x50
    __ubsan_handle_negate_overflow+0x109/0x14e
    SYSC_kill+0x43e/0x4d0
    SyS_kill+0xe/0x10
    system_call_fastpath+0x16/0x1b

Add code to avoid the UBSAN detection.

[akpm@linux-foundation.org: tweak comment]
Link: http://lkml.kernel.org/r/1496670008-59084-1-git-send-email-zhongjiang@huawei.com
Signed-off-by: zhongjiang <zhongjiang@huawei.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Xishi Qiu <qiuxishi@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/signal.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1392,6 +1392,10 @@ static int kill_something_info(int sig,
 		return ret;
 	}
 
+	/* -INT_MIN is undefined.  Exclude this case to avoid a UBSAN warning */
+	if (pid == INT_MIN)
+		return -ESRCH;
+
 	read_lock(&tasklist_lock);
 	if (pid != -1) {
 		ret = __kill_pgrp_info(sig, info,
