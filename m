Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932227AbeCKPV7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 11:21:59 -0400
Received: from mout.web.de ([212.227.17.12]:59059 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932137AbeCKPV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 11:21:57 -0400
Subject: [PATCH 6/9] um/drivers/vector_user: Less checks in
 user_init_socket_fds() after error detection
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: user-mode-linux-devel@lists.sourceforge.net,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-user@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Message-ID: <a47f1d9b-f917-bb98-9872-fcae70e67ac3@users.sourceforge.net>
Date: Sun, 11 Mar 2018 16:21:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:wsEplIWHHY5y0bkNJW2UvdSmz9q79Nel8epTAuEeGRNwKEpaD1L
 o1v05eGdPjAK658332JwtDYN6t4/xM6DwRphgBotoEVMjtD4ITe+tPcVGA/HSOfpo8xIclh
 avFwHgQ5iYwYh6B4Yw/igLjU4W3tUSpzRz3iKDOMDRRbRMxqXw2eoiDFjtRrbqPZaSaex3r
 JxMXlfQhvZnDwCpuC2+cQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yUvKFoXjULk=:9MPMRAPwI7A+DWZC/+SaR2
 MsBBsgW0kLb1QQva82k3LezWQp61tfpPj+CQQ12TI2gOFDwB+NJiGBRlHq71kjPxsVVyoqqHN
 rAo4f9ikVP9Vzmb95O3+VtGT+7L8u1zZiG1F4K6dmf33cU/bGN7u7I3/nQFKNDEXcHpfEkDSl
 iacgs34mV0dFeNEeLuIrb93U7vCTKkSdKSUjyA5TBlq/cpbL6Ti5ATvF7k4BjTkYhlqQJ75lA
 INyW7snmD/loTwABJEuOiNbAH2fXjXe1qkH6AD/nfd+ON8WVxiKWeS0IZspYFuh0SwvZYhPGU
 AHbCxMpMeZLMJInrgQNpA1JnRz4QiXrn1ZoFJTENWmXpESjW8GjndXkbRZcfuEm2jJH8p67tt
 S3kIp16TQPOWwKAcfiPfBX4Pmgg2Pn/AHspmuIJFO5GCQLj4oW68oF78bXr0Ex8Ee3cAVOHnl
 BBo8taR5kvpTTo9Ger4vOmZX6x9wCEfZETMAdtcZJfEbUv4As3288Tn5Mw3O2lipq3GcdDbtl
 APL+zdUKZtlQVX3J1od4vsoCNEpl/470SO+jS25z1yaCOANfWcPwYn+U3Jm6P9+Gs5doexUbM
 PnlWbC8xrIFVYJBBmlPMQGe5y4twohGmV2GXgTlJmHIj3PxwAG4JWSsyP75IF23PiNYhr6+26
 Ae8RWHABJ3MJ5mW6Ou0ZV5DlN6hrU1PZJ757wxntw2VDEtHufcoOO437vJd9szccECN/9SfcS
 D18nt+ONK/zOqRkrvsiLBZhV9NEGiV4itgNnLPfxYrZvJoVkqRVuq6bhCi5+MeSklPAQODOhz
 VSotyy1XmCvEYHlJZHp94CL+VzoUDkqzSOTxbPC1LjMhT3TH50=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 11 Mar 2018 14:56:38 +0100

Two checks could be repeated by the user_init_socket_fds() function
during error handling even if the relevant properties can be determined
for the involved variables before by source code analysis.

* Adjust jump targets.

* Delete two sanity checks and a call of the function "kfree"
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/um/drivers/vector_user.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index 2dee1e183387..4c265262a369 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -375,13 +375,13 @@ static struct vector_fds *user_init_socket_fds(struct arglist *ifspec, int id)
 			"socket_open : could not open socket, error = %d",
 			-errno
 		);
-		goto cleanup;
+		goto free_info;
 	}
 	if (bind(fd,
 		(struct sockaddr *) gairesult->ai_addr,
 		gairesult->ai_addrlen)) {
 		printk(UM_KERN_ERR L2TPV3_BIND_FAIL, errno);
-		goto cleanup;
+		goto close_file;
 	}
 
 	freeaddrinfo(gairesult);
@@ -403,7 +403,8 @@ static struct vector_fds *user_init_socket_fds(struct arglist *ifspec, int id)
 		result->remote_addr = uml_kmalloc(
 			gairesult->ai_addrlen, UM_GFP_KERNEL);
 		if (result->remote_addr == NULL)
-			goto cleanup;
+			goto free_result;
+
 		result->remote_addr_size = gairesult->ai_addrlen;
 		memcpy(
 			result->remote_addr,
@@ -413,16 +414,13 @@ static struct vector_fds *user_init_socket_fds(struct arglist *ifspec, int id)
 	}
 	freeaddrinfo(gairesult);
 	return result;
-cleanup:
-	freeaddrinfo(gairesult);
-
-	if (fd >= 0)
-		os_close_file(fd);
-	if (result != NULL) {
-		kfree(result->remote_addr);
-		kfree(result);
-	}
 
+free_result:
+	kfree(result);
+close_file:
+	os_close_file(fd);
+free_info:
+	freeaddrinfo(gairesult);
 	printk(UM_KERN_ERR "%s: init failed: %d", __func__, -ENOMEM);
 	return NULL;
 }
-- 
2.16.2
