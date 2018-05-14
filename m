Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp7QKv3w7xBa5TK3wwnxqwAeJlqJHDplGJ8wYvA1V0XXyfVgw6d0TAM3Cnaj/X1OZk461Xa
ARC-Seal: i=1; a=rsa-sha256; t=1526281001; cv=none;
        d=google.com; s=arc-20160816;
        b=vMEESb/JXgHWz2z0n1ikaSapdqEoJCvSTTA59bTNbq++JdcC4b5rFr8KnM2rzZ+XZG
         xU9d5JCiWOqDMpPPKHQYEHMRaeKRN3+WKElm29Z3LhEujEQA87QmFkzqIQwpuYRG3qAC
         Yvy7akNydJDelMlczuWWEfU67sJXi3iZFiU0+r3d8XOviVfydojLUcrQqAPG5tVu4PSv
         qGgx0PQQeRfL2jU5hdDJoO5qs1s8ey3VUUefDHuXpF3wM3+YDn1CZsrpUy04Hlh15vQO
         vP1eF61NiwDvoobp7jCHyalRTn5Yy0HJmbLluuQ9sx4jIDokBuBpVeNo33ON0T0NINgC
         rFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=g7P2lvi/CVLZLbQp79knjPAt0SF93B/Bhs22/njzNFg=;
        b=n71gLUobUsjE+dsX91rIPTbR5FeN2F9XPbgoHvkTy328fTvGC46x8ZbyUcp0r+a2qN
         hXm89fwOUEP+fFgtaOLbwYXFNMFSK92EqHPj0f9Srm83VBXOlrT2/WZOj1+yg5u0Wszq
         LwrbI4WF8lRq8kFOLYdpU/ZfP4XKXCFRqmjb/cTcv5lZUy7FHTgZyNaqReSsBw1N4U8N
         hRYGpf92EpziDhyculzHoGKmfdpfHONNfq9UyWSNSmrkjOfVnNQ4QXcxYbUFj+o5W2Ae
         v647MMR22r+Xn9iMufpdUHmtG6zE207KFgJNEBm4Pq4E4Mzt7NCuCkl1ZqDZC3wYdMoE
         rxmg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=1czs4Mx4;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=1czs4Mx4;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 43/62] atm: zatm: Fix potential Spectre v1
Date: Mon, 14 May 2018 08:48:59 +0200
Message-Id: <20180514064818.884009535@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421383113753187?=
X-GMAIL-MSGID: =?utf-8?q?1600421627523824675?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
