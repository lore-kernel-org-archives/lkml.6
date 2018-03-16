Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELufFpLy8gavHYEQLbT/YYbZLbXmywjtjL5DTRgNgON95yW5tNVSgwFOIkl30KrQjf1tunDo
ARC-Seal: i=1; a=rsa-sha256; t=1521214732; cv=none;
        d=google.com; s=arc-20160816;
        b=FCg2ZvBtEuUBmbhWXUJwAIQ99iyAsg7Iu+LhswhrzySLctV+guEfBeBHD/EbYZhGPU
         zO4JXCe8t2ycA6Ltap0q4yhx0h4F0vNwtOwOJ1LajnG21JMCkpddftWKHPJzvalbJOma
         xVUiv9yFaPsgxA3USeugMNyPe6xTiplxOAVOAD/8qNxdflTAyh8zcXVgFukvpdsZDcrp
         PvNz4pNcF8At3nUg/fNCLEq/QV941kp4dZELDisdrxtLUNjKRxkKdCne4E3BXAr9lkL9
         cys+7vS4wp5NlHeenTrgRkRuZE0D0v6Uz/c/bqM30HFgfSbU5fKXA8GhjMqTMTrOJ1rb
         +V5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=giqgu/iJXNB9c0cqQyuN6TESnxTmcALblVCwc8f5LxY=;
        b=i2R4mE0b4PhxgoSgMFHJ4NFx2L5OBEmYbHp5w+jZr2gsZNMRnMAujmkpkBAnUMBqxY
         bnKWW81zgsNXltSkSX/UCyx+ErCXzn6MKtT563GO4QPoQa1opqfCoPyUkHHEJRnYNCK4
         +Kth9rH6PqJkjMkK+wklyUItf5IuJNj2YVgGQnzPMQ+djnTpU1QnUvlyKhEvdf4f+qY6
         Tm9yahzO+47HRyjWcX9D1eV1nkRR8tKXUfaruKVpkyWTFbD/TaQlV0ZNoZ6QZu+91H5G
         WSZdO0QYcI3Yo9IyVnXe2H3BJmN3OMx+gdUK2ZyR6o/SusBzIfoe4ofuoTBrU02qMVTZ
         llSA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 063/109] cpufreq: Fix governor module removal race
Date: Fri, 16 Mar 2018 16:23:32 +0100
Message-Id: <20180316152333.395213939@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109259104693147?=
X-GMAIL-MSGID: =?utf-8?q?1595109259104693147?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>


[ Upstream commit a8b149d32b663c1a4105273295184b78f53d33cf ]

It is possible to remove a cpufreq governor module after
cpufreq_parse_governor() has returned success in
store_scaling_governor() and before cpufreq_set_policy()
acquires a reference to it, because the governor list is
not protected during that period and nothing prevents the
governor from being unregistered then.

Prevent that from happening by acquiring an extra reference
to the governor module temporarily in cpufreq_parse_governor(),
under cpufreq_governor_mutex, and dropping it in
store_scaling_governor(), when cpufreq_set_policy() returns.

Note that the second cpufreq_parse_governor() call site is fine,
because it only cares about the policy member of new_policy.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/cpufreq.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -631,6 +631,8 @@ static int cpufreq_parse_governor(char *
 			*governor = t;
 			err = 0;
 		}
+		if (t && !try_module_get(t->owner))
+			t = NULL;
 
 		mutex_unlock(&cpufreq_governor_mutex);
 	}
@@ -759,6 +761,10 @@ static ssize_t store_scaling_governor(st
 		return -EINVAL;
 
 	ret = cpufreq_set_policy(policy, &new_policy);
+
+	if (new_policy.governor)
+		module_put(new_policy.governor->owner);
+
 	return ret ? ret : count;
 }
 
