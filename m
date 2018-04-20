Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755966AbeDTQCh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:02:37 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:51115 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755923AbeDTQCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:02:35 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bradley Grove <linuxdrivers@attotech.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Tomas Henzl <thenzl@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND 2] scsi: esas2r: use ktime_get_real_seconds()
Date: Fri, 20 Apr 2018 18:02:09 +0200
Message-Id: <20180420160219.3560091-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:w3BU8myseDQpQSO/o/xq04Ipu0/0uvNIqfUWBZmDIeK14mlE2JU
 DyIAr08p4f/sO9SPUZu2GeQPYcRy2r12sWqol1R1dYqgB8suoOQ0jHo6rNTeUlmlXV6KEGC
 w1uLJvq/9yYN01kpU6YXvKx3jzdJi6iIvAbmRbXamyAsK7GZBQRnRYqs42QSZXsf5NHngIp
 awTCK0gtoV717JwEhxleA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Uj+3k/qT1Go=:T5ztMrlipzpdfdf743xu24
 AoKgmmSW6S4wh8vJoK7CvaDHIkrINDDPrkPSzp6NIZIWkAn20M6kplKDUqYK4/SITPcU6uwCL
 4LTz5JPlmJNDv9mKrVuCtg1V8wOI0ZmUCAx9uTdykjrwJDRjBU9967lT9cIKmv3QeWtJxpHQg
 Huq/iIGIxlVcYt36JkhFEX+F3C5I+0es7ZyEa3IyLpsm1xlqCiUlyxMqWfTgZivDWm+TWqZks
 hrUjN/jCMjw1PJvh8gaVMq7VRX7MSpgpXjoeqSU1VXawV6gSiQig69AJCLfn3kjPbaYLoKsP9
 dPBB4FT6X8n7IVK/JyZNv08qwW4B/cLFcPYSKZRJTHddDzuTMfxGkdDzmCyhP4m4QnFu0dyNp
 32sZQAxmT3zDZeN7kmKuor/jHmi1sdo77GxJx3mwcUfTxg3lAtdIWpyz4iGUHaKtMtYhD8WME
 xuGhHGvVnBkG+sQgdIKx55rEBt1pV1Ak/Npy/1ss54fNnPIda8k75zm5jp/6W7ZH6pPdtmyir
 QPuJwRAz0h0JWog3ow8PnmtHP3jisdw0FG+TsPBy67lz5yPLXgJcbuC+KZK2Udig+eMzWWe2n
 z3hm/2lU6+VD3S/BCa9v12NbNGPcM9Mh+EiL3HUKyjJuGxG0965XTkvXRwVrydUZaQWyUyu8X
 4dmogvOYvmiZEW3KzBDSqfCd+cr/VeKzdZTU+yL0K8c0WB7TY2yPGda0brsDBsx9kzoqkZxni
 ZePAxsm8ZjO4KGcoVsWcqfYh2ITh3MFt35eDwQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_gettimeofday() is deprecated because of the y2038 overflow.
Here, we use the result to pass into a 32-bit field in the firmware,
which still risks an overflow, but if the firmware is written
to expect unsigned values, it can at least last until y2106,
and there is not much we can do about it.

This changes do_gettimeofday() to ktime_get_real_seconds(), which
at least simplifies the code a bit, and avoids the deprecated
interface. I'm adding a comment about the overflow to document
what happens.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Originally submitted in November 2017, no reply.
Sent again in January, still no reply.

Resending once more now, could you please apply the trivial patch?
---
 drivers/scsi/esas2r/esas2r_init.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/esas2r/esas2r_init.c b/drivers/scsi/esas2r/esas2r_init.c
index 9dffcb28c9b7..9db645dde35e 100644
--- a/drivers/scsi/esas2r/esas2r_init.c
+++ b/drivers/scsi/esas2r/esas2r_init.c
@@ -1202,8 +1202,6 @@ static bool esas2r_format_init_msg(struct esas2r_adapter *a,
 	case ESAS2R_INIT_MSG_START:
 	case ESAS2R_INIT_MSG_REINIT:
 	{
-		struct timeval now;
-		do_gettimeofday(&now);
 		esas2r_hdebug("CFG init");
 		esas2r_build_cfg_req(a,
 				     rq,
@@ -1212,7 +1210,8 @@ static bool esas2r_format_init_msg(struct esas2r_adapter *a,
 				     NULL);
 		ci = (struct atto_vda_cfg_init *)&rq->vrq->cfg.data.init;
 		ci->sgl_page_size = cpu_to_le32(sgl_page_size);
-		ci->epoch_time = cpu_to_le32(now.tv_sec);
+		/* firmware interface overflows in y2106 */
+		ci->epoch_time = cpu_to_le32(ktime_get_real_seconds());
 		rq->flags |= RF_FAILURE_OK;
 		a->init_msg = ESAS2R_INIT_MSG_INIT;
 		break;
-- 
2.9.0
