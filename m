Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48HqdGtOOTqTHPyGyZwrzyUGwJCHCAMfct2wOKEYAMFjrn7kpamQbstP5msBxoz2LoGabV/
ARC-Seal: i=1; a=rsa-sha256; t=1523021809; cv=none;
        d=google.com; s=arc-20160816;
        b=SAk0bgyuWfVDcchPelJ0vPYDRBzHUP3AWMHWG3+YC7M+A/A+sGRW3Npc1KfEgeoZar
         qYsXvpUQ9tzZt7WAWALhCnqVfRbh1kFOe5a5diXoR3e8cQaDS0CEFKVnYGEo/QAd6CAh
         mR6DB1BKLZAic6398nq+XSgbKvOPNbPPOYawhsYNdl7RIGXc8sZuc7aNIqUcCUZ5SfiG
         OQVb6Rlq+CtyuLtmcDIHsLtcTV+djdxGsM1ZRzw53lpQ4ZjUxukxLe7PXz+0lO1SR4Xg
         xBxmnam6fuzctw+EmmHRtUp/F9kfW4a/ImzQQELCUMuvkw8mG6IljQ9E0Uuib9IRYhml
         FY2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ykIfCMUvyfXK1gfuQSMHOhvX4IYpYsI2WELUKFZKTVk=;
        b=OtKpWpjK3lowucN0Lns6NwZmBWPS7YUuhLg2aTiQzNyYBsBbHAm/JbeEadpbg4xk6M
         bTtEg1OI1UmRFuazKpote1mnDOBNe3cYiNrpUQdLyMF2Vi8YB8SGDseOI0JpE4brZxsm
         ua9yCx0+jmfwxiNf/ryIF71PcrWXVOsbX1DCU/A8P+U4jjXupwt8yEKzKlkyQDDIvr+P
         a24mAda0AWVb7gY6CukL6b84FU2SMQbS07vz/xj/xdMOSxnF2vZpml4snZj5Ve1KSJqD
         24vEw6FawPURF4/JeR6d9ovSIqykkIQZYk67+IpB8L5muKuMQwtC6eElEkUJ3n+ly5G8
         itYg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Alex Shi <alex.shi@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 068/102] arm64: Allow checking of a CPU-local erratum
Date: Fri,  6 Apr 2018 15:23:49 +0200
Message-Id: <20180406084341.058538653@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004116470406440?=
X-GMAIL-MSGID: =?utf-8?q?1597004116470406440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit 8f4137588261d7504f4aa022dc9d1a1fd1940e8e upstream.

this_cpu_has_cap() only checks the feature array, and not the errata
one. In order to be able to check for a CPU-local erratum, allow it
to inspect the latter as well.

This is consistent with cpus_have_cap()'s behaviour, which includes
errata already.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org> [v4.9 backport]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpufeature.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1103,20 +1103,29 @@ static void __init setup_feature_capabil
  * Check if the current CPU has a given feature capability.
  * Should be called from non-preemptible context.
  */
-bool this_cpu_has_cap(unsigned int cap)
+static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
+			       unsigned int cap)
 {
 	const struct arm64_cpu_capabilities *caps;
 
 	if (WARN_ON(preemptible()))
 		return false;
 
-	for (caps = arm64_features; caps->desc; caps++)
+	for (caps = cap_array; caps->desc; caps++)
 		if (caps->capability == cap && caps->matches)
 			return caps->matches(caps, SCOPE_LOCAL_CPU);
 
 	return false;
 }
 
+extern const struct arm64_cpu_capabilities arm64_errata[];
+
+bool this_cpu_has_cap(unsigned int cap)
+{
+	return (__this_cpu_has_cap(arm64_features, cap) ||
+		__this_cpu_has_cap(arm64_errata, cap));
+}
+
 void __init setup_cpu_features(void)
 {
 	u32 cwg;
