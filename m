Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuumTLOYso0OPpnilwI/nkN1FX4AiifFjtLnxYyYOfWbu+7N9hsWbYP7EvxIpv+W5/UtKl9
ARC-Seal: i=1; a=rsa-sha256; t=1521800138; cv=none;
        d=google.com; s=arc-20160816;
        b=zcgRYZQlN3XKpvdIFcf238DTV8oZOo9uCYwHG0MRQeB3/zAgjV0F5IHDTjMAT2SmkN
         2Uva+Hr+ZB/3VT+2b+pzgxphm6o6Js+l+6W1rgvdtd3k9clPqDkN6uoQkoMaQdb4vjUl
         IQP+wnev0e8zfBcLfYDdOlPhJ1rUIM+QTXPsoYN27OVQjb5ufSM7Ej9pW4kzaMAlW491
         FB3JDVdrYrf16lDzAUHGqUQZ9aRNmjW4XMiK5dTCP3WbVZGL7u2U9kimvU18ICpgveY6
         b8mDeWYlygLIzHbKCu945R5scLNbaJ7T8ktb9JtCewxafSG4hdpXOSVHf6JMOZcEmTcX
         Q8HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=c9hdvDQDhszg+WxUsdMS5sz3yjrzNk9/2tzZZSqrjSo=;
        b=bYY0JbimmnHxgtNBtrQPKXkvhMhrCstPOBvJRfuaTBe6Lp4GG2Uv79FDFaE2LfQJtv
         mdB0pkGMH5NRnQm3PSJmWas0iWggCmc48pnioStKmTVwn1t+ZRmGkEfvFYKp4VVii5a/
         eS7Nqh71lmxpV5xVdHKyOrZn3Wz/I9ogoq91UqlSAAg33faQqSBghDCx/9gwQB4/RJtR
         KZBdMDaSXIG3RaqV5A7gvQftuWEl//a7aJ8QvQn9aJA7iSNg0PSqXasV3dHvnbDiufN3
         zcHx2yDUdVEqxzGdm+Yiqy44zmHPJxxMKDV0iPDe+6oLANXS9obpJcofsQLf+/oIhjlr
         v2bg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 62/97] Input: twl4030-pwrbutton - use correct device for irq request
Date: Fri, 23 Mar 2018 10:54:49 +0100
Message-Id: <20180323094201.091325005@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722752515965613?=
X-GMAIL-MSGID: =?utf-8?q?1595723101742355218?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>


[ Upstream commit 3071e9dd6cd3f2290d770117330f2c8b2e9a97e4 ]

The interrupt should be requested for the platform device
and not for the input device.

Fixes: 7f9ce649d267 ("Input: twl4030-pwrbutton - simplify driver using devm_*")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/misc/twl4030-pwrbutton.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -70,7 +70,7 @@ static int twl4030_pwrbutton_probe(struc
 	pwr->phys = "twl4030_pwrbutton/input0";
 	pwr->dev.parent = &pdev->dev;
 
-	err = devm_request_threaded_irq(&pwr->dev, irq, NULL, powerbutton_irq,
+	err = devm_request_threaded_irq(&pdev->dev, irq, NULL, powerbutton_irq,
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
 			IRQF_ONESHOT,
 			"twl4030_pwrbutton", pwr);
