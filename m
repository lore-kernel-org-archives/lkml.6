Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/UIJGOU/iIvrvusizrsBHQcRF1BnfcJMzjP3cNR2PeiDemYGbbDVQHMhyoJKqsxqWUfbuX
ARC-Seal: i=1; a=rsa-sha256; t=1523021528; cv=none;
        d=google.com; s=arc-20160816;
        b=rhL0Pkeq7zKu2k8rhWtRK1mfjtxw6t829+Kj//btJ0N7x18V2rhat3htHSwP3ncdwH
         A2OFQZl7+XOsVf9PPYr014lqti7tLwwmi2npYFOyziAVki2EZbxkTOViLS21Hysy59oO
         YfreCtISRoGND3xyr2F94NEiB3yPRSXRmlLlgR3rnKdY9IF8rwRTTNzFDXyuuxFD2xtN
         5Z0GS7iL6Q2EfrkJK9AkT10zehHvfnLfHZlajXbwsnKVvgla3X2Q2Hqo6Umsc1E7JJ+S
         fO1pDcHiY1SsW4aXabzuPiCJ5ojlFYCf7kxaZEpX9ASiwGbDe564SZcBNqKfCcadf/W6
         0nXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WadymtlzgWs1wJqcvukbPaxGce6BRGmxRO05l21V5Ag=;
        b=FeSuG7+/xeinNKV5YHaGE+ffUD72ul5cUaIudkqUOLSMfIUlKLM3WqIUggsjoTrdkO
         j0srs9OdYKDtGZnybuFN2OffgYKVZ3a8Zzrt8O7bSdVqeOthr1xSm1ZJjxWbsc+FPyz6
         S2ooWRA409ojNZwFUuU8+IfN/1J6JSUIQfHB8275T/ingmjqvXMSsd8ovgg5GDtB1Oak
         df/QqGGq9/TkPHuOn2mvAealrDqqttsl+lE5lnDOm5Wu4H3c+meRcBgstOKohGfYCHtw
         h27CEOQgh86BfQIeMwz9sNmL7lp63BWEwTMeooBWR6KsRUQiH02sbrVycA2sWoOMGTkq
         19WA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 68/72] Revert "cpufreq: Fix governor module removal race"
Date: Fri,  6 Apr 2018 15:24:09 +0200
Message-Id: <20180406084311.302591634@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003822271079165?=
X-GMAIL-MSGID: =?utf-8?q?1597003822271079165?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 3f7dfb7fcf98a7e73dee018c4a68537ce7fec646 which was
commit a8b149d32b663c1a4105273295184b78f53d33cf upstream.

The backport was not correct, so just drop it entirely.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/cpufreq.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -551,8 +551,6 @@ static int cpufreq_parse_governor(char *
 			*governor = t;
 			err = 0;
 		}
-		if (t && !try_module_get(t->owner))
-			t = NULL;
 
 		mutex_unlock(&cpufreq_governor_mutex);
 	}
@@ -671,10 +669,6 @@ static ssize_t store_scaling_governor(st
 		return -EINVAL;
 
 	ret = cpufreq_set_policy(policy, &new_policy);
-
-	if (new_policy.governor)
-		module_put(new_policy.governor->owner);
-
 	return ret ? ret : count;
 }
 
