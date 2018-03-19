Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs0xajia8ZUQVMU7AdgqBcorhusm2pGH/rGDheOQJkIVtpgDosyP6AvXtsGl7oh4fO+IAAe
ARC-Seal: i=1; a=rsa-sha256; t=1521483182; cv=none;
        d=google.com; s=arc-20160816;
        b=IrQwSTynow8cVEmaMPZzMCFM2J4UZXlBfbQJ+503qJ7fp3VapgpqmF6b093R0qKpIU
         OvnRSEHlNMFDQJxbec5CYiBuRNHJq0sXYs5QEjeN4PQXqT+EaRuUDiUXakxwVrF5k2+Z
         l36iMASfCjUNojLSH6y6RakzUD8wx3ECExEN84FTn+l31jMeqbApa/L1TuZ/nSPGaq3V
         YhpNvaI0U5ndcOirnipPTiSziKB8WepYaTsqgOTgirp2jvIYDGKfP6guXkjFre4+N0pE
         O0k1TFjkWdVQOSq/OnUstwQZGrBjk2c80+A/5uXznr9zvOEMlhqy7PRZBMH3tqlCwkrK
         /TDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6xqiEyej/P7EW/cv1IxLFPhC4gDMLERZ6KBXcyJV4QY=;
        b=iUplIGOC1Pf2/BAU9kuyVnDbImoxYJF7wCARC7M80y3kILJoblZu6mbVvDk1BHDx2e
         jiexQRjcFwak4sFjQrD26D8G2BQBv1SzXn41eQdPHNDbr2ykt00zalF5agzbzpDjkSBY
         DqnjOjP/e3gsFwdAraHKE4ZCL4svIDKZc+RJj4PDAgx0gYJlCEQOET0Dnntjy7l6lIYW
         XvIocWSD8PaBylLNHnxe1FmShe+dkdTBDs/lzaHQJt6EybSh3YdApwyv8DFK42qYPG7f
         wkCvTNmq1NJFNcXuekGTEqnIoUrNneHEiTMTgtCDmxVBBx2rLb1L+RwyGJIIluH9Bx6Y
         u/mQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 029/134] Input: qt1070 - add OF device ID table
Date: Mon, 19 Mar 2018 19:05:12 +0100
Message-Id: <20180319171853.422990742@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390749733261002?=
X-GMAIL-MSGID: =?utf-8?q?1595390749733261002?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Martinez Canillas <javier@osg.samsung.com>


[ Upstream commit cf5cd9d4480a87da78768718cac194a71079b5cb ]

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

The compatible strings don't have a vendor prefix because that's how it's
used currently, and changing this will be a Device Tree ABI break.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/keyboard/qt1070.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/input/keyboard/qt1070.c
+++ b/drivers/input/keyboard/qt1070.c
@@ -274,9 +274,18 @@ static const struct i2c_device_id qt1070
 };
 MODULE_DEVICE_TABLE(i2c, qt1070_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id qt1070_of_match[] = {
+	{ .compatible = "qt1070", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qt1070_of_match);
+#endif
+
 static struct i2c_driver qt1070_driver = {
 	.driver	= {
 		.name	= "qt1070",
+		.of_match_table = of_match_ptr(qt1070_of_match),
 		.pm	= &qt1070_pm_ops,
 	},
 	.id_table	= qt1070_id,
