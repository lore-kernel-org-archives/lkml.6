Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqw8AwQhw/qRSwWyBZfMuwtY6inEAFFgFsbsOeE1vvdlUE/O5//Cdjmrr9CRVBU4ca7DEkk
ARC-Seal: i=1; a=rsa-sha256; t=1526280768; cv=none;
        d=google.com; s=arc-20160816;
        b=NuLfpyuHH+8qHp6dZuFH/3wlROVcw2YhOhQixJRUhHSavgn5sMKJ7ht3Bz8U8Bxy04
         mEHjH6gY9EIhhlDg35WI3nr6J4f0An8IXW31yr9WWA3kEva0m4t30wZGGuLKVgBGKrHX
         W/z0z8iwEOpcl6rgdLcMNC0F18tiBOh4ZEbRL7vTSJBJLBi+eEdaQUWp73lyHzhPtq8a
         8cWHoQ4yy4E5JyvtXK0sLjCrfnKY1jtZYETzY+CyHitDb8EbmCM6wm9SwgjW3TcdPbLR
         kUUHzv5RuRFSL5YeclJefDad/sROj/GbZlBz8YVzkqDcN62ldFIo2SyOsRTGvfMEwi0L
         Hf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=dtahHsPKC+YdLGT5urxGPWdq54nguMZa5qk5YqYOSfQ=;
        b=Y98TboHIpq3Gw3SQhlVq14GrKgIKFCURGEmqykOJVdtowviiPrwXeZ7Ao4feFh/wg7
         LC/O/+N8LZ2Vj9fG8daOy1hlfkaSPzBEF/gDsJ1Ctl1cygxTJSMRmnbG+s0zVjfh6Mtf
         R+htQfQwoBNIc8Go58ARafxu8ArkGFpus1fbQe/xXIOR+KKo3PUSKVJdNM3r0fQg462G
         KtCqfq9rAzk+Vh3wsklXFnHjgNPk0Gq9NqaUoO/Am+tWakHJN3GRkE+q5eJhC+o7Dv0E
         hSNI3R+I+GUZgTgWdBGy8km2M7qMDbvYDFdubT5YGwuKqUXadUjGy+h/gWIx51B64dAG
         Cynw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ekvpdkLQ;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ekvpdkLQ;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 49/56] atm: zatm: Fix potential Spectre v1
Date: Mon, 14 May 2018 08:48:54 +0200
Message-Id: <20180514064759.341729745@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421383113753187?=
X-GMAIL-MSGID: =?utf-8?q?1600421383113753187?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 2be147f7459db5bbf292e0a6f135037b55e20b39 upstream.

pool can be indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/atm/zatm.c:1462 zatm_ioctl() warn: potential spectre issue
'zatm_dev->pool_info' (local cap)

Fix this by sanitizing pool before using it to index
zatm_dev->pool_info

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/atm/zatm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/atm/zatm.c
+++ b/drivers/atm/zatm.c
@@ -23,6 +23,7 @@
 #include <linux/bitops.h>
 #include <linux/wait.h>
 #include <linux/slab.h>
+#include <linux/nospec.h>
 #include <asm/byteorder.h>
 #include <asm/string.h>
 #include <asm/io.h>
@@ -1456,6 +1457,8 @@ static int zatm_ioctl(struct atm_dev *de
 					return -EFAULT;
 				if (pool < 0 || pool > ZATM_LAST_POOL)
 					return -EINVAL;
+				pool = array_index_nospec(pool,
+							  ZATM_LAST_POOL + 1);
 				spin_lock_irqsave(&zatm_dev->lock, flags);
 				info = zatm_dev->pool_info[pool];
 				if (cmd == ZATM_GETPOOLZ) {
