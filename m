Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227MD8CnaFayfU2Inpgfqn5bJt12uTjPfPywQ3lmY9qLRsaftEa2lqVFcgWx6q/zIVpNJFdg
ARC-Seal: i=1; a=rsa-sha256; t=1518709268; cv=none;
        d=google.com; s=arc-20160816;
        b=OCH7IowQpr588zVRhUleq+aRAFSzTDHDKAWFveO5YLHAofcFC5fH05WiJXhvUAFiNi
         6/9GAYSZW7HuU85lL9ymayg7UcUs1hLAeOp0o+GCagkXc6bFb71Kc3H/0L/81PRjesc7
         jfgasSbQzPFGSU6cuHdS86hY9CU7TCE71TpNUMBKHatewsreX1CT+83JcsdIzcBClCsF
         th5s/V6hwt1GP031NmJHNTeN8GoqlO/D7aAXuL4tDBGp7dZ7HchOBCTz2uhQnbpP84OZ
         q/b0AISeACr0dt4gt14mtaDhWIFrEBbLWScuSqPQ6vsen7zeXCSWxJIYYWkeeVFakAH/
         ZRUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KsDaiBCVbJ5HViVD/pr+8EO/fjhQ2MCQLCP28x/zlM4=;
        b=v0vSwfdriOXWcgiVk0PcgNEM/j0GPFq+HrNwTMd2O2XS+XB5FeMc3tPfzt2vRelvov
         eBMJv+XDfjLOqYjCsInnZooeiGiO+WA1e+V6/8wpbZA1E9NxqQL58ZRLpnhZocrZUZUK
         ol4/uaeHGXStDUwCDvS7wVDSw1fPKHJBYOck7hZd1EsrYfBP8xOcjgdpT1CaQb36XRfi
         1yAdDiMFutij7+jO4Apw6hLURDYD1stGxzaFMdrRSxK5MBFuBYJk3FMZ/09s8UyjjbwA
         vPCi/Hy16R0EhaWiKPDH3DCWsp7SZ8iqHsHHa88g+OcUg9u+aPV/0tXrTG1JGMsOjD1+
         aQTg==
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
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.15 058/202] [Variant 2/Spectre-v2] arm64: cpufeature: __this_cpu_has_cap() shouldnt stop early
Date: Thu, 15 Feb 2018 16:15:58 +0100
Message-Id: <20180215151716.313237101@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481540201586336?=
X-GMAIL-MSGID: =?utf-8?q?1592482090134558389?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpufeature.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1173,9 +1173,8 @@ static bool __this_cpu_has_cap(const str
 	if (WARN_ON(preemptible()))
 		return false;
 
-	for (caps = cap_array; caps->desc; caps++)
+	for (caps = cap_array; caps->matches; caps++)
 		if (caps->capability == cap &&
-		    caps->matches &&
 		    caps->matches(caps, SCOPE_LOCAL_CPU))
 			return true;
 	return false;
