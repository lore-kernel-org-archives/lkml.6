Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtghbk8Hw3ha80hsKoQS9Chhyz4oT5FcT4JzmSHJZ45k6jfGaeEo26u1scYtKgrvLhRHwyc
ARC-Seal: i=1; a=rsa-sha256; t=1521215082; cv=none;
        d=google.com; s=arc-20160816;
        b=WLAS075B5WKy0oKXsXbGLMB/kDtwkEcT4cBi3EwTjMKXI3Y614/l8JQiPyBnum/yfE
         OmhrST+DMWrqT6Y0ouVkgHSZynTIPc8Xp+QSXAe5mBZw5d53YbTilwTGNCU2ooJSvBOk
         8Pl7dR842TKOr1Fy4JJgBni60b+MJWnEB+1VwgrMc80AwNeRR+37l0hxgMmM7a/5w9tp
         YNs2LwOsi99ZcM3G/oTfc43xjKTZy+UKpmc5dH/xZUjtHZmu8P5+TqD8YtqLRDcDWzzL
         TC5a+GC0NRfDljD4pB9OOMs+u/k+IttL9kfWXt/BG27lJD9MHs2kQXNqvYCyIXq+6dw5
         J3+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=krizd8V4gWSxAhx4q0OGrizbtycx97prRk3N6E99zIQ=;
        b=jOSKScGKT5oijFBzqQ3W6aPxZTcrfCg0CgmOI51ObfXucGoTkObW2DCTYqBsGq8/SE
         cSYeCB3IKg3oM2u3RR/c1mI7jHYllJAWraGE19MjNx8phDsSjAlO6mz7fS1Mo4pXyYl6
         H1vqRKtY5as7H9D1BhSsKCEWNQGb5mgsc5R50kEXVVJZUDJtPQnIxnZEskpEB0JROWyt
         +d58KmU9iI705RFWMXbhfdL2DccNb+aFzjXyjWA1rrak0RMZbZvnUxJ6KIOSe4UFWFK+
         GHNeR5K03ihM958FM+6haa57I96d1gXu8VpPXL0jnpkDmMOrTRS2UIdZqksIbRpXrdys
         /kNA==
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
Subject: [PATCH 4.15 076/128] cpufreq: Fix governor module removal race
Date: Fri, 16 Mar 2018 16:23:37 +0100
Message-Id: <20180316152340.471679903@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109259104693147?=
X-GMAIL-MSGID: =?utf-8?q?1595109626470997005?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -637,6 +637,8 @@ static int cpufreq_parse_governor(char *
 			*governor = t;
 			err = 0;
 		}
+		if (t && !try_module_get(t->owner))
+			t = NULL;
 
 		mutex_unlock(&cpufreq_governor_mutex);
 	}
@@ -765,6 +767,10 @@ static ssize_t store_scaling_governor(st
 		return -EINVAL;
 
 	ret = cpufreq_set_policy(policy, &new_policy);
+
+	if (new_policy.governor)
+		module_put(new_policy.governor->owner);
+
 	return ret ? ret : count;
 }
 
