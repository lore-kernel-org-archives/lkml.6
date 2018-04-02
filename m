Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753166AbeDBRAB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 13:00:01 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:34706 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753124AbeDBQ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:59:56 -0400
X-ME-Helo: ubuntu-CJ.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 02 Apr 2018 18:59:55 +0200
X-ME-IP: 86.244.119.222
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nfarnesi4@gmail.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] iio: sca3000: Handle errors returned by 'sca3000_configure_ring()' in 'sca3000_probe()'
Date: Mon,  2 Apr 2018 18:59:53 +0200
Message-Id: <20180402165953.9110-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'sca3000_configure_ring()' can fail, so test its return value and
propagate it if needed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Un-tested and not 100% sure that we should bail-out if it fails.
---
 drivers/iio/accel/sca3000.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index dae4c594c170..45285edd216f 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1486,7 +1486,9 @@ static int sca3000_probe(struct spi_device *spi)
 	}
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	sca3000_configure_ring(indio_dev);
+	ret = sca3000_configure_ring(indio_dev);
+	if (ret)
+		return ret;
 
 	if (spi->irq) {
 		ret = request_threaded_irq(spi->irq,
-- 
2.14.1
