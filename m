Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932220AbeCKPX4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 11:23:56 -0400
Received: from mout.web.de ([217.72.192.78]:57349 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932141AbeCKPXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 11:23:54 -0400
Subject: [PATCH 8/9] um/drivers/vector_user: Less checks in
 user_init_tap_fds() after error detection
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: user-mode-linux-devel@lists.sourceforge.net,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-user@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Message-ID: <123bc855-031f-1884-388b-f56df4be5be5@users.sourceforge.net>
Date: Sun, 11 Mar 2018 16:23:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:h2wgIRGyKfem9yNrQBKVvmBClQbhFulFsuLArDorNjO7oDQ9Tg/
 5C7C+5MyksDcKhJ9sX0ezvXN3k48Bc74qJS3/+FrhE2/bGMUA7GN1khUY7E8R5o69zgUi1/
 WdvR3TU+U5rpjeRAh/2n1IBLQM+fIBeXQGjS1Gan8SoF88xzzfZTM6/P4sqw+yQp/gVlLTD
 BDw429tAC/KORtWqoHC4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0JAKh6Zn83I=:Zo2sLpu3z1LGW8S12RVkH+
 vdG0g5rKOdZUfQJ5na6g7GNzw4Rg9kuR1Qxt9Y2E4rqNeapasCyYRiK3nDNDCIvNcWI3cQmfL
 opc49y6kJTQzY5pj3J2OlQ9JtxHIUT4/M6EtilZGxMjAzJKFY0NxKRGxmKNabgkN0yZDTtdtB
 1bcpDPKtNKHxgYITzQR4zS0kOS6m8MBjg/zJegaaVSFm40o3UlW0JmZoBvCROVPmTCZgdiuWq
 qJm9KkeNV8dVmd2j/Hw1YHMoaLyQ4bmCVwS+7UJqq+1uLBLGs7l3Sjijxygyd7l0Es7Wk6WXu
 +y5ScMHc6hf/qqbpl2gwpW82TFFTysDgJdZke1aVqDkSzMG+DNHLlBIPwBCHFGRaPidAZaYnx
 u8Mht7y4RPuvjtUofPfiR6Ew52zVwbPFoBQITACvh7StaB0BaUyQNxEWJCP4p4wkROEgl4FfI
 USHFLaRAiw1qkc9mBbnboM/thjaZNDRwHC628vXd9QKvT4HlWLK9w+XBR/MEIRYNnw1tyHf58
 fSONr7AWJn15VJvBz1Sak+Xfyx7LL7ICeTcHYT+PQPhb4SqNtfu/Q2fVhXdNozeEutWP7vBQn
 8Q8v6ndiq2PCgFaiaBEisJ//mo77FPWvK0Www/LaXjF2aJjRDTPGYjqTy2nJugslY2/EAtGTx
 hD0pwtamZPyXKyZkdyCi0FIpozrxC4cbtKWwgFj2ZqvMlWxpa/U3EO0byl3j0+1L1ohi0eW+p
 OHxdJUz7xsjvFYLxp3zi0ldojcI2YUrhUseGrKDNkXqZLCNq/iOm0rSrCgwfnMuh68pT5Eo8d
 ZaDSL3OWrHAFA9uDLFdu5p8rBfodzym2cavtdMofSm0759GDxc=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 11 Mar 2018 15:43:31 +0100

Three checks could be repeated by the user_init_tap_fds() function
during error handling even if the relevant properties can be determined
for the involved variables before by source code analysis.

* Adjust jump targets.

* Delete three sanity checks and an initialisation (for the local
  variable "result") which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/um/drivers/vector_user.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index 5e78723c34d4..bd625034a0f0 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -123,18 +123,18 @@ static struct vector_fds *user_init_tap_fds(struct arglist *ifspec)
 	struct sockaddr_ll sock;
 	int err = -ENOMEM, offload;
 	char *iface;
-	struct vector_fds *result = NULL;
+	struct vector_fds *result;
 
 	iface = uml_vector_fetch_arg(ifspec, TOKEN_IFNAME);
 	if (iface == NULL) {
 		printk(UM_KERN_ERR "uml_tap: failed to parse interface spec\n");
-		goto tap_cleanup;
+		goto report_failure;
 	}
 
 	result = uml_kmalloc(sizeof(struct vector_fds), UM_GFP_KERNEL);
 	if (result == NULL) {
 		printk(UM_KERN_ERR "uml_tap: failed to allocate file descriptors\n");
-		goto tap_cleanup;
+		goto report_failure;
 	}
 	result->rx_fd = -1;
 	result->tx_fd = -1;
@@ -146,7 +146,7 @@ static struct vector_fds *user_init_tap_fds(struct arglist *ifspec)
 	fd = open(PATH_NET_TUN, O_RDWR);
 	if (fd < 0) {
 		printk(UM_KERN_ERR "uml_tap: failed to open tun device\n");
-		goto tap_cleanup;
+		goto free_result;
 	}
 	result->tx_fd = fd;
 	memset(&ifr, 0, sizeof(ifr));
@@ -156,7 +156,7 @@ static struct vector_fds *user_init_tap_fds(struct arglist *ifspec)
 	err = ioctl(fd, TUNSETIFF, (void *) &ifr);
 	if (err != 0) {
 		printk(UM_KERN_ERR "uml_tap: failed to select tap interface\n");
-		goto tap_cleanup;
+		goto close_tx_fd;
 	}
 
 	offload = TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6;
@@ -168,7 +168,7 @@ static struct vector_fds *user_init_tap_fds(struct arglist *ifspec)
 	if (fd == -1) {
 		printk(UM_KERN_ERR
 			"uml_tap: failed to create socket: %i\n", -errno);
-		goto tap_cleanup;
+		goto close_tx_fd;
 	}
 	result->rx_fd = fd;
 	memset(&ifr, 0, sizeof(ifr));
@@ -176,7 +176,7 @@ static struct vector_fds *user_init_tap_fds(struct arglist *ifspec)
 	if (ioctl(fd, SIOCGIFINDEX, (void *) &ifr) < 0) {
 		printk(UM_KERN_ERR
 			"uml_tap: failed to set interface: %i\n", -errno);
-		goto tap_cleanup;
+		goto close_rx_fd;
 	}
 
 	sock.sll_family = AF_PACKET;
@@ -188,18 +188,17 @@ static struct vector_fds *user_init_tap_fds(struct arglist *ifspec)
 		printk(UM_KERN_ERR
 			"user_init_tap: failed to bind raw pair, err %d\n",
 				-errno);
-		goto tap_cleanup;
+		goto close_rx_fd;
 	}
 	return result;
-tap_cleanup:
-	if (result != NULL) {
-		if (result->rx_fd >= 0)
-			os_close_file(result->rx_fd);
-		if (result->tx_fd >= 0)
-			os_close_file(result->tx_fd);
-		kfree(result);
-	}
 
+close_rx_fd:
+	os_close_file(result->rx_fd);
+close_tx_fd:
+	os_close_file(result->tx_fd);
+free_result:
+	kfree(result);
+report_failure:
 	printk(UM_KERN_ERR "%s: init failed: %d", __func__, err);
 	return NULL;
 }
-- 
2.16.2
