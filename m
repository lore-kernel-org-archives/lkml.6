Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753108AbeDBQ7u (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 12:59:50 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:39426 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752530AbeDBQ7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:59:47 -0400
X-ME-Helo: ubuntu-CJ.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 02 Apr 2018 18:59:45 +0200
X-ME-IP: 86.244.119.222
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nfarnesi4@gmail.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] iio: sca3000: Fix an error handling path in 'sca3000_probe()'
Date: Mon,  2 Apr 2018 18:59:42 +0200
Message-Id: <20180402165942.9056-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, we must undo the previous 'sca3000_configure_ring()' call
in order to free some memory.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iio/accel/sca3000.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index f33dadf7b262..dae4c594c170 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1496,7 +1496,7 @@ static int sca3000_probe(struct spi_device *spi)
 					   "sca3000",
 					   indio_dev);
 		if (ret)
-			return ret;
+			goto error_unconfigure_ring;
 	}
 	indio_dev->setup_ops = &sca3000_ring_setup_ops;
 	ret = sca3000_clean_setup(st);
@@ -1513,6 +1513,9 @@ static int sca3000_probe(struct spi_device *spi)
 	if (spi->irq)
 		free_irq(spi->irq, indio_dev);
 
+error_unconfigure_ring:
+	sca3000_unconfigure_ring(indio_dev);
+
 	return ret;
 }
 
-- 
2.14.1
