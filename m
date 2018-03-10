Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsPDY7dfG0PBMdCDqqifVZLaOeYduBgdauggIrUatUmxaiXvX+iHobRT3FrMeSuBV9UozJN
ARC-Seal: i=1; a=rsa-sha256; t=1520641266; cv=none;
        d=google.com; s=arc-20160816;
        b=YzMKQXWcfvuKwA5N0TxE3hbPrA7goN/lxGU5eD6i9w5rC7myTgIL7twIz8eA9ATWFJ
         0OVFjIMNJhSHPQVXzXdPkpforzkQg8P0rT/sYx8hYMVHHJNH0VDV9prWyWQcWnEsSrTD
         vpSXdjfbao9/OfmubuzHQL4Yb1j8CICWqjc4aQPo3Fzz9/4S85ZNn7w08o+D3yT6fU1L
         HpiEgBOo4nT2WmvS9O4lQaHenJrOBa8C05KVsv7iDPiDVVOe4oRCt9yyI172VD+RlBdJ
         K52yPYYAnLS7healHSQ7G26TV+lAmvKLfreCYOJEzJQi45cnFiIAcT9ECa5HqYPo7pDd
         lP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5QhkUfOUl5E30eipyxkSbO8iXovxu8HNh3vlf86uIj4=;
        b=x97YFaqq0w48EDCwY/on5NkpJzEYioTA/2PskIV9s0SpeekXmFAtfttro+Vfprsh64
         sJ4SDzrye/pupNV9gxmLpcF5rrb7cj9cmoO7pXzN5eE3iYgHPr8r5IsJc9hxyAIgL2ay
         8JUOYrCsZyMAOWbdx4XPyHIIateiNvf3ohI4SUlsMoC27Lmp81OZUr7c/pkeDWieT0jx
         9zAqFJbfm0M9Wsfyaik7a+ZzZ3b0qr42K548J9VmdCyNvxRNuTNDAaKd6k3E1kzc4BHK
         wW85Wc0CFXcj1Mx4Li7CrwbDaI1oIZzmmxIQpqBc+n6mD+xGz9CcDtpJ/1F1jEZ8lGg0
         CjDQ==
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
Subject: [PATCH 4.9 13/65] cpufreq: s3c24xx: Fix broken s3c_cpufreq_init()
Date: Fri,  9 Mar 2018 16:18:13 -0800
Message-Id: <20180310001826.019666530@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507806873576777?=
X-GMAIL-MSGID: =?utf-8?q?1594507936066124368?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
