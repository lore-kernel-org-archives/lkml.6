Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELstU8bcPohmBk6Mtie9tx2wcWUOFJj4VP60KEDE/Ziy7m41+7OgAPnsSZw8X2ebEHhAcBAq
ARC-Seal: i=1; a=rsa-sha256; t=1520451915; cv=none;
        d=google.com; s=arc-20160816;
        b=ZS7geWb2g7iza+wT+stUMD4+rR1MlkDeYxWQ9b9mw8ex4PD81hhClr8n4f+MlIa/Sv
         0xVSWpwijKeQxxSW1hZp+zg2//pon7jYefooZGlSTjq8qwiD1EjVA5W7nJS7ut8L8HW8
         wrbXQe/ZQaBVirv4/Q1/7vnQJBQwAITM2mIkX0r/Zx3M3z0JEouIufLbEsR970vVsq0n
         9G6yJHgCIlTJOS/B4MrinsUvAXMKAtLgeM5eMREEaeIlAMrpYpKJSxeg9wis+qJhhczB
         fOrzoHYa4XV/G7u4MLTnK5minVLZSUHi+T3M/M37eXdwz+zQPM71LMFsbjkbbkBK9OSQ
         +HGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BySxhBICl1y8gmW8BQrfUh3wzHC/P69yEmTtEdg16rc=;
        b=hAdQ2Y6v1SKGieVDVV32yTKD309pbDr4/LJ8i6Z/eMeP6T2xqTjJFb1urKrM7vBN6e
         YTQwBUM9R1ZT7KylOrk09EtY6nmIm/1ZlprDTC6UFEIMm2cA+P7HoB61znFHJ1Ki4mVb
         FUmpfm/syl9HUkUk3B8xGda+tMMrrkpW8y4t/EkuhLGDOJJU9qJkeRJF0ZEsYHxtyZkU
         tGKxq+HNJK8nqp6Lcc6l0wEHoUf2BDzULiaSmZBWIETEqxT5PjSqyaUTUSt8D54KmEjJ
         0bxWo3P5JCrlfxyawks2Jf7vMtPNMIBjJXyV3U8vRvqlELX4RNKSW9yw7sZcJzkTlrJG
         9WaA==
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
Subject: [PATCH 4.14 028/110] cpufreq: s3c24xx: Fix broken s3c_cpufreq_init()
Date: Wed,  7 Mar 2018 11:38:11 -0800
Message-Id: <20180307191043.342127421@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309141082260799?=
X-GMAIL-MSGID: =?utf-8?q?1594309387716321610?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
