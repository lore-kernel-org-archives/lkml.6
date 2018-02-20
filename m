Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeBTU5G (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 15:57:06 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:56733 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeBTU5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 15:57:05 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky <leonro@mellanox.com>,
        Dasaratharaman Chandramouli
        <dasaratharaman.chandramouli@intel.com>,
        Eddie Wai <eddie.wai@broadcom.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] infiniband: bnxt_re: use BIT_ULL() for 64-bit bit masks
Date: Tue, 20 Feb 2018 21:56:27 +0100
Message-Id: <20180220205638.1959033-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220205638.1959033-1-arnd@arndb.de>
References: <20180220205638.1959033-1-arnd@arndb.de>
X-Provags-ID: V03:K0:KhaiDgnSD+cMVSEl4+FmNZV5Xvd8iAdqyCgQ6IqXONx796W7T67
 7oJ4p9mwdhNdqkqOw79AcPVcTpWi7LFsrTvA//UH/GBJzziGlz3xQ/SsiULN8El8ztKVqNn
 q5DaMODZho3RXtoyVtXXVYfojMZq4K7gPIcEDLgyvfXerYefdCqeN3FDMEu/XUMfWNP+zfu
 T3MKgGHStbusx+dE4VGRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rLqOSOpHLl4=:ULde+PK2ZaeuPJmF3bWEZL
 kMHKeSyyhr98hAX+UEK2++XNPFFwO3xRTjR+mk5Y1fDQRdqADCFjSAkeHsUnHQBOHHyPiqRaz
 1PFssl9hvMdASmYwrd8LwagQfAElufyHF16NOoqRxnrq2jEAFWuI62uVHSnUNkklaDiC0gL9h
 RrPN6AoKtpraedF7AqYVdNi9g8B1g03J/6TS6puv+VB42C5jN9vl+q3s3E5nIdEkez5Rd6KKF
 GqHEIggXwb8oiBi/6DmmkRGnobmm1USKLASD5WQ+b62h3n0VrSGFshkUIL4qD++0I7IivkwbY
 VrEGNC7RTWwmLOVNEkRjIT1Plt30SeiI5Ngw65uEyyyjzoDmTO9itH8Ul35rgcfJmeEVuigxG
 oM+V1LESskcvz76RGLrlyUGRgNmdLhrFVkplnxZdYCpw6gRevNXBTFnWBUEYNoYy8k3ilA/Zn
 ZYMIjNzKUvQPmGD9H/JPy7hp/wU7+ll4Y2QXUWXhBqZqF4D6mePnWqtS2xabgodDICY6ihGq6
 leF1B1jdAnglWTg480CQgFZOgTwq3OxSxxsPB812edIR14abzHf7/7s54HAYM9kucZ/pg5IJ6
 MlqsOAdfvIu04l/kxM+LVLNWNsaXbdm9oRqM9xmb4F9G8mlRk0iPi+sl6MOigQBs1d14jg5fo
 kBzHozbq8AFmeapNlYGMMXnKp4NGg6BQR+VM/DO8jBhmyVGIUxOsiue6R0pnnDfTpi+PRe6+0
 E7waCwnQLECQZpPWPjOIGES6exPE1Cdh3SUMgg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit targets, we otherwise get a warning about an impossible constant
integer expression:

In file included from include/linux/kernel.h:11,
                 from include/linux/interrupt.h:6,
                 from drivers/infiniband/hw/bnxt_re/ib_verbs.c:39:
drivers/infiniband/hw/bnxt_re/ib_verbs.c: In function 'bnxt_re_query_device':
include/linux/bitops.h:7:24: error: left shift count >= width of type [-Werror=shift-count-overflow]
 #define BIT(nr)   (1UL << (nr))
                        ^~
drivers/infiniband/hw/bnxt_re/bnxt_re.h:61:34: note: in expansion of macro 'BIT'
 #define BNXT_RE_MAX_MR_SIZE_HIGH BIT(39)
                                  ^~~
drivers/infiniband/hw/bnxt_re/bnxt_re.h:62:30: note: in expansion of macro 'BNXT_RE_MAX_MR_SIZE_HIGH'
 #define BNXT_RE_MAX_MR_SIZE  BNXT_RE_MAX_MR_SIZE_HIGH
                              ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/infiniband/hw/bnxt_re/ib_verbs.c:149:25: note: in expansion of macro 'BNXT_RE_MAX_MR_SIZE'
  ib_attr->max_mr_size = BNXT_RE_MAX_MR_SIZE;
                         ^~~~~~~~~~~~~~~~~~~

Fixes: 872f3578241d ("RDMA/bnxt_re: Add support for MRs with Huge pages")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  | 4 ++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index ca32057e886f..32dbde48f3e6 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -57,8 +57,8 @@
 #define BNXT_RE_PAGE_SIZE_8M		BIT(BNXT_RE_PAGE_SHIFT_8M)
 #define BNXT_RE_PAGE_SIZE_1G		BIT(BNXT_RE_PAGE_SHIFT_1G)
 
-#define BNXT_RE_MAX_MR_SIZE_LOW		BIT(BNXT_RE_PAGE_SHIFT_1G)
-#define BNXT_RE_MAX_MR_SIZE_HIGH	BIT(39)
+#define BNXT_RE_MAX_MR_SIZE_LOW		BIT_ULL(BNXT_RE_PAGE_SHIFT_1G)
+#define BNXT_RE_MAX_MR_SIZE_HIGH	BIT_ULL(39)
 #define BNXT_RE_MAX_MR_SIZE		BNXT_RE_MAX_MR_SIZE_HIGH
 
 #define BNXT_RE_MAX_QPC_COUNT		(64 * 1024)
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index ae9e9ff54826..56878387c8f9 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3548,7 +3548,7 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 	int umem_pgs, page_shift, rc;
 
 	if (length > BNXT_RE_MAX_MR_SIZE) {
-		dev_err(rdev_to_dev(rdev), "MR Size: %lld > Max supported:%ld\n",
+		dev_err(rdev_to_dev(rdev), "MR Size: %lld > Max supported:%lld\n",
 			length, BNXT_RE_MAX_MR_SIZE);
 		return ERR_PTR(-ENOMEM);
 	}
-- 
2.9.0
