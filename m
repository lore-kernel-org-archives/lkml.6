Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49hd6qOZdX0kVrjkVGbJ5/S+7TLV8wq7Qq/y0xbvZnhQa7PhuW6rKeUOlPb1yc4rD84d8IB
ARC-Seal: i=1; a=rsa-sha256; t=1524406911; cv=none;
        d=google.com; s=arc-20160816;
        b=NByQGIgyASipQ6WW0pHH1boPzuP1TSmO5UOYhJsYSf5xHqwn8WCZWSh4T3bLoVLeFo
         8+NE9IvNKGbtD/yiJuJFNu6D2dbZ43GZAfTTzXq3Gj518k+29NT9+BAx74Xlz1oRxVvA
         4MCMSQMBkeXtPScsrrmAlRNWDfkB6Bu3easxiBGJGJx/iDstAXOKfhExhy+lc1Q2z5Nm
         BoKIwliRs/Ahe8VPIVEfcE0DjDyoMXWvJn29lulOVQ8feinQWqxHMzqA+cAbE9N6nx1i
         cNYcAAqwCOW0wN50Gled4n/oWdJ4yq3jc2w45sI8E7sSq2lvXYTkTPBJVmfILrvNlbWn
         UJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7kTnDUQawUkUl3qARt9NYIH1mfe/lAgS/IAwCcDPKRE=;
        b=hVM6npb3CMe7KR1nLZVjEJix0gAydfqze/IveWIUuhyeXmTVRrpfhDRdNmNCBR+bu1
         g4k93n4Vjx4D6gEu+tJrPmWvpkZ8wtiB53ompeEig0/Aoo2yyOEIph71RpIiwtlUdb9t
         4cGwLNLRIzaRPTzBKAqVqAYSHMk9CAyyB9q3f/U3OTbHxnIrC8JnOYHwQuQroTEgT/v8
         nMBj8X5zOSPwkLYLDiSTruXKpo69Sfa0pLzrK/gLwNCRAZD6QCz45xrfZO5iuqBAnxAj
         kw6o3A7bI9LkEyPVvFNU6yJKRQ//bcwoEyCNyCz/VaF0z9BjqerXbqN7sh8kQpwuLDjN
         UgMA==
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
Subject: [PATCH 3.18 22/52] ASoC: ssm2602: Replace reg_default_raw with reg_default
Date: Sun, 22 Apr 2018 15:53:55 +0200
Message-Id: <20180422135316.306919125@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454978890490474?=
X-GMAIL-MSGID: =?utf-8?q?1598456501238850220?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
 
