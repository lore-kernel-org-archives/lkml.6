Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpDiXlwr9vqCVZfWVEi2WiC1CdKJZuci6638ThbrqeR8x7TiUUtP25ql+joc14HoD+diDyA
ARC-Seal: i=1; a=rsa-sha256; t=1526281189; cv=none;
        d=google.com; s=arc-20160816;
        b=Ex78I8VSstBsjRBI2H3ZRCVQX5lIWekC3mUui7Mqhje09mp9CHkV8v5XqglWazsSZO
         OoFWzXDquqKRuPPnpfBE0nm7oVxOoCZESSJBHvcl1XyuW6RNOSv6yv2akP5cAstq5YyO
         xLGTN8hi63tQxeqUcneDIL3MYvjzT4Jxb8aaLWSO0vFemHJcsXiQnIFXUv14Yuz0b2GB
         NosCwtd7q3OmJugNSW8gNV3LDSVi8ADlEu/t9e4lQlfLrqJCvTbA9kvtc6fGLyy4GO/O
         eWmZxuaybHyTT2GNIIuWhcN4xF7nPm5hdiITR4wfN4ifpzjaOvP2OJE/ZtzGDoMkB8SW
         Cmqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=4YaZPgAy9gJLDEQaiKXVAm7jJmeuFSEcNRddXteM9IU=;
        b=PWkUwi1B9YLkcavHlSgaHwFw8LF+U+FtF4qKhPBEInCqH7b92l4g1Oj8t4kbS0dDG6
         ugvUqu/UEaJUVSsDJZA7pGsBmFfTnPv0NiXOWGIUo7Kq1QZSkcqX+s8vqh/eG42LTbVd
         8ddbmKYcWyK+VVxKQ2/hnF3kfjLtiBRNu7EBaf42WGvCjgcSofIrFw8vWjtBQQbWGfzg
         XfefxsVquw/fd2gW/+W3vAkI0oWQgTRF1bLHbP9eNguT1/Ad/rG36vIeEobgUhVryjIS
         lazUmkCUJUSgd5C0I4Pjsv7SJKZpTzgvy/KquDnTDSo88xwV6pDNBTEKQ4qFmkv1F0aw
         iuBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=M3tLs4oE;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=M3tLs4oE;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 50/72] net: atm: Fix potential Spectre v1
Date: Mon, 14 May 2018 08:49:07 +0200
Message-Id: <20180514064825.572953481@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421380423998410?=
X-GMAIL-MSGID: =?utf-8?q?1600421823980581926?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
