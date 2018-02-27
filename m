Return-Path: <benjamin.gaignard@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519740582; cv=none;
        d=google.com; s=arc-20160816;
        b=Kh0X7gDO5DuWBtz5de2ULZZL8O4ql19sMwjG1AlArqjTZiIcij+LxQOIY0q3imaC08
         7Yv5OH2RTvSocnQaHLR5bM1Cnv3NF0uGJgrErFmpKgtpc3WuKzbZnaVsoV9nHuoZHT80
         pfs5pM0hRBFioJpPKwsoiA7Sakey0e+RoKKK1Px4TEw9MngkuRIszyYj2BQqeM4RsVrI
         i7etxqxVmnYKxl/EBTywPfcKNXP9K2fsDIifWi2YJfomUWdfF6vimRh0kWptMRaaHDQj
         MS9o5P4VfrVJX+gj0ubS16sCzjv5588FqURy0GcoOBPXBV5fbQDkxXcLn7s0C90zAwis
         sskg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=+qPp2gLc0zJ8QDezJSeSnIvB+cVCQ5fMNsIOfQ1z91Q=;
        b=Z8jO9LP/UY+exbch+XOwjf8Kd/3uyXlH3ksFONLACURPSUcKoX7SNXD2nzYzO6+Ei/
         uk5exjNjro+fbZUNIks0GkC5ixEJ/EvmzA0RtXGcPJjjrBsyo/aFG9NeubPBEMLQ+s1X
         eF9vYvVgxOJPZYGwmxnLYIKzr87VH2SGO1wIW9EVgL7PE2A/RQCCpg1m8MaHuDwYvSJP
         Sg4n/V4WJjxKnk1zdxKb65hOINoYkf7DmP51q9CbENeg4CEo425SWztPhsGICED3zGiD
         SfXQ1aAuXGdWxhqF/BDHLKH/G4tDtuE+1IPs6Sxx91l3cJDkQmnUUTfwtUCLSMO5FZqQ
         TUZg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Ods7cilq;
       spf=pass (google.com: domain of benjamin.gaignard@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=benjamin.gaignard@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Ods7cilq;
       spf=pass (google.com: domain of benjamin.gaignard@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=benjamin.gaignard@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELvn5PUSlAl3q1WfwH5Rzx/P9opWmWNd9L8+Xv9RLpH2YIhVTd586RsbyEbMGWofDVW/Kn8lQA==
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@st.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 1/3] driver core: check notifier_call_chain return value
Date: Tue, 27 Feb 2018 15:09:24 +0100
Message-Id: <20180227140926.22996-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180227140926.22996-1-benjamin.gaignard@st.com>
References: <20180227140926.22996-1-benjamin.gaignard@st.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593563501482605185?=
X-GMAIL-MSGID: =?utf-8?q?1593563501482605185?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When being notified that a driver is about to be bind a listener
could return NOTIFY_BAD.
Check the return to be sure that the driver could be bind.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/base/dd.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index de6fd092bf2f..9275f2c0fed2 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -304,9 +304,12 @@ static int driver_sysfs_add(struct device *dev)
 {
 	int ret;
 
-	if (dev->bus)
-		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
-					     BUS_NOTIFY_BIND_DRIVER, dev);
+	if (dev->bus) {
+		if (blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
+						 BUS_NOTIFY_BIND_DRIVER, dev) ==
+						 NOTIFY_BAD)
+			return -EINVAL;
+	}
 
 	ret = sysfs_create_link(&dev->driver->p->kobj, &dev->kobj,
 				kobject_name(&dev->kobj));
-- 
2.15.0
