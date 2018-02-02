Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2244vjROc1UArWqbzFTr60LdqsRmlDcw/THxcbnPtqudXPInlU5Jan8OhisRQHQFvkJ2pq3X
ARC-Seal: i=1; a=rsa-sha256; t=1517591102; cv=none;
        d=google.com; s=arc-20160816;
        b=GQoXwASXhPMkixtHwFV5Wh5+fktHhT5UOryQOHyctS931nzyelDUS84AuMisuN/HEf
         XZr4OnI6p7uZWJFvSZvMI35yYoZL9VIsQcZAAoHDJfo9OUugrOOf/tluwyCar+4bDYU3
         NhM6szCZFR/EVOWAh2RT+dWnYtK+TILjyTftTkb++YRUi6Ajg1Q94ZRFVDXMt5Ruqp9I
         DkGjhmg/V9P37ampCwsk25Eu4NpVD/TiaYMPqF3g07NaRh8kAvwsyyxwXNGb4FxIxB0/
         O6gb3uABjieW7mXLzTCkHGJUkeL8+PMNKpk9swcJpfeAu+6VWxYcaTsTeYg+15Jo4Uhv
         416g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qZN/Um9NxwKsdkD6mA6WV5Eik6GJX726rJSKGekJex8=;
        b=hdwSVptnE0qBRWRyq9oV075jdm15MwWvstaIOez0RHp6a/heTc95VSjxAsiVqxMQBN
         KjAS2Y5zpErxj8vI457zTM5qxjXQ4I0z4OkQZXlKleBR4NOXBDi73Jd7mZGMK8jwiAe+
         mEcUrdLrtlQS3so9G6RlIJTX1BEMEyHi4umgexXWna1SnZDGxgHiwb7F6GmW67k21f2S
         XmfPj4nC3aAcz/GH/DtxfSS2T4JZ6fouo77XF58SXR2jPChxcD8+gjYw/5AtHKrr/2RF
         dGaj8RQTHrv2avxW9BXj5hloK9/qGZI0H/fO1rOBMhaOsUoqQaHGZ5hREb0wEygPa1ll
         KL1g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Abhishek Goel <huntbag@linux.vnet.ibm.com>,
	Shuah Khan <shuahkh@osg.samsung.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 19/86] cpupower : Fix cpupower working when cpu0 is offline
Date: Fri,  2 Feb 2018 17:57:39 +0100
Message-Id: <20180202140824.536513876@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309607653259712?=
X-GMAIL-MSGID: =?utf-8?q?1591309607653259712?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abhishek Goel <huntbag@linux.vnet.ibm.com>


[ Upstream commit dbdc468f35ee827cab2753caa1c660bdb832243a ]

cpuidle_monitor used to assume that cpu0 is always online which is not
a valid assumption on POWER machines. This patch fixes this by getting
the cpu on which the current thread is running, instead of always using
cpu0 for monitoring which may not be online.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
@@ -130,15 +130,18 @@ static struct cpuidle_monitor *cpuidle_r
 {
 	int num;
 	char *tmp;
+	int this_cpu;
+
+	this_cpu = sched_getcpu();
 
 	/* Assume idle state count is the same for all CPUs */
-	cpuidle_sysfs_monitor.hw_states_num = cpuidle_state_count(0);
+	cpuidle_sysfs_monitor.hw_states_num = cpuidle_state_count(this_cpu);
 
 	if (cpuidle_sysfs_monitor.hw_states_num <= 0)
 		return NULL;
 
 	for (num = 0; num < cpuidle_sysfs_monitor.hw_states_num; num++) {
-		tmp = cpuidle_state_name(0, num);
+		tmp = cpuidle_state_name(this_cpu, num);
 		if (tmp == NULL)
 			continue;
 
@@ -146,7 +149,7 @@ static struct cpuidle_monitor *cpuidle_r
 		strncpy(cpuidle_cstates[num].name, tmp, CSTATE_NAME_LEN - 1);
 		free(tmp);
 
-		tmp = cpuidle_state_desc(0, num);
+		tmp = cpuidle_state_desc(this_cpu, num);
 		if (tmp == NULL)
 			continue;
 		strncpy(cpuidle_cstates[num].desc, tmp,	CSTATE_DESC_LEN - 1);
