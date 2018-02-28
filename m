Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvqdSe69BHQwLF3nDp9BYtREYaWFyOZ2L+RHWyEN/0Jq/bFERjn7BelIbYGyIgQo7icuXZm
ARC-Seal: i=1; a=rsa-sha256; t=1519831337; cv=none;
        d=google.com; s=arc-20160816;
        b=d5mIBYb01KBNqk4nVBrwQT7wB1i9uQaPAw+Lmj/9PRgI+FXCpjOShAE0DA2OZ4WTeu
         WVQNSKvgvWaZoj8bF1vqcMgzLolf73569zYrw+giBqqu39ESzSZiVwVLlBC64Bwz2dDc
         yAS+d/CKHuJ699rsdRzIqDCY62WMdcgN/i9q9TyjyeIwFw70DErQoHCTVv8R9EQnTh4D
         35mxKSwxVWoAKPj2GulFul0UkCrMjhIn9g7PCf0UDfRHtZrPT5/zsomiuUrfyhdMniDJ
         PMGztBWsuwo7DC1kLIuEu3EtoxLD+Ap+FLL3X7W1tc17rqScDQEdnZBIho4Qqgxp+PND
         o1mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=GVY/6uJEV7b+unnE2y8lVFrVIuKoyVXzMavZjNeBlTY=;
        b=IO0FzOr9/spq3xg+Q0NFMvmMJb9yWZJTDtTE/tRjD2rRrTAsj+sFH3tBDeF3IyrJ78
         aWOr3ZEpH2RxkLJw20Lon1t9WdS7/17MUJQ0H7DoFxHQlyXDF1tH3AnNZgwO5pTXgmAG
         DFUrW9GYjhyollD+k5u+9gxXZK4L9q4njAUlk2uyrjLluDfg1cJHz9S03wyU13N0z/i2
         5odeYfVt2kNAUEC0eVhM7RDgRxVTbodPo2Gp+1K2FtcDW8k2PZh7DnKlx+W9z3k+HILw
         j7N8Un/m32dWRbTl/SiklMuqArGsqTMj+1g0P4CC8RXpOt1w/FbR1YrFQOBnwMAbfvkC
         kyjg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Shuah Khan" <shuahkh@osg.samsung.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.734972010@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 060/140] usbip: prevent leaking socket pointer address
 in messages
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658664025208938?=
X-GMAIL-MSGID: =?utf-8?q?1593658664025208938?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 90120d15f4c397272aaf41077960a157fc4212bf upstream.

usbip driver is leaking socket pointer address in messages. Remove
the messages that aren't useful and print sockfd in the ones that
are useful for debugging.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.2: adjust filenames, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/staging/usbip/stub_dev.c
+++ b/drivers/staging/usbip/stub_dev.c
@@ -186,8 +186,7 @@ static void stub_shutdown_connection(str
 	 * step 1?
 	 */
 	if (ud->tcp_socket) {
-		dev_dbg(&sdev->udev->dev, "shutdown tcp_socket %p\n",
-			ud->tcp_socket);
+		dev_dbg(&sdev->udev->dev, "shutdown sockfd %d\n", ud->sockfd);
 		kernel_sock_shutdown(ud->tcp_socket, SHUT_RDWR);
 	}
 
--- a/drivers/staging/usbip/usbip_common.c
+++ b/drivers/staging/usbip/usbip_common.c
@@ -346,13 +346,10 @@ int usbip_recv(struct socket *sock, void
 	char *bp = buf;
 	int osize = size;
 
-	usbip_dbg_xmit("enter\n");
-
-	if (!sock || !buf || !size) {
-		pr_err("invalid arg, sock %p buff %p size %d\n", sock, buf,
-		       size);
+	if (!sock || !buf || !size)
 		return -EINVAL;
-	}
+
+	usbip_dbg_xmit("enter\n");
 
 	do {
 		sock->sk->sk_allocation = GFP_NOIO;
@@ -366,11 +363,8 @@ int usbip_recv(struct socket *sock, void
 		msg.msg_flags      = MSG_NOSIGNAL;
 
 		result = kernel_recvmsg(sock, &msg, &iov, 1, size, MSG_WAITALL);
-		if (result <= 0) {
-			pr_debug("receive sock %p buf %p size %u ret %d total %d\n",
-				 sock, buf, size, result, total);
+		if (result <= 0)
 			goto err;
-		}
 
 		size -= result;
 		buf += result;
--- a/drivers/staging/usbip/vhci_hcd.c
+++ b/drivers/staging/usbip/vhci_hcd.c
@@ -811,7 +811,7 @@ static void vhci_shutdown_connection(str
 
 	/* need this? see stub_dev.c */
 	if (ud->tcp_socket) {
-		pr_debug("shutdown tcp_socket %p\n", ud->tcp_socket);
+		pr_debug("shutdown tcp_socket %d\n", ud->sockfd);
 		kernel_sock_shutdown(ud->tcp_socket, SHUT_RDWR);
 	}
 
