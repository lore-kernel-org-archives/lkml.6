Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvzHwOpGkyDfqWaF+JAGdhcMjT/maPnDygBS/qkJaTZ343WST00O6KrQmsScXPNO5lX4+4N
ARC-Seal: i=1; a=rsa-sha256; t=1521799797; cv=none;
        d=google.com; s=arc-20160816;
        b=0ALW+k5ceD0ZMzfnC+5BIeJUIhQIKySORM1CNMTLqYAYuV5vF2fhkn/CwLh3PtbToD
         EebL2t+2dgFNyO5+Fz5XroHrocvqlQonJilCUMa/P7iTgCuEbD6/LWQii/FbXoXF3fsY
         GItZhYeX+MO9VuuZP8mKw7WmEvzj6Q+KVy+2oSRlh4teFV4VzVeoJ4lMI0LCsdn3JezQ
         0EcyV4zZTTdKtCTuhe8WcF0F3150ptEz8IwHufURm4SDg3LBzisP7ngGj6upUDMr8OPN
         fKGouZPAc3A2EvjcAqat9U50PFy2ZsnhCtVE8AlzOQCdI7ix9bK53yFz2uc6yB6uG1TM
         r0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GBNbElZZHarsIuhvSPq8yOvxL9qt0ahCUvEIOpCBSEE=;
        b=lsngi7wBsFQuoB6xS3yV/btDFYjXzVjI/M8N0dY6cN0+zpwEh9gQs5VEdcSiALcA4Q
         iue6Du80mfwhNG4mn+tVWT/BVYrrlvGxPT0gKpi+3V/X0hUZ2wYRQAokb9uO1rcMC1OG
         phs/zObMwsXIiDWfj1CN6Fr4/WWtCueGcZ5F9qhcgGw+GUkrBhPdXp4ThGhELxofF3eY
         puBlXny5mPHXRMh76cdIztVu/RiLnAWxIqNrTR8zl2b6CI69h7DZEQQytFzghUckw+Pq
         vkegbxJWPZhX6H1Plh7SqxVJxkgO4uYT/GQsCG4W+ePIwrgnMAS9rgMC5krdZzJArZEw
         4n7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pan Bian <bianpan2016@163.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 112/177] power: supply: isp1704: Fix unchecked return value of devm_kzalloc
Date: Fri, 23 Mar 2018 10:54:00 +0100
Message-Id: <20180323094210.205500571@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722744909432665?=
X-GMAIL-MSGID: =?utf-8?q?1595722744909432665?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pan Bian <bianpan2016@163.com>


[ Upstream commit 8b20839988f1ed5e534b270f3776709b640dc7e0 ]

Function devm_kzalloc() will return a NULL pointer. However, in function
isp1704_charger_probe(), the return value of devm_kzalloc() is directly
used without validation. This may result in a bad memory access bug.

Fixes: 34a109610e2a ("isp1704_charger: Add DT support")
Signed-off-by: Pan Bian <bianpan2016@163.com>
Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/isp1704_charger.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/power/supply/isp1704_charger.c
+++ b/drivers/power/supply/isp1704_charger.c
@@ -418,6 +418,10 @@ static int isp1704_charger_probe(struct
 
 		pdata = devm_kzalloc(&pdev->dev,
 			sizeof(struct isp1704_charger_data), GFP_KERNEL);
+		if (!pdata) {
+			ret = -ENOMEM;
+			goto fail0;
+		}
 		pdata->enable_gpio = gpio;
 
 		dev_info(&pdev->dev, "init gpio %d\n", pdata->enable_gpio);
