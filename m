Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpkPpT8SQUhILoSx80ik8jl0//lrgo8Vt7LWXp8SvDjc1fvufMWzeYE12JE0kKYIYkUAvkg
ARC-Seal: i=1; a=rsa-sha256; t=1524837744; cv=none;
        d=google.com; s=arc-20160816;
        b=hrrUrv8uD6pCECsyMCzOgNFbNjhle8/cvsLkdEFUL4JYGrHrS59pzDPT+/SYorkSVx
         r6mmi5PAbgtaNnjFO9frBPQrc30aom6FYqzaNPzDHKxqRHHxIa6iiewvl6LLGfbNPNxM
         m/pAs29quncYFr8qapsgs4E836QkTdd+kcVfyxWXxCiJRCLsuTS+c6vCO/KJspX9vfh4
         /Lh3w1FurlMLbZViOs2gpNBV+Lg3B8X1yxQhlHEVESBKGFP1zvLK6mFMiKBlDFtF0LDZ
         2zokdSCxEP62GOlqeR5GqXZ6YiHaK/Xcp2iYRyEWVOc2tRJaXkYmcOeeu8hsSpXVTq/y
         sv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=udhh1JyPn4igKimfwpFylQjX1Yrl/OqZamEglkZCzl8=;
        b=FqFlrWrmX9O5VhJXg11zB7jxt4EBTQOvPQ+vKb5b9bFC9zHavQKk1/G6OV1rFmXyMR
         tJQ3Cv0oslVgu1a7ZUH/8frIvo62r/a7rQVhQcEx6R8D0m1byjMT1ik/qp1wSe5GLc2O
         TI5Fvwxjv35SACi8b7XOZJXMn2bCz/0M8d5buuOchrA/TBZOBovnqrwsTP3OcgiGVFuK
         z/NPhkvGgldzgfA9LzHriok+nJOILviowal3/7o93NbPVdbVaIo0jU32OJf8k6DFfb8j
         Y8Q/nZ88Le4AlJs4c2ph6UWVY8swhb2Xp4WoJ+AYTl0IJQh/qWndLKz3n9/7F+Tw9Tmy
         nCrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907AE2189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Murphy <dmurphy@ti.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.4 06/50] Input: drv260x - fix initializing overdrive voltage
Date: Fri, 27 Apr 2018 15:58:08 +0200
Message-Id: <20180427135656.018112844@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908262562310694?=
X-GMAIL-MSGID: =?utf-8?q?1598908262562310694?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit 74c82dae6c474933f2be401976e1530b5f623221 upstream.

We were accidentally initializing haptics->rated_voltage twice, and did not
initialize overdrive voltage.

Acked-by: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/misc/drv260x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -521,7 +521,7 @@ static int drv260x_probe(struct i2c_clie
 	if (!haptics)
 		return -ENOMEM;
 
-	haptics->rated_voltage = DRV260X_DEF_OD_CLAMP_VOLT;
+	haptics->overdrive_voltage = DRV260X_DEF_OD_CLAMP_VOLT;
 	haptics->rated_voltage = DRV260X_DEF_RATED_VOLT;
 
 	if (pdata) {
