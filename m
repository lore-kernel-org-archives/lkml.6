Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELulWnC1RElljVH+yLa1UEiC8PecUezmJ5b2S3mA4aS9SIT2L2y18GepBOkphYfuof2Q/HNd
ARC-Seal: i=1; a=rsa-sha256; t=1520451680; cv=none;
        d=google.com; s=arc-20160816;
        b=VBsYhIQcLRuek8YbXALxW+rz9ZzZR4d+K9uW39nYQ1kCMZLLwEP2GI2hRFzavK6wX+
         qoEM6T3X4zXMI2pv3FCrFRrjYcUkK/n2ugyL7V7qHOzblxN+Q02i19XKgm8i+3palJgG
         XgAlGoG/UWtdkvboufk0Iv2moRMrx/cTBwzMWSv9w2ICzgEF8f3Od6e4igq7v+dnBZis
         cw2hiNAZXYasXrzYmGg14XUbe//RfpEut3RWQX3J66WPx86yQnUYdVEUY9Ahf3nralWF
         y0IC3jN2w9H7dgV3DUaV2i6sg93/tu8xfFlGdgLoR5Ml5N8u6oz/Wc85QWTIUCxb2T/Q
         gPOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CXaV149gnGzeMVLrLv6osJAtFA6skdVpgLgbg6489uA=;
        b=NURSbHQlLjjSQ3F3Wl9euwBYDAMVegkBaLEHk/YKgM/OI7IUtSLIZzXDoVob5D6AtQ
         tNjv70pnvru+tQWvi8JjGU7kAhbLHzqHQhwrMLI0UNvDbTJYv0UtLZQYH3P0XBVjCNxC
         KNyaRp4LXjwdEhXFVCjjNtiCDHvjhUiaqsTb9yOIbb0Pe9iaMy6l6wGtwPpVbmpBraqj
         R87xIi3+EAmM/vPGba2wazQDbOZpDvRtRHdUqIFxxlibp8gHxqqi9uYMHXjoEf5eks2k
         xwqURfUQkpilNDIamwUo/PI6ilkiZCxnkR0Arb1N/P+/J6BQwVE3sFNFveHKnaAY6vL1
         hYjw==
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
Subject: [PATCH 4.15 033/122] cpufreq: s3c24xx: Fix broken s3c_cpufreq_init()
Date: Wed,  7 Mar 2018 11:37:25 -0800
Message-Id: <20180307191733.984904057@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309141082260799?=
X-GMAIL-MSGID: =?utf-8?q?1594309141082260799?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -351,7 +351,13 @@ struct clk *s3c_cpufreq_clk_get(struct d
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
