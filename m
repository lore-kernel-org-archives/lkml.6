Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtPttEUnauQK1omamhd2BkH14pOsT2CWrvzaOZeKeDXZ6emK0IrgJn/OfIW7Dfw671o94q5
ARC-Seal: i=1; a=rsa-sha256; t=1521483352; cv=none;
        d=google.com; s=arc-20160816;
        b=xtz9gixOf93JD/po/tlskyHef54Vu9UZojQXg7TmgHwz2cnhcv5xRE98/gcfn8tizi
         oE5+4qrXmUca14VOwnmE+ZfAyRKFiBEPcUtgYQ5IBz8DEEBoNBDQG47XkMir12EpNJ32
         TrPBYtwhw0HbSmezI6wG6JiRdjK3r9fVBuUs+iLcpE++P4k2yMrj7HYRg0DDJ4qqIwQE
         KSzbHE0gfabUeiunVF1EVWunb/34wHNdSFFW62yx1rH/RgqWJZ7jvhz1NR3qj+4odzsw
         2hoTZrVI1EJZ1Ba2tL/5AsVSANcOaI2/asVXJpK/8iB7ZcnO4YnJ57Vnz1MVpAkGLByf
         exHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Y/xC9kEXQHVHh5DpR4pUf69y6tTR958p2Xgsfq1JU1o=;
        b=Svq0gN/g3RLxrI3nbFTfLytnbyjLa61UTJNsc/9yssGU/ChDLQeoevNYdvetlLl5CL
         x7AfVXDeBqXtvkS9o9wA6oiYikgA4Jod9vw9/033veFthMQp16S70V4KH1VYdUanOjL8
         EnACYF5JSTebba5tOTBqrrmzqTJXIHEIDP8KxJnqdolmFwuHH7Kxb4k05QKVWPV88QlR
         556DDexq7yqYTYN/n/h5nWvS640b8+B0JKNi96/CeY4bB/GBTXwvEP5i2ZMFMGMrGzeV
         1AIEIjCEnsWw1GUhS3c+y+3DYVFiciL+YlEYrs6HatH/LtsdHY6n+S6MQfgEYtzxF7Xv
         6L9g==
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
Subject: [PATCH 4.4 092/134] cpufreq: Fix governor module removal race
Date: Mon, 19 Mar 2018 19:06:15 +0100
Message-Id: <20180319171902.578082436@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390927744329142?=
X-GMAIL-MSGID: =?utf-8?q?1595390927744329142?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -551,6 +551,8 @@ static int cpufreq_parse_governor(char *
 			*governor = t;
 			err = 0;
 		}
+		if (t && !try_module_get(t->owner))
+			t = NULL;
 
 		mutex_unlock(&cpufreq_governor_mutex);
 	}
@@ -669,6 +671,10 @@ static ssize_t store_scaling_governor(st
 		return -EINVAL;
 
 	ret = cpufreq_set_policy(policy, &new_policy);
+
+	if (new_policy.governor)
+		module_put(new_policy.governor->owner);
+
 	return ret ? ret : count;
 }
 
