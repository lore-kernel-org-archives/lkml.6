Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELv6+BHDS1jBO4u/6jUVvaqNWy2epmZ4ru9X+Iyh2LSO2DmWCPOro8Mei/qesBR/APb0RE6+
ARC-Seal: i=1; a=rsa-sha256; t=1519831347; cv=none;
        d=google.com; s=arc-20160816;
        b=bGeH2HLh93LDGoB+BlYg6913mGqd9iZUZX4Uf1xdwgzrHQiB6/eyDA3kSd4cg/FMH8
         d10ds9Wt4OeoqIGaQfMBABVx59i5M0zb4WccfnPsak7kIHVjuUaMhavG2tSgkhNYna0a
         fi5NuA2hwN37HaJzADAxGsw8OOpwZb7yArEzGwR6n0fUN80g61TslRRWOCQJCpa837IR
         jWUtSDuH7kwMRvfreBN0tMaIvNVDlKiutR1sENJPccJvmWeae1N+nmGntuLffw9sCCQK
         7TXDW2Fgywu1JkpOzajj6o8V1sLT4NqK4D8OA6I2Xmjuk1OEZGpz1bFb5yFof7yTZp96
         BJ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=sC1tqxrc8NzviiJ6wH4YRniPuRGXrO6lrlsO/mqP4So=;
        b=FMeFfCOsRI6fFNrqeXEHlJxlphwf9aG4eoS2UP6pJLf6sRU2IeD2vO06i428Fmlkwf
         LFXYEpJlVmSmPVm1KSG8Jj2kv8uhxXv3gqbQIRNkNdibaJOFJaXCjCobkRIzVbTqomtY
         UddNKR40b2pX4vF1qZ1L9hKWC/1UnpDMZf8GSseE8cU+IleaiM5JyrguZGj7AFlEifil
         oEVWxJLoLNwI+0thQZqhkg6lsVRKoJZCE8l0IYTUzaxrK3qqfQh8McYl6/goy9txb6KO
         aAr6z/4iWbc0OKbv77gpMNAmyLTWhUM9uIgJyxUrnh+TsvIcd8IjJ5oxHvVdMC/8+Xll
         SjcQ==
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
 "Shuah Khan" <shuahkh@osg.samsung.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.683007469@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 129/254] usbip: prevent leaking socket pointer
 address in messages
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658664025208938?=
X-GMAIL-MSGID: =?utf-8?q?1593658674824117176?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 90120d15f4c397272aaf41077960a157fc4212bf upstream.

usbip driver is leaking socket pointer address in messages. Remove
the messages that aren't useful and print sockfd in the ones that
are useful for debugging.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust filenames, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/staging/usbip/stub_dev.c
+++ b/drivers/staging/usbip/stub_dev.c
@@ -190,8 +190,7 @@ static void stub_shutdown_connection(str
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
@@ -333,13 +333,10 @@ int usbip_recv(struct socket *sock, void
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
@@ -352,11 +349,8 @@ int usbip_recv(struct socket *sock, void
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
@@ -767,7 +767,7 @@ static void vhci_shutdown_connection(str
 
 	/* need this? see stub_dev.c */
 	if (ud->tcp_socket) {
-		pr_debug("shutdown tcp_socket %p\n", ud->tcp_socket);
+		pr_debug("shutdown tcp_socket %d\n", ud->sockfd);
 		kernel_sock_shutdown(ud->tcp_socket, SHUT_RDWR);
 	}
 
