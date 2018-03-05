Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbeCEIcq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 03:32:46 -0500
Received: from mout.web.de ([217.72.192.78]:51081 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751483AbeCEIcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 03:32:43 -0500
Subject: [PATCH 2/4] scsi: hpsa: Less function calls in
 hpsa_big_passthru_ioctl() after error detection
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-scsi@vger.kernel.org, esc.storagedev@microsemi.com,
        Don Brace <don.brace@microsemi.com>,
        "James E. J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <f013341a-e3b2-69a7-4918-8bb3d109f0cc@users.sourceforge.net>
Message-ID: <e53f792c-0062-1b7a-a914-fa5f62b9a5c9@users.sourceforge.net>
Date: Mon, 5 Mar 2018 09:32:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f013341a-e3b2-69a7-4918-8bb3d109f0cc@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Y/lM97Sz93C0ANeqOcHlDzh4o8RZGt3sdlgvkll2rnXEkwO94xH
 eVjax4TUviRVSAlOK5HibGFRM6qYZoQMudMVLVbW90PRd3iwuXEEN0LT3rNNK1Hk6r2gLc6
 Hitx84Zs8yHKHtsGQg6KTqNC9EYxSU15sEhgCx+SXaHNasnR4eDR/qmalAkPZPJ9v/9qB0/
 4n0w3mslJB4sZNcjA/jpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M8JT4hgY4z0=:7BqNJNCT3BCTf3Ku4NWiy6
 aWTe92ItB/kgbFZqfHgFRYAgl4wIcVn7IRhkXE1CtG3rlDwNl87ZU9PvawnQfbwMXs0n+HTgs
 BF19y4IuZP56Fw8jfX6Oy2mkxYFhgrzozEoc711Q9nkn89jfBlC6zVntdz5NRNO0HkuUOk2CS
 r5zqSEryebhVe+SbypnB2p0bmQihMLUdHz4w8t5Y9wGNQ8pfhE9D+ZIW23xhv4F3H7ylGvltE
 iKJaJoIXkBH/E+T1Au07jOwrZvOSYM15CT466TWj6pl3k352LRQc4e+/ur9iWl6WUqdKM9+Wv
 2w+e0bsziqOVYY46weLRCRPqrfkmbSZ9e7JhDCNrUn7JytuH5PX9zbJW3doNGV4HU6ImGhu2v
 IiANp04T2nAZ+qHcHQ1C35hwt+r0s+Dr9TLH+SPr5VBET93+0lCCZNfQTeKhXd0kPSco+SiX4
 nDaNk0vonJazbD/EBmOJK4yXheHitrwq3pglmEc5EtQqKh5Cf2yKB5SpXcFCvo1cK5qdqleEM
 dvc/6D9QBmVoOe+Jx3eVSKxZXfhU3BzBwhwInQBzFodvNjQdTABbI1c6O0w5C0I+7BGpDnZzJ
 E2ib0zoEo5IBnXAcazdBgftIqvnlk+mxZBLIty13YW0wTeZDwYsfLh0nVAQWNwsLw5olQvC77
 AnCNglJj2nF9f5yXPVMtz8zkWQiP4VRRdQWoFlRX+SvF58Y+wnAlVWzlZaq9UW/3yS1z85/+i
 xDq5LYyYGDZ0sYbXj6VJ7uUn4E1mvDiuL0RNpDC0yGlK+qEvyLmDwsflQ2+031MX5rT+y/SxS
 wbDSfaYWKSkCrUg77po+S81SmJNF4Om4NcGEfgWbe9CAPSRaYU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 4 Mar 2018 22:00:19 +0100

The function "kfree" was called in a few cases by
the hpsa_big_passthru_ioctl() function during error handling
even if the passed variable contained a null pointer.

* Adjust jump targets.

* Delete two initialisations and a check (for the local variable "buff")
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/scsi/hpsa.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index b35248becef9..45177ead811f 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -6377,8 +6377,8 @@ static int hpsa_big_passthru_ioctl(struct ctlr_info *h, void __user *argp)
 {
 	BIG_IOCTL_Command_struct *ioc;
 	struct CommandList *c;
-	unsigned char **buff = NULL;
-	int *buff_size = NULL;
+	unsigned char **buff;
+	int *buff_size;
 	u64 temp64;
 	BYTE sg_used = 0;
 	int status = 0;
@@ -6397,26 +6397,26 @@ static int hpsa_big_passthru_ioctl(struct ctlr_info *h, void __user *argp)
 	if ((ioc->buf_size < 1) &&
 	    (ioc->Request.Type.Direction != XFER_NONE)) {
 		status = -EINVAL;
-		goto cleanup1;
+		goto free_ioc;
 	}
 	/* Check kmalloc limits  using all SGs */
 	if (ioc->malloc_size > MAX_KMALLOC_SIZE) {
 		status = -EINVAL;
-		goto cleanup1;
+		goto free_ioc;
 	}
 	if (ioc->buf_size > ioc->malloc_size * SG_ENTRIES_IN_CMD) {
 		status = -EINVAL;
-		goto cleanup1;
-	}
-	buff = kzalloc(SG_ENTRIES_IN_CMD * sizeof(char *), GFP_KERNEL);
-	if (!buff) {
-		status = -ENOMEM;
-		goto cleanup1;
+		goto free_ioc;
 	}
 	buff_size = kmalloc(SG_ENTRIES_IN_CMD * sizeof(int), GFP_KERNEL);
 	if (!buff_size) {
 		status = -ENOMEM;
-		goto cleanup1;
+		goto free_ioc;
+	}
+	buff = kzalloc(SG_ENTRIES_IN_CMD * sizeof(char *), GFP_KERNEL);
+	if (!buff) {
+		status = -ENOMEM;
+		goto free_buff_size;
 	}
 	left = ioc->buf_size;
 	data_ptr = ioc->buf;
@@ -6501,14 +6501,16 @@ static int hpsa_big_passthru_ioctl(struct ctlr_info *h, void __user *argp)
 cleanup0:
 	cmd_free(h, c);
 cleanup1:
-	if (buff) {
+	{
 		int i;
 
 		for (i = 0; i < sg_used; i++)
 			kfree(buff[i]);
 		kfree(buff);
 	}
+free_buff_size:
 	kfree(buff_size);
+free_ioc:
 	kfree(ioc);
 	return status;
 }
-- 
2.16.2
