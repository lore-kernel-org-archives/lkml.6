Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224ZQWfoajj4SV1IX/bqg9Oso477Blkn3LLUdth2F7PK/utldJneK6xrUiVsm/tn4Drck7Ij
ARC-Seal: i=1; a=rsa-sha256; t=1518708039; cv=none;
        d=google.com; s=arc-20160816;
        b=gauM6C8zJoVHRZUcImZWk2t7nPgOkGIcHDs0NfmI+QEry2fVmp/4Nin9VHUO1fEBzM
         3CZ1znKxihIjCh0mGcf/9VjTnizvChkSJA9dyzcidD3UfhYFC/eJu7vJrzA8zza730rs
         nK9De/hnQJH83dFoE3jxwHqzYU+LUjzBTtabiV+vVwQ2qfpHvHW5351lQOi1n0zOFc1P
         5SJB04GqtNSiCmIIonBM+paqg9Kl0j4S//4EmaqP5raLq98wcjKTVYJcVv8XVFhNZ8zL
         CSM+Hl4s5rnge+d/EfpkUtqDMT7XiEPtLDvYDEqLjMizxko9c7oG+QzEM8QlpKlZaayd
         tFFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lfAV6lBuj7e/vusqT6KnFq+gflGO9h8tKGFhIngZZ2U=;
        b=gwk4szyUZZIKkEYjmjh8EPzqtxIz7Xs8zkNDc+GwKZ1L5Af5yvvcBU1c1IHuX2z3Ek
         IXkOqg/dBvlgRYlHgd4t3HQnTRDin70jRAdMR2Z0YcoDRlltACS15qdQ3hsNEGtzOGIm
         EFZnsJisi8q3nbHEVvPwgJrMoNrQHmVvbEf+bdybVllhTHhIbjYXd8p/uRnWj+nfBuIA
         BwezkCMYJjnZl3f/uRd87hGyEs6Sd3jO29VzfCBAkL8BpuPF1qHZCS3GvIp5he0NjTKE
         7WOQLWbrs7xzSP8TlEYHUwrWo9nzELfq4qJw6PQa4T1lgjEsLTZjbL/rLHR9FQTcwdH1
         2mfg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 3.18 21/45] usbip: prevent leaking socket pointer address in messages
Date: Thu, 15 Feb 2018 16:17:12 +0100
Message-Id: <20180215144120.421046542@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480801427227738?=
X-GMAIL-MSGID: =?utf-8?q?1592480801427227738?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 90120d15f4c397272aaf41077960a157fc4212bf upstream.

usbip driver is leaking socket pointer address in messages. Remove
the messages that aren't useful and print sockfd in the ones that
are useful for debugging.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/stub_dev.c     |    3 +--
 drivers/usb/usbip/usbip_common.c |   15 ++++-----------
 drivers/usb/usbip/vhci_hcd.c     |    2 +-
 3 files changed, 6 insertions(+), 14 deletions(-)

--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -163,8 +163,7 @@ static void stub_shutdown_connection(str
 	 * step 1?
 	 */
 	if (ud->tcp_socket) {
-		dev_dbg(&sdev->udev->dev, "shutdown tcp_socket %p\n",
-			ud->tcp_socket);
+		dev_dbg(&sdev->udev->dev, "shutdown sockfd %d\n", ud->sockfd);
 		kernel_sock_shutdown(ud->tcp_socket, SHUT_RDWR);
 	}
 
--- a/drivers/usb/usbip/usbip_common.c
+++ b/drivers/usb/usbip/usbip_common.c
@@ -317,18 +317,14 @@ int usbip_recv(struct socket *sock, void
 	struct msghdr msg;
 	struct kvec iov;
 	int total = 0;
-
 	/* for blocks of if (usbip_dbg_flag_xmit) */
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
@@ -341,11 +337,8 @@ int usbip_recv(struct socket *sock, void
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
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -782,7 +782,7 @@ static void vhci_shutdown_connection(str
 
 	/* need this? see stub_dev.c */
 	if (ud->tcp_socket) {
-		pr_debug("shutdown tcp_socket %p\n", ud->tcp_socket);
+		pr_debug("shutdown sockfd %d\n", ud->sockfd);
 		kernel_sock_shutdown(ud->tcp_socket, SHUT_RDWR);
 	}
 
