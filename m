Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Qhu7bhbEKJbhWV6vcEKlz96MIl/5RwU1l6Nzhg2VeeWlQIlKp2byxkHZy4/NWYCEOQ1Sj
ARC-Seal: i=1; a=rsa-sha256; t=1524405285; cv=none;
        d=google.com; s=arc-20160816;
        b=w5JBRV3IHo70gh6OPZ7HMMEnWRqOPNVYvxet2HKl9i/1iwVonoN3WMGNV0S1raz0t1
         u44q3DRSYygN88cLShfdVml2X5yOn6COlCQgfIv10+LiBdxYE33U2wbXPWKqqyxw7FLc
         gPA13eY0nmKwObOZuSIEnWIiT9jZ6GcppH0XPudOdZiv1hlmPtDwCbs9N065ZHcYAiZg
         ZAHkl+CYhPQ6HjqhWGQM6LDqIK7VjOxo5pOC33KZc1OztAek0N02CI2et0qanvNCB3M2
         yldUxTW4sF5kg6AmoqFbkousIg0Zfy4b3uEZHLPxSr6UDqWwZf0vJtaqWnR09svKbepK
         KGCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mcThcBYR/LMwNXUE6eCqF6hrZ3u9NF/8yKlGdS/DRek=;
        b=CIvTs+Vt7XcRyKiD/rypiBDOob/a4eB6Tr0G7txn38RTzH+/jdu3yoh2SFndB4NNEF
         UeSzdN287BArEhryPgU3qffC5lKjucry1B7tAZmkQ+eGeuZIuJy1rXLwzhLXQsHZKF4c
         sZptgFYbN2yvtSmDj9lHezDwDbVHPAezL+j2bKgs2vuZeUbBeTEp9O6sTEiHJdFE4fKV
         Etc0v94051mG+fuxFN8s8ZMG0EDmVhZjhedfT2a0HXNSfc6KAEQjP7wa2JWoUOuSix9C
         CNtnrSTvCXtcDVhxJsCDSAvVyOoGmXUIWIHuYM4OUgEX4mcF226aQn0WUMyfR9fAGPgz
         OGkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.16 003/196] cpufreq: armada-37xx: Fix clock leak
Date: Sun, 22 Apr 2018 15:50:23 +0200
Message-Id: <20180422135104.416677467@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454796919280303?=
X-GMAIL-MSGID: =?utf-8?q?1598454796919280303?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gregory CLEMENT <gregory.clement@bootlin.com>

commit bbcc328561040292f7d6796954d478e4a2335e6f upstream.

There was no clk_put() balancing the clk_get(). This commit fixes it.

Fixes: 92ce45fb875d (cpufreq: Add DVFS support for Armada 37xx)
Cc: 4.16+ <stable@vger.kernel.org> # 4.16+
Reported-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/armada-37xx-cpufreq.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -202,6 +202,7 @@ static int __init armada37xx_cpufreq_dri
 	cur_frequency = clk_get_rate(clk);
 	if (!cur_frequency) {
 		dev_err(cpu_dev, "Failed to get clock rate for CPU\n");
+		clk_put(clk);
 		return -EINVAL;
 	}
 
@@ -210,6 +211,7 @@ static int __init armada37xx_cpufreq_dri
 		return -EINVAL;
 
 	armada37xx_cpufreq_dvfs_setup(nb_pm_base, clk, dvfs->divider);
+	clk_put(clk);
 
 	for (load_lvl = ARMADA_37XX_DVFS_LOAD_0; load_lvl < LOAD_LEVEL_NR;
 	     load_lvl++) {
