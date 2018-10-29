Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321ABC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 07:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEBE2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 07:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gI1N7dBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEBE2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbeJ2QFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 12:05:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33591 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbeJ2QFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 12:05:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id x6-v6so3366171pln.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 00:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDlV+Xbz1j+NaR368L2vTpe24uF3g5mlaQe0xzBflGQ=;
        b=gI1N7dBtcaiUljcwKUPdD0lhNurPTNaQ728+UNi7gvxJ9tn08e3Hm9+efVxFd0rBys
         42/qKw4i8NM/Sfjbc7JzC25VK7t8intb8J4+L6fWaZ5K1BvEDUSDCE1T7qsBBebA4EEr
         NQRzQ6Iq6VRZ6d1kjnvDcJg+Io97QQKRXkeWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDlV+Xbz1j+NaR368L2vTpe24uF3g5mlaQe0xzBflGQ=;
        b=eqsdRBLdbLZVVe4yX2y5ytL9lfrzx/jp8KXljAAeDgAheNH9zAZCElPRh0mdUHdFlt
         k1Wkf0GhWHk7vtZjj/t1jLLR44oD0RebuJ8bK0oDztDMvKQ3AWquEWX3GMm3z+6wXOTc
         Z6FJOZXtYQ3pbtLeVb+83d20yWv7ZBiHdudRca7NoD49Qh00GYFGLHsLS1eGe85dw1aH
         azUOLbV83NzJObLUaPc52MFRIa9x3HF2I4USt0b9USdSb9cxPLbAa+CGO4wRsEoTKslf
         8BmSJgdbnEGIkp3myCf2TuAtLu7rv/uLjoUBOUNv1RU/IkvW6VD7zYVlM8JOXbSHgTCb
         bGTA==
X-Gm-Message-State: AGRZ1gIB7aD3/NogUDmbgtOisXOqhQpAEsoOtTbF3gElHb8D3IAk4Apd
        +Lwe2gZvEfkOfSPOHiIdt2Hmcg==
X-Google-Smtp-Source: AJdET5c8ObvQnCb8owdZb7slfRkHgqpPhewVlNYQGEQVn9ck0BMr+blRI5Y2ueprqD5ApFe0r8RTeA==
X-Received: by 2002:a17:902:f203:: with SMTP id gn3mr12600884plb.93.1540797469909;
        Mon, 29 Oct 2018 00:17:49 -0700 (PDT)
Received: from localhost ([122.172.56.94])
        by smtp.gmail.com with ESMTPSA id b16-v6sm21538679pfm.145.2018.10.29.00.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 00:17:48 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Pavel <pavel2000@ngs.ru>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: cpu-freq: Frequencies aren't always sorted
Date:   Mon, 29 Oct 2018 12:47:40 +0530
Message-Id: <844626b372018192fd0e9fe399343e09ef4dc842.1540797432.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The order in which the frequencies are displayed in cpufreq stats
depends on the order in which the frequencies were sorted in the
frequency table provided to cpufreq core by the cpufreq driver. They can
be completely unsorted as well.

The documentation's claim that the stats will be sorted in descending
order is hence incorrect and here is an attempt to fix it.

Reported-by: Pavel <pavel2000@ngs.ru>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/cpu-freq/cpufreq-stats.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/cpu-freq/cpufreq-stats.txt b/Documentation/cpu-freq/cpufreq-stats.txt
index a873855c811d..14378cecb172 100644
--- a/Documentation/cpu-freq/cpufreq-stats.txt
+++ b/Documentation/cpu-freq/cpufreq-stats.txt
@@ -86,9 +86,11 @@ transitions.
 This will give a fine grained information about all the CPU frequency
 transitions. The cat output here is a two dimensional matrix, where an entry
 <i,j> (row i, column j) represents the count of number of transitions from 
-Freq_i to Freq_j. Freq_i is in descending order with increasing rows and 
-Freq_j is in descending order with increasing columns. The output here also 
-contains the actual freq values for each row and column for better readability.
+Freq_i to Freq_j. Freq_i rows and Freq_j columns follow the sorting order in
+which the driver has provided the frequency table initially to the cpufreq core
+and so can be sorted (ascending or descending) or unsorted.  The output here
+also contains the actual freq values for each row and column for better
+readability.
 
 If the transition table is bigger than PAGE_SIZE, reading this will
 return an -EFBIG error.
-- 
2.19.1.568.g152ad8e3369a

