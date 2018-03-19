Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt7fyKyy9Cpfco2LFCOKqgWa8lp/0+4p00y3NP+/bJBpOKfU4NKRu+1WvcqFDzAn5MQIpx6
ARC-Seal: i=1; a=rsa-sha256; t=1521483631; cv=none;
        d=google.com; s=arc-20160816;
        b=HP8PGlgFrttmndWQ5CK6dtrKFMmCAJHmS/mJjtfkvsZJp5HzmZDf/LYEj+tTjU957F
         iwunTMDsNKyvTV97OP0l64t+mLpp4XTk7hVdSO/cyDMYcWyu1/ecugOBQpCBr9T+Axpm
         vOoX/r5dgAGBV85BxRDExVc+qrRARPwGvGxug6Loy0yRpVDj1zg9ldpti2/KsLkEO5fG
         dudTyir4ekxmgR6pq/XZgY2J2g+IN7ROx0Wmi+5X5eah3K/fnOy7Wb/NQLzr5cKRkGFx
         DAGH5XuyjZZuGhbtIf6r8vNSR78YGEdSrdhcEZmt3b0tTlViiBpMMaxV/pHU51IqYyKl
         yvqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0h2wQ+zyfTG2mG+OGdA4Ck6acRNfATfO+3U8bqUA8SM=;
        b=Doj4WMfr2MjHL4hn0+Q9JGpA+HDEHaFEElGLsnvFBcljfZogn4nlFcmnOSJk2Pi4Q0
         zJ7DIxJhG7Nsla8MnQzujWEBInAnULHIx87/zSeTUZkEQKghJIMPR1iawTsj3BVKmUnV
         D2O0kPRkv9VVg+Zbe2HYVboHsGXvx6VzU5+v/y4CPcUUo/NqwTM8jRBW5L+0xl5BiW/R
         2epeDUw20sEXeDRaPgih1ncmMrgUEOC3sahrWlLtDIRIeB93Q/cjlkipH0iuKPNc53WC
         qiK3nBO6VR++hROvyGPxnS/48qeUhZA1THKpH0YHNNKWOqLR5LciZvJh50Ma7iNEf+Kn
         sBcw==
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
Subject: [PATCH 4.9 058/241] Input: qt1070 - add OF device ID table
Date: Mon, 19 Mar 2018 19:05:23 +0100
Message-Id: <20180319180753.606780668@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390749733261002?=
X-GMAIL-MSGID: =?utf-8?q?1595391220739580015?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
