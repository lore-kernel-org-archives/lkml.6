Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225RajK+nOv46OeXRQHshcCbzDX6YncY72chNbLH89NlZhh8NvI7wmLHI4JC0bGBCJXOr6fY
ARC-Seal: i=1; a=rsa-sha256; t=1519217747; cv=none;
        d=google.com; s=arc-20160816;
        b=HtYcGtjZcUtxC2t6K5c1yLr9M7fmCkTQwOgHETWWxhJhC8W6Sp7pYQBZMvXlDC/l6X
         1hJENNlGGYrFqKWRTubQLrfao8ERhZz5lcw1dcpX2+SZPV9uNNg0G8BcmzLeiZ8pMKm0
         K6IRXSp6uqfn3jMN6OWIK2HKi8KdFpSr+TndCTnXMRs+HkS3jqBLMXhr4BS69RfHj5yP
         l6fDWi2adjNPif13HumoGPGKPvcGrVSnFeQSUsAuzmWybOAOt3x65IkCYPJYWK/I+HiF
         Zhoi83A2CZsQ0hbAt89ZAzk1pR+V95096pezLMWQsuCzn417kB1XP10Qd0ot0/1IByJS
         TIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QMQ+ZauoIdle+jyIcAGfK3dn1GHNkDnnwdm1WASeT+E=;
        b=cMei/rvzPsBx93W7Lw8tWIRiVpmzFbhmgKHlEgvTnZhb43SXraA3/9xCZsE6VbLVYL
         bHsMWVo/GhyS+03OglMHIvdey/Lf4VlM4yrNEdVARiqUzTA6EaSQCYCzjY781XKAxy01
         xqRVCA6cG1a8QhOgmYpJ06UGchRf02F1S+umpP+ASnYFB9iABhRijimXuZhR3D3U/2h4
         RR9PUJcKawX1bpo37DkarEQN+x8z4YWKCSUSAKkwJ2HrM7cihQOPMycyOrM89qftM4Bj
         lm82+7M4bXOZYpZLvAjm/fKz7zm3AXAVClPkaJmVSeqRxCMOym63dr6FDL5eToJe2Nwe
         E6UA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alvin Wang <wangat@tw.ibm.com>,
	Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.9 39/77] cpufreq: powernv: Dont assume distinct pstate values for nominal and pmin
Date: Wed, 21 Feb 2018 13:48:48 +0100
Message-Id: <20180221124433.818164950@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015268788550839?=
X-GMAIL-MSGID: =?utf-8?q?1593015268788550839?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

commit 3fa4680b860bf48b437d6a2c039789c4abe202ae upstream.

Some OpenPOWER boxes can have same pstate values for nominal and
pmin pstates. In these boxes the current code will not initialize
'powernv_pstate_info.min' variable and result in erroneous CPU
frequency reporting. This patch fixes this problem.

Fixes: 09ca4c9b5958 (cpufreq: powernv: Replacing pstate_id with frequency table index)
Reported-by: Alvin Wang <wangat@tw.ibm.com>
Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: 4.8+ <stable@vger.kernel.org> # 4.8+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/powernv-cpufreq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -260,9 +260,9 @@ static int init_powernv_pstates(void)
 
 		if (id == pstate_max)
 			powernv_pstate_info.max = i;
-		else if (id == pstate_nominal)
+		if (id == pstate_nominal)
 			powernv_pstate_info.nominal = i;
-		else if (id == pstate_min)
+		if (id == pstate_min)
 			powernv_pstate_info.min = i;
 	}
 
