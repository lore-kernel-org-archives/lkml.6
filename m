Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZppOdbYi+79geArLhIZqf3W1ZTcjtek5FRel2bTOW3ZRcjDaaYxzIuNCEd+3d/2/PbHeBur
ARC-Seal: i=1; a=rsa-sha256; t=1526281194; cv=none;
        d=google.com; s=arc-20160816;
        b=0sM0iDgdQLL9dQ+JWGVJLAviJRIfayTtlKfhdYrvLHTjw/F4x9/7S1HTLFiASyNgEA
         iD4qCtcIL59PEA+2+ZJRkOjXbIH5XssL6QLXVM7XjjvLPNmQU5voop2i3WaTa8/xVbwa
         FhMYwMEM4hndD6uGcLc/U1inBdYBsv/guVQgr/ib3GX9O9P0i3wRG2e33BGkaq+GQBzd
         rNEDBWasXAGmUKSajpGcYYY7UAGTbNzTEXzeL+He4UuS+z/qZhtSWy23qYXZuj3lNma5
         LFJjTOdBDLaC90dl8T8Gr419wcDV2cme0d2YS/FP4XEhRK7wYFxh8xV43ZSmeEdB56w2
         9dKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=7YrD5LgFdG9Pyr3MJm33Nkjej9lC1ZtG2Etef+kpUxM=;
        b=UAVJJmVE5xVNACsP7sX+BGevaZ5cc2dO2johzz17mkCICqgDgN+gdHSHrCFS9AnPSC
         7VS5I8wO8dO7wke6fZx1SQ7hdpHO/+YPYT+QzNKNPVNeaoZKLI1isotS4U9X4p2T4kFX
         S1IZMGzQtmZRC+pbnez+z37lrezVmaIYvT8CzEZUQ4zN6WbDntbSMwJHiSZJGxD3PXMz
         1iiYUaJlpcARXTH1IupyPhhh2t/SA2IUrjOfUw85rqJ+hCsjIgyrVUWwL1nc9emJAKuC
         3lrbqCdAjodQ9scrVJAzhJeJdENdf4JGJeajLKAYCcaZGzwXw+4QujEvIUOYB75t/b1P
         NZSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=pfJPcPGx;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=pfJPcPGx;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 51/72] atm: zatm: Fix potential Spectre v1
Date: Mon, 14 May 2018 08:49:08 +0200
Message-Id: <20180514064825.671477735@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421383113753187?=
X-GMAIL-MSGID: =?utf-8?q?1600421829369274907?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -28,6 +28,7 @@
 #include <asm/io.h>
 #include <linux/atomic.h>
 #include <linux/uaccess.h>
+#include <linux/nospec.h>
 
 #include "uPD98401.h"
 #include "uPD98402.h"
@@ -1458,6 +1459,8 @@ static int zatm_ioctl(struct atm_dev *de
 					return -EFAULT;
 				if (pool < 0 || pool > ZATM_LAST_POOL)
 					return -EINVAL;
+				pool = array_index_nospec(pool,
+							  ZATM_LAST_POOL + 1);
 				spin_lock_irqsave(&zatm_dev->lock, flags);
 				info = zatm_dev->pool_info[pool];
 				if (cmd == ZATM_GETPOOLZ) {
