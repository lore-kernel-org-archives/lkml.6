Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2763C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5322148D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6Kb5Z1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5322148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbeJSCGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:06:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbeJSCGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:06:06 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7963A21480;
        Thu, 18 Oct 2018 18:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885839;
        bh=+qkxDcDVyd0St3cpBtBevbyUobFWnTpOlwO9jd4tO8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C6Kb5Z1BRyyddTJXANySiDUu+I9ziGSBQM5EQKDZM7l0Fs493vcJljSyufBnOAXRK
         Bf1+irFCVH+WjwO//1RsRYORmLojekLlQVMh5EZ9qmMj3rUXgnAAApCLxj+l+njk05
         kGXRPh03HcyBs095O596uLIro68+1mJ5mMFGvFog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@redhat.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ivan Delalande <colona@arista.com>
Subject: [PATCH 4.9 31/35] macintosh/rack-meter: Convert cputime64_t use to u64
Date:   Thu, 18 Oct 2018 19:55:00 +0200
Message-Id: <20181018175426.899956596@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175422.506152522@linuxfoundation.org>
References: <20181018175422.506152522@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frederic Weisbecker <fweisbec@gmail.com>

commit 564b733c899f4e12a64946658960fce80cad0b05 upstream.

cputime_t is going to be removed and replaced by nsecs units,
so convert the drivers/macintosh/rack-meter.c use to u64..

Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Stanislaw Gruszka <sgruszka@redhat.com>
Cc: Wanpeng Li <wanpeng.li@hotmail.com>
Link: http://lkml.kernel.org/r/1485832191-26889-5-git-send-email-fweisbec@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ivan Delalande <colona@arista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/macintosh/rack-meter.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -52,8 +52,8 @@ struct rackmeter_dma {
 struct rackmeter_cpu {
 	struct delayed_work	sniffer;
 	struct rackmeter	*rm;
-	cputime64_t		prev_wall;
-	cputime64_t		prev_idle;
+	u64			prev_wall;
+	u64			prev_idle;
 	int			zero;
 } ____cacheline_aligned;
 
@@ -81,7 +81,7 @@ static int rackmeter_ignore_nice;
 /* This is copied from cpufreq_ondemand, maybe we should put it in
  * a common header somewhere
  */
-static inline cputime64_t get_cpu_idle_time(unsigned int cpu)
+static inline u64 get_cpu_idle_time(unsigned int cpu)
 {
 	u64 retval;
 
@@ -91,7 +91,7 @@ static inline cputime64_t get_cpu_idle_t
 	if (rackmeter_ignore_nice)
 		retval += kcpustat_cpu(cpu).cpustat[CPUTIME_NICE];
 
-	return nsecs_to_cputime64(retval);
+	return retval;
 }
 
 static void rackmeter_setup_i2s(struct rackmeter *rm)
@@ -217,23 +217,23 @@ static void rackmeter_do_timer(struct wo
 		container_of(work, struct rackmeter_cpu, sniffer.work);
 	struct rackmeter *rm = rcpu->rm;
 	unsigned int cpu = smp_processor_id();
-	cputime64_t cur_jiffies, total_idle_ticks;
-	unsigned int total_ticks, idle_ticks;
+	u64 cur_nsecs, total_idle_nsecs;
+	u64 total_nsecs, idle_nsecs;
 	int i, offset, load, cumm, pause;
 
-	cur_jiffies = jiffies64_to_cputime64(get_jiffies_64());
-	total_ticks = (unsigned int) (cur_jiffies - rcpu->prev_wall);
-	rcpu->prev_wall = cur_jiffies;
-
-	total_idle_ticks = get_cpu_idle_time(cpu);
-	idle_ticks = (unsigned int) (total_idle_ticks - rcpu->prev_idle);
-	idle_ticks = min(idle_ticks, total_ticks);
-	rcpu->prev_idle = total_idle_ticks;
+	cur_nsecs = jiffies64_to_nsecs(get_jiffies_64());
+	total_nsecs = cur_nsecs - rcpu->prev_wall;
+	rcpu->prev_wall = cur_nsecs;
+
+	total_idle_nsecs = get_cpu_idle_time(cpu);
+	idle_nsecs = total_idle_nsecs - rcpu->prev_idle;
+	idle_nsecs = min(idle_nsecs, total_nsecs);
+	rcpu->prev_idle = total_idle_nsecs;
 
 	/* We do a very dumb calculation to update the LEDs for now,
 	 * we'll do better once we have actual PWM implemented
 	 */
-	load = (9 * (total_ticks - idle_ticks)) / total_ticks;
+	load = div64_u64(9 * (total_nsecs - idle_nsecs), total_nsecs);
 
 	offset = cpu << 3;
 	cumm = 0;
@@ -278,7 +278,7 @@ static void rackmeter_init_cpu_sniffer(s
 			continue;
 		rcpu = &rm->cpu[cpu];
 		rcpu->prev_idle = get_cpu_idle_time(cpu);
-		rcpu->prev_wall = jiffies64_to_cputime64(get_jiffies_64());
+		rcpu->prev_wall = jiffies64_to_nsecs(get_jiffies_64());
 		schedule_delayed_work_on(cpu, &rm->cpu[cpu].sniffer,
 					 msecs_to_jiffies(CPU_SAMPLING_RATE));
 	}


