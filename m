Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225W5uFpHIcE7boZCdl575mpvahbT8E6zBU1yKTIopTFHX7/jRDagI80zCKvydj5UOrkM4l/
ARC-Seal: i=1; a=rsa-sha256; t=1519412165; cv=none;
        d=google.com; s=arc-20160816;
        b=kbv+OsF+CWNSuSoDQ40JOPWtSO6g5xjaaT5T0a3QYWNeKr2mDIkAeEoxypIS/jRUeN
         NXIlRnCkS144/GPgMZCgKAbBVjPPoMGWJIuc0I9/rF4St7R//usxeJQODBQlnz2vJqEH
         RTZPjoHYlXiCkLsHvQO2PZmRFmp7TIeomu2F5XuRyHkCJcq98buS8EhjfSv8hHoEO9KQ
         2TCP0uU2BI+6FglAUyeqpWb67YQde6A+UHwX0XP6f7Eq2BtYMe+9adEOSAcgspMNrk3K
         8nRUoHfYlo70RMQ+fQNMM3lQWE4fw5cMP4SENq6ms2FdwiEBO9JG+rgUH/1U5wSQQViT
         BKAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5Xwq+6pLCCop2yiW1A+qW4T6KHM2J1a0twtDr8KFKvM=;
        b=VWCIAz6tsso/sT73AXTHjBWikS5D6rhUuBMHxZbV9Fs0WKTN7u6ykXe4JTAKVoLlIS
         RnvrhPbZnY9elbnIDY6H818195+RwSvt9FAZsjiOxu0q73s/q0QGDGRLO3RnT/k3x7GU
         qpRDOySVf5tz0peUFXqYYZMFblHslog37NTrrQfIW8kN8UD4UxZ4+4fBIRR/QaT/R4s5
         8QSG0/cbOfEgr5VDZWDutJHT1ZFrfKqWH5BWkNARvjRaDM7HGSXguapa5JB3gG0UpWWf
         N+/ISB0nqbJaimXyMMpYKS7NVXozaaZIcU2OBhyCtFZFgAHH4DEaY3hZq4DehGy6J5BQ
         Uapg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andreas Platschek <andreas.platschek@opentech.at>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 146/159] usb: dwc3: of-simple: fix missing clk_disable_unprepare
Date: Fri, 23 Feb 2018 19:27:34 +0100
Message-Id: <20180223170800.632976786@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218493004940773?=
X-GMAIL-MSGID: =?utf-8?q?1593219131504134450?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Platschek <andreas.platschek@opentech.at>


[ Upstream commit ded600ea9fb51a495d2fcd21e90351df876488e8 ]

If of_clk_get() fails, the clean-up of already initialized clocks should be
the same as when clk_prepare_enable() fails. Thus a clk_disable_unprepare()
for each clock should be called before the clk_put().

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 16adc674d0d6 ("usb: dwc3: ep0: fix setup_packet_pending initialization")

Signed-off-by: Andreas Platschek <andreas.platschek@opentech.at>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/dwc3-of-simple.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -57,8 +57,10 @@ static int dwc3_of_simple_clk_init(struc
 
 		clk = of_clk_get(np, i);
 		if (IS_ERR(clk)) {
-			while (--i >= 0)
+			while (--i >= 0) {
+				clk_disable_unprepare(simple->clks[i]);
 				clk_put(simple->clks[i]);
+			}
 			return PTR_ERR(clk);
 		}
 
