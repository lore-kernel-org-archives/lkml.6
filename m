Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrxHerk8gdtoKBQp/gQcu5Xcl783+u+sagmpT7sZOP6zNBfNVfFdbUlY3vMTHYLdGFAGZjT
ARC-Seal: i=1; a=rsa-sha256; t=1526280856; cv=none;
        d=google.com; s=arc-20160816;
        b=kg29SaZFvBQzV1cjiTSHDV0CrE36iTVGjk7JBp3e7Oxy22/EyOBghBgISEjeEQIcx3
         /q4YysKiT5RyxXHFZKvdcpW/HilJBzeyxM9NO5xdtpsItz2dDkChTK2FLd167dO2N7MN
         KCYVDUyNUkb3tTwIdv9FwBt8LqDDvyP9grm2krrdGwb0f4ZBFfiosnV0OK3EKzux5zrR
         Avw0jfyrm8fqhD00gB8qpQEEcyEHQeiL6LLK7uhLw8WT/vqx0yXwceWw0gI/lQX2lS4C
         JI+o3nJ9gvFfi0XVlOOTi86Xlwm/YnSdVaYUQ8fIzgagvFO9+k/GelFkAaJxXMvkNXYO
         jamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=GLJOOT0Lj6DKcZNIZUBKOJDVIIG14bWOFFwib5U+9G0=;
        b=Mgu/sCh7ySu0SbfhhKqCWWmIceIeDWM375gM+ab2rFvmtoPLU6sXZN+pVFfX5sMr36
         VfSimfiJ2qewf3OvUJ6WkzELFo/hpB10eApTz+31Dewzv/lLkpV9eFerupwgY9tho9T7
         O5SCRSr7H52T9Od8TZg7DDP9MJq33wSt9eUuSIKy7f4tIWV7aP0PWeZBunzvbeEIO4aS
         VTNwxKNleb6tNmom/iURrGG3BMuPasoLgR1S3cQoP2sDoyFBwZ2EZOqTdtxElMvo8BPL
         An9M8LWqL/EYIeuYUMgKop7xVkv3iK5+NwyJs4uqteNJ6Lx/htdvI7Xi8RPk0d1TV6uj
         QW+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=G149DzPr;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=G149DzPr;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 26/36] net: atm: Fix potential Spectre v1
Date: Mon, 14 May 2018 08:49:00 +0200
Message-Id: <20180514064806.271076142@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421380423998410?=
X-GMAIL-MSGID: =?utf-8?q?1600421475532602377?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -697,8 +700,10 @@ static int lec_vcc_attach(struct atm_vcc
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
