Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsOjNSw8yNoZCN2D1+9Mz/5GJYQtl/DGWHvjkWvrDbRsHDIT8NjpQ74BMtNKZtJb9bh/5vr
ARC-Seal: i=1; a=rsa-sha256; t=1520641220; cv=none;
        d=google.com; s=arc-20160816;
        b=cGvPCJfMHiPV5Lm6bzVbq+fAINVIVMmth57EEGszMZVEuqINngjaapu+RnMZpe5yjl
         68jQrKPmr4dTsGa/tBc/3QDFPU4rSeHlZ2c64m0glaGaLbNdEUqNYDlXm/3mG4OyuY37
         KKGIDLGsvX5ijtR1TzD1sxlXEI5PAKNboiQNL9SVk+ZWlOmGDVNrMc+oaTd3CEorpwgE
         /xLOfxiW//RujL/5uGhLQJcCRqCRB2iI+73S10gp+OQpetPCdKfr4w1Co/6Lrpadpi+X
         7+n4Fw7wtiqGEJWq8KyrGenTnyjuu2I+qI81S2ywuECUnJbSwXyKnTw+eYrWlDfwIWEv
         zsOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=D3XyiAOKJBKBBZeBb8KNfuRzWgfJySYGMMDdm5/dUiM=;
        b=goOLsUFE2OVmIcMsQ2LobTP7HUoh58fwnGsKCZXxqHkRVOGAFj+xBAAblbODfukunF
         Q0eZkj4vsnHBFIESfMv50kOdQ/2XGe8+GxrAklVr5getDPex+kJngNcc8LthqaKkNJ2B
         Jb3yWqgmXLlD8H4KPu1wR5PzJMSAdkHgpoDY2Z/fZ4cM4eKDzfQW8cAXlOluBJWUAL5P
         bFpF5nxubL8cnc/pee4xpgXxLYMADCqcEOCaJzWg5updVKON5xYWeROfhjFvrpNkJTqp
         RUO24Y3qJf6r712HcRbaPOlXU0nsF+YekwzShGAeYX+hI0dgfkDcrspWUGVmwFjTonwy
         9t2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.4 06/36] cpufreq: s3c24xx: Fix broken s3c_cpufreq_init()
Date: Fri,  9 Mar 2018 16:18:22 -0800
Message-Id: <20180310001807.545539995@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507806873576777?=
X-GMAIL-MSGID: =?utf-8?q?1594507888435920142?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 0373ca74831b0f93cd4cdbf7ad3aec3c33a479a5 upstream.

commit a307a1e6bc0d "cpufreq: s3c: use cpufreq_generic_init()"
accidentally broke cpufreq on s3c2410 and s3c2412.

These two platforms don't have a CPU frequency table and used to skip
calling cpufreq_table_validate_and_show() for them.  But with the
above commit, we started calling it unconditionally and that will
eventually fail as the frequency table pointer is NULL.

Fix this by calling cpufreq_table_validate_and_show() conditionally
again.

Fixes: a307a1e6bc0d "cpufreq: s3c: use cpufreq_generic_init()"
Cc: 3.13+ <stable@vger.kernel.org> # v3.13+
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/s3c24xx-cpufreq.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -364,7 +364,13 @@ struct clk *s3c_cpufreq_clk_get(struct d
 static int s3c_cpufreq_init(struct cpufreq_policy *policy)
 {
 	policy->clk = clk_arm;
-	return cpufreq_generic_init(policy, ftab, cpu_cur.info->latency);
+
+	policy->cpuinfo.transition_latency = cpu_cur.info->latency;
+
+	if (ftab)
+		return cpufreq_table_validate_and_show(policy, ftab);
+
+	return 0;
 }
 
 static int __init s3c_cpufreq_initclks(void)
