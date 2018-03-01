Return-Path: <bich.hemon@st.com>
X-Google-Smtp-Source: AG47ELuBk8L0SEnpbxncwc5k1cH5wUa1u2NSLaS7nmfSRVDQcax7vog9SQSO2hD6qnur/nyWQhYU
ARC-Seal: i=1; a=rsa-sha256; t=1519907398; cv=none;
        d=google.com; s=arc-20160816;
        b=W28dLCFHFZCsSdGratJ5iPNeo+St0CGOlTBxPJl/gArE0Lddx/t8nXEqQ8UiMU/sLA
         yWkyW+Fe7hisUKURyfAKkO7ml1wuT7QR/bWVh+FXVLy6euPi7HiHISmWOr76XwWN96Rc
         Criqsc2hxpUmJROl0tjPAWtg3TN36Rm1QHk6PTnBidbmCkmEll0N3I24AbEhEAiY1VUA
         /owLlaGwrlgiiDNVla4PbYsvRI3QbxYVAkaYIrSM8TFRWkG8Xz18aTmQuzD+aQgj+Sft
         NYZul0NY5QJJPhq7rLPT/KmwX1nYqUHfBiKUz3ROTF1pk/cfObrP61awFuRI38zLYMGp
         WeIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:arc-authentication-results;
        bh=dHWYj9cHmpmfWOyAL5tOMLf8ks82hYPuhrOcvuxuJvs=;
        b=jTAl1K6wjNgCWw8dSb50QBvbSwLD5SzIzgtG26foyYkbBMD1G/oP9okrxNO5kkk1Xt
         zNBMASFzAufuhbiN67uhkJiG6hauxjVc2cuAb8v1nOjHmtvTR+vbTglmmzdxXImMXwV6
         rnSuEnp+02UtKdaM+WlGTZqm9EkTWosZtdK/Jk67d+PnN4VjLaQzsnwe3bjeAxBvGiwQ
         tSWy0rGn8iO3dQDwRZrCSIgvYTCewLM9OWzjtmyXY9d3Ch7GatyS0ZbJwcdLizqDj25x
         vwe5Jc2QigA+sJbUi/oFGnF0IrYnSm0ILwopzpXVGnrevWYdRTxno8z/k9hVX/yVv+Bv
         Hnsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bich.hemon@st.com designates 62.209.51.94 as permitted sender) smtp.mailfrom=bich.hemon@st.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bich.hemon@st.com designates 62.209.51.94 as permitted sender) smtp.mailfrom=bich.hemon@st.com
From: Bich HEMON <bich.hemon@st.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring
	<robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "Jiri Slaby" <jslaby@suse.com>,
        "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH] can: m_can: select pinctrl state in each suspend/resume
 function
Thread-Topic: [PATCH] can: m_can: select pinctrl state in each suspend/resume
 function
Thread-Index: AQHTsVj+oIHYuI2hpUGPrP1VhQsGlA==
Date: Thu, 1 Mar 2018 12:29:50 +0000
Message-ID: <1519907380-15135-1-git-send-email-bich.hemon@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_07:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593738420380267806?=
X-GMAIL-MSGID: =?utf-8?q?1593738420380267806?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Make sure to apply the correct pin state in suspend/resume callbacks.
Putting pins in sleep state saves power.

Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 drivers/net/can/m_can/m_can.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 2594f77..a86ef69 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1700,6 +1700,8 @@ static __maybe_unused int m_can_suspend(struct device=
 *dev)
 		m_can_clk_stop(priv);
 	}
=20
+	pinctrl_pm_select_sleep_state(dev);
+
 	priv->can.state =3D CAN_STATE_SLEEPING;
=20
 	return 0;
@@ -1710,6 +1712,8 @@ static __maybe_unused int m_can_resume(struct device =
*dev)
 	struct net_device *ndev =3D dev_get_drvdata(dev);
 	struct m_can_priv *priv =3D netdev_priv(ndev);
=20
+	pinctrl_pm_select_default_state(dev);
+
 	m_can_init_ram(priv);
=20
 	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
--=20
1.9.1
