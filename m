Return-Path: <merlijn@wizzup.org>
X-Google-Smtp-Source: AG47ELv+yhKeJGWvT5xBZ5+F/FEAgvap2SaNtLuHplbshtl8YlWuRGC/Tz/o4p8eVpmQz7M75te/
ARC-Seal: i=1; a=rsa-sha256; t=1519943575; cv=none;
        d=google.com; s=arc-20160816;
        b=hQ5fgemvSe6cd0StpTZq8812sUdO36ZGAP6I8V/NQiYjPkRyWNaVGbjAFsO+jw+i9a
         BOd4gozfFLH2AZ564LPOylLtfbmiS9hQjylpumATLncezV3NR30+UTyoJIuAEbwetC1/
         +9E2kz7PDam63/lfQ0UBeXB/aCdhy4n5MGWUcIpKHFhf45vHz91ZOnjepUa9vPu4oOZn
         YnM+1382FSgWXqL9Us2Bv7per5SoN6QqoFsN2xRzf1RgIS0UY47mEVB9mIcDTcQyyVCo
         /8ZfAUxYJW+Czv/1tnXPeYfiEiICoprHdXRyZhwcKcjHDVHpg32ZmL0ftinrSy7APM3D
         LNTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=bCJiacTRdjzrA3SaEdV9ojiTEicKkO7Q2sdHR8/6R9U=;
        b=LJFL5yVfnEeP0or9QdwVAhmhEXMVDab1dzzUThayRjOcKL/mg7yEGLaD+uhhvSnsas
         3O8sLieTuRbyUd0Vq7NIetT2mXQvZJBxBKqB5MmPieWxrnybp/9FHLlfJQw9TFh2M3ug
         RIwOsf4Im9vp1E7t36YhrSb2rZe57qlD4X0T8JPiQaoEFzkNtmp8I84Zi9jvtv1oPF1Z
         WJjtCrL03i8rgc2brf8O1K/MuA04O7KnSW04Ngb8qBqPdeAj7QDlje71ukTECZu/YTye
         N8M2JIRV8XKhrnOYTvcq3xetxd/akR213afTYZJj3bYIQ1gCF6vzIF6/M07t4pHzA4mo
         KLZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 188.165.243.101 is neither permitted nor denied by best guess record for domain of merlijn@wizzup.org) smtp.mailfrom=merlijn@wizzup.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 188.165.243.101 is neither permitted nor denied by best guess record for domain of merlijn@wizzup.org) smtp.mailfrom=merlijn@wizzup.org
From: Merlijn Wajer <merlijn@wizzup.org>
To: 
Cc: merlijn@wizzup.org,
	ivo.g.dimitrov.75@gmail.com,
	"Andrew F. Davis" <afd@ti.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Breck <kernel@networkimprov.net>,
	Matt Ranostay <matt.ranostay@konsulko.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] power: supply: bq27xxx: Call power_supply_changed on status change
Date: Thu,  1 Mar 2018 23:32:03 +0100
Message-Id: <20180301223218.17422-1-merlijn@wizzup.org>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593776354858171040?=
X-GMAIL-MSGID: =?utf-8?q?1593776354858171040?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It seems that bq27xxx_battery_update does not call power_supply_changed when the
charging status changes, and instead only when the capacity changes.

This can cause considerable delays in reporting charging status changes to
userspace. This patch turns the battery status reading function into one that
returns the value directly (as other *_read functions), adds the status to the
cache, uses the cache when reporting the values and finally will trigger
power_supply_changed when the charging status changes.

Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/power/supply/bq27xxx_battery.c | 59 +++++++++++++++++-----------------
 include/linux/power/bq27xxx_battery.h  |  1 +
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 0a203672744c..218d153fb431 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1527,6 +1527,31 @@ static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
 	return POWER_SUPPLY_HEALTH_GOOD;
 }
 
+static int bq27xxx_battery_read_status(struct bq27xxx_device_info *di)
+{
+	int status;
+
+	if (di->opts & BQ27XXX_O_ZERO) {
+		if (di->cache.flags & BQ27000_FLAG_FC)
+			status = POWER_SUPPLY_STATUS_FULL;
+		else if (di->cache.flags & BQ27000_FLAG_CHGS)
+			status = POWER_SUPPLY_STATUS_CHARGING;
+		else if (power_supply_am_i_supplied(di->bat) > 0)
+			status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		else
+			status = POWER_SUPPLY_STATUS_DISCHARGING;
+	} else {
+		if (di->cache.flags & BQ27XXX_FLAG_FC)
+			status = POWER_SUPPLY_STATUS_FULL;
+		else if (di->cache.flags & BQ27XXX_FLAG_DSC)
+			status = POWER_SUPPLY_STATUS_DISCHARGING;
+		else
+			status = POWER_SUPPLY_STATUS_CHARGING;
+	}
+
+	return status;
+}
+
 void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 {
 	struct bq27xxx_reg_cache cache = {0, };
@@ -1547,6 +1572,7 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 			cache.time_to_full = -ENODATA;
 			cache.charge_full = -ENODATA;
 			cache.health = -ENODATA;
+			cache.status = bq27xxx_battery_read_status(di);
 		} else {
 			if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)
 				cache.time_to_empty = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
@@ -1559,6 +1585,7 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 			if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
 				cache.energy = bq27xxx_battery_read_energy(di);
 			cache.health = bq27xxx_battery_read_health(di);
+			cache.status = bq27xxx_battery_read_status(di);
 		}
 		if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
 			cache.cycle_count = bq27xxx_battery_read_cyct(di);
@@ -1570,7 +1597,7 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 			di->charge_design_full = bq27xxx_battery_read_dcap(di);
 	}
 
-	if (di->cache.capacity != cache.capacity)
+	if ((di->cache.capacity != cache.capacity) || (di->cache.status != cache.status))
 		power_supply_changed(di->bat);
 
 	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)
@@ -1625,34 +1652,6 @@ static int bq27xxx_battery_current(struct bq27xxx_device_info *di,
 	return 0;
 }
 
-static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
-				  union power_supply_propval *val)
-{
-	int status;
-
-	if (di->opts & BQ27XXX_O_ZERO) {
-		if (di->cache.flags & BQ27000_FLAG_FC)
-			status = POWER_SUPPLY_STATUS_FULL;
-		else if (di->cache.flags & BQ27000_FLAG_CHGS)
-			status = POWER_SUPPLY_STATUS_CHARGING;
-		else if (power_supply_am_i_supplied(di->bat) > 0)
-			status = POWER_SUPPLY_STATUS_NOT_CHARGING;
-		else
-			status = POWER_SUPPLY_STATUS_DISCHARGING;
-	} else {
-		if (di->cache.flags & BQ27XXX_FLAG_FC)
-			status = POWER_SUPPLY_STATUS_FULL;
-		else if (di->cache.flags & BQ27XXX_FLAG_DSC)
-			status = POWER_SUPPLY_STATUS_DISCHARGING;
-		else
-			status = POWER_SUPPLY_STATUS_CHARGING;
-	}
-
-	val->intval = status;
-
-	return 0;
-}
-
 static int bq27xxx_battery_capacity_level(struct bq27xxx_device_info *di,
 					  union power_supply_propval *val)
 {
@@ -1733,7 +1732,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		ret = bq27xxx_battery_status(di, val);
+		ret = bq27xxx_simple_value(di->cache.status, val);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		ret = bq27xxx_battery_voltage(di, val);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index e6187f524f2c..4f27656045fd 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -49,6 +49,7 @@ struct bq27xxx_reg_cache {
 	int flags;
 	int power_avg;
 	int health;
+	int status;
 };
 
 struct bq27xxx_device_info {
-- 
2.16.2
