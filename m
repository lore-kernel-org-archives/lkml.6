Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CC6C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEB62086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="mQ0IrP52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AEB62086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeLJNwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:52:34 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44550 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeLJNwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:52:33 -0500
Received: by mail-qk1-f196.google.com with SMTP id n12so6457664qkh.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 05:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8RbBHMlHC4MBAxHJ/VKYOqUPgKWsUsgjDHJ/6QsaCV4=;
        b=mQ0IrP52cV3hOoqcWLeYg1PX6fs9QsNDlX6cQlAXGsO4doPFW969At55QsnHgFaGDA
         u+ddBCkDjiqLEwyD5rX28kEIZJkQtb1+c+8IIhK8a8222JRMc6P/YQUmqgvL6ar1PGiq
         fvByncSn08DCn06qSPc7wZXNqWGYzTHgMz+Cbe+eL4PPUm1UTS0z6bX56QiO76fY68Aj
         6wb9gcVpX1KRQPgJdWuKbr11jG88BaMSt9qEZ88zw4HsZhaFuM54ASuRjorwYrHgImLx
         KKLfOlReA81HL3hXlipz7/gIq4O/ucKawGYEHTFDdh199eAgaYAmwmW9iftqTUfAFmZ3
         mSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8RbBHMlHC4MBAxHJ/VKYOqUPgKWsUsgjDHJ/6QsaCV4=;
        b=Vao+tEhUdNfrHpUvK0Gm99NiRESlxJbBHo5iFg5C5AGaDIUU+DSOGFumXY15iw97E/
         hCMXg5gD9VJYPnxVtk0B7jH5SdbFU+BurLUrfsX3lzF8giaxT7Gfc9elfdH8MWbWb9gC
         DSivKITAbXBvzgVhq4aCA02RAtA74WfjeGK5hDOhPOdmr8+e/OxNkxpd9JxX+9VVvxCi
         /9qXoJz8Si43DkNXKTNM4T080kXusCBluA8thOriL8BFTZM3lpUh1W+Du5zl7Rbdnqn3
         6JC6/6jg4GDuMzDiIq1ZqM3ETZPWyVjb9A/sthi8uuGYDhd6iZ4jcCd7yLB+MGQqVZrz
         T3+w==
X-Gm-Message-State: AA+aEWZHMj+AwIOEIcR8rHzmBgIRyEeMJJJPW7n2pPXy74TomGtmCsN8
        oQjFzYHm9be5mIhTuJavubxNTA==
X-Google-Smtp-Source: AFSGD/U3hLsfUNTIL9SOo9dVZOP6/1WAjGlUmNPzoyhYTIIpXgqBrKN9XyeX5Rl+OJCvGospEWwsnQ==
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr11141349qkg.147.1544449952499;
        Mon, 10 Dec 2018 05:52:32 -0800 (PST)
Received: from ovpn-121-90.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j33sm7104854qte.38.2018.12.10.05.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 05:52:31 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mark.rutland@arm.com, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org, longman@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [RESEND PATCH v2] clocksource/arm_arch_timer: fix a lockdep warning
Date:   Mon, 10 Dec 2018 08:52:28 -0500
Message-Id: <20181210135228.49751-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <1543877121-4098-1-git-send-email-cai@gmx.us>
References: <1543877121-4098-1-git-send-email-cai@gmx.us>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting this Huawei TaiShan 2280 arm64 server generated this lockdep
warning.

[    0.000000]  lockdep_assert_cpus_held+0x50/0x60
[    0.000000]  static_key_enable_cpuslocked+0x30/0xe8
[    0.000000]  arch_timer_check_ool_workaround+0x128/0x2d0
[    0.000000]  arch_timer_acpi_init+0x274/0x6ac
[    0.000000]  acpi_table_parse+0x1ac/0x218
[    0.000000]  __acpi_probe_device_table+0x164/0x1ec
[    0.000000]  timer_probe+0x1bc/0x254
[    0.000000]  time_init+0x44/0x98
[    0.000000]  start_kernel+0x4ec/0x7d4

This is due to the commit cb538267ea1e ("jump_label/lockdep: Assert we hold
the hotplug lock for _cpuslocked() operations").

Since it is applying a global workaround to all CPUs here, it did not hold
any CPU locks in this path.

arch_timer_acpi_init
  arch_timer_check_ool_workaround(ate_match_acpi_oem_info, table)
    arch_timer_enable_workaround(wa, local = false)
      for_each_possible_cpu()
	per_cpu()

There is also another path did not have any CPU lock.

time_init
  clocksource_probe
    arch_timer_of_init
      arch_timer_check_ool_workaround(ate_match_dt, np)
        arch_timer_enable_workaround(wa, local = false)

When hot-adding a CPU, it will go with a slightly different route.

arch_timer_starting_cpu
  __arch_timer_setup
    arch_timer_check_ool_workaround(ate_match_local_cap_id, NULL)
      arch_timer_enable_workaround(wa, local = true)
        __this_cpu_write()

Hence, deal with them differently.

Fixes: 450f9689f294 (clocksource/arm_arch_timer: Use
static_branch_enable_cpuslocked())
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: fix the root cause instead of a workaround.

 drivers/clocksource/arm_arch_timer.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9a7d4dc00b6e..81dca7d31d13 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -492,17 +492,20 @@ void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa
 
 	if (local) {
 		__this_cpu_write(timer_unstable_counter_workaround, wa);
+
+		/*
+		 * Use the locked version, as we're called from the CPU
+		 * hotplug framework. Otherwise, we end-up in
+		 * deadlock-land.
+		 */
+		static_branch_enable_cpuslocked(&arch_timer_read_ool_enabled);
 	} else {
 		for_each_possible_cpu(i)
 			per_cpu(timer_unstable_counter_workaround, i) = wa;
+		/* A global workaround is not on the CPU hotplug path. */
+		static_branch_enable(&arch_timer_read_ool_enabled);
 	}
 
-	/*
-	 * Use the locked version, as we're called from the CPU
-	 * hotplug framework. Otherwise, we end-up in deadlock-land.
-	 */
-	static_branch_enable_cpuslocked(&arch_timer_read_ool_enabled);
-
 	/*
 	 * Don't use the vdso fastpath if errata require using the
 	 * out-of-line counter accessor. We may change our mind pretty
-- 
2.17.2 (Apple Git-113)

