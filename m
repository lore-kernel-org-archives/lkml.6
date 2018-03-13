Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752625AbeCMTQ6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 15:16:58 -0400
Received: from mout.web.de ([212.227.17.11]:33983 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751997AbeCMTQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 15:16:55 -0400
To: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] iio/adc/ad7291: Improve unlocking of a mutex in
 ad7291_read_raw()
Message-ID: <a53248a9-4422-4436-aa43-bfbd2b60a85f@users.sourceforge.net>
Date: Tue, 13 Mar 2018 20:16:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:IftT0/FB8vm1TNcxmuG/gpWMqlg9vvVG5y84y9DhSi6JQf575c6
 eX6OEU/hhzElt2Q2zJl3KQpuiEucjtEEkY4lWOIpDTog+pAL4vJ++qCF+S52NTry1E7LzKl
 qVEVEAdvC/sm1y/Wy3sJtk0Uy1AUaYrqaUs615D3DZj5Av7pG6smtoHqLpo54ySQirNbwBI
 67n+pv6GVvNx0azcwdd9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/xEKgIh2J4A=:0iU/9GmaEazpIr+/SK6a9T
 tGi6jUZpBsCRrqNbt+wXHnoEIMP5pi7fowyRZGU80IuMlexwaHot9aPRPpNxhILRCrNJTarci
 /D0wfXg55AIMrk3JO8dgdvGvFULkH0xTrkWNv+U+OZ9uk9Wwwp7Q55JfHL5qNQaqfRDWfII9f
 yoiLWb9Ppv3Y4WqapbTnbCZmpkqKNY+BeS+jHdfxA05rRwji+/w6CdilyL6pSRuz08DM71hJn
 Xt2zF11XigLLZB4xiyUy+6FtOc6Y88hEEb6nZhB2q/qcicZ3IO8abrmjskgrTUZ7J/W+4wbjD
 dUTgazSggptxNiyaerUEHnAIwey+1yGq+fx2ypvbtK8LSuouc20xYHPuC+P/cTBnj/3Ruidt7
 VAgXwKxcSQ5wCZpSNSyNiNmgxn6P6z/+IQw4BNUxl9XVq6TyOADTbUr6ZkId5cGRqDw3OtQ8O
 zW4jTOLvimMAE51NEvJx0qMZXHlCRXYi1NKnQwXsDvLi4C6N6EzxZbLDKfVRGUuFq5R68iLTN
 /xFa+XxVgOw3/K0s93InNnzF0HBPuKKpc/ZyiKlM/JdeKyL4PWOI12uwsFkzeda7fdubJUGNn
 dXN+84RzVV/L2L6PlM/odm3QAAS1oytx14Gb/ifEY5PfEo2yF860cWrE+BySmqadwG5ZnZeX1
 CZH6256NkTJNst+HvMOHhzAwfPJcTnUGPo89DiDf3rX7KgO3TCsAybpsgOEh4nWKi8/n2w5tX
 PDT+E+dNazotlI9iGk8qc7Nwiimg1M587dD1BodcaZv4ce0Yp/O3FF+0JEu5cZt0trxjRGWS2
 THCHutOR4WL5vo9CFyWlnfItd/Thxl5FY8Qwif10eptyrC0Ad4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 13 Mar 2018 20:08:40 +0100

* Add a jump target so that a call of the function "mutex_unlock" is stored
  only once in this function implementation.

* Replace three calls by goto statements.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/adc/ad7291.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
index a862b5d8fb4b..b2c3d4c79909 100644
--- a/drivers/iio/adc/ad7291.c
+++ b/drivers/iio/adc/ad7291.c
@@ -335,27 +335,27 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 			mutex_lock(&chip->state_lock);
 			/* If in autocycle mode drop through */
 			if (chip->command & AD7291_AUTOCYCLE) {
-				mutex_unlock(&chip->state_lock);
-				return -EBUSY;
+				ret = -EBUSY;
+				goto unlock;
 			}
 			/* Enable this channel alone */
 			regval = chip->command & (~AD7291_VOLTAGE_MASK);
 			regval |= BIT(15 - chan->channel);
 			ret = ad7291_i2c_write(chip, AD7291_COMMAND, regval);
-			if (ret < 0) {
-				mutex_unlock(&chip->state_lock);
-				return ret;
-			}
+			if (ret < 0)
+				goto unlock;
+
 			/* Read voltage */
 			ret = i2c_smbus_read_word_swapped(chip->client,
 							  AD7291_VOLTAGE);
-			if (ret < 0) {
-				mutex_unlock(&chip->state_lock);
-				return ret;
-			}
+			if (ret < 0)
+				goto unlock;
+
 			*val = ret & AD7291_VALUE_MASK;
+			ret = IIO_VAL_INT;
+unlock:
 			mutex_unlock(&chip->state_lock);
-			return IIO_VAL_INT;
+			return ret;
 		case IIO_TEMP:
 			/* Assumes tsense bit of command register always set */
 			ret = i2c_smbus_read_word_swapped(chip->client,
-- 
2.16.2
