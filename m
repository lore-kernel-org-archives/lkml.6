Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvaHbUDhoYpKQbwL+8msQRXtoqzV4mOvBUlkezMVrIWB/NiFS4fjfpIMJcvz8BKuNtLhR68
ARC-Seal: i=1; a=rsa-sha256; t=1521482940; cv=none;
        d=google.com; s=arc-20160816;
        b=vJNnlESSQi9OHnHszzqm6vzTGoj5A6c81Dl+LGiuaw0VJo6dd6nkAYHO6y/Buig91w
         +42oT6GQNI+RCdeI4D8bQKTMwkmphu6iLgvycF717UKZs1/4zjQMe7OPoTrqEvmhAGW0
         OCvSOoVcG/Eeel7RoRrtX1Pt73p9ZmlXF9grTI572BiXDvDIDdveiec9fRjWhU6V/DnM
         Z1vRxk/aBuBOkMCVWNf/XbKoiSg4PYHB0QwWGHfriDsPoiU2Hp+YoEo9C5Bq9B+9gpJp
         ZexRMZAorlTdCkti13uF0rCaqiMxbkOoJWKRKntOKmexbxq2z9Z2pQSTgz8dVVhX+6MF
         7yeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=c6kIKZoGnQs7g4xQnwLDGskDU5gG1s0czc+RtAAOonE=;
        b=h4GN6cBccGpMZfQbxaTgbTORUZ3XXzwIFB1QRBvLUxO4MxKXp+xWCMqJOfF487tV/E
         Xk1b7ZmZYkzNzGKtI1saaPOcbkjofOkoBxTZU1EZoMYfojIW7xEGSk1Z6AKbqZYi+7Kg
         H1SArv8IbvNb3TuLVQbSQeoSQ08psycVDcBatNSYL37t/kgoJarXmt+SOYwf2rJ4RMLy
         CAmVe0xQRSBMRVqDu4+JPBbIRvoKwvzvoSrIVfRtI+8FDfyI5H9Kyo/zk1YLCkfDUXJT
         0Axun4QaS8ntviygKG6Zv4YWjBTI46PbKCSVNUocHR7SnVM0oNoFQOtjyb3GvE1jqoLS
         EV1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 01/68] Input: tsc2007 - check for presence and power down tsc2007 during probe
Date: Mon, 19 Mar 2018 19:05:39 +0100
Message-Id: <20180319171828.077672836@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390495654526465?=
X-GMAIL-MSGID: =?utf-8?q?1595390495654526465?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "H. Nikolaus Schaller" <hns@goldelico.com>


[ Upstream commit 934df23171e7c5b71d937104d4957891c39748ff ]

1. check if chip is really present and don't succeed if it isn't.
2. if it succeeds, power down the chip until accessed

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/touchscreen/tsc2007.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -456,6 +456,14 @@ static int tsc2007_probe(struct i2c_clie
 
 	tsc2007_stop(ts);
 
+	/* power down the chip (TSC2007_SETUP does not ACK on I2C) */
+	err = tsc2007_xfer(ts, PWRDOWN);
+	if (err < 0) {
+		dev_err(&client->dev,
+			"Failed to setup chip: %d\n", err);
+		return err;	/* usually, chip does not respond */
+	}
+
 	err = input_register_device(input_dev);
 	if (err) {
 		dev_err(&client->dev,
