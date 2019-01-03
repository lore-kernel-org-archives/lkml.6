Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6326C43612
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AB32073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="a5w3L0we"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbfACN3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:29:51 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:42329 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731409AbfACN3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:29:49 -0500
X-IronPort-AV: E=Sophos;i="5.56,435,1539673200"; 
   d="scan'208";a="22165264"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Jan 2019 06:29:48 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 3 Jan 2019 06:30:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ReJdSPRLur42ChEef64TCSjKzn6BBELfoqH8OV4ZGY=;
 b=a5w3L0wewzlZdPrqHyKIuaoyDN+Zz5/gNKrm7E61ISs5gXaUCk47gLXK0VW/+V7H5H1mIMNXNnU4DhMEE8+XtLwvhPdjCwJsomwaR6/OEiBwWuYHLkauEttLwr9rYhQe3u/27HnXVd6ljePfPa0ky3/zy1Bm7mXPyo1UsAajjU0=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1984.namprd11.prod.outlook.com (10.175.54.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 13:29:45 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627%6]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 13:29:45 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <corbet@lwn.net>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v8 1/6] pwm: extend PWM framework with PWM modes
Thread-Topic: [PATCH v8 1/6] pwm: extend PWM framework with PWM modes
Thread-Index: AQHUo2hjF9SHYVC+/UyvQjeBLKSGNw==
Date:   Thu, 3 Jan 2019 13:29:44 +0000
Message-ID: <1546522081-23659-2-git-send-email-claudiu.beznea@microchip.com>
References: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0209.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::33) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1984;6:roNmuBqogtV9npHEKNXjkWKuwI8I6moAwwHXsBp0uwYK/tJ1grVXvqe2YSCya8lb+58s7D3+uiH6LOTu3+32SSuxalYt1plsnqqpDStgxU+TVMKLUKbTh+GzENwGrYqKq4jjh20b0wBjq3+7j0yBTkGUJ1auOyeltqwH4MeEvNvEOnIdHu68W7RUS8okegeo2uNy4SPy8IirMbNTYY68nRwRT0XF6JRO7FlkEH+hUJTDbRRRDKw7Ju8SobY03OuNY32bA/IW5Wl6+W3meUACOukTiiAE/4ozmpUxmBzyIafLBIScLNVPgYTUwugl7VeZiXTM2cdy/zjo16bXmjcuWDLgf6n/sjgIH05DgUJLN+a9MUsUsUubAXZOBtASKnN1UybUsqrsbA6hkF30wK6OEXNpMuMZG01wGjGdQdAydCRs9zbHqP9O2co6JXRCreAB5v04sLEitKhbG6xahlxWsQ==;5:q/IhCGv9jRQh3tJ3unHqwTFRWHXYmngqoRuSnz0PlBXw8G7qCIrMbYhPdWYlodFEDwViL7SOAhtkDd1n9B+R7GzQOdLpm7T9brvS6YnVpWVdTYQ8st6xa1Xk020f2Mx3g27JFsoltohWotdrc0/y676v/cW0asFFnBUXoQXHWq7jtR8+DQDkZNuPGS2wG82t4dPhxUE6TD/t9aKBwSVkVA==;7:deenA9spZLekTVGgh/p5phBnm+j/vBtzrgSSDzq01A3NvuXfECe4pel+eMmQj43+4KGwMtTBW54fLgD4earZ32+Typb6cj4xCRJZJ2DU0aSwwZ43eCXZzmMZeXdoGdChNyxRhAer2lg+TI2orU4Odg==
x-ms-office365-filtering-correlation-id: 696837e1-99fd-49fd-ffc6-08d6717f861b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1984;
x-ms-traffictypediagnostic: MWHPR11MB1984:
x-microsoft-antispam-prvs: <MWHPR11MB198442C0FBF537751B80C84A878D0@MWHPR11MB1984.namprd11.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR11MB1984;BCL:0;PCL:0;RULEID:;SRVR:MWHPR11MB1984;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(11346002)(71190400001)(6486002)(2501003)(72206003)(14454004)(4744004)(2616005)(476003)(97736004)(446003)(5660300001)(478600001)(316002)(6636002)(86362001)(99286004)(54906003)(52116002)(110136005)(71200400001)(6436002)(6512007)(186003)(53936002)(305945005)(7736002)(3846002)(39060400002)(6506007)(386003)(6116002)(105586002)(106356001)(107886003)(68736007)(76176011)(36756003)(4326008)(26005)(81156014)(81166006)(102836004)(8936002)(66066001)(2906002)(486006)(8676002)(256004)(25786009)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1984;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZzJeUHOotROsYl4YdxgXKlYzHf29pnJ/jlZ31tO0RADhprufvMTjY/NHpMc4TphL6NffTT2h9rX28DBeDIbGyrkwFWuphwQvj8YS/U/qUyrwJkAjyC5POO58LPBcnnyeW3NWP4keWXTxofhwBtRzDkdb8d9E3QdlVU0HpA/TMMAfW9giIbgHlYxw1JM602WrNRn4S6zOoO24MRphZjasIXzR2wJ9jC2ZDEckKKJ2SCexfgZisX8RwPBiePNYDr0v3x17WoByDgsbGYpbZ6mQ6dMW4FJnTbaobvdDcpJ3bWj2U0E3/nZIOE2pki7g8or2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 696837e1-99fd-49fd-ffc6-08d6717f861b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 13:29:44.8304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1984
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add basic PWM modes: normal and complementary. These modes should
differentiate the single output PWM channels from two outputs PWM
channels. These modes could be set as follow:
1. PWM channels with one output per channel:
- normal mode
2. PWM channels with two outputs per channel:
- normal mode
- complementary mode
Since users could use a PWM channel with two output as one output PWM
channel, the PWM normal mode is allowed to be set for PWM channels with
two outputs; in fact PWM normal mode should be supported by all PWMs.

The PWM capabilities were implemented per PWM channel. Every PWM controller
will register a function to get PWM capabilities. If this is not explicitly
set by the driver a default function will be used to retrieve the PWM
capabilities (in this case the PWM capabilities will contain only PWM
normal mode). To retrieve capabilities the pwm_get_caps() function could
be used.

Every PWM channel have associated a mode in the PWM state. Proper
support was added to get/set PWM mode. Only modes supported by PWM channel
could be set.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/core.c  |  91 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/pwm/sysfs.c |  61 ++++++++++++++++++++++++++++++
 include/linux/pwm.h | 104 +++++++++++++++++++++++++++++++++++-------------=
----
 3 files changed, 222 insertions(+), 34 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1581f6ab1b1f..eb444ee8d486 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -249,6 +249,88 @@ static bool pwm_ops_check(const struct pwm_ops *ops)
 	return false;
 }
=20
+static int pwm_get_default_caps(struct pwm_caps *caps)
+{
+	static const struct pwm_caps default_caps =3D {
+		.modes_msk =3D PWM_MODE_BIT(NORMAL),
+	};
+
+	if (!caps)
+		return -EINVAL;
+
+	*caps =3D default_caps;
+
+	return 0;
+}
+
+/**
+ * pwm_get_caps() - get PWM capabilities of a PWM device
+ * @pwm: PWM device to get the capabilities for
+ * @caps: returned capabilities
+ *
+ * Returns: 0 on success or a negative error code on failure
+ */
+int pwm_get_caps(const struct pwm_device *pwm, struct pwm_caps *caps)
+{
+	if (!pwm || !caps)
+		return -EINVAL;
+
+	if (pwm->chip->ops->get_caps)
+		return pwm->chip->ops->get_caps(pwm->chip, pwm, caps);
+
+	return pwm_get_default_caps(caps);
+}
+EXPORT_SYMBOL_GPL(pwm_get_caps);
+
+/**
+ * pwm_get_default_modebit() - get the default mode for PWM (as a bit mask=
)
+ * @pwm: PWM device to get the default mode for
+ *
+ * Returns: the default PWM mode (as a bit mask) for PWM device
+ */
+unsigned long pwm_get_default_modebit(const struct pwm_device *pwm)
+{
+	struct pwm_caps caps;
+
+	if (pwm_get_caps(pwm, &caps))
+		return PWM_MODE_BIT(NORMAL);
+
+	return BIT(ffs(caps.modes_msk) - 1);
+}
+EXPORT_SYMBOL_GPL(pwm_get_default_modebit);
+
+/**
+ * pwm_supports_mode() - check if PWM mode is supported by PWM device
+ * @pwm: PWM device
+ * @modebit: PWM mode bit mask to be checked (see PWM_MODE_BIT())
+ *
+ * Returns: true if PWM mode is supported, false otherwise
+ */
+bool pwm_supports_mode(const struct pwm_device *pwm, unsigned long modebit=
)
+{
+	struct pwm_caps caps;
+
+	if (!pwm || !modebit)
+		return false;
+
+	if (hweight_long(modebit) !=3D 1 || ffs(modebit) - 1 >=3D PWM_MODE_CNT)
+		return false;
+
+	if (pwm_get_caps(pwm, &caps))
+		return false;
+
+	return !!(caps.modes_msk & modebit);
+}
+EXPORT_SYMBOL_GPL(pwm_supports_mode);
+
+const char *pwm_get_mode_name(unsigned long modebit)
+{
+	if (modebit =3D=3D PWM_MODE_BIT(COMPLEMENTARY))
+		return "complementary";
+
+	return "normal";
+}
+
 /**
  * pwmchip_add_with_polarity() - register a new PWM chip
  * @chip: the PWM chip to add
@@ -294,6 +376,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 		pwm->pwm =3D chip->base + i;
 		pwm->hwpwm =3D i;
 		pwm->state.polarity =3D polarity;
+		pwm->state.modebit =3D pwm_get_default_modebit(pwm);
=20
 		if (chip->ops->get_state)
 			chip->ops->get_state(chip, pwm, &pwm->state);
@@ -469,7 +552,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_=
state *state)
 	int err;
=20
 	if (!pwm || !state || !state->period ||
-	    state->duty_cycle > state->period)
+	    state->duty_cycle > state->period ||
+	    !pwm_supports_mode(pwm, state->modebit))
 		return -EINVAL;
=20
 	if (!memcmp(state, &pwm->state, sizeof(*state)))
@@ -530,6 +614,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_=
state *state)
=20
 			pwm->state.enabled =3D state->enabled;
 		}
+
+		pwm->state.modebit =3D state->modebit;
 	}
=20
 	return 0;
@@ -579,6 +665,8 @@ int pwm_adjust_config(struct pwm_device *pwm)
 	pwm_get_args(pwm, &pargs);
 	pwm_get_state(pwm, &state);
=20
+	state.modebit =3D pwm_get_default_modebit(pwm);
+
 	/*
 	 * If the current period is zero it means that either the PWM driver
 	 * does not support initial state retrieval or the PWM has not yet
@@ -999,6 +1087,7 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct=
 seq_file *s)
 		seq_printf(s, " duty: %u ns", state.duty_cycle);
 		seq_printf(s, " polarity: %s",
 			   state.polarity ? "inverse" : "normal");
+		seq_printf(s, " mode: %s", pwm_get_mode_name(state.modebit));
=20
 		seq_puts(s, "\n");
 	}
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index ceb233dd6048..7865fbafbeb4 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -223,11 +223,71 @@ static ssize_t capture_show(struct device *child,
 	return sprintf(buf, "%u %u\n", result.period, result.duty_cycle);
 }
=20
+static ssize_t mode_show(struct device *child,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	struct pwm_device *pwm =3D child_to_pwm_device(child);
+	struct pwm_state state;
+	unsigned long modebit;
+	enum pwm_mode mode;
+	int len =3D 0;
+
+	pwm_get_state(pwm, &state);
+
+	for (mode =3D PWM_MODE_NORMAL; mode < PWM_MODE_CNT; mode++) {
+		modebit =3D BIT(mode);
+		if (pwm_supports_mode(pwm, modebit)) {
+			if (state.modebit =3D=3D modebit)
+				len +=3D scnprintf(buf + len,
+						 PAGE_SIZE - len, "[%s] ",
+						 pwm_get_mode_name(modebit));
+			else
+				len +=3D scnprintf(buf + len,
+						 PAGE_SIZE - len, "%s ",
+						 pwm_get_mode_name(modebit));
+		}
+	}
+
+	len +=3D scnprintf(buf + len, PAGE_SIZE - len, "\n");
+	return len;
+}
+
+static ssize_t mode_store(struct device *child,
+			  struct device_attribute *attr,
+			  const char *buf, size_t size)
+{
+	struct pwm_export *export =3D child_to_pwm_export(child);
+	struct pwm_device *pwm =3D export->pwm;
+	struct pwm_state state;
+	unsigned long modebit;
+	enum pwm_mode mode;
+	int ret;
+
+	for (mode =3D PWM_MODE_NORMAL; mode < PWM_MODE_CNT; mode++) {
+		modebit =3D BIT(mode);
+		if (sysfs_streq(buf, pwm_get_mode_name(modebit)))
+			break;
+	}
+
+	if (mode =3D=3D PWM_MODE_CNT)
+		return -EINVAL;
+
+	mutex_lock(&export->lock);
+	pwm_get_state(pwm, &state);
+	state.modebit =3D modebit;
+	ret =3D pwm_apply_state(pwm, &state);
+	mutex_unlock(&export->lock);
+
+	return ret ? : size;
+}
+
 static DEVICE_ATTR_RW(period);
 static DEVICE_ATTR_RW(duty_cycle);
 static DEVICE_ATTR_RW(enable);
 static DEVICE_ATTR_RW(polarity);
 static DEVICE_ATTR_RO(capture);
+static DEVICE_ATTR_RW(mode);
=20
 static struct attribute *pwm_attrs[] =3D {
 	&dev_attr_period.attr,
@@ -235,6 +295,7 @@ static struct attribute *pwm_attrs[] =3D {
 	&dev_attr_enable.attr,
 	&dev_attr_polarity.attr,
 	&dev_attr_capture.attr,
+	&dev_attr_mode.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(pwm);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index d5199b507d79..3d89343bc405 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -26,6 +26,28 @@ enum pwm_polarity {
 };
=20
 /**
+ * PWM modes capabilities
+ * @PWM_MODE_NORMAL: PWM has one output
+ * @PWM_MODE_COMPLEMENTARY: PWM has 2 outputs with opposite polarities
+ * @PWM_MODE_CNT: PWM modes count
+ */
+enum pwm_mode {
+	PWM_MODE_NORMAL,
+	PWM_MODE_COMPLEMENTARY,
+	PWM_MODE_CNT,
+};
+
+#define PWM_MODE_BIT(name)		BIT(PWM_MODE_##name)
+
+/**
+ * struct pwm_caps - PWM capabilities
+ * @modes_msk: bitmask of supported modes (see PWM_MODE_*)
+ */
+struct pwm_caps {
+	unsigned long modes_msk;
+};
+
+/**
  * struct pwm_args - board-dependent PWM arguments
  * @period: reference period
  * @polarity: reference polarity
@@ -53,12 +75,14 @@ enum {
  * @period: PWM period (in nanoseconds)
  * @duty_cycle: PWM duty cycle (in nanoseconds)
  * @polarity: PWM polarity
+ * @modebit: PWM mode bit
  * @enabled: PWM enabled status
  */
 struct pwm_state {
 	unsigned int period;
 	unsigned int duty_cycle;
 	enum pwm_polarity polarity;
+	unsigned long modebit;
 	bool enabled;
 };
=20
@@ -151,39 +175,6 @@ static inline void pwm_get_args(const struct pwm_devic=
e *pwm,
 }
=20
 /**
- * pwm_init_state() - prepare a new state to be applied with pwm_apply_sta=
te()
- * @pwm: PWM device
- * @state: state to fill with the prepared PWM state
- *
- * This functions prepares a state that can later be tweaked and applied
- * to the PWM device with pwm_apply_state(). This is a convenient function
- * that first retrieves the current PWM state and the replaces the period
- * and polarity fields with the reference values defined in pwm->args.
- * Once the function returns, you can adjust the ->enabled and ->duty_cycl=
e
- * fields according to your needs before calling pwm_apply_state().
- *
- * ->duty_cycle is initially set to zero to avoid cases where the current
- * ->duty_cycle value exceed the pwm_args->period one, which would trigger
- * an error if the user calls pwm_apply_state() without adjusting ->duty_c=
ycle
- * first.
- */
-static inline void pwm_init_state(const struct pwm_device *pwm,
-				  struct pwm_state *state)
-{
-	struct pwm_args args;
-
-	/* First get the current state. */
-	pwm_get_state(pwm, state);
-
-	/* Then fill it with the reference config */
-	pwm_get_args(pwm, &args);
-
-	state->period =3D args.period;
-	state->polarity =3D args.polarity;
-	state->duty_cycle =3D 0;
-}
-
-/**
  * pwm_get_relative_duty_cycle() - Get a relative duty cycle value
  * @state: PWM state to extract the duty cycle from
  * @scale: target scale of the relative duty cycle
@@ -254,6 +245,7 @@ pwm_set_relative_duty_cycle(struct pwm_state *state, un=
signed int duty_cycle,
  * @get_state: get the current PWM state. This function is only
  *	       called once per PWM device when the PWM chip is
  *	       registered.
+ * @get_caps: get PWM capabilities.
  * @dbg_show: optional routine to show contents in debugfs
  * @owner: helps prevent removal of modules exporting active PWMs
  */
@@ -272,6 +264,8 @@ struct pwm_ops {
 		     struct pwm_state *state);
 	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
 			  struct pwm_state *state);
+	int (*get_caps)(const struct pwm_chip *chip,
+			const struct pwm_device *pwm, struct pwm_caps *caps);
 #ifdef CONFIG_DEBUG_FS
 	void (*dbg_show)(struct pwm_chip *chip, struct seq_file *s);
 #endif
@@ -402,6 +396,10 @@ struct pwm_device *pwm_request_from_chip(struct pwm_ch=
ip *chip,
 					 unsigned int index,
 					 const char *label);
=20
+int pwm_get_caps(const struct pwm_device *pwm, struct pwm_caps *caps);
+bool pwm_supports_mode(const struct pwm_device *pwm, unsigned long modebit=
);
+unsigned long pwm_get_default_modebit(const struct pwm_device *pwm);
+const char *pwm_get_mode_name(unsigned long modebit);
 struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
 		const struct of_phandle_args *args);
=20
@@ -488,6 +486,11 @@ static inline struct pwm_device *pwm_request_from_chip=
(struct pwm_chip *chip,
 	return ERR_PTR(-ENODEV);
 }
=20
+static inline unsigned long pwm_get_default_modebit(const struct pwm_devic=
e *pwm)
+{
+	return 0;
+}
+
 static inline struct pwm_device *pwm_get(struct device *dev,
 					 const char *consumer)
 {
@@ -522,6 +525,40 @@ static inline void devm_pwm_put(struct device *dev, st=
ruct pwm_device *pwm)
 }
 #endif
=20
+/**
+ * pwm_init_state() - prepare a new state to be applied with pwm_apply_sta=
te()
+ * @pwm: PWM device
+ * @state: state to fill with the prepared PWM state
+ *
+ * This functions prepares a state that can later be tweaked and applied
+ * to the PWM device with pwm_apply_state(). This is a convenient function
+ * that first retrieves the current PWM state and the replaces the period
+ * and polarity fields with the reference values defined in pwm->args.
+ * Once the function returns, you can adjust the ->enabled and ->duty_cycl=
e
+ * fields according to your needs before calling pwm_apply_state().
+ *
+ * ->duty_cycle is initially set to zero to avoid cases where the current
+ * ->duty_cycle value exceed the pwm_args->period one, which would trigger
+ * an error if the user calls pwm_apply_state() without adjusting ->duty_c=
ycle
+ * first.
+ */
+static inline void pwm_init_state(const struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct pwm_args args;
+
+	/* First get the current state. */
+	pwm_get_state(pwm, state);
+
+	/* Then fill it with the reference config */
+	pwm_get_args(pwm, &args);
+
+	state->period =3D args.period;
+	state->polarity =3D args.polarity;
+	state->duty_cycle =3D 0;
+	state->modebit =3D pwm_get_default_modebit(pwm);
+}
+
 static inline void pwm_apply_args(struct pwm_device *pwm)
 {
 	struct pwm_state state =3D { };
@@ -550,6 +587,7 @@ static inline void pwm_apply_args(struct pwm_device *pw=
m)
 	state.enabled =3D false;
 	state.polarity =3D pwm->args.polarity;
 	state.period =3D pwm->args.period;
+	state.modebit =3D pwm_get_default_modebit(pwm);
=20
 	pwm_apply_state(pwm, &state);
 }
--=20
2.7.4

