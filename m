Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+lkxiF731Z3Ooxgr+sfAAlKYpuL4KnJFlAO0MOS0jEcHGO20HVd4/HRvkhKpIf07sVRird
ARC-Seal: i=1; a=rsa-sha256; t=1523021840; cv=none;
        d=google.com; s=arc-20160816;
        b=Z3k1AqByBA69r2uEY0R3vsdLjh0K569EZ1BUMzjbhjrOLylOOo5Tgg0hZ2gzFoECIQ
         megCiWXrEzok32KgpYLHBBXS9yvswyKd7al1BVVVlEcVHvWwGxn1Ovyl77o8zzm61mwn
         +ewtGCzSU3t7yTQFfxAji905F6tCrRreeeeHYcM+nhVZqIO3i2sBSpYDGKYluaHvs4Z+
         0izYhmUa7AHgTtPiZsYI1fCLW0xiYVZAxonb6S+iy/zjm45z8PqZp+jqjWQmVxvjbRzA
         ZIvOCi+5gbnNXR18t+Q0TBYaJiuWQ3VUHRrDJkKMXVphfQdZjqzi34MmH1GNEV1FTLNn
         CqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Iv5JXZgaKLP4eXy/ibrUlmhvLP5vVkLc7t0dwtokLUI=;
        b=BsPGiJNov1PGsCX8ohAOR2mYavZxWo9kDw9NgnYv81XQgFz9pCCQkToLNLnhGQj0RV
         4VhgNYf8i2IZ/+QQcntDTkOznV5TgCH0aumz6RXE1b3HwE0HQBW1k2lkxMsXZ8Gqg2TG
         17IOCKBKs8MO3d0cfBIqCBBfgA4KsPgH1OfPndhZyqBzwdFDVkI8x4AwZ74k/Bi3s2eD
         xQEzKfrBuZhqPoUOvM12GUUpQiZGGY7vFKFo6sLGNaRvOOAo0PcnZpTewGkCpuOSucF+
         l63v4a6MNemC+6PY0Iu+k0FYhwWcpIuZs9JLHfYm+gLsNawPa2mLu7SYHlRT9qTuVepy
         E3uQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	Jayachandran C <jnair@caviumnetworks.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Alex Shi <alex.shi@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 071/102] arm64: Turn on KPTI only on CPUs that need it
Date: Fri,  6 Apr 2018 15:23:52 +0200
Message-Id: <20180406084341.470027340@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004149116145630?=
X-GMAIL-MSGID: =?utf-8?q?1597004149116145630?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jayachandran C <jnair@caviumnetworks.com>

commit 0ba2e29c7fc1 upstream.

Whitelist Broadcom Vulcan/Cavium ThunderX2 processors in
unmap_kernel_at_el0(). These CPUs are not vulnerable to
CVE-2017-5754 and do not need KPTI when KASLR is off.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org> [v4.9 backport]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpufeature.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -766,6 +766,13 @@ static bool unmap_kernel_at_el0(const st
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
 		return true;
 
+	/* Don't force KPTI for CPUs that are not vulnerable */
+	switch (read_cpuid_id() & MIDR_CPU_MODEL_MASK) {
+	case MIDR_CAVIUM_THUNDERX2:
+	case MIDR_BRCM_VULCAN:
+		return false;
+	}
+
 	/* Defer to CPU feature registers */
 	return !cpuid_feature_extract_unsigned_field(pfr0,
 						     ID_AA64PFR0_CSV3_SHIFT);
