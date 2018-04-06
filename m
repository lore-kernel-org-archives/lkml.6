Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/2c4ynoYWrCO82wk/znuXANxNPOViU1xwgR80ZhZEIS0chPcZTKFm3ZZzsQDgVQ/RKLAd7
ARC-Seal: i=1; a=rsa-sha256; t=1523022025; cv=none;
        d=google.com; s=arc-20160816;
        b=v6NAORExCj+3w2/YiVFJhyDcX2duvaT2FSm0eUkdcm3EsQb+LK7DqWaHZ7F3bhj7P1
         qlJAeCOmH7jA+pzg+++8kPTOi1WvOAQaKnNYCQOI+X5rtKy+cqCuXAOCM8tB2e89lCwe
         ixRZ1jmGuUaStywgr3h465dX6YfCbdGS0XNS5OHFZMFRd2Iz4b86lDPlmnFg12Lr3yHY
         fyfCVud2VWMovrtopv5lk7bRHKLdGTlfUkB8C1s9lXzh0/7R9PXGb42h9bK5lUHzj5pY
         GXpev6LTdTPyJyn9V+L0GgQDRPvllDzHMFCg5jYx0vr/iLUpbIl/O/SnS4gtVHW8fwWW
         /AhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2CNvXDI367Ke9O0XVDY7VGTWjDSP30W19g64zELI4DU=;
        b=Bok2TgOSORWkk6n8WIBHUNK+BwC4uo+thrHb7+z6r8T+TauryqVqCSAz/ZWjVvC1dn
         +fAlVfywADTEVZuq0nSVcvb28hEN1c+zrpf64Tu8k+MTm2/GgEM2+I2Y4jEWm2rDygqm
         KpS6big7n9d5jnSKWlbTApSRgWnPuG/g6hR7okOIGzaowELjKCpNupmW78uD2dMz/qFx
         x7UgLztelHvjA8wjVi4ifPS3mtFEjj9I9bOjMcNO7lPnuwqMarPo09v/XGogRl+UMlLS
         QBCUMQPHXOVYmAZTzEZR8CKNw77uGoHSsAP8u2WW9fiSTOneneI1mXt4XGGFgL5N0Lxh
         /m9A==
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
Subject: [PATCH 4.14 66/67] Revert "cpufreq: Fix governor module removal race"
Date: Fri,  6 Apr 2018 15:24:36 +0200
Message-Id: <20180406084348.875487593@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003822271079165?=
X-GMAIL-MSGID: =?utf-8?q?1597004344046797812?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 0049457bfde661cf47410eaacad65845c9a2bb45 which was
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
@@ -631,8 +631,6 @@ static int cpufreq_parse_governor(char *
 			*governor = t;
 			err = 0;
 		}
-		if (t && !try_module_get(t->owner))
-			t = NULL;
 
 		mutex_unlock(&cpufreq_governor_mutex);
 	}
@@ -761,10 +759,6 @@ static ssize_t store_scaling_governor(st
 		return -EINVAL;
 
 	ret = cpufreq_set_policy(policy, &new_policy);
-
-	if (new_policy.governor)
-		module_put(new_policy.governor->owner);
-
 	return ret ? ret : count;
 }
 
