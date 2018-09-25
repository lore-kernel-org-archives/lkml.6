Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8A1C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A666720867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XCk9hXMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A666720867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbeIYPps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:45:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34036 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbeIYPpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:45:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id t15so14677427wrx.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qJ8VdacrR0OZB3Gp+tWRJQDJ11ucpy9Q/KD5cZtzofU=;
        b=XCk9hXMmPCQHix5vlMEEoppjPa1d5zXoD6Eqt5Gk78tWwm85rFsIvOH64flVcbaJ6g
         cEBjqwTePJ1GptQSDf8veAE/TVa/Xj7AQBMIIW7PKYzKZBTv4rrSD4Uls0K9ey+j7Crq
         as73FZumZlROSXNkTOXf7Tfh80BSYYvI4K1eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qJ8VdacrR0OZB3Gp+tWRJQDJ11ucpy9Q/KD5cZtzofU=;
        b=R+h5VQN494XBzgfc62/+x6t7VmJK6X7RTieTxfwQwdliMtfExLActe8Yj3sIp1Wvju
         UHFF60gtQwn9sYhJ4kN7QZb7phxT+pz3YNMgC73Gehkfbcyg8bG1VTudYQ4iBgKPF70L
         5RJmgG5B5aHULEQ+CjotksRo9KmSEFfH7QQmZ0+/j5NPGLw2gc3GcasRm2jP9hxZFXwk
         71wV+7gViLrLUK7kEEKmzv0aZ2TJ+0r05w9EjUSpuW4m4JHwZDb9QliRamc1PyZjUpzP
         9zdznjfPQiv/nMkeIYPsR+wmjlQjmrwwGDLH0Yaa4UNW1jSGVuKYQJIXeV9eW06zMkxq
         koHw==
X-Gm-Message-State: ABuFfogMIJAmKG2I7Eb48vC+v1qEOTJ7AWXtVvQy9F/zhdHoO3GINqkh
        6lDi78EXlVmaKjpbs4crp6my1w==
X-Google-Smtp-Source: ACcGV63bvTub74JO4C4g0Z8OLHk9s3FemeOrmLgxoZ5fkcS20xfn2KU+AqmDG/ZAViWrrFqOH8TlgA==
X-Received: by 2002:adf:f94e:: with SMTP id q14-v6mr144775wrr.151.1537868344865;
        Tue, 25 Sep 2018 02:39:04 -0700 (PDT)
Received: from localhost.localdomain (251.150.136.77.rev.sfr.net. [77.136.150.251])
        by smtp.gmail.com with ESMTPSA id x15-v6sm1288203wrt.53.2018.09.25.02.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Sep 2018 02:39:04 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@android.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        Alex Shi <alex.shi@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC] cpuidle/drivers/menu: Remove get_loadavg in the performance multiplier
Date:   Tue, 25 Sep 2018 11:38:44 +0200
Message-Id: <1537868328-13405-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function get_loadavg() returns almost always zero. To be more
precise, statistically speaking for a total of 1023379 times passing
to the function, the load is equal to zero 1020728 times, greater than
100, 610 times, the remaining is between 0 and 5.

I'm putting in question this metric. Is it worth to keep it?

Cc: Todd Kjos <tkjos@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Colin Cross <ccross@android.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/governors/menu.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index e26a409..d939b8e 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -173,18 +173,10 @@ static inline int which_bucket(unsigned int duration, unsigned long nr_iowaiters
  * to be, the higher this multiplier, and thus the higher
  * the barrier to go to an expensive C state.
  */
-static inline int performance_multiplier(unsigned long nr_iowaiters, unsigned long load)
+static inline int performance_multiplier(unsigned long nr_iowaiters)
 {
-	int mult = 1;
-
-	/* for higher loadavg, we are more reluctant */
-
-	mult += 2 * get_loadavg(load);
-
 	/* for IO wait tasks (per cpu!) we add 5x each */
-	mult += 10 * nr_iowaiters;
-
-	return mult;
+	return 1 + 10 * nr_iowaiters;
 }
 
 static DEFINE_PER_CPU(struct menu_device, menu_devices);
@@ -359,7 +351,8 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		 * Use the performance multiplier and the user-configurable
 		 * latency_req to determine the maximum exit latency.
 		 */
-		interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
+		interactivity_req = data->predicted_us /
+			performance_multiplier(nr_iowaiters);
 		if (latency_req > interactivity_req)
 			latency_req = interactivity_req;
 	}
-- 
2.7.4

