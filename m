Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsLkp0lffWy4vYlyw7s/kf7d6/yfXHZUOAd9umaeodYRr1gaoJI25ZAGpRZMqExsN4/qdYs
ARC-Seal: i=1; a=rsa-sha256; t=1521483955; cv=none;
        d=google.com; s=arc-20160816;
        b=BABD2zeUM2VsYF2eI4EZXyDcYrZLjdiE4SnDLMDHUMPZOncpAXs80paoIMuhTyOZMA
         P92HV8BXx123ukpApYXef7P2qJO2Yo08vFqaGbGy2LsyHv5g1PmdLc/H9vzMW7BkN7qj
         QaKR0CTbfeOd/tucJvKu/IqzWX2GLzKE/Y7+znHh4eJ9GvtZAHTiO1ATrpE6/cYsZl1G
         pWvdS3eq4cyUqk7jVn2bWzwZfoBj4Av3EXudCZxJ/jAwNuBJH2gmSOTwXHFPhZDDlxF8
         TO+UMuewlKWhsMGY0j5FYjEJMkZTgiFvsn+KlC7SCfnl2IQoMsMG/w23pXV+IS3sE5c4
         xKwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qP49o6ULFPUNunwZ3ZjmTdlgrcpV5ACECnFAjoxXeo8=;
        b=CdF6VjO+PYmeCZHSvE7i8bDgpjg9JVTJAXdm1GoRHtHzL4gGhfqLzTVCnSoisM3TZN
         xjW2vdObc1wIfkUnv/M51SnSNqcK4a8AEFd92FAjZI6xZkxWyFChQ+/NRbOlZXXLXSff
         lbzRlJF3KpsWN66wmVsYUfM72uOFOYlAeSwTqxAzy3IrF20IdKvYi+8EvxTYHNQPBUW6
         mW5vzrlEGaEtHQisjN4vvgj583NrZb3gnk4ntKcAftjiCruxzCd4xO7of9r6vpp2YSxF
         +FVMhSJoYw151v33xkMWvCG77WuVQcJeraRT8kM1nhhz3bwoGKOv7yg/8WCgzgXbT+nL
         Li1w==
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
Subject: [PATCH 4.9 143/241] drivers/perf: arm_pmu: handle no platform_device
Date: Mon, 19 Mar 2018 19:06:48 +0100
Message-Id: <20180319180757.110623684@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390868408579074?=
X-GMAIL-MSGID: =?utf-8?q?1595391560219769245?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -322,10 +322,16 @@ validate_group(struct perf_event *event)
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
@@ -337,8 +343,8 @@ static irqreturn_t armpmu_dispatch_irq(i
 	 * dereference.
 	 */
 	armpmu = *(void **)dev;
-	plat_device = armpmu->plat_device;
-	plat = dev_get_platdata(&plat_device->dev);
+
+	plat = armpmu_get_platdata(armpmu);
 
 	start_clock = sched_clock();
 	if (plat && plat->handle_irq)
