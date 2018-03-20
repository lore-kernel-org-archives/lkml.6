Return-Path: <dietmar.eggemann@arm.com>
X-Google-Smtp-Source: AG47ELsjlnNA7xCHHHMkVhqIuK5nbBy7QZ8dn78t8qZNTgM/IUcDKrObmEOBkZZE9mim65xxmhFp
ARC-Seal: i=1; a=rsa-sha256; t=1521539063; cv=none;
        d=google.com; s=arc-20160816;
        b=Kv5IGP64BqD4qj2YWBmKPSkZOYX9YuewUo8agizPsA4SHUKrUmo+B8ad4gYVI1xIUh
         iWjY75kOetfCdyqzCTUpi2ng6Ec6V3rJNODZB5uGfy3sU4EMMdnkHxQf2Zs0/NnBqhSb
         voGzrtrNr9s+2Q9zUa7USdBYcxRv9wzPN4lomGMf5a/iPQiuZgziD8/92ZvIt+EttcXJ
         HY74ahCdudwan2l3hJYoouDoVT9Nw+3WTxsA+Ksj7mzJZBI9eLhL1LxkKggPXI1yNYYp
         P9vk7lXwPFLs/u4qpaEC69ZD0VzKbJA0mq9bGXpktYcThfbAqHj46GuzAPdvUussfTMd
         iJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=t4gJWA8/3RTVXDZ1B1zPQjtdqO7lTwQwlooGwxSbXg8=;
        b=WaQCDKKv5WIEXzi3+Uq4dzkxfcszpkCmuXSPSVASfD+RzswSgcER+imX8zrvSpC2Rw
         CtH3H7NatY9yQAdrg7r77c0JMIsNWHSY6tLmVDtLeBC4VNTHpE/daWhv7Ts7nvY3Wyqx
         ruJtA6p5uOVlBjsUIS1IA9TRY4vTJmxzMz6noXArKQdhmBC7JvKlKjhQSiR4fIxgQuI1
         kTfrZbd5QElcmlooYxgsdJU/nUNTgwpeTor+1AWRo8H6y3y/UAj3qPmGP/gAFiuctOFT
         ur/2ybwrZnhOsXXnbuvhI7DhzVsEUMNmbay05Ffeh7wlmclspk//cIphOkTOtgnZzwr6
         7NNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Quentin Perret <quentin.perret@arm.com>,
	Thara Gopinath <thara.gopinath@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>,
	Joel Fernandes <joelaf@google.com>
Subject: [RFC PATCH 6/6] drivers: base: arch_topology.c: Enable EAS for arm/arm64 platforms
Date: Tue, 20 Mar 2018 09:43:12 +0000
Message-Id: <20180320094312.24081-7-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180320094312.24081-1-dietmar.eggemann@arm.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449345498208449?=
X-GMAIL-MSGID: =?utf-8?q?1595449345498208449?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Quentin Perret <quentin.perret@arm.com>

Energy Aware Scheduling (EAS) has to be started from the arch code.
This commit enables it from the arch topology driver for arm/arm64
systems, hence enabling a better support for Arm big.LITTLE and future
DynamIQ architectures.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/base/arch_topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 52ec5174bcb1..e2206ea16538 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/sched/topology.h>
+#include <linux/sched/energy.h>
 
 DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
 
@@ -204,6 +205,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 		free_raw_capacity();
 		pr_debug("cpu_capacity: parsing done\n");
 		schedule_work(&parsing_done_work);
+		init_sched_energy();
 	}
 
 	return 0;
-- 
2.11.0
