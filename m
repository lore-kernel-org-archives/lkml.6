Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+9zsbK4eMF3PAj9TqmuHnOW5M4yS2b4k1qCH3u9qCFP7KP0+liCaAF8t9NE/dHHrtw1S38
ARC-Seal: i=1; a=rsa-sha256; t=1524405963; cv=none;
        d=google.com; s=arc-20160816;
        b=MLv8OU4LbrDLRTdUMp1l0BCkdVN4jdKi/6c7aryEZcOhDThFDbmSqiUjsSaO8MnLwf
         1D9dPPVnvPerwKMrBmk9BqpXlsQm1v9EbNcsQyddFkQZGK076HTvVFVWxAvOVAs8QCA+
         NLG3cYn1IQe8CLc23z3O7rHRttBwqk4pjjDIHDd/zdHi/KPOwClbDT+xOqCMl8iNsZVi
         yFIdBDPznqYkf9aZrb0fgAL6Obt+XZMNjpC4MydSwWwxDuqwL62O6XzBUDxUFpTj+sIJ
         A7WDNFAVuSavHB4kdW7XEVWmUuriK1tRaQFPD96+VfjouZcyPmYREX4yHsDRAfEkWqu6
         59Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IOizuCN8F9Qy08srNR6W4Z/d8WzzWs7Xbb4binWh6h4=;
        b=kD5IsDRZwknjQACRLnoLlkpBcj+VSDUThVu0FObwTLuktmxftg6bJ+S4ngHsxYiRcY
         2GX1ppnktVaVIt0DL/GIBUW0ZA+z0S88sAd1xBRtjFIH9o0wOsZG28Emu2xAmHAfsL5U
         /hda61gzu29AfWpga/op5yx6aKuXdtqj/nrE1EzwVkJsIRHgnZkIm++crAHQDeRg4sZM
         q/iin5oumesCgxvY3OkfzQ1FLXmkgmFWARrqqkQVEQnBvraKQlO3lQJak44ij4ueBiXC
         33SePMdbMzxVAJ8tQNCbZycqQMYwQ7eH/dLQUfNa+UGdBxwHEX/716uCR0sQjXCtFZT1
         9H2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	James Kelly <jamespeterkelly@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 061/164] ASoC: ssm2602: Replace reg_default_raw with reg_default
Date: Sun, 22 Apr 2018 15:52:08 +0200
Message-Id: <20180422135137.949620503@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454978890490474?=
X-GMAIL-MSGID: =?utf-8?q?1598455506922306133?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Kelly <jamespeterkelly@gmail.com>

commit a01df75ce737951ad13a08d101306e88c3f57cb2 upstream.

SSM2602 driver is broken on recent kernels (at least
since 4.9). User space applications such as amixer or
alsamixer get EIO when attempting to access codec
controls via the relevant IOCTLs.

Root cause of these failures is the regcache_hw_init
function in drivers/base/regmap/regcache.c, which
prevents regmap cache initalization from the
reg_defaults_raw element of the regmap_config structure
when registers are write only. It also disables the
regmap cache entirely when all registers are write only
or volatile as is the case for the SSM2602 driver.

Using the reg_defaults element of the regmap_config
structure rather than the reg_defaults_raw element to
initalize the regmap cache avoids the logic in the
regcache_hw_init function entirely. It also makes this
driver consistent with other ASoC codec drivers, as
this driver was the ONLY codec driver that used the
reg_defaults_raw element to initalize the cache.

Tested on Digilent Zybo Z7 development board which has
a SSM2603 codec chip connected to a Xilinx Zynq SoC.

Signed-off-by: James Kelly <jamespeterkelly@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/ssm2602.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -54,10 +54,17 @@ struct ssm2602_priv {
  * using 2 wire for device control, so we cache them instead.
  * There is no point in caching the reset register
  */
-static const u16 ssm2602_reg[SSM2602_CACHEREGNUM] = {
-	0x0097, 0x0097, 0x0079, 0x0079,
-	0x000a, 0x0008, 0x009f, 0x000a,
-	0x0000, 0x0000
+static const struct reg_default ssm2602_reg[SSM2602_CACHEREGNUM] = {
+	{ .reg = 0x00, .def = 0x0097 },
+	{ .reg = 0x01, .def = 0x0097 },
+	{ .reg = 0x02, .def = 0x0079 },
+	{ .reg = 0x03, .def = 0x0079 },
+	{ .reg = 0x04, .def = 0x000a },
+	{ .reg = 0x05, .def = 0x0008 },
+	{ .reg = 0x06, .def = 0x009f },
+	{ .reg = 0x07, .def = 0x000a },
+	{ .reg = 0x08, .def = 0x0000 },
+	{ .reg = 0x09, .def = 0x0000 }
 };
 
 
@@ -620,8 +627,8 @@ const struct regmap_config ssm2602_regma
 	.volatile_reg = ssm2602_register_volatile,
 
 	.cache_type = REGCACHE_RBTREE,
-	.reg_defaults_raw = ssm2602_reg,
-	.num_reg_defaults_raw = ARRAY_SIZE(ssm2602_reg),
+	.reg_defaults = ssm2602_reg,
+	.num_reg_defaults = ARRAY_SIZE(ssm2602_reg),
 };
 EXPORT_SYMBOL_GPL(ssm2602_regmap_config);
 
