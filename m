Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeCMMrr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:47:47 -0400
Received: from mout.web.de ([212.227.17.11]:36615 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750903AbeCMMrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:47:45 -0400
To: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] iio/accel/kxcjk-1013: Improve unlocking of a mutex in three
 functions
Message-ID: <a4522ea5-78dc-4746-054a-7477d395630f@users.sourceforge.net>
Date: Tue, 13 Mar 2018 13:47:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:w4J00DZxUzxovB92QQDzo1xBUnfQNYk0uQarQvBhDUYcKRWQmjc
 D1nMOeXPNcRvn/kmSsemdaIbCHkjbP0t6Y42ziy0rTBAX+3E1O6w44W6oaR+WSeFBpYAFZ1
 R23f80nzgVaheeIanoo4U+8sLxdtt4pl+EvkR4yE0IH1hviI+702K40A7Z3LvFDjhPGdccS
 Ww+f0dV2NbtQmHDwI518g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G3f3aCWzbIM=:bPT2EHbwHw5dxyKAQGCnxs
 lgwKRF+rri3TNJDcVUmIUvmM8T89orL37jpKsTz5U3e8tRyaLD0q9Pq1qYmdXhHArZg6mOJar
 Uvug83FniFRcLIp5S/6dHA3Gppq7rP3kvbZ2PRPMe9Tz3RwCDaRdYJO4F0ukuyr9ZWo4BQdYm
 +v071xtKQSzMx6yQRsALihzFjimg+73DQ+YivP9rUHzaR8V071aTjUV+qNvKW51RRlFiqzOg0
 MD1/OFerQUwtI1t63qwMfNrkt2TgsYo+30ICl7jxgkwdqS2fGUBUchuH9LWP7z/gU4iJXMUVJ
 x5h2R9qsaoeaqHJLqp1R3yxbBkpavZrQHHBQAyvt3y1Rv4pCMeD9AKAETEieWMkeui/7X9Qwy
 kC5AQ363PSXjRexVbYcKFvt3quIT3qq2krpeWrFBUDj033XwSXWqOxB9VpPtrGPFM4gVt6/pg
 hNrTi4bCb815G1uALJq098UucfrHdzlqZSr6GxkgaYNn6F9t+m6QpjCBMB2NikVYawO48FDH7
 R+kzT7EZi1uVNh2IWLiLnI6Up8VZ0qHyWrNIb1if1bQFW6d2CJ0xhxkAVBS4rgRv8EU6BDN1a
 VonxQz24CijmjI3fpAVbqp4G62TITqonoZdcx2b9H93u3GW1yk2k7/exqWNPNlblCxFmGlS8D
 vpMf4eswvhQqWoMylEW6qi9Y29DhPeVZ4+OWn6533BhRS+oRNhnSPqKMTtcOtEq8jBT4G4u9f
 fgOr88dSpsmhI8TlQujaCNCvtyae3HIYt5crTBQUPavGuoSoJlWAxaN8ElT+ZhfAfE+GselpQ
 lTf04Lt4yNgWPxNZFZsoklI7V8EQ5xs6PfZFCxI6u/rQk5ShWE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 13 Mar 2018 13:40:12 +0100

* Add jump targets so that a call of the function "mutex_unlock" is stored
  less often in these function implementations.

* Replace eight calls by goto statements.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/accel/kxcjk-1013.c | 46 ++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index af53a1084ee5..4adf38b6d939 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -765,19 +765,18 @@ static int kxcjk1013_read_raw(struct iio_dev *indio_dev,
 			ret = -EBUSY;
 		else {
 			ret = kxcjk1013_set_power_state(data, true);
-			if (ret < 0) {
-				mutex_unlock(&data->mutex);
-				return ret;
-			}
+			if (ret < 0)
+				goto unlock;
+
 			ret = kxcjk1013_get_acc_reg(data, chan->scan_index);
 			if (ret < 0) {
 				kxcjk1013_set_power_state(data, false);
-				mutex_unlock(&data->mutex);
-				return ret;
+				goto unlock;
 			}
 			*val = sign_extend32(ret >> 4, 11);
 			ret = kxcjk1013_set_power_state(data, false);
 		}
+unlock:
 		mutex_unlock(&data->mutex);
 
 		if (ret < 0)
@@ -905,8 +904,8 @@ static int kxcjk1013_write_event_config(struct iio_dev *indio_dev,
 
 	if (!state && data->motion_trigger_on) {
 		data->ev_enable_state = 0;
-		mutex_unlock(&data->mutex);
-		return 0;
+		ret = 0;
+		goto unlock;
 	}
 
 	/*
@@ -919,23 +918,20 @@ static int kxcjk1013_write_event_config(struct iio_dev *indio_dev,
 	 * is always on so sequence doesn't matter
 	 */
 	ret = kxcjk1013_set_power_state(data, state);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
-		return ret;
-	}
+	if (ret < 0)
+		goto unlock;
 
 	ret =  kxcjk1013_setup_any_motion_interrupt(data, state);
 	if (ret < 0) {
 		kxcjk1013_set_power_state(data, false);
 		data->ev_enable_state = 0;
-		mutex_unlock(&data->mutex);
-		return ret;
+		goto unlock;
 	}
 
 	data->ev_enable_state = state;
+unlock:
 	mutex_unlock(&data->mutex);
-
-	return 0;
+	return ret;
 }
 
 static int kxcjk1013_buffer_preenable(struct iio_dev *indio_dev)
@@ -1086,32 +1082,30 @@ static int kxcjk1013_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 	if (!state && data->ev_enable_state && data->motion_trigger_on) {
 		data->motion_trigger_on = false;
-		mutex_unlock(&data->mutex);
-		return 0;
+		ret = 0;
+		goto unlock;
 	}
 
 	ret = kxcjk1013_set_power_state(data, state);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
-		return ret;
-	}
+	if (ret < 0)
+		goto unlock;
+
 	if (data->motion_trig == trig)
 		ret = kxcjk1013_setup_any_motion_interrupt(data, state);
 	else
 		ret = kxcjk1013_setup_new_data_interrupt(data, state);
 	if (ret < 0) {
 		kxcjk1013_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
-		return ret;
+		goto unlock;
 	}
 	if (data->motion_trig == trig)
 		data->motion_trigger_on = state;
 	else
 		data->dready_trigger_on = state;
 
+unlock:
 	mutex_unlock(&data->mutex);
-
-	return 0;
+	return ret;
 }
 
 static const struct iio_trigger_ops kxcjk1013_trigger_ops = {
-- 
2.16.2
