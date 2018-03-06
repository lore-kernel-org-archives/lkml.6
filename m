Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AG47ELszOgCuYVA+1KOKGV9187PDFsJnKbtCAlpAd+DYzpk+i6FEXSbC6Pxf9rSV5y7pRvxH0EMN
ARC-Seal: i=1; a=rsa-sha256; t=1520334283; cv=none;
        d=google.com; s=arc-20160816;
        b=o2vI1LzkT/WNgXtvuIcZNrX2/yDHehQnCM8GPRuzP0dQ3YrVlCfiu/ESvSHxuaf9Tw
         uYJ6q3DszA0B0Y2c/cNDIV+0i/zRVg2fRv3e8PvNuZj4S1Ds7Q2Y8cvwbnyLI+f4lj3m
         mzLX32d5+sL9192znbpwp3gYGgAn++WbkBFBi2+di0FyYQ72863JF0nHa+6rgzYpNBej
         gHcSZdEWWa5B8COEooH5Y5GZlZ6SOvZJaY5Uyqx3pfcka2eX5Fhb2UtVsOxjj8pNBag0
         4CJXTKhYme52jbZB7nkTwfJ/0Aq6lLdgCkFXrhz9f4m2mxfa8NE9+fz877zVJHvrX017
         NAAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=FiG31vPoBhZiBscQ2hVnbZaVI0UMwPNVG8Zq3+3w5mU=;
        b=nMqBgMuJHpD0bggpnFGPgbHw08Dak1F/7pUk1spXHKS+B2iaeQt+HI07sZ7K02O3Z/
         YGX4mxolYT0uktBWTNEUB30EDOZW+uZvI/2Mp8z8koKwGmRPQ2Q45au3QtC/eiriRcCo
         0ibPm00R0tkn73V0C4uxMA+0LBO28wJxE6I6T879Ai8I/+ezQiwgotubEykeIinWPfr3
         nDt7BJiOqqD83zxz+WqNXqjs39b2Gh7eMc2WifCzp72/Sx9C6YRmqUr9BbqHExdwkzuM
         Yo6WEu3cC4zAR4DTkVUqJ94oFHOt6A/cPwaKk6xp5O/Q2cQUDEb7zz9tCWdzl7YHxsun
         YhkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.20 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.20 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <4f232d89f9933886e547d38f35e06fb9>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/3] regmap: debugfs: Fix kmemleak in regmap_debugfs_init
Date: Tue,  6 Mar 2018 19:04:02 +0800
Message-Id: <20180306110403.14438-2-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180306110403.14438-1-jeffy.chen@rock-chips.com>
References: <20180306110403.14438-1-jeffy.chen@rock-chips.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594186041905499825?=
X-GMAIL-MSGID: =?utf-8?q?1594186041905499825?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use map->debugfs_name to store allocated debugfs name, so it would be
freed in regmap_debugfs_exit().

Kmemleak reported:
unreferenced object 0xffffffc0cf78cf00 (size 128):
  comm "swapper/0", pid 1, jiffies 4294669168 (age 89.152s)
  hex dump (first 32 bytes):
    64 75 6d 6d 79 32 33 00 00 00 00 00 00 00 00 00  dummy23.........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000027429160>] kmemleak_alloc+0x58/0x8c
    [<0000000081861ddf>] __kmalloc_track_caller+0x1dc/0x2bc
    [<00000000258a341f>] kvasprintf+0xd0/0x168
    [<00000000f3243f27>] kasprintf+0xac/0xd8
    [<000000005f585642>] regmap_debugfs_init+0x1a0/0x3b0
    [<000000002c08b110>] __regmap_init+0x12b8/0x135c
    [<00000000f64bcddb>] __regmap_init_mmio_clk+0x70/0x84
    [<000000009c8f06b5>] of_syscon_register+0x278/0x378
    [<0000000087e6c121>] syscon_node_to_regmap+0x80/0xb0

Fixes: a430ab205d29 ("regmap: debugfs: Disambiguate dummy debugfs file name")
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/base/regmap/regmap-debugfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index e3e7b91cc421..5479a183248f 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -570,15 +570,15 @@ void regmap_debugfs_init(struct regmap *map, const char *name)
 		map->debugfs_name = kasprintf(GFP_KERNEL, "%s-%s",
 					      devname, name);
 		name = map->debugfs_name;
+	} else if (!map->dev) {
+		map->debugfs_name = kasprintf(GFP_KERNEL, "%s%d",
+					      devname, dummy_index);
+		name = map->debugfs_name;
+		dummy_index++;
 	} else {
 		name = devname;
 	}
 
-	if (!strcmp(name, "dummy")) {
-		name = kasprintf(GFP_KERNEL, "dummy%d", dummy_index);
-		dummy_index++;
-	}
-
 	map->debugfs = debugfs_create_dir(name, regmap_debugfs_root);
 	if (!map->debugfs) {
 		dev_warn(map->dev, "Failed to create debugfs directory\n");
-- 
2.11.0
