Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpEpV2m8bNUzWmkm09us2d3TtYkiEfB5O8wVULzA2U3/asMfJoKBd20pEAROYV0S3Qh/9cP
ARC-Seal: i=1; a=rsa-sha256; t=1526281023; cv=none;
        d=google.com; s=arc-20160816;
        b=ePBOdUqH/LjFB7oNcxpGCHgDkpuGRgrBZryRIxBR24WZ2MbXJ7vrh0aSv421ZM3FCb
         sMQQWDc5Zo7jxkkF8mIvCZXzfq8mYXgE+VEV9K+DVcOwzyilzSuaa4raPSB0QcBBtnAp
         tEix//ZruaU0ahgkxmlP5y18wAcjeLINUVnyl9ObkxAJ3rzuiyHAWxShlR5yc0Xo4r+B
         Wt+bjr3iqIEuXQFkr59FClfvZNgGeTDHo/+z4RWv+ia1BRXhuKvV0gtToYovqnO5EM4h
         JnYq20cRL9h3tMJDzzZk4Lcs1aAAgv0Nc9hAHy8llv/RnzYP9ARLyCwzT7CFS3fbutBl
         BCzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=4oOoCbmKjs0wRZ2JdyzqfLeaaGmR5zcn/mDc4NW+BTQ=;
        b=UNanyfX4gFRsa10BdWpqggYJLLGiJoa2Wcrp3cwOHkkyO1D99fsIcBUcvMotG9cxX0
         9xpKqq+UihNDjU0517SSwXnBNeZ8NblfaCSKlALz6pufej8UFvnsR4h72kGzqoJ6Tu1v
         9Itb6/zKaWvVRSEwv+lFPW1y486Y72rXEdIEybtBsbCtsdj+IoK/bHg7B3ukpxHj1iIw
         czMgRZcrN/CaQniECuX7iEo2l836T3rSDhXcZawANhDGDdfq7V13EEUxI3q0qzmDZkJ3
         Bbm9+PcfyjPemnn2mP5FidrNDKC/rT8nzlnFKKxAtgtpu5f8sPTIR20YyI0Z60nYfIPw
         1eig==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JlpBK4qV;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JlpBK4qV;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 4.14 50/62] thermal: exynos: Reading temperature makes sense only when TMU is turned on
Date: Mon, 14 May 2018 08:49:06 +0200
Message-Id: <20180514064819.268510145@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421485227377992?=
X-GMAIL-MSGID: =?utf-8?q?1600421650316547365?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit 88fc6f73fddf64eb507b04f7b2bd01d7291db514 upstream.

When thermal sensor is not yet enabled, reading temperature might return
random value. This might even result in stopping system booting when such
temperature is higher than the critical value. Fix this by checking if TMU
has been actually enabled before reading the temperature.

This change fixes booting of Exynos4210-based board with TMU enabled (for
example Samsung Trats board), which was broken since v4.4 kernel release.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 9e4249b40340 ("thermal: exynos: Fix first temperature read after registering sensor")
CC: stable@vger.kernel.org # v4.6+
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thermal/samsung/exynos_tmu.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -185,6 +185,7 @@
  * @regulator: pointer to the TMU regulator structure.
  * @reg_conf: pointer to structure to register with core thermal.
  * @ntrip: number of supported trip points.
+ * @enabled: current status of TMU device
  * @tmu_initialize: SoC specific TMU initialization method
  * @tmu_control: SoC specific TMU control method
  * @tmu_read: SoC specific TMU temperature read method
@@ -205,6 +206,7 @@ struct exynos_tmu_data {
 	struct regulator *regulator;
 	struct thermal_zone_device *tzd;
 	unsigned int ntrip;
+	bool enabled;
 
 	int (*tmu_initialize)(struct platform_device *pdev);
 	void (*tmu_control)(struct platform_device *pdev, bool on);
@@ -398,6 +400,7 @@ static void exynos_tmu_control(struct pl
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
 	data->tmu_control(pdev, on);
+	data->enabled = on;
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 }
@@ -890,7 +893,7 @@ static int exynos_get_temp(void *p, int
 {
 	struct exynos_tmu_data *data = p;
 
-	if (!data || !data->tmu_read)
+	if (!data || !data->tmu_read || !data->enabled)
 		return -EINVAL;
 
 	mutex_lock(&data->lock);
