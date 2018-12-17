Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B756C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA42820874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="J0GL08JQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbeLQOPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:15:03 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:44897 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbeLQONn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:13:43 -0500
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; 
   d="scan'208";a="24311046"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Dec 2018 07:13:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 17 Dec 2018 07:13:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BMkSmX/0HT0VNAH+rqVTriEboRLGFCp1YYtHWxHBGw=;
 b=J0GL08JQ9oqUy7++5zsOTEcILeFqOwczVuiwgrgDjmAIfIRmZYxrbvClgoNtlB0P014ngVZ19QVBYC2AOk/DKqbXuQSWWzTRlLUgGWpsD3F6P+xZxg73pWYKygSY1LvKpFpnPx3WdZu10/IF3rfksfyiqybV6Dyd+lUDtfAGrdQ=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0584.namprd11.prod.outlook.com (10.163.159.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Mon, 17 Dec 2018 14:13:40 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 14:13:40 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <robh@kernel.org>, <corbet@lwn.net>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v7 1/6] pwm: extend PWM framework with PWM modes
Thread-Topic: [PATCH v7 1/6] pwm: extend PWM framework with PWM modes
Thread-Index: AQHUlhK1b8ZkGsIsyE+4dj10q48ORg==
Date:   Mon, 17 Dec 2018 14:13:40 +0000
Message-ID: <1545055999-23950-2-git-send-email-claudiu.beznea@microchip.com>
References: <1545055999-23950-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1545055999-23950-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0015.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:d0::25) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0584;6:qgtMfrgiRrBHZSj1g7ttRclzKBMnVp2eZWmn0tJLB9a8pmLaPFaZQg/C33glVR3HS40pwjjej3dbywwswv9cBngnI3VYDi7AWXJlZGCJ1HhxVSNplcsAZaPpP2Vs+TmwS9wu0MS+0Km6HSwcb6zl6Jj9QSDsR4DWczYmmGlWZo+hxE/rwIm2MKNAryjCc7HXuXJpojTQmAYlo4hUlB3QkiwDwJ+1Npn4Gqhf2zNGilSSWQSvOMKuDxOHtIzKQLfV3Qs4LTgQ0TXapWClOJcXTf16DpHvRmCw/YUlizadB7bLL+j1iI/885tJ2sXopySAymFq2HT18shgxDLLPdVEMuTERILd8x+0KptpW2SdP7ceLkI0j7W85sYb/NZr2DCiu/JYquKPK4msVNirSkZLmqVfR1Iz1px/fmVaehSsOMvCIEBF/z/YYJA6dLAW2cRMTFHUVYXhHfMpSHhugc3+iQ==;5:7rjm/oR/cdyQnNKELFbaw6ns3lcBRc2TXJ3hVZqJyVJjWXbwyY5qSWkEgqNat0lZqGgIFkQHLVvEwftyvDVnNSOA1FWFB0C8NAboImrMp5XtQF8tIn5907q+DPdhuegswGrZvHaGBCD0m+9u3A+ZKN/BfQ2NABm0tJK49yTwwCg=;7:VpTS31mTyEJcqBJ2yeKRBMzhb+/fJYU9tD/clYbPiiF0n+iI3251JypvjR1QvqBdidSP6/BHD2YVR3ZXPbMCNplysr5a2JQhm4mUWaTFT+fbXcX9eiMqg65+IGGHNH1Z6Cc21vbadGBJgPiWho0LgQ==
x-ms-office365-filtering-correlation-id: b89fa3ed-50f3-4d4a-9874-08d66429d7ea
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0584;
x-ms-traffictypediagnostic: BY2PR11MB0584:
x-microsoft-antispam-prvs: <BY2PR11MB05849472415B653DDA61508B87BC0@BY2PR11MB0584.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0584;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0584;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(8676002)(25786009)(68736007)(6506007)(386003)(6116002)(102836004)(5660300001)(6436002)(66066001)(3846002)(39060400002)(478600001)(107886003)(71190400001)(2501003)(72206003)(256004)(305945005)(71200400001)(6486002)(7736002)(186003)(97736004)(26005)(52116002)(316002)(54906003)(476003)(4326008)(2201001)(99286004)(14444005)(14454004)(4744004)(11346002)(2616005)(446003)(2906002)(76176011)(6512007)(36756003)(53936002)(110136005)(86362001)(6636002)(8936002)(81156014)(486006)(81166006)(105586002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0584;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fFVQnAxVUQ8nmdAKqhViIABDtKeEBn1jaJAmCsBYO78Zd7CSbldqLSXPRa6vS1RP5wQGS0Ppe9HovogNI4X9kyvSQOEyjJuQwUf+dOSV2wmJa/m8QnuT+UE9z+ilfjXDtXNaV/O9IibOK62HORnMIW+wZ10EJOm6k/qyM151GoTFjbHe3wbpJ9thUQns1fuT2z4JYCItFSikxCqUBohYC/xEfblD1Wbol7Aqx3MwAm0I6KQi5iDjwXOYY3fprwhyFnCkc0gm0LnkZnY+dU75C5jzuJ1pzd/8QDK/owbV5ohphBX21RvfKtGGguAC8vT2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b89fa3ed-50f3-4d4a-9874-08d66429d7ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 14:13:40.1889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0584
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
 drivers/pwm/core.c  | 91 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 drivers/pwm/sysfs.c | 61 +++++++++++++++++++++++++++++++++++
 include/linux/pwm.h | 35 +++++++++++++++++++++
 3 files changed, 186 insertions(+), 1 deletion(-)

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
index 56518adc31dd..abe189d891af 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -10,6 +10,9 @@ struct pwm_capture;
 struct seq_file;
=20
 struct pwm_chip;
+struct pwm_device;
+
+unsigned long pwm_get_default_modebit(const struct pwm_device *pwm);
=20
 /**
  * enum pwm_polarity - polarity of a PWM signal
@@ -26,6 +29,28 @@ enum pwm_polarity {
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
@@ -53,12 +78,14 @@ enum {
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
@@ -181,6 +208,7 @@ static inline void pwm_init_state(const struct pwm_devi=
ce *pwm,
 	state->period =3D args.period;
 	state->polarity =3D args.polarity;
 	state->duty_cycle =3D 0;
+	state->modebit =3D pwm_get_default_modebit(pwm);
 }
=20
 /**
@@ -254,6 +282,7 @@ pwm_set_relative_duty_cycle(struct pwm_state *state, un=
signed int duty_cycle,
  * @get_state: get the current PWM state. This function is only
  *	       called once per PWM device when the PWM chip is
  *	       registered.
+ * @get_caps: get PWM capabilities.
  * @dbg_show: optional routine to show contents in debugfs
  * @owner: helps prevent removal of modules exporting active PWMs
  */
@@ -272,6 +301,8 @@ struct pwm_ops {
 		     struct pwm_state *state);
 	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
 			  struct pwm_state *state);
+	int (*get_caps)(const struct pwm_chip *chip,
+			const struct pwm_device *pwm, struct pwm_caps *caps);
 #ifdef CONFIG_DEBUG_FS
 	void (*dbg_show)(struct pwm_chip *chip, struct seq_file *s);
 #endif
@@ -438,6 +469,9 @@ struct pwm_device *pwm_request_from_chip(struct pwm_chi=
p *chip,
 					 unsigned int index,
 					 const char *label);
=20
+int pwm_get_caps(const struct pwm_device *pwm, struct pwm_caps *caps);
+bool pwm_supports_mode(const struct pwm_device *pwm, unsigned long modebit=
);
+const char *pwm_get_mode_name(unsigned long modebit);
 struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
 		const struct of_phandle_args *args);
=20
@@ -592,6 +626,7 @@ static inline void pwm_apply_args(struct pwm_device *pw=
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

