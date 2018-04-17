Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+802FNBcJGGnk1fv7ZBp3xKgM5hmqF98NLTahbya+k7LAj4YA4BSGsdEZo6vIQ61dWHiEa
ARC-Seal: i=1; a=rsa-sha256; t=1523981310; cv=none;
        d=google.com; s=arc-20160816;
        b=hhzIyak5uH9VE6zwu3QbVjVzGG1MrlVctOIOj3decokwfQZCsovH9ctMGZQ+ET61BV
         4YPWgjRmMqkJ8K5C4gJ5og5JD3t7WckQmc0lSpXZYXfYXEpoFzk+9ApGbrG0jhZLHKYm
         2FToLK5Kz1EVChr3jJtyT+GAYBtoFBbqYvnOrugAGiNs+HHpIdo5ih9Y17rmL2gR0bwa
         Yqf/WdkbOulaKLLIzxJcJ5WK1CnS/lwxzJNx6C1JHgpjIZ6+1cozvc9lDp3mvyHc3ykq
         mg4K6ShjnPvvb3f6RZmwO3jb1QNYzSCl0nVU05+6xNu/ym5xYxhD7SklIDwMQTgAJ6m5
         pzMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1YMpjzGIBL7bFor4ij0UJvjPm8iCJaTEopJv542NfoU=;
        b=GSEf9BZgcrB9HFTmkmtrJ51T7Ja39z+asUdVI3xKsxDe3gxGiiwt1I9hP7Fg4ypc4o
         A5wHKwdDgQyE4/waVvfUw9RTD4CIUxWcW99Z6ZFoIm2sQWrwvJwJ4UbqUwKXW7PRCdH1
         WzYGbwMyYOCl0wefyAPXo3wCLSqAEvBgPa95W0U/qaVc8Se8epw2PhBQ5DUT1JOz7JDE
         TDG0gSxTZ0Dc1bjdvP67x4wptDgFaxfQg1kTOd8COT4F08nM+SrrlwHfH9zXjtyYdg6L
         +3HVCfhe9lwh0qBZ7PpQmMVCMC4IiQRKMSNcA9SChp5SY7IXje/7D76ftEkNPtytRAUe
         CfZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	James Morse <james.morse@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 19/66] arm64: cpufeature: __this_cpu_has_cap() shouldnt stop early
Date: Tue, 17 Apr 2018 17:58:52 +0200
Message-Id: <20180417155646.684452470@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010226619795635?=
X-GMAIL-MSGID: =?utf-8?q?1598010226619795635?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: James Morse <james.morse@arm.com>

commit edf298cfce47ab7279d03b5203ae2ef3a58e49db upstream.

this_cpu_has_cap() tests caps->desc not caps->matches, so it stops
walking the list when it finds a 'silent' feature, instead of
walking to the end of the list.

Prior to v4.6's 644c2ae198412 ("arm64: cpufeature: Test 'matches' pointer
to find the end of the list") we always tested desc to find the end of
a capability list. This was changed for dubious things like PAN_NOT_UAO.
v4.7's e3661b128e53e ("arm64: Allow a capability to be checked on
single CPU") added this_cpu_has_cap() using the old desc style test.

CC: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpufeature.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1024,9 +1024,8 @@ static bool __this_cpu_has_cap(const str
 	if (WARN_ON(preemptible()))
 		return false;
 
-	for (caps = cap_array; caps->desc; caps++)
+	for (caps = cap_array; caps->matches; caps++)
 		if (caps->capability == cap &&
-		    caps->matches &&
 		    caps->matches(caps, SCOPE_LOCAL_CPU))
 			return true;
 	return false;
