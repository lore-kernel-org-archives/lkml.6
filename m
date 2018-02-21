Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225cJj79utkjt0ApsF/Q4BjOpINRcxeAdD6SfQy7HnLl1hlPA3hH3SIOHnjUD4bljyXjRITB
ARC-Seal: i=1; a=rsa-sha256; t=1519217889; cv=none;
        d=google.com; s=arc-20160816;
        b=lVWR3F5LlB9Ru5VrMLDgQlBFFMmfWE7NFqy3SJbuITuBndu7wzelwx0CVR9jEg+e26
         +CP16BTr4hTd2e9QMICrMTr5Ru4uVl/c7SpftNqhnc8nH58PJwAWt0pNoa3W55qPnINj
         w4Ujr5WsizNElH/lz9vh2b/JEZdpeB9ChzzX+I8jjN0DGP6efg2hLVAEu+YvawPlcxHX
         XGGIxxq9G0wo38BiRTErMDcAEqt0Vp2+QNk0Pkmh3XHHdl7nn3mdPQ5gRRXB3zhm/fp7
         wVXPRMMALOkJ6qpGc3AHGHkkxn/oZOZN4ba77sWdreemf6lj5IyxOrJujkbXMljt+GzW
         sfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k8ESBR9WPVcqm8BbzUZUdzbqjNw5cK72eM9hEP2ZViI=;
        b=VqyqWHl9cnbgVIm1N05VRMJd4PwZ7B9t7q2kznLYSuVlagmIWgTzGX7RP8L6wTC+bM
         h7gtFW7o5qryGgG4i5HEh3UwJQB9mCwMy8sjkz627GWThcdeJQC+r2IPuF/I45rDLLrY
         qzgvbCBwixZOUy8sdgPETVU8NVaeqsTIt5f/EJbtOKk5PQzTZcti461b23ZRjpHVAKdI
         OfaytcwKePaFCwp96lrUI6vWCRjIBJ6bHovwsmhP7sAx5ejfqWrcLu6+jlNEDqbKKqk7
         t3W25s8EvHrgmUBuh/VViGu7n4a+h7PQaODBunmLsKzSO4CJIrvGW8m4adscSCnIa4kY
         Pm4w==
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
Subject: [PATCH 4.14 014/167] cpufreq: powernv: Dont assume distinct pstate values for nominal and pmin
Date: Wed, 21 Feb 2018 13:47:05 +0100
Message-Id: <20180221124525.390995429@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015268788550839?=
X-GMAIL-MSGID: =?utf-8?q?1593015417455926297?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -287,9 +287,9 @@ next:
 
 		if (id == pstate_max)
 			powernv_pstate_info.max = i;
-		else if (id == pstate_nominal)
+		if (id == pstate_nominal)
 			powernv_pstate_info.nominal = i;
-		else if (id == pstate_min)
+		if (id == pstate_min)
 			powernv_pstate_info.min = i;
 
 		if (powernv_pstate_info.wof_enabled && id == pstate_turbo) {
