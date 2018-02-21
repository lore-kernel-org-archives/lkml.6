Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227iVVI8yom7hG8Vs4Zfv8kM0Xl4yLCowyJhyj0l6U59SP+/Gh9cplA99Zh2nan0Nj/wAA5E
ARC-Seal: i=1; a=rsa-sha256; t=1519218072; cv=none;
        d=google.com; s=arc-20160816;
        b=p+sr1O5SyPYNWDSih7o5/GlpRkcI+oa27a93dotk7B/IzN2jFcJAINEIJmR6zBUG6R
         tdr49uGgyuj6DhWisp9hhcvxhCt/cJ30Ibuwx5h4X0HAc42aSYRXEOHwywAPE3d8f7qM
         IRqcY5iMpAQTkpGWF4WLBB3Agc00Qo4Y9kauMwBPm9/K3XIUNIf9vTrDtHWqsLC0iTmB
         xVasi/tbe7V7qxM0E9FyqGP1EtWH/RWNl4rnKsfZCDIzkEMgNZMmZxuX0utHQ1pGdvfc
         LF2MjB1FFpbwpggR0U18CbSSXAtgmPL4TsjUaZ4zlXwWvgCm5Ot0+pN9CASXVzbgI+te
         pQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WTNs2sNbpQK9IHMyCiE5kKAEeglJx4Jh5+TlDVeyf0E=;
        b=uVC1gBsCh6zaoL3v+cdbCQLPrmzZySuPhLfS9WJdRTI5JsiXmjaspn+b/HTqTXpyMe
         VPnOur7LHamL/2EDJjJyFm3V9rGBKe+36dKf4VKmtackrxYs3kR31aVjGtxagbAHdOV/
         AzTvUqhx0aMcnpquae28+GkNTC30buVa8MZelCJUpxhmrU/L9auiC0Mc6y/HbaACjE+2
         pjNisJSHnU375rzvl0C0s5CsI5QbKIAPGcwi1C/ZNu9O/NvTBY6yu1hnQvvDo+8ll9La
         KIF3qmvyhP6Tp1F0DWBNIlfWkrAqkDUow+JVM0CUjE8aytKEVDjZCF1gH5ET7sDqFjUI
         RO4g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 039/167] x86: PM: Make APM idle driver initialize polling state
Date: Wed, 21 Feb 2018 13:47:30 +0100
Message-Id: <20180221124526.733831265@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015610134726356?=
X-GMAIL-MSGID: =?utf-8?q?1593015610134726356?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit f859422075165e32c00c8d75d63f300015cc07ae upstream.

Update the APM driver overlooked by commit 1b39e3f813b4 (cpuidle: Make
drivers initialize polling state) to initialize the polling state like
the other cpuidle drivers modified by that commit to prevent cpuidle
from crashing.

Fixes: 1b39e3f813b4 (cpuidle: Make drivers initialize polling state)
Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Tested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: 4.14+ <stable@vger.kernel.org> # 4.14+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/apm_32.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -2389,6 +2389,7 @@ static int __init apm_init(void)
 	if (HZ != 100)
 		idle_period = (idle_period * HZ) / 100;
 	if (idle_threshold < 100) {
+		cpuidle_poll_state_init(&apm_idle_driver);
 		if (!cpuidle_register_driver(&apm_idle_driver))
 			if (cpuidle_register_device(&apm_cpuidle_device))
 				cpuidle_unregister_driver(&apm_idle_driver);
