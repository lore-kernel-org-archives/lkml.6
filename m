Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2250E2GSpRQs5IXLR/holoXbmBjC9ljLOuPVq89OeDDZ9AjuDcHKRci8myzYTVvJQSlFU7IW
ARC-Seal: i=1; a=rsa-sha256; t=1518708744; cv=none;
        d=google.com; s=arc-20160816;
        b=hcmkqPGKHNyjHYkBJFC5C6AS2eBPdnr5PGTp1ECNRzoViuOhLF352poxW83daklauX
         L7Nj9+XF53xPJ9OPm7YHz6ChLf74L4yRnZGsyAQbfMNaI8JtBAZvb2Q//ZRip7c3XZvp
         Eq1EuNfG19cY/IpVrndnSFpYjTXIlGQfXwfs8Ygk5jJHUFf0X81Y1CtLMpUZfRWffsYX
         Ry0Jmsyl4IQMLNcahu5x7VLwyAHOXdcq8MoUvb3VY09quunXwtG5mqPwSThK+OHlfV85
         e8exVXAUHNpxvyJSjAzHmAKbIOIpdrRm90XBVfLr8RRVAqK1djYXeZhu5wsVU3Hm67P9
         hcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cxsQpi34M4re158VzqEL4GX9qNoH+0U2vYQeAxSSkzQ=;
        b=hFwGy2vVayYFF1ezpP3kInKZ5Gv2lma8x8slvTsuBksan+ZBQSkeNUuHRd4adGL6Ou
         Iga5C8AlAWVqh/zVZffLelkaVTuBHlj1yZEKCTsBtjhTWLqj7WgUvr+LS1BDWFtuEcED
         tKNSNNLGH/8h8qOJtl/jligRbw6jBbop5CnP7DkxsXCKXo/VOafSV5Pn+O6dvORPIuhC
         ApnPs6Ow38af6HYS7/KZO1ZzcIAM8F2oSFuSzjElCfVlxU975eCzd8vWqtFVKfhksFzB
         0vEQtq5WoVuBO7YmWNrooiEUeb5rhC96xRS2EkaA0XV8czYXGcq2S07/etUkdhJdodr7
         s50g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	James Morse <james.morse@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 065/195] [Variant 2/Spectre-v2] arm64: cpufeature: __this_cpu_has_cap() shouldnt stop early
Date: Thu, 15 Feb 2018 16:15:56 +0100
Message-Id: <20180215151708.961123461@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481540201586336?=
X-GMAIL-MSGID: =?utf-8?q?1592481540201586336?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Morse <james.morse@arm.com>


Commit edf298cfce47 upstream.

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
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpufeature.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1102,9 +1102,8 @@ static bool __this_cpu_has_cap(const str
 	if (WARN_ON(preemptible()))
 		return false;
 
-	for (caps = cap_array; caps->desc; caps++)
+	for (caps = cap_array; caps->matches; caps++)
 		if (caps->capability == cap &&
-		    caps->matches &&
 		    caps->matches(caps, SCOPE_LOCAL_CPU))
 			return true;
 	return false;
