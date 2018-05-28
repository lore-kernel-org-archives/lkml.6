Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163956AbeE1KwJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:52:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163748AbeE1KwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:52:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 240/496] lib/test_kmod.c: fix limit check on number of test devices created
Date: Mon, 28 May 2018 12:00:25 +0200
Message-Id: <20180528100330.020430841@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Luis R. Rodriguez" <mcgrof@kernel.org>

[ Upstream commit ac68b1b3b9c73e652dc7ce0585672e23c5a2dca4 ]

As reported by Dan the parentheses is in the wrong place, and since
unlikely() call returns either 0 or 1 it's never less than zero.  The
second issue is that signed integer overflows like "INT_MAX + 1" are
undefined behavior.

Since num_test_devs represents the number of devices, we want to stop
prior to hitting the max, and not rely on the wrap arround at all.  So
just cap at num_test_devs + 1, prior to assigning a new device.

Link: http://lkml.kernel.org/r/20180224030046.24238-1-mcgrof@kernel.org
Fixes: d9c6a72d6fa2 ("kmod: add test driver to stress test the module loader")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/test_kmod.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -1149,7 +1149,7 @@ static struct kmod_test_device *register
 	mutex_lock(&reg_dev_mutex);
 
 	/* int should suffice for number of devices, test for wrap */
-	if (unlikely(num_test_devs + 1) < 0) {
+	if (num_test_devs + 1 == INT_MAX) {
 		pr_err("reached limit of number of test devices\n");
 		goto out;
 	}
