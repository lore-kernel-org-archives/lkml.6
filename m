Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB95C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64882133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6qjrC7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388250AbeLQUhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:37:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33015 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbeLQUhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:37:34 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so12257429ljd.0;
        Mon, 17 Dec 2018 12:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zoQTfiTpFV5CX4uDVUACEK0OAsKuuDvGa8nVraXrcOE=;
        b=A6qjrC7ikqGWAn4XzKZcc4ow1cmN6BDfy1Bfefa5gRDST+6qPt/TKdg8kM+abTRKAl
         zALQIKBremgMoPMAm/ZxKZxfTxGFE3zOQYiz+3F4fjCH3ppShbV3k6Ck3OYDGNnL8P36
         SUuQcI3O12KYD/B25YAMW1+KNnttAmEc1fs7tI6FRHpSYyUJMLmzGJWzY2xqCEQ12uh/
         rTaYfoUP1N0g536bMRtiE3959GrrtLiprCc6yORGC4GVJfJWagztkNtYMR3SGIpUDt5z
         auVAFy5LW8IFG9zaBbFFDm1vAbWuagGh/l23UiRTAGIO/unMCBPBzmjHSYmTuW7Lvx4G
         vO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zoQTfiTpFV5CX4uDVUACEK0OAsKuuDvGa8nVraXrcOE=;
        b=U73kbTkie5q+7KQojdTDN0aLYiJ0HaE7kNrEjDkWsETLYevlkt0xkRiLYbj3ENb7jN
         P7LVL3Z7wOcxCCzGUzeotFa8iIsR1kgikzI79vZ9FgF8icBQi3EkvQanbgEQdP4N27Lh
         g5iTHNzQ+M2pGdM60/9SSzD+k9cBZxB32zmsdyUF3HawMzGOZuJ15VDSegaVjtVJv4kl
         AQz5m+HhySWptByyKV38JzbKzxb+kgORrk42j1lstwRExA9mq34v442E8MkAMITQbwR0
         xyYssudKNtI1R1n5eCoTucpGiaE3ZvrH+8cUUhYAUAjTHDwK4Q8kFYa1EasKn3twPtuY
         GRmg==
X-Gm-Message-State: AA+aEWZXg7jdqyMRuIFVnRDDn3MJeacrn5mIMnpfNy0MknqeVfpUDDzD
        TNi2t5VFJYGoGHH0jYl/jygJJQKN
X-Google-Smtp-Source: AFSGD/XqYxfEmI0TxaagyAdUycOPx9qRbS1q0t8WWEMztv8tEpC/JQkoPzl5lstA/JT9gW2PKuDonw==
X-Received: by 2002:a2e:8546:: with SMTP id u6-v6mr8295319ljj.95.1545079051420;
        Mon, 17 Dec 2018 12:37:31 -0800 (PST)
Received: from arch.domain.name (89-70-220-87.dynamic.chello.pl. [89.70.220.87])
        by smtp.gmail.com with ESMTPSA id p91sm2909917lfg.4.2018.12.17.12.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 12:37:30 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH] iio: chemical: sps30: add support for self cleaning
Date:   Mon, 17 Dec 2018 21:37:05 +0100
Message-Id: <20181217203705.8295-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Self cleaning is especially useful in cases where sensor undergoes
frequent power on/off cycles. In such scenarios it is recommended to
turn self cleaning at least once per week in order to maintain reliable
measurements.

Self cleaning is activated by writing 1 to a dedicated attribute.
Internal fan accelerates to its maximum speed and keeps spinning
for about 10 seconds blowing out accumulated dust.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-sps30 |  8 +++++
 drivers/iio/chemical/sps30.c                  | 34 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-sps30

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-sps30 b/Documentation/ABI/testing/sysfs-bus-iio-sps30
new file mode 100644
index 000000000000..81c91f225b2d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-sps30
@@ -0,0 +1,8 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_start_cleaning
+Date:		December 2018
+KernelVersion:	4.22
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Writing 1 starts sensor self cleaning. Internal fan accelerates
+		to its maximum speed and keeps spinning for about 10 seconds in
+		order to blow out accumulated dust.
diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index fa3cd409b90b..1cb05cfc4bba 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -37,6 +37,7 @@
 #define SPS30_READ_DATA_READY_FLAG 0x0202
 #define SPS30_READ_DATA 0x0300
 #define SPS30_READ_SERIAL 0xd033
+#define SPS30_START_FAN_CLEANING 0x5607
 
 enum {
 	PM1,
@@ -104,6 +105,7 @@ static int sps30_do_cmd(struct sps30_state *state, u16 cmd, u8 *data, int size)
 		break;
 	case SPS30_STOP_MEAS:
 	case SPS30_RESET:
+	case SPS30_START_FAN_CLEANING:
 		ret = sps30_write_then_read(state, buf, 2, NULL, 0);
 		break;
 	case SPS30_READ_DATA_READY_FLAG:
@@ -275,7 +277,39 @@ static int sps30_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static ssize_t in_start_cleaning_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct sps30_state *state = iio_priv(indio_dev);
+	int val, ret;
+
+	if (kstrtoint(buf, 0, &val) || val != 1)
+		return -EINVAL;
+
+	mutex_lock(&state->lock);
+	ret = sps30_do_cmd(state, SPS30_START_FAN_CLEANING, NULL, 0);
+	mutex_unlock(&state->lock);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR_WO(in_start_cleaning, 0);
+
+static struct attribute *sps30_attrs[] = {
+	&iio_dev_attr_in_start_cleaning.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group sps30_attr_group = {
+	.attrs = sps30_attrs,
+};
+
 static const struct iio_info sps30_info = {
+	.attrs = &sps30_attr_group,
 	.read_raw = sps30_read_raw,
 };
 
-- 
2.20.0

