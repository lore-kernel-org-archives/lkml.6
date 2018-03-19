Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvyp7KXUmmPtmlIh4a9ihhEhy35vy2SMekkcJ+FsiaxBj+qFI+ZoIsxg6GNqK0AUZteJ9J8
ARC-Seal: i=1; a=rsa-sha256; t=1521483295; cv=none;
        d=google.com; s=arc-20160816;
        b=qwNrUulJyTRjYYerUHNq+jFeuQ2TyhSvs9mC7VixXEGwXm6D7u3YuD/yrsTOUysN1t
         Cw/vW7khsIgNNPNkj15DE5eFcPntJQv+JAAzmEaNAyaHduVu68mFShbBkuFf/2hqQJb5
         6CXzUlKWbNcotzWCkpJBC//O1eZzrruuV+4F0VHHxkuGCZRFjvLlSiLCwpfOE8aLzuiR
         qZebK2T29bVCsG38b7Y8Zkn2/h8LRm0l+8ZHYghLO3Z9LLv/PvinOWXYkEETaoOEpIn3
         Z5p4DEiKFlTHc0qu3CJjh6mPUPDH4wuBUaoTHNwqHzROMpzwZXCCQIpGUmtxGWuc3F4u
         0IiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aoDNvGd3miw86H1uZNsTvg5cEHSCKn972IIMbznw6d4=;
        b=hA0amg38GScq2jp9cBWiL++OAvV2llusPZLKMvl7PELZi+T8Fw3Rd0Iyvy8mjCGq4v
         Y4WOeGObESmZ+93K+539sXXKMtQ/ex3Kx7nXQTTm80scUcRMLIzhDbv4l9DMgeaQNPui
         y6ox4D6ghO7bAQPmQnom9XepsRcbTGNL7Zjlr3KvurT6ICbIbs3MIHDRUrokYJX0VbSj
         O1PcHcMIs4SxKzveZhxkaw+qcTGXVzDp6/mspswDowEwF8qCgmfdFjGeJvYeyHAIvl2Y
         tfT29ruTKR1k+X55PJAl/cqB2UVBZFATS84u6Kcb9xW/u1A2MIhr8PDwfYkjPedHw955
         YiTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 070/134] drivers/perf: arm_pmu: handle no platform_device
Date: Mon, 19 Mar 2018 19:05:53 +0100
Message-Id: <20180319171859.341765752@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390868408579074?=
X-GMAIL-MSGID: =?utf-8?q?1595390868408579074?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


[ Upstream commit 7654137071fa706e5c91f4f27bc2a5cd7e435a9b ]

In armpmu_dispatch_irq() we look at arm_pmu::plat_device to acquire
platdata, so that we can defer to platform-specific IRQ handling,
required on some 32-bit parts. With the advent of ACPI we won't always
have a platform_device, and so we must avoid trying to dereference
fields from it.

This patch fixes up armpmu_dispatch_irq() to avoid doing so, introducing
a new armpmu_get_platdata() helper.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/perf/arm_pmu.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -321,10 +321,16 @@ validate_group(struct perf_event *event)
 	return 0;
 }
 
+static struct arm_pmu_platdata *armpmu_get_platdata(struct arm_pmu *armpmu)
+{
+	struct platform_device *pdev = armpmu->plat_device;
+
+	return pdev ? dev_get_platdata(&pdev->dev) : NULL;
+}
+
 static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
 {
 	struct arm_pmu *armpmu;
-	struct platform_device *plat_device;
 	struct arm_pmu_platdata *plat;
 	int ret;
 	u64 start_clock, finish_clock;
@@ -336,8 +342,8 @@ static irqreturn_t armpmu_dispatch_irq(i
 	 * dereference.
 	 */
 	armpmu = *(void **)dev;
-	plat_device = armpmu->plat_device;
-	plat = dev_get_platdata(&plat_device->dev);
+
+	plat = armpmu_get_platdata(armpmu);
 
 	start_clock = sched_clock();
 	if (plat && plat->handle_irq)
