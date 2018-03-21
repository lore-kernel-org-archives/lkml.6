Return-Path: <rrajk@nvidia.com>
X-Google-Smtp-Source: AG47ELtzeZ8Fyi5AheiAyponjNySQ+aaqxov8IuD5GLxCAEYKqQdA+9pyl57lGyDyS+BSP1CeDvG
ARC-Seal: i=1; a=rsa-sha256; t=1521607321; cv=none;
        d=google.com; s=arc-20160816;
        b=STaQVWk9ampYbUU+4RloCJpKVOh10yTjJ8mJKXbyeG0NCdIIDblJvRBxp92I2NQ5Ec
         h7gZwHgsmuOKTO7J0NGsDAtN6H7W6joE0Wknw8keDmfzVJnPLMHYKvYXlYadBi5HcPlT
         ZchEXacNMz9Gh3Leqw2kCI3rEDIoFFXzVoudGcNJ9Yap48aZ0BnsR8B1DUFphdq8rrht
         Oap+reSReiFOIEArmXRnnwWODhCLD+Fg2zoDFPluHUE5prnow76zGQgo/DqPoFUsmbK3
         MKIZYlmdfDQmf+lQwU7ZlImLZAZ7YZ6rXGdBOYC2TsCTqw6zExFQ9/b+jOy/AJokTHmt
         m+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=KnTZzAErrOzRoDAR19m+1MHotTDRmvjnqm0vVUPi+o4=;
        b=rkRg+SlEYwqlMbTWSRI/BSdwFIcSwItr18kuwAUAzxiIdGi8/ZfApMSZWrcT1coL/C
         q6MUuitHoiSMlOoSTwlfcH87QLQlAJ+1hC6RT5RnvAwxvcwJy3kFrIJpwTQfU2plwJRu
         aUjvLvob+pB+AoTNDRmrFIBSU1Nr3x5w5lqNlhc/duQzImxhvFYUo0mF5oPOpeBBB3sQ
         JzwDr6yxjltuA8qRgyYRpC3ia9tGHdMN/muoTw6mN5vWrMJdihIjn5REAfmbofDTvrP0
         +DUGBGLymyr6sPDOjFodvXTQOtzJbO4tOMgCo7n2rJiKIdBmKwrpk62JV7o3LLUC6Y5/
         zLNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.143 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.143 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Tue, 20 Mar 2018 21:42:00 -0700
From: Rajkumar Rampelli <rrajk@nvidia.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <jdelvare@suse.com>, <linux@roeck-us.net>,
	<corbet@lwn.net>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
	<kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
	<pombredanne@nexb.com>, <mmaddireddy@nvidia.com>, <mperttunen@nvidia.com>,
	<arnd@arndb.de>, <timur@codeaurora.org>, <andy.gross@linaro.org>,
	<xuwei5@hisilicon.com>, <elder@linaro.org>, <heiko@sntech.de>,
	<krzk@kernel.org>, <ard.biesheuvel@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ldewangan@nvidia.com>,
	<rrajk@nvidia.com>
Subject: [PATCH V2 7/9] hwmon: pwm-fan: add sysfs node to read rpm of fan
Date: Wed, 21 Mar 2018 10:10:42 +0530
Message-ID: <1521607244-29734-8-git-send-email-rrajk@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595520919303322117?=
X-GMAIL-MSGID: =?utf-8?q?1595520919303322117?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add fan device attribute fan1_input in pwm-fan driver
to read speed of fan in rotations per minute.

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---

V2: Removed generic-pwm-tachometer driver and using pwm-fan driver as per suggestions
    to read fan speed.
    Added fan device attribute to report speed of fan in rpms through hwmon sysfs.

 drivers/hwmon/pwm-fan.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 70cc0d1..8dda209 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -98,11 +98,34 @@ static ssize_t show_pwm(struct device *dev,
 	return sprintf(buf, "%u\n", ctx->pwm_value);
 }
 
+static ssize_t show_rpm(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct pwm_fan_ctx *ptt = dev_get_drvdata(dev);
+	struct pwm_device *pwm = ptt->pwm;
+	struct pwm_capture result;
+	unsigned int rpm = 0;
+	int ret;
+
+	ret = pwm_capture(pwm, &result, 0);
+	if (ret < 0) {
+		pr_err("Failed to capture PWM: %d\n", ret);
+		return ret;
+	}
+
+	if (result.period)
+		rpm = DIV_ROUND_CLOSEST_ULL(60ULL * NSEC_PER_SEC,
+					    result.period);
+
+	return sprintf(buf, "%u\n", rpm);
+}
 
 static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 0);
+static SENSOR_DEVICE_ATTR(fan1_input, 0444, show_rpm, NULL, 0);
 
 static struct attribute *pwm_fan_attrs[] = {
 	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	NULL,
 };
 
-- 
2.1.4
