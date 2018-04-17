Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Eo+FOlM5ZUIeJ3J5DhwCdkpo9OcGT4DF1qv1MNvZAoPNSp/a7lyPc90iceg6AWa2Reec+
ARC-Seal: i=1; a=rsa-sha256; t=1523981316; cv=none;
        d=google.com; s=arc-20160816;
        b=OL9GOycYxtsn8uM6OpN9pi7EcHvZt8MTzyW31r7BySepBbw3otUX6yqq1gfT3xuo7U
         052+M1dAQV94LY6EXbpR+GhrEdWn91U/ghgdFotXLtO8kO3S2EG60+wEKBIUJxwNrnVt
         N0jU4HZpOlBV8ffAbJW/tuMtdE/eXVpFVtYV6WoeIFxJUAQ0IkN34W0yW5uSZlnxfhUU
         B2JhpsjpEK2qYVxfZBVgItXeiLFf5cjlk4BkI8fBPBxWilaB8q9pU2kebPxgBUWxNniJ
         1FM2whXS+QWPvJBij89Rr6VP8qysl+CLQdvrMBPyNtUL9JsrIMljnckG6x6PPxeGNIKP
         FWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CCT+Nym4+qNTeS9bPdvhuesU+KvOx6nEVl38fOmR/18=;
        b=L4MLxHpzk6miKlTmyhq29bp7YR72vjqk5Chy3ujbLlPYqTqdBf8GXoP9p19LmsLvm8
         ytGprhs6E5yFTMtLTfmSeqizwZDewTIl8L7QWxnqdzHb8x4hzPWHVOVT3W9geoJ1CSp0
         ldcpd8lK88DOo89O/wvC9xoZQFt+MPCU6FIHz/lRK6mXJ1Sc5ISu8zY2TgPJ1efgSHu+
         elqB8e3LLZEhjcxVStmXaKDf/vQKvLkw9A/NEjnc5l/Xn4XOGagJLyIjnnn/k8Cx6n/5
         svgAeQxYZuLcQvpnXnMZgmOZGD6CH1oMjz8pXex2wWkEfpu5AOnOR8bC30JEpP9pnrFF
         7Ekg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Dave Martin <dave.martin@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>
Subject: [PATCH 4.9 20/66] arm64: Run enable method for errata work arounds on late CPUs
Date: Tue, 17 Apr 2018 17:58:53 +0200
Message-Id: <20180417155646.726727900@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010233493316618?=
X-GMAIL-MSGID: =?utf-8?q?1598010233493316618?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Suzuki K Poulose <suzuki.poulose@arm.com>

commit 55b35d070c2534dfb714b883f3c3ae05d02032da upstream.

When a CPU is brought up after we have finalised the system
wide capabilities (i.e, features and errata), we make sure the
new CPU doesn't need a new errata work around which has not been
detected already. However we don't run enable() method on the new
CPU for the errata work arounds already detected. This could
cause the new CPU running without potential work arounds.
It is upto the "enable()" method to decide if this CPU should
do something about the errata.

Fixes: commit 6a6efbb45b7d95c84 ("arm64: Verify CPU errata work arounds on hotplugged CPU")
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpu_errata.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -143,15 +143,18 @@ void verify_local_cpu_errata_workarounds
 {
 	const struct arm64_cpu_capabilities *caps = arm64_errata;
 
-	for (; caps->matches; caps++)
-		if (!cpus_have_cap(caps->capability) &&
-			caps->matches(caps, SCOPE_LOCAL_CPU)) {
+	for (; caps->matches; caps++) {
+		if (cpus_have_cap(caps->capability)) {
+			if (caps->enable)
+				caps->enable((void *)caps);
+		} else if (caps->matches(caps, SCOPE_LOCAL_CPU)) {
 			pr_crit("CPU%d: Requires work around for %s, not detected"
 					" at boot time\n",
 				smp_processor_id(),
 				caps->desc ? : "an erratum");
 			cpu_die_early();
 		}
+	}
 }
 
 void update_cpu_errata_workarounds(void)
