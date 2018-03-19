Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvBPDAm52vXrLaqiLoh12wrq+SCQOLjEB/pcXZeMGGm5wYT0C16dDAdUNC59h26ja11cnCp
ARC-Seal: i=1; a=rsa-sha256; t=1521483521; cv=none;
        d=google.com; s=arc-20160816;
        b=B2tdlyHVktWFYMZ3q++zF3786oEVSo0HBpj8BhMWoiMhsI3K6WMfCgqeVYYZtGontM
         ifZM0bBRyN+aAgaw+/vdsTCmotdqJiXcPRNmn364v9igqbZCrXaCr+5VC5dYtwu8SgUx
         73qHdbuymmVYy2epb0WZT6JMJ3ZM1u9d/8b3ZhzagUgJlhIfgIh4LSx5rvU7LxFXRU80
         59uP5if7wX+KfjsTt0Hfnor+u8wKEa2WsuQiRwKaAyU7wlzVRILC3ObDH73he+g2axZe
         xZZydxvK1yY3qUAMvjkYWFaWQ1bWxlFZmuPfe6FTPENze4ZQ1InmeSUALWZeuQfg0mcg
         QiIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+Ou8XalbW6PGSIyp3gOVOR/K97mYW84w/L1VqvyzV+U=;
        b=RMQd8iJmezlYVLZ2yZqAmwmdZXZAAY+WHXDZO320C4I4KlvzaGk+XyDDgqjgDSTmjA
         YaymKmN/CRJ+1+li3tK7ud6F3XAcNA5FB7Fhyq0T91kez85K0tOPXGSZYCEk4MefWIoG
         zdDirgyGgEwiQdffE+7GhKfGZDTonWiQ7aXlmRmIznAom1PDOQyrNmV6MiqBx/xAZtpl
         jup5MDmX7XdZ+Ls+AMs4EAiNVgkYH2o11sORFsbRGV8tThJqt77H2olOs8/z/2yD4GhP
         gkyzii19w+Da+h2h8aYjtXBuSpGpiHaEIyIMF3J1Xxemmc52pYHWdP8YW+JAWsMvFFis
         xmsA==
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
Subject: [PATCH 4.9 002/241] Input: tsc2007 - check for presence and power down tsc2007 during probe
Date: Mon, 19 Mar 2018 19:04:27 +0100
Message-Id: <20180319180751.272167310@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390495654526465?=
X-GMAIL-MSGID: =?utf-8?q?1595391105330498826?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -455,6 +455,14 @@ static int tsc2007_probe(struct i2c_clie
 
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
