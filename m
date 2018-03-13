Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932439AbeCMT5A (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 15:57:00 -0400
Received: from mout.web.de ([212.227.17.12]:52793 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751714AbeCMT46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 15:56:58 -0400
To: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] iio/adc/nau7802: Improve unlocking of a mutex in
 nau7802_read_raw()
Message-ID: <f2874cab-329b-297f-2b4a-bfc72755123d@users.sourceforge.net>
Date: Tue, 13 Mar 2018 20:56:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:jNtyBwpp8soAHaqR9+aUaFbO6H8g5qxRwrMGuwV6xtHy+pmlOCJ
 IKMPjMPDTYXXX9rD7D8hy4W6X1IF/PZhKIF1kn2YArdfadxQxm1BD1pE0wN9FbliqKkbKYb
 jqlSfV7sL4PLEfYxi/UJRHdJT61wuJ+cW1rFl5Ao9XMEsTcAnqnjMN9eb2j2FBF4sW+84Vk
 oaEek24fUeW8gHpwtY0nw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ODQCqoLIlyI=:RvZjdBXq+9ZdJdkV0UKIsX
 P+ix5Cuhjp5kK9mtsq1bP0oayggyBhta4tQ/Md6qrL1tm541wCQYoHm5He/b2EEBCvRETd155
 nJiBWohc6GpzwHhKudaqFpXqfdmahcsv9rU5iUYmOllVMKaSFsn87tFDgPfNAF2ZZ/SKQdW+z
 mpXFC6N0DmwrQch9uXbtfI6UjBUzjw/XKWJJN+65tPPIxJKChzDQJjQEvhbSayg3/IhPh/Vni
 WJfU8nqknc4GS3osWmc8vvckXX8iEcBp/3vC4kBuRveC9ixVp3JSC5MltpBfUOVOAFMgLRPKd
 M/wqMBLw3BYBeLYumkxv5WGqquGoOmDCiRihqnvbOhdh7Q+70sQJNOoWGD7utoa7durw37xO7
 6jeHN20PKg8O5exok79fDY6WYUv5d4Z03zOZjEzTULOqeHcHAEcMZsq5QTiVKaGi8suxeeG2j
 LGy86O9Tp7yXs2ga6HvfeQZ4fGU2aAqqDgikEXmZppKTKaOMpZ0dWGSwx6qPeNFxt2KIF3x+X
 Uv3GPFaTvHyap7sqRwoYTHKNfrroLdKkERBzjqszm1ueeIU81REXzG2d4tpXFdpyxkDJNWZ4F
 vilB6isOVo42U2yiE1AZai+NPpiboh8gxKy4+flIHxqMRZ5TBqXUZcEce88d11vsdudaDsY2Z
 DH3ghHUsxijWh15qWBLcfVvWGwNv7UYCn7a3TYwikNUug9VQL0Nw1Se4Zk6ySpN+LeOAVgfkc
 tC42QS3MDbTopIEEyYybdxXSAyz8RR2+NIGoftz1D+VscQWjeMi74U/F/NDELsbaf6M4Cav3X
 CYNuEV+UNkawaf21FqlxYisNjni9M9ngP7v9zG1GGL2dToOWlE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 13 Mar 2018 20:52:26 +0100

* Add a jump target so that a call of the function "mutex_unlock" is stored
  only once in this function implementation.

* Replace two calls by goto statements.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/adc/nau7802.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
index 8997e74a8847..68d06a492760 100644
--- a/drivers/iio/adc/nau7802.c
+++ b/drivers/iio/adc/nau7802.c
@@ -303,10 +303,8 @@ static int nau7802_read_raw(struct iio_dev *indio_dev,
 		 *   - Channel 2 is value 1 in the CHS register
 		 */
 		ret = i2c_smbus_read_byte_data(st->client, NAU7802_REG_CTRL2);
-		if (ret < 0) {
-			mutex_unlock(&st->lock);
-			return ret;
-		}
+		if (ret < 0)
+			goto unlock;
 
 		if (((ret & NAU7802_CTRL2_CHS_BIT) && !chan->channel) ||
 				(!(ret & NAU7802_CTRL2_CHS_BIT) &&
@@ -316,18 +314,15 @@ static int nau7802_read_raw(struct iio_dev *indio_dev,
 					NAU7802_REG_CTRL2,
 					NAU7802_CTRL2_CHS(chan->channel) |
 					NAU7802_CTRL2_CRS(st->sample_rate));
-
-			if (ret < 0) {
-				mutex_unlock(&st->lock);
-				return ret;
-			}
+			if (ret < 0)
+				goto unlock;
 		}
 
 		if (st->client->irq)
 			ret = nau7802_read_irq(indio_dev, chan, val);
 		else
 			ret = nau7802_read_poll(indio_dev, chan, val);
-
+unlock:
 		mutex_unlock(&st->lock);
 		return ret;
 
-- 
2.16.2
