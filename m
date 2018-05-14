Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpgdTBkWYuopB34JGt+i6iw+KeyhuA/8fMgN8z4uIg3aFR0Xk+8D7V/JBJDyPC5wZLteDq9
ARC-Seal: i=1; a=rsa-sha256; t=1526280765; cv=none;
        d=google.com; s=arc-20160816;
        b=UtZJTyrUb8LHxqzRnlHRVPnbOfTC+jbJMOSg5F84a61LM+4mCD6Z9J3uPqXN9o8Tgt
         XtPI6jn0vpJsfLr4LlJFNWO4OplVwIRxtM8skp5bpIotiHlmCVnIGy7LkVm29lprUa78
         AGAkEqg9syxz2+2mlGFxZT4PnWIcWO5ByneLluI09ZbSm4g3N9nGpWHoo1CTixT0BC2S
         jJ5/AZ86Hl328KKJ2KAY0W8EpGNGq3PbU98UBkIub0motEqPorbRIdLwPTww7w0gw8nU
         tyCLqE9TxDTMJgiTkb7Ezz6MILxhUQmm7UKzcVnKtLdl4znF+XkY6dy2jmDfzHDld/Y8
         0QTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=3C4qEeqCT+nxIeo0ZHBUFU3VWFJuB1A6SiaGmTLFzvY=;
        b=ll9u9pHsouotDZ+iL5YOc4wjEK6dAHYrs3eQDgWZZRwXxiITBVEcwE36Rr+srDBDCq
         9vz+1ZYmz+PY66VTSLna0TNENyh549bgW1gmQrhdcrzWm8cXM3VBL2hGloadSP8yCL7M
         EfRn3TfPrFbAMoAHG4GFXfssjIhbUEXcRYmuJ1tZxsyU2vF91z4lpw7WPeh74XlhU6+n
         FgZYYPEmeSzHzxN096/wR0UaXJAxTZ5Ef2eJjKBTC4sHjMEjPxkioBN+tM7DLv9n2jps
         rI4rzI30LExYqYl+OMmHDs7WTRdbGgfw5lPD6q9weChdFeCIvqFfyOpQV7TVUEhoPhXB
         PLag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=KpkF9jGq;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=KpkF9jGq;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 48/56] net: atm: Fix potential Spectre v1
Date: Mon, 14 May 2018 08:48:53 +0200
Message-Id: <20180514064759.262649994@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421380423998410?=
X-GMAIL-MSGID: =?utf-8?q?1600421380423998410?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
