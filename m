Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpRtGbE59uZxb490CW8eamigs9QksKSIigi3QKXNocV3IKau6gmYJcgByTDhiAz1902Qr2c
ARC-Seal: i=1; a=rsa-sha256; t=1526280998; cv=none;
        d=google.com; s=arc-20160816;
        b=xaJ3dYYhkRxPgoZlSII6nCxzBxoN/k5Yk+EPieg/UG5M30IjQA1USTeVhkS3bZbt5l
         qmI6oWHCAWO2X/KOg7L6yTZDRKT76SHgwGkXocrE4qJOAeAIAa5FL1Bixx6VDnkXPuaQ
         K5isTQMW8yoBhRyTPax+J7gk0s5cB0f1l8xCoXgQZbORrKQoOHTVUznsvshf3dW8qyZi
         lrF10DmTd3xaXQ87fvWAMHEV0zBfminixr2hHE+imI5rlDXjVzY+1QJvuny8phN3AoBn
         +YwKLWcBgu9SL+iu7e1fyr4LDi9akaygNGv4MkZCHW6nZ4XPAN0hNIwuFDPubHC7ZebY
         BDkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=AhSKqN31nRJCD5rxf4zZxzr4zrv6K5E8GQvEwdet8JA=;
        b=hl/vRRlE1mH9u08nsQaMC712fjyGfIyIh6/f6f1tOFu+NAivmCSLWV/qJ55GxWZSa3
         QUWqH2PhnqTbAkcltzXiTWR80Db2o13PndNRFkbgc9gT8PABBSbmlOBuugGSac+CjQCm
         2UKJ95GgLimmmIwSgtt60P3oIm/PcIL/0QXWYnKeC5LPtyVcxJoLi54MuMZi/9BAb2iU
         YP0WOWJBHUHM2gxrAB3Mnm0/FMmcXxZHQwir40sHaQzAqbBME4/WZTvJXETCTnBF7mx5
         jl6SOKdIb2vIi08hkYPNfZYGX0zkqNetyy0Oolqi/zsFybZCTPkkbIQ2sOMi9zJrAbxS
         xKpA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=MPK7VH+x;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=MPK7VH+x;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 42/62] net: atm: Fix potential Spectre v1
Date: Mon, 14 May 2018 08:48:58 +0200
Message-Id: <20180514064818.826924980@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421380423998410?=
X-GMAIL-MSGID: =?utf-8?q?1600421624317645267?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit acf784bd0ce257fe43da7ca266f7a10b837479d2 upstream.

ioc_data.dev_num can be controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:
net/atm/lec.c:702 lec_vcc_attach() warn: potential spectre issue
'dev_lec'

Fix this by sanitizing ioc_data.dev_num before using it to index
dev_lec. Also, notice that there is another instance in which array
dev_lec is being indexed using ioc_data.dev_num at line 705:
lec_vcc_added(netdev_priv(dev_lec[ioc_data.dev_num]),

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/atm/lec.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -41,6 +41,9 @@ static unsigned char bridge_ula_lec[] =
 #include <linux/module.h>
 #include <linux/init.h>
 
+/* Hardening for Spectre-v1 */
+#include <linux/nospec.h>
+
 #include "lec.h"
 #include "lec_arpc.h"
 #include "resources.h"
@@ -687,8 +690,10 @@ static int lec_vcc_attach(struct atm_vcc
 	bytes_left = copy_from_user(&ioc_data, arg, sizeof(struct atmlec_ioc));
 	if (bytes_left != 0)
 		pr_info("copy from user failed for %d bytes\n", bytes_left);
-	if (ioc_data.dev_num < 0 || ioc_data.dev_num >= MAX_LEC_ITF ||
-	    !dev_lec[ioc_data.dev_num])
+	if (ioc_data.dev_num < 0 || ioc_data.dev_num >= MAX_LEC_ITF)
+		return -EINVAL;
+	ioc_data.dev_num = array_index_nospec(ioc_data.dev_num, MAX_LEC_ITF);
+	if (!dev_lec[ioc_data.dev_num])
 		return -EINVAL;
 	vpriv = kmalloc(sizeof(struct lec_vcc_priv), GFP_KERNEL);
 	if (!vpriv)
