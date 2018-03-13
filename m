Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933477AbeCMMJj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:09:39 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:54759 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932682AbeCMMJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:09:36 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Martin Sebor <msebor@gmail.com>,
        Toshihiko Matsumoto <Toshihiko.Matsumoto@sony.com>,
        Kota Yonezawa <Kota.Yonezawa@sony.com>,
        Satoshi Watanabe <Satoshi.C.Watanabe@sony.com>,
        Masayuki Yamamoto <Masayuki.Yamamoto@sony.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: cxd2880-spi: avoid out-of-bounds access warning
Date: Tue, 13 Mar 2018 13:09:11 +0100
Message-Id: <20180313120931.2667235-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:S+RFW9etdNDC9M0CHb7K1B1lRqYbNXjaHzikiIkxk41IBs0W2ML
 V6J+6ziBK8bHpW6fpH83s3zVPmzQ/8c9vcefKMNK/24BB1pobR3/PXmCbI+QYRwx9DB5oxq
 nOOrU6R3UjgXmhPlQUIti2buGE3UmE0oq9H3qqgwr7aGif5NvzPHVcSTp77mjYqJ9pwey7K
 tY+86ec7VUtdBPdPSHKDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Czu44b+jZZs=:Z6FllyUz9tfSDwWjX9iETa
 hz1fs75nZiFgNGQUOf5tIey9058JcnGzqCMt8FiHUpjVhVdODb7iZsjs1/z1KGLV/CFimvDr+
 D7P2I6YTSzZHkC+Ec2i+/wx2IzM9vwLrgksARHE5RZB3EY0yF8Ezx5oJtEsSWpWcNj1eHv7Wr
 DE84agqIkROpkcI5+M6aN0bg4+gotQCRYBfiaQktfzWSmR+zWw730JnupxpJZwyr7y4LnzxTx
 65daJub+u9VsvHlo0ZlUelZfxamWNZRZBSR5omYigWx9jlCjCIQ4Ybdk0hmPn78vxyMcbRoDO
 UPmkdPCzjwmH+wBOb/DyCFcmrtthBbBdzOjQntOSFpYhKAZsKvAArvNojWt5LjeT80QF32A2y
 A61M9VzRJdRVhaCjUkuVnzmEbohbVrPUJjh2LQUQEGkKNbcESj40mXFo2jjmWxXr0sbyob5hk
 UvvU8NuMJfG3Nzntj1cEkSZa6OwgcYyicugWFFVXaL0Q12jSibCagQeB8FEONWHuAtlYs966J
 AxX1QY5ap/o5NytehYOKS9X0JZM+mPBhXFHdgMfP3KCk/KsgCixDcC0X68J68/UOm/DBdjxhG
 iIIpdZd/+rET5ygIk6H8cnhfFNQlMvDGSb5Ao/21IY15lKD54pkw2eaOmwbf+KRjjF3dsCDem
 QRi2bl+nJFDl1r+/R4TEmybEKWpAh2z6NZrrRQHJsfKoMmjSMcEzl14s/wRrgDSaxzR2Ir8Ou
 1y9Iqc7b3C1k0KqIDwjN6KDd2p6DMrPHg+htjw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -Warray-bounds warning in gcc-8 triggers for a newly added file:

drivers/media/spi/cxd2880-spi.c: In function 'cxd2880_write_reg':
drivers/media/spi/cxd2880-spi.c:111:3: error: 'memcpy' forming offset [133, 258] is out of the bounds [0, 132] of object 'send_data' with type 'u8[132]' {aka 'unsigned char[132]'} [-Werror=array-bounds]

The problem appears to be that we have two range checks in this function,
first comparing against BURST_WRITE_MAX (128) and then comparing against
a literal '255'. The logic checking the buffer size looks at the second
one and decides that this might be the actual maximum data length.

This is understandable behavior from the compiler, but the code is actually
safe. Since the first check is already shorter, we can remove the loop
and only leave that. To be on the safe side in case BURST_WRITE_MAX might
be increased, I'm leaving the check against U8_MAX.

Fixes: bd24fcddf6b8 ("media: cxd2880-spi: Add support for CXD2880 SPI interface")
Cc: Martin Sebor <msebor@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/spi/cxd2880-spi.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/media/spi/cxd2880-spi.c b/drivers/media/spi/cxd2880-spi.c
index 4df3bd312f48..011a37c2f272 100644
--- a/drivers/media/spi/cxd2880-spi.c
+++ b/drivers/media/spi/cxd2880-spi.c
@@ -88,7 +88,7 @@ static int cxd2880_write_reg(struct spi_device *spi,
 		pr_err("invalid arg\n");
 		return -EINVAL;
 	}
-	if (size > BURST_WRITE_MAX) {
+	if (size > BURST_WRITE_MAX || size > U8_MAX) {
 		pr_err("data size > WRITE_MAX\n");
 		return -EINVAL;
 	}
@@ -101,24 +101,14 @@ static int cxd2880_write_reg(struct spi_device *spi,
 	send_data[0] = 0x0e;
 	write_data_top = data;
 
-	while (size > 0) {
-		send_data[1] = sub_address;
-		if (size > 255)
-			send_data[2] = 255;
-		else
-			send_data[2] = (u8)size;
+	send_data[1] = sub_address;
+	send_data[2] = (u8)size;
 
-		memcpy(&send_data[3], write_data_top, send_data[2]);
+	memcpy(&send_data[3], write_data_top, send_data[2]);
 
-		ret = cxd2880_write_spi(spi, send_data, send_data[2] + 3);
-		if (ret) {
-			pr_err("write spi failed %d\n", ret);
-			break;
-		}
-		sub_address += send_data[2];
-		write_data_top += send_data[2];
-		size -= send_data[2];
-	}
+	ret = cxd2880_write_spi(spi, send_data, send_data[2] + 3);
+	if (ret)
+		pr_err("write spi failed %d\n", ret);
 
 	return ret;
 }
-- 
2.9.0
