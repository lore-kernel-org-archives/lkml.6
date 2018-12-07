Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A4DC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8938520868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8938520868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbeLGL42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:56:28 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42890 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbeLGL42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:56:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 412B3EBD;
        Fri,  7 Dec 2018 03:56:27 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7FC43F5AF;
        Fri,  7 Dec 2018 03:56:24 -0800 (PST)
Subject: Re: [PATCH v4 10/10] sched/fair: Provide idle search schedstats
To:     Steve Sistare <steven.sistare@oracle.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org
References: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
 <1544131696-2888-11-git-send-email-steven.sistare@oracle.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <be837c2a-6e8d-3598-0a27-db90792a2673@arm.com>
Date:   Fri, 7 Dec 2018 11:56:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544131696-2888-11-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 06/12/2018 21:28, Steve Sistare wrote:
[...]
> @@ -6392,6 +6422,7 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
>  static int
>  select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
>  {
> +	unsigned long time = schedstat_start_time();

With arm64's defconfig (!CONFIG_SCHEDSTATS) I get:

kernel/sched/fair.c: In function ‘select_task_rq_fair’:
kernel/sched/fair.c:6459:16: warning: unused variable ‘time’ [-Wunused-variable]
  unsigned long time = schedstat_start_time();
                ^~~~

So you probably want something like this:

----->8-----
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5a113a8..7d33f74 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6456,12 +6456,14 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 static int
 select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
 {
-	unsigned long time = schedstat_start_time();
 	struct sched_domain *tmp, *sd = NULL;
 	int cpu = smp_processor_id();
 	int new_cpu = prev_cpu;
 	int want_affine = 0;
 	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
+	unsigned long time;
+
+	time = schedstat_start_time();
 
 	if (sd_flag & SD_BALANCE_WAKE) {
 		record_wakee(p);
-----8<-----

The 0-day bot will catch those but since it's the only warn I got I figured
I'd report it :)

>  	struct sched_domain *tmp, *sd = NULL;
>  	int cpu = smp_processor_id();
>  	int new_cpu = prev_cpu;
[...]
