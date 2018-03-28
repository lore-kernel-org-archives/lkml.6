Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753023AbeC1Nz7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:55:59 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:51283 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbeC1Nz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:55:58 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Max Gurtovoy <maxg@mellanox.com>, Parav Pandit <parav@mellanox.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: target: fix buffer overflow
Date: Wed, 28 Mar 2018 15:55:13 +0200
Message-Id: <20180328135522.2345359-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:PRBSVk8jgrrDzPtYzlprjfxG20U50GkEkVOZgU9MXwrrWgHh/Yw
 Bdw03T8g4V/izBhH3V/8WioS3AnWgXdmL0YdAB+q/Cbg/nHbzieWamB8Jdpt87B12EZP0Wj
 cMECq3unZ6HQvGE7yVvl18msZke/pWmYiW/t2IM4goP/a/SK5fVDQzpi5GERb5TqDG37hRs
 G+nACVuoCTASkPCCvChpA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TkJnn+uo0Qo=:vDUHRzJZ5+xaJy0Pi0rPxY
 Y59a96dRE0tY4yO/dXIwff8NowummLYs8+fYxjfbnXnO5HZ4dI61WYdrqU1sBXWtfmz0FZ93m
 qHPTjm+GCbTfn8O2JsfNNo7pxDrBO7SJqWSZhTIFtIFQobyGqoyZDRmYSfvG7K4FPbbLD7UgQ
 4lU3uMHk31pK2239u8VEie0n4ltYdbDtIKJVo+sjArgzxgtiYX5xU9y9fLqqIM8b3YLW2csf/
 AOACFaFCWFp4gH8AtdMuyZyJ+SvzMZVwFYZQmuPyml7sE9X4bdb6rYk84hH5y9cAoj0ai0x+K
 Cq1cmphx2qRry/LPB+JUHfZQBZ2H3z6n3p5funnhc6l0gFIb6kGbingRDKTFOXDU3y611Kgxo
 8gyXIf9oGG/pXcFMmKzmVwshoMYXeFHQWay2Kur7T+gIGB6yzEng33fz6onosXMEIIiJPPEVk
 isGNXfWUzqYvcatanz6HvBzT6jL43X9t1g0gy4v4Hd9+d4yiNJzsUBQYYC3gajvNRZjkL2SP+
 Jvor5WyjcOH4UM8wUWJFwiPXYxpMKD2qq5iqERcmSZ4R6MoZKGrCKyedPjj4iYo6A3iQTjPM8
 2Tobahew7KYNxNtEbFHXhoK/ZVXsBaUSnpFeZ/j5QvwXyW5+pI7D8gTdlAv/Xnh77Dvk3OTW5
 r+cPTbeDdjYz83Qt4ePhrEmCpEMgy1MDuHsjRHHZqN77RxSg2P5WFcqnEB+s2yxs1RlVoT93N
 JPjc5hKjTufAX0YPpkdroHpvy2844rHA6xfYAg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvmet_execute_get_disc_log_page() passes a fixed-length string into
nvmet_format_discovery_entry(), which then does a longer memcpy() on
it, as pointed out by gcc-8:

In function 'nvmet_format_discovery_entry',
    inlined from 'nvmet_execute_get_disc_log_page' at drivers/nvme/target/discovery.c:126:4:
drivers/nvme/target/discovery.c:62:2: error: 'memcpy' forming offset [38, 223] is out of the bounds [0, 37] [-Werror=array-bounds]
  memcpy(e->subnqn, subsys_nqn, NVMF_NQN_SIZE);

Using strncpy() will make this well-defined, filling the rest of the
buffer with zeroes, under the assumption that the input is either
a NUL-terminated string, or a byte sequence containing no zeroes.
If the input is a string that is longer than NVMF_NQN_SIZE, we
continue to have no NUL-termination in the output.

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I'm not sure why this only showed up in linux-next now, the bug seems
to have been in that file for a while.
---
 drivers/nvme/target/discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index d5e19493e3fa..84e731e57f07 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -59,7 +59,7 @@ static void nvmet_format_discovery_entry(struct nvmf_disc_rsp_page_hdr *hdr,
 	memcpy(e->trsvcid, port->disc_addr.trsvcid, NVMF_TRSVCID_SIZE);
 	memcpy(e->traddr, traddr, NVMF_TRADDR_SIZE);
 	memcpy(e->tsas.common, port->disc_addr.tsas.common, NVMF_TSAS_SIZE);
-	memcpy(e->subnqn, subsys_nqn, NVMF_NQN_SIZE);
+	strncpy(e->subnqn, subsys_nqn, NVMF_NQN_SIZE);
 }
 
 /*
-- 
2.9.0
