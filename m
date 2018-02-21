Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbeBUVES (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:04:18 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47078 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752024AbeBUU54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:56 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 093/100] rtc: s35390a: remove useless indirection
Date: Wed, 21 Feb 2018 21:56:28 +0100
Message-Id: <20180221205635.31314-94-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s35390a_set_datetime, s35390a_get_datetime, s35390a_set_alarm and
s35390a_read_alarm are only used after casting dev to an i2c_client. Remove
that useless indirection.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-s35390a.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index 18c1d8a9f447..77feb603cd4c 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -210,8 +210,9 @@ static int s35390a_reg2hr(struct s35390a *s35390a, char reg)
 	return hour;
 }
 
-static int s35390a_set_datetime(struct i2c_client *client, struct rtc_time *tm)
+static int s35390a_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct s35390a	*s35390a = i2c_get_clientdata(client);
 	int i, err;
 	char buf[7], status;
@@ -241,8 +242,9 @@ static int s35390a_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 	return err;
 }
 
-static int s35390a_get_datetime(struct i2c_client *client, struct rtc_time *tm)
+static int s35390a_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct s35390a *s35390a = i2c_get_clientdata(client);
 	char buf[7], status;
 	int i, err;
@@ -274,8 +276,9 @@ static int s35390a_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 	return 0;
 }
 
-static int s35390a_set_alarm(struct i2c_client *client, struct rtc_wkalrm *alm)
+static int s35390a_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct s35390a *s35390a = i2c_get_clientdata(client);
 	char buf[3], sts = 0;
 	int err, i;
@@ -329,8 +332,9 @@ static int s35390a_set_alarm(struct i2c_client *client, struct rtc_wkalrm *alm)
 	return err;
 }
 
-static int s35390a_read_alarm(struct i2c_client *client, struct rtc_wkalrm *alm)
+static int s35390a_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct s35390a *s35390a = i2c_get_clientdata(client);
 	char buf[3], sts;
 	int i, err;
@@ -384,26 +388,6 @@ static int s35390a_read_alarm(struct i2c_client *client, struct rtc_wkalrm *alm)
 	return 0;
 }
 
-static int s35390a_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
-{
-	return s35390a_read_alarm(to_i2c_client(dev), alm);
-}
-
-static int s35390a_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
-{
-	return s35390a_set_alarm(to_i2c_client(dev), alm);
-}
-
-static int s35390a_rtc_read_time(struct device *dev, struct rtc_time *tm)
-{
-	return s35390a_get_datetime(to_i2c_client(dev), tm);
-}
-
-static int s35390a_rtc_set_time(struct device *dev, struct rtc_time *tm)
-{
-	return s35390a_set_datetime(to_i2c_client(dev), tm);
-}
-
 static int s35390a_rtc_ioctl(struct device *dev, unsigned int cmd,
 			     unsigned long arg)
 {
-- 
2.16.1
