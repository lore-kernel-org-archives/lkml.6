Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELucVW5bKucj1VDAMg4BkrBl5jqTMeV3WaBIMuia0pJ+RxCoUkl6MTmoheINAeGXUb/ZVE/C
ARC-Seal: i=1; a=rsa-sha256; t=1521483685; cv=none;
        d=google.com; s=arc-20160816;
        b=sJrNCLqkcF06+puWp0daumfjLNjlt10sFuGgme7ohstdcDhGWErPPOXA7foPaVDgEf
         KROqx/SxG39MyIsnh5AMA06xpakMatxxLLoJdLsWkROObVHR+ribj1nKcLo0MbpVB860
         LOxA8BRv62b/uR78JpVQ8NmOlBwXgstd9LDVHBnqD2Q9mVibqS5nKbJXePasOHSS6omK
         jE8ASTX8u8a3Km+ulVk/wrcDBtWPK6U24OI+VMBVD+E5sutArq/fXQjOc3dyJdo2mbZb
         Q22HPCRpYcdvF4GVwYcVdIkmWHLXiEMbX09hnI7RDzG/bQDq8XLzOoKLXqxeLu1GmIrl
         GcZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hkJYD2E4w5zlVabyK7i+c8iMDN0PqprK7d+5CsorcIM=;
        b=pwD1kD9MuEyzeR9bph1ZXZ4H6a4iAkUcmlz9UrLMF/yjysKUlsEIP/aAYLMOr1qWte
         fPTGpyNi0Y56STqNhyPRpoj8sTnv98PXtImAYJQ7XnpgGfvPJ0UrNw4GOtzyRYoDo5Tf
         TQUfh+IU7J7nqsaWKbNqB34BUMmCvm4i5o7vDns4+PfL8hBhEMQakivV/mPNF9CH8vqi
         jnervzXEQnoRE5FAssLMp21ywMqa5KjEzd9k9hmWISdbircbPC6iTeOVAImlSq0ir7Q2
         4WiUykdg6vayiNCW5hmw7ekHNqC3gekYpxLx8HeVx9NHCQzYDfhDQW1GMVJ/U29RMdU2
         uGLg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthias Kaehlcke <mka@chromium.org>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 080/241] regulator: core: Limit propagation of parent voltage count and list
Date: Mon, 19 Mar 2018 19:05:45 +0100
Message-Id: <20180319180754.520172717@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391276712954548?=
X-GMAIL-MSGID: =?utf-8?q?1595391276712954548?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>


[ Upstream commit fd086045559d90cd7854818b4c60a7119eda6231 ]

Commit 26988efe11b1 ("regulator: core: Allow to get voltage count and
list from parent") introduces the propagation of the parent voltage
count and list for regulators that don't provide this information
themselves. The goal is to support simple switch regulators, however as
a side effect normal continuous regulators can leak details of their
supplies and provide consumers with inconsistent information.

Limit the propagation of the voltage count and list to switch
regulators.

Fixes: 26988efe11b1 ("regulator: core: Allow to get voltage count and
  list from parent")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/regulator/core.c         |    9 +++++++--
 include/linux/regulator/driver.h |    2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2465,7 +2465,7 @@ static int _regulator_list_voltage(struc
 		ret = ops->list_voltage(rdev, selector);
 		if (lock)
 			mutex_unlock(&rdev->mutex);
-	} else if (rdev->supply) {
+	} else if (rdev->is_switch && rdev->supply) {
 		ret = _regulator_list_voltage(rdev->supply, selector, lock);
 	} else {
 		return -EINVAL;
@@ -2523,7 +2523,7 @@ int regulator_count_voltages(struct regu
 	if (rdev->desc->n_voltages)
 		return rdev->desc->n_voltages;
 
-	if (!rdev->supply)
+	if (!rdev->is_switch || !rdev->supply)
 		return -EINVAL;
 
 	return regulator_count_voltages(rdev->supply);
@@ -4049,6 +4049,11 @@ regulator_register(const struct regulato
 		mutex_unlock(&regulator_list_mutex);
 	}
 
+	if (!rdev->desc->ops->get_voltage &&
+	    !rdev->desc->ops->list_voltage &&
+	    !rdev->desc->fixed_uV)
+		rdev->is_switch = true;
+
 	ret = device_register(&rdev->dev);
 	if (ret != 0) {
 		put_device(&rdev->dev);
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -425,6 +425,8 @@ struct regulator_dev {
 	struct regulator_enable_gpio *ena_pin;
 	unsigned int ena_gpio_state:1;
 
+	unsigned int is_switch:1;
+
 	/* time when this regulator was disabled last time */
 	unsigned long last_off_jiffy;
 };
