Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CEEC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8732A218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358979;
	bh=Wv530xqr03+n3a7x+O6AkwfJQNYNvbeuPtpQHz27SIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U35TfLmesbG/o8PC0rDs8vMLNw1TDe6+EZD6FsDQvJbEnqp9HaQqmWp1uaLPFlMlL
	 GVEisP4RuFXimomLAwB9DJdeo9aFcurf/4FAss7DIuVnepk+MSweBylUWVt2MzoP6B
	 XUGZzXv4kzNeW+FKBGPvC5MUztblIH1EKqvUt4J4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387855AbfAXTm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:42:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387438AbfAXTmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:42:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21ECB20663;
        Thu, 24 Jan 2019 19:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358970;
        bh=Wv530xqr03+n3a7x+O6AkwfJQNYNvbeuPtpQHz27SIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JB/W6Pfo0TbTwv4r8lvtl+mjlsH958STHHdLDqYWUskWcl9Ee3S72I65te1hFSMYq
         OaaCNtiQmwPxYMy9OqjXHZw+npN/jOKmNUW62CEa9C5gUscG1I+MsPZ9zjXDO6iWH+
         cPzNQZk4/hpMJXcuq0r1zYpFSUn1nRf7qs5TDd2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Wang <john.wanghui@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, guijianfeng@huawei.com,
        wencongyang2@huawei.com, douliyang1@huawei.com,
        qiaonuohan@huawei.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 091/127] x86/topology: Use total_cpus for max logical packages calculation
Date:   Thu, 24 Jan 2019 20:20:37 +0100
Message-Id: <20190124190215.931962973@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit aa02ef099cff042c2a9109782ec2bf1bffc955d4 ]

nr_cpu_ids can be limited on the command line via nr_cpus=. This can break the
logical package management because it results in a smaller number of packages
while in kdump kernel.

Check below case:
There is a two sockets system, each socket has 8 cores, which has 16 logical
cpus while HT was turn on.

 0  1  2  3  4  5  6  7     |    16 17 18 19 20 21 22 23
 cores on socket 0               threads on socket 0
 8  9 10 11 12 13 14 15     |    24 25 26 27 28 29 30 31
 cores on socket 1               threads on socket 1

While starting the kdump kernel with command line option nr_cpus=16 panic
was triggered on one of the cpus 24-31 eg. 26, then online cpu will be
1-15, 26(cpu 0 was disabled in kdump), ncpus will be 16 and
__max_logical_packages will be 1, but actually two packages were booted on.

This issue can reproduced by set kdump option nr_cpus=<real physical core
numbers>, and then trigger panic on last socket's thread, for example:

taskset -c 26 echo c > /proc/sysrq-trigger

Use total_cpus which will not be limited by nr_cpus command line to calculate
the value of __max_logical_packages.

Signed-off-by: Hui Wang <john.wanghui@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <guijianfeng@huawei.com>
Cc: <wencongyang2@huawei.com>
Cc: <douliyang1@huawei.com>
Cc: <qiaonuohan@huawei.com>
Link: https://lkml.kernel.org/r/20181107023643.22174-1-john.wanghui@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/smpboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index a9134d1910b9..ccd1f2a8e557 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1347,7 +1347,7 @@ void __init calculate_max_logical_packages(void)
 	 * extrapolate the boot cpu's data to all packages.
 	 */
 	ncpus = cpu_data(0).booted_cores * topology_max_smt_threads();
-	__max_logical_packages = DIV_ROUND_UP(nr_cpu_ids, ncpus);
+	__max_logical_packages = DIV_ROUND_UP(total_cpus, ncpus);
 	pr_info("Max logical packages: %u\n", __max_logical_packages);
 }
 
-- 
2.19.1



