Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932250AbeCKPRg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 11:17:36 -0400
Received: from mout.web.de ([217.72.192.78]:56875 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932118AbeCKPRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 11:17:34 -0400
Subject: [PATCH 2/9] um/drivers/vector_user: Less checks in
 user_init_raw_fds() after error detection
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: user-mode-linux-devel@lists.sourceforge.net,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-user@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Message-ID: <d68574df-868c-3a9a-b1fb-2e95b1a452a4@users.sourceforge.net>
Date: Sun, 11 Mar 2018 16:17:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:5kZe5SK1a1Y7+JZ+2vsCoHAxaOY3yjYUt4dexnHlRjbc6EWItLb
 L3VTnhhh2tj2IFjdD4PNZbXb1NgaJ0ITS/aWcrYhOM1NaebG5sO1BWu5sIDQCQimJM1qzxi
 5VqiO4srUM5e6e2bhroseOdc6TO+4or6nhrLjkz1Af35Ohkm/yH73UsdBQ3W23cQ6ZIbHVU
 EPqzjsovA2K3eR8MFpetQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FwMMmuvp6i4=:We7SeJCjQmIsx5SQQr704z
 PM+P+miUQERB5H+O6Uj4oMf6wfeSjndPzGYrLdHjMP3PnhfLMqNQivq/hOH+1yIXAPQrKUvi6
 Qd5aHHrY+0ZNWxD5baI/Qh9OtEcjlcG4Jj0U+YZZ7aZybn6+qXfuGJnujb2/HjHyHNehMsr9Q
 uZmh668mc5e3ASK/zePFvG0W7NL0275iUyMyCrvrrxY1rfGtrj2wjt628HepPpQX7CzzPqoFn
 9WO8nc1jaqiO3jN8UgS+6kyWu29uMAsSxUok5pQmmKim6bTxHIhH7s3YpzykVCoFkr+aWaW5f
 1vPsujpZ0yFmu9V559gAkOLHUdZVz/bfC6OsmifvOYxPN0vH+bTfSUUicORYisv/VnhhdflLD
 8eARJAk5XzOdnkML+UmZhG9HM2swwb8pP+QfWRI93A0y4P1AU93XDN5oNw4qKmCDnUpD+LdmA
 pCr213FISTiEr5F8MVh9PwhdRVbT4AaVCvzZgsSvq/4XXVJIfJ5qezjaW9p/xdRPRcXhtHkfh
 qoFwv2n/vkdnrrXI+nYMV8YQj/828VNQ31wHoIA1PllfMoM5MAzJ7UNVx7k9bVLtBV2ajeRdS
 U+Fl2baXlPjenKlzojMKX8ujLFBYv9rkZxj9teUrozUPVmRdna0w8s+Srw8ihwVB2zklc8jdw
 sBQ3HgiPobQ0etw/ueN9qYFEjwCrI7mYbX05hbFgq9b2329Yb6Emy7f10OS1HMw4coi8AHcNv
 o0F/wd4DPcWXObJhwwTrpLST6Iq/y9ztDHGBzyTopmltQlpmFz0Tz8VAdvq53W9e8311uTcR4
 QQQyNhpe4U337/e7nL4TFbyJoYloVvcn9W25PGMOc0h4hFr6WE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 11 Mar 2018 11:40:14 +0100

Up to two checks could be repeated by the user_init_raw_fds() function
during error handling even if the relevant properties can be determined
for the involved variables before by source code analysis.

* Adjust jump targets so that an extra check can be omitted at the end.

* Delete an initialisation for the local variable "rxfd"
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/um/drivers/vector_user.c | 61 ++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index d6a6207d4061..037cd85ee424 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -207,54 +207,46 @@ static struct vector_fds *user_init_tap_fds(struct arglist *ifspec)
 static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
 {
 	struct ifreq ifr;
-	int rxfd = -1, txfd = -1;
+	int rxfd, txfd = -1;
 	struct sockaddr_ll sock;
-	int err = -ENOMEM;
-	char *iface;
 	struct vector_fds *result;
 	int optval = 1;
+	int err;
+	char *iface = uml_vector_fetch_arg(ifspec, TOKEN_IFNAME);
 
-
-	iface = uml_vector_fetch_arg(ifspec, TOKEN_IFNAME);
-	if (iface == NULL)
-		goto cleanup;
+	if (!iface) {
+		err = -ENOMEM;
+		goto report_failure;
+	}
 
 	rxfd = socket(AF_PACKET, SOCK_RAW, ETH_P_ALL);
-	if (rxfd == -1) {
-		err = -errno;
-		goto cleanup;
-	}
+	if (rxfd == -1)
+		goto set_error_code;
+
 	txfd = socket(AF_PACKET, SOCK_RAW, 0); /* Turn off RX on this fd */
-	if (txfd == -1) {
-		err = -errno;
-		goto cleanup;
-	}
+	if (txfd == -1)
+		goto set_error_code;
+
 	memset(&ifr, 0, sizeof(ifr));
 	strncpy((char *)&ifr.ifr_name, iface, sizeof(ifr.ifr_name) - 1);
-	if (ioctl(rxfd, SIOCGIFINDEX, (void *) &ifr) < 0) {
-		err = -errno;
-		goto cleanup;
-	}
+	if (ioctl(rxfd, SIOCGIFINDEX, (void *) &ifr) < 0)
+		goto set_error_code;
 
 	sock.sll_family = AF_PACKET;
 	sock.sll_protocol = htons(ETH_P_ALL);
 	sock.sll_ifindex = ifr.ifr_ifindex;
 
-	if (bind(rxfd,
-		(struct sockaddr *) &sock, sizeof(struct sockaddr_ll)) < 0) {
-		err = -errno;
-		goto cleanup;
-	}
+	if (bind(rxfd, (struct sockaddr *)&sock, sizeof(struct sockaddr_ll))
+	    < 0)
+		goto set_error_code;
 
 	sock.sll_family = AF_PACKET;
 	sock.sll_protocol = htons(ETH_P_IP);
 	sock.sll_ifindex = ifr.ifr_ifindex;
 
-	if (bind(txfd,
-		(struct sockaddr *) &sock, sizeof(struct sockaddr_ll)) < 0) {
-		err = -errno;
-		goto cleanup;
-	}
+	if (bind(txfd, (struct sockaddr *)&sock, sizeof(struct sockaddr_ll))
+	    < 0)
+		goto set_error_code;
 
 	if (setsockopt(txfd,
 		SOL_PACKET, PACKET_QDISC_BYPASS,
@@ -270,12 +262,15 @@ static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
 		result->remote_addr_size = 0;
 	}
 	return result;
-cleanup:
-	printk(UM_KERN_ERR "user_init_raw: init failed, error %d", err);
-	if (rxfd >= 0)
-		os_close_file(rxfd);
+
+set_error_code:
+	err = -errno;
+	os_close_file(rxfd);
+
 	if (txfd >= 0)
 		os_close_file(txfd);
+report_failure:
+	printk(UM_KERN_ERR "%s: init failed: %d", __func__, err);
 	return NULL;
 }
 
-- 
2.16.2
