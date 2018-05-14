Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpsdQiL6M8jdZWuNKVE7Hub/zyppc9xDxm/pZJ/H2a/+LKjIC/Qt1QyhJKj1k0YxkNMnaLi
ARC-Seal: i=1; a=rsa-sha256; t=1526280865; cv=none;
        d=google.com; s=arc-20160816;
        b=DjgqThOhIu8o/5N/js+pu8L/6vOmWKLQJxqT9oSSSQNA3TvoWsVvIpI2C47bwUQR1x
         sNSXC6VKyMElUH0Ni5gP0efJbuq3lGOloHuM3y6C50z0H3nCtAjfukQWad8Ji9bkHs1U
         jZ0c5+2752P0YEPHaCN/FNpmROUUf8QsGWNjdISI2YQNJJpWteuGVl+C0vw9uxVDbyEC
         Fo8AkIxtCoSlckavxC24+Khus3EyLBkh3tCTd7zjof3jjLaOOMMv1W2G7gRErrZAdL6W
         GWjojONvmLeLK0t8F/o7hv3gRryexzIjbNzyjn+vMcskYcWCKvenk0UIgsNYxNhu/8WX
         r95Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ciN/2kFU4PcBWCE01mZXbNshtYtu3CmY+cwRNqRRrhI=;
        b=H20UoxOjDRKe4eR1+o5xGr2BtFDn99z3soFtKcHOLp+ZBaUu0i1fqHa+gZpVYeNhDj
         q7e4Vu7pCLDPDHs1CN3ZzudmXGgcWFsVnLA3pkYCVT8nfrm1Ux/F930hwdRlyigZcHAL
         hZByW7nobL07V/lZl87wl4iRnh4LehPPNhRB0Xd7dQxQj7RiDFSK7kW/DQwZNH55ZM/F
         e77XiyvTdqR58u2PPcH6wCoKTeARIujEhKiM80Hzpn8BPCTUbSNYSyDni90sSJQ/0I2F
         h9PIM4Am8f1WHtls8kctdY2+Ep7gKbcDL6qAtepOUaY/u3HVrsGDqICGpi5+vYACQnZb
         NZNg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=SOWiO3X2;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=SOWiO3X2;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 4.9 29/36] thermal: exynos: Reading temperature makes sense only when TMU is turned on
Date: Mon, 14 May 2018 08:49:03 +0200
Message-Id: <20180514064806.513239677@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421485227377992?=
X-GMAIL-MSGID: =?utf-8?q?1600421485227377992?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
