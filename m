Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZphzkqgIKWB2uBys6zhMB63cnKNqzHtXTnbIQM/OQ/xC5R2VOrR93nCOuEJ6rIDgKknra4t
ARC-Seal: i=1; a=rsa-sha256; t=1526281012; cv=none;
        d=google.com; s=arc-20160816;
        b=l6wBRvC/nVTuIbF8Zl0NxUB9UDNN6v1AUyF80STi4ByCY0eJmZiqIzYigOBHFZDIfy
         e8JwP7iEqoBaRBQP7C2OZJ1OcAgWpbKLxSYfoKZr/NQCYIHgdg0N5BPOc0JRsL5Z+2sE
         xOCDX7xI05UyEEXXRB/J59uN/MhIFWFLO7ZgdUFXElXkmBp6XZtPrmVeYXJol1qaApPy
         8SzQloB/RiV79Yo17okMtNGgcakKjjaPZ/Z402k2MjPEjgsCoVDa69ZJb8IlmDzoR1mU
         HEEdjUEPg/BFllihQmyCsPBQS8bi+vsaX/PqLaWk4uGUt/yNMCojE7l+1IFWtvxuOXSH
         YMJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=mtLK/uzbjGAY4DSgZ47jBUfGajxtLD0dFRaIB3HEiD8=;
        b=ft47CVc1e6he0Dw4rBt8gftfZZdqCoBkpKoEQaj2ZCTIqtuHN5xFXKvregV1776H7u
         WGMhIWq4nbRv147kj0a/mxZxJeLCzlMqF+3l8G+54JsxcnISZE9sXofRHC9TcCE2UJQR
         Fkmmkuc2FZKCGqJV2GO102vlsRajgQrHLAlZxHvmSXqlZmWzcNGPhfFyE9ZHTD6ESE/a
         DVVsTPoQn6Z1zTIwxY3WAxF06xgjVwGkDg5wsqU8Jr/+/HKmAtM8PIlDb/SHVlJkU6N5
         QNP1jrO7GTONGUfCBHYn9AlWKU/VTdsp8p+6CB2hmQzmAkikubQM+VaLaPlNSH1NStjn
         IqZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=G6lzGSio;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=G6lzGSio;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 46/62] cpufreq: schedutil: Avoid using invalid next_freq
Date: Mon, 14 May 2018 08:49:02 +0200
Message-Id: <20180514064819.067486089@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421638744745486?=
X-GMAIL-MSGID: =?utf-8?q?1600421638744745486?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 97739501f207efe33145b918817f305b822987f8 upstream.

If the next_freq field of struct sugov_policy is set to UINT_MAX,
it shouldn't be used for updating the CPU frequency (this is a
special "invalid" value), but after commit b7eaf1aab9f8 (cpufreq:
schedutil: Avoid reducing frequency of busy CPUs prematurely) it
may be passed as the new frequency to sugov_update_commit() in
sugov_update_single().

Fix that by adding an extra check for the special UINT_MAX value
of next_freq to sugov_update_single().

Fixes: b7eaf1aab9f8 (cpufreq: schedutil: Avoid reducing frequency of busy CPUs prematurely)
Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: 4.12+ <stable@vger.kernel.org> # 4.12+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/cpufreq_schedutil.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -282,7 +282,8 @@ static void sugov_update_single(struct u
 		 * Do not reduce the frequency if the CPU has not been idle
 		 * recently, as the reduction is likely to be premature then.
 		 */
-		if (busy && next_f < sg_policy->next_freq) {
+		if (busy && next_f < sg_policy->next_freq &&
+		    sg_policy->next_freq != UINT_MAX) {
 			next_f = sg_policy->next_freq;
 
 			/* Reset cached freq as next_freq has changed */
