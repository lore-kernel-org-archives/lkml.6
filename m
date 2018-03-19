Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtz0u9FKlRc2+uTkGn7GoZBYbcDnJoDsRi38T4LypXIut1N3IOhyMfZLgUDAXBzflRTlEP5
ARC-Seal: i=1; a=rsa-sha256; t=1521483863; cv=none;
        d=google.com; s=arc-20160816;
        b=ozVbhdssTCwoeIFiyyTF/OaBislO5fIIvrPsPd44HfKRNx2zOL94Vf/U9aK1fgFwlz
         JWFEs8mjuhCnkUOnHxLbZI4PNjXSkZ7XEk9zckwFWI4wuCilGAqeNKixtNlXJu2M0I3R
         CtU/Ih89k+Q4Ses/sz8Ws5dYWiou3enkBBZw8Mpq5xVgKDv/SGqQmSs4apDZ5kJ599up
         ryOp7QfozLVjdF5kFfH7C1wjtJH5M177rOcATdoFO675F+twihjhaCCxMHxTgJYPH/b+
         hG2IqBrgAQoZupfM+ttRB/dXcQTJ1GSURrtsthGmZLOwLme/jW2Kv2RFgDLsSrDMAdZ4
         0Ctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XkGKSS3NP0Uy3m6D6Px1BrUOExPT+ORsGngyvWbLLRM=;
        b=yWVy1lRXG0nPAkB0wr3X7OOxtHBzdmPTF+bYcvut/7BzD5evP3g/bB9Djez8BN+3SE
         nh/E/ENiLsBregqxzTcS0if6YePUH+yja7R3tASMxpyqgLx8mHvX7Rd1JydlCRm9GN+u
         ySjwIpKCnhH26Z0be8YC45Q04MNvzKWZthCeH/0eoHzDYdavOr/+bCaExmhyzTcS5P9h
         cAL2vdv86Ttu7tD+iCGib+6x93s3Z2jZFtTy0v78abr1jnIdTMigyMnJEC1ysGTgMDjw
         2s1EK2EfmR2f+al9mvYuDisUzx+TdLawW6GHOR2iTq9txQJPVzhWK/smme91RqQKeBHV
         qT8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 108/241] ASoC: rt5677: Add OF device ID table
Date: Mon, 19 Mar 2018 19:06:13 +0100
Message-Id: <20180319180755.666233581@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391463626429173?=
X-GMAIL-MSGID: =?utf-8?q?1595391463626429173?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Martinez Canillas <javier@osg.samsung.com>


[ Upstream commit 7b87463edf3e2c16d72eeea3d1cf3c12bb5487c6 ]

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Before this patch:

$ modinfo sound/soc/codecs/snd-soc-rt5677.ko | grep alias
alias:          i2c:RT5677CE:00
alias:          i2c:rt5676
alias:          i2c:rt5677

After this patch:

$ modinfo sound/soc/codecs/snd-soc-rt5677.ko | grep alias
alias:          of:N*T*Crealtek,rt5677C*
alias:          of:N*T*Crealtek,rt5677
alias:          i2c:RT5677CE:00
alias:          i2c:rt5676
alias:          i2c:rt5677

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/rt5677.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5035,6 +5035,12 @@ static const struct i2c_device_id rt5677
 };
 MODULE_DEVICE_TABLE(i2c, rt5677_i2c_id);
 
+static const struct of_device_id rt5677_of_match[] = {
+	{ .compatible = "realtek,rt5677", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rt5677_of_match);
+
 static const struct acpi_gpio_params plug_det_gpio = { RT5677_GPIO_PLUG_DET, 0, false };
 static const struct acpi_gpio_params mic_present_gpio = { RT5677_GPIO_MIC_PRESENT_L, 0, false };
 static const struct acpi_gpio_params headphone_enable_gpio = { RT5677_GPIO_HP_AMP_SHDN_L, 0, false };
@@ -5294,6 +5300,7 @@ static int rt5677_i2c_remove(struct i2c_
 static struct i2c_driver rt5677_i2c_driver = {
 	.driver = {
 		.name = "rt5677",
+		.of_match_table = rt5677_of_match,
 	},
 	.probe = rt5677_i2c_probe,
 	.remove   = rt5677_i2c_remove,
