Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227psgZmNGnW/gQCObWXyIK3F5DCSeVMs2GM65kW03HBw5jhTq/pUWIwgQHA9/zafUlzfkwT
ARC-Seal: i=1; a=rsa-sha256; t=1517855177; cv=none;
        d=google.com; s=arc-20160816;
        b=tNKTBnROu/AoPfxzor9nYuoA6e2SW0Ql8BYanmCNTZ34dX5scLvxlW4tt85aI/pvAD
         PI4xZNO4Bh1FlbNYXOKrAZEkSg6i4ABsYaYIr11t7XP2oo/xG4AWyt5lmHsgxfWZY+J2
         NDYHLdBlg2rlwl2c21OYDgcbjgUCNmeUHAns47HlXUn8eyKSPkja1USNlDmKv+t2K8Qz
         YP64swMBdsQhUIiosWLSXLCFlO5Okqg/XLSG0rgVFprMQFcwT8ZnBBPh1RjAhaF5joBz
         OLIEDIa9W3AOMFmRVGsSUdykXbdkY7LD1ETG25KCGOuCmlIz1KqwPt0j+IzlNXFC2HyJ
         Sgag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NRnD/sbQbPrUxqLDM9ocaHdMng5izaXY9exfNzxwWoY=;
        b=vAOWSJaqbDKQBh/BZGwoX3sG22HrmKMO7WoxXEssoJt/zpsckP7rxhJs5UXFdKYgg8
         JV/wR5qFG9kw6t9GM0eggnhJmerXNQc6cZjOEVjESkDlmFYp3r3F85Y0TSts4nHESKT0
         /JuvjxEyCjst2K4sa55kk1us0SV/fOPtlhTOcSXeG1vY8O62Zki6ihLnnI7WUB/H1c5K
         ERiVCoWd9Vzru1jwZtAWINP7laceISHXjwboTDZJ29xwjfnb51m6LsY6+C5wp0e9ndme
         NLZgwbNk5ooqh2P1Eg6ykBAEAe9rc3cEjW3paztLx9NSZAA1bpfcJggp9od7XmR2Oyff
         pBXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Robert Lippert <rlippert@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 18/36] hwmon: (pmbus) Use 64bit math for DIRECT format values
Date: Mon,  5 Feb 2018 10:23:46 -0800
Message-Id: <20180205182352.530993019@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586511357995491?=
X-GMAIL-MSGID: =?utf-8?q?1591586511357995491?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Lippert <roblip@gmail.com>


[ Upstream commit bd467e4eababe4c04272c1e646f066db02734c79 ]

Power values in the 100s of watt range can easily blow past
32bit math limits when processing everything in microwatts.

Use 64bit math instead to avoid these issues on common 32bit ARM
BMC platforms.

Fixes: 442aba78728e ("hwmon: PMBus device driver")
Signed-off-by: Robert Lippert <rlippert@google.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/pmbus_core.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/err.h>
@@ -443,8 +444,8 @@ static long pmbus_reg2data_linear(struct
 static long pmbus_reg2data_direct(struct pmbus_data *data,
 				  struct pmbus_sensor *sensor)
 {
-	long val = (s16) sensor->data;
-	long m, b, R;
+	s64 b, val = (s16)sensor->data;
+	s32 m, R;
 
 	m = data->info->m[sensor->class];
 	b = data->info->b[sensor->class];
@@ -472,11 +473,12 @@ static long pmbus_reg2data_direct(struct
 		R--;
 	}
 	while (R < 0) {
-		val = DIV_ROUND_CLOSEST(val, 10);
+		val = div_s64(val + 5LL, 10L);  /* round closest */
 		R++;
 	}
 
-	return (val - b) / m;
+	val = div_s64(val - b, m);
+	return clamp_val(val, LONG_MIN, LONG_MAX);
 }
 
 /*
@@ -588,7 +590,8 @@ static u16 pmbus_data2reg_linear(struct
 static u16 pmbus_data2reg_direct(struct pmbus_data *data,
 				 struct pmbus_sensor *sensor, long val)
 {
-	long m, b, R;
+	s64 b, val64 = val;
+	s32 m, R;
 
 	m = data->info->m[sensor->class];
 	b = data->info->b[sensor->class];
@@ -605,18 +608,18 @@ static u16 pmbus_data2reg_direct(struct
 		R -= 3;		/* Adjust R and b for data in milli-units */
 		b *= 1000;
 	}
-	val = val * m + b;
+	val64 = val64 * m + b;
 
 	while (R > 0) {
-		val *= 10;
+		val64 *= 10;
 		R--;
 	}
 	while (R < 0) {
-		val = DIV_ROUND_CLOSEST(val, 10);
+		val64 = div_s64(val64 + 5LL, 10L);  /* round closest */
 		R++;
 	}
 
-	return val;
+	return (u16)clamp_val(val64, S16_MIN, S16_MAX);
 }
 
 static u16 pmbus_data2reg_vid(struct pmbus_data *data,
