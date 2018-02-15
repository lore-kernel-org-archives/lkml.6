Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226qmY8jwEh8NVtjFVz3aiILyD2sP3Cop+o3iOeNU+qDGY7mDXL+IsqghLszvWMv9N6FPg0j
ARC-Seal: i=1; a=rsa-sha256; t=1518709227; cv=none;
        d=google.com; s=arc-20160816;
        b=Ffc7Q5m4yb2ZKZY34NiOEipaZG98Qh3V3aiaxQCeXOi3VZ+uZ/i+DZZyPxaPhvm/lY
         0mDN0UNTOwGMUzsTN55hOKrqIwyDgI0MroCYUpL0zh+h75Jx1Uf2GYUU9IN7JZfA7Dza
         l3VrH99CKWbXIYdsAIlSJU26ytjlLzrWnfIX0zF6X3h0uLIZHhWTwUY/a0PnnUFKdVwY
         MPmXELgF6G7yhC+50zD+8vYAuvqI6blCNQxIcLZZWRIN+s3joX1EE+IqnBaKng5s4C26
         EVjv8qnm6QnToVhHxdBf1Cp4rVpFRmf7glh8mMuIGWnCfbzJZEVhZE/AJrUW3a0Mv5Qy
         PIlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k9gPN6pTLVozOQV+YLT9huuW0cbXmm9lt7/xEzryPbU=;
        b=x5x7kMJekYaDgDn14SZlnOeXS9KKpgHbgBbhJV4/qekxHMi0ju5f6MiLaZ13yeTH/B
         Jv/Cpn4FiHpgx5VWZ3qOz/w0mX+no2Syg8x4bcWKKZn3Poy9NLou+jqGeqnZf5OfbJbo
         Sc38U36YII+232+1b04BbwUCw8r/rI0eFH0SdfTNl3dYpHjXat9HdgHJyeLUT5hCXNoz
         10Ub65GyhpxAjLJQa0TYQ9JeJzqJTa+FDklDw/1Zb3OqtrTHKi3b4N/PAE8zFM6fz9Tt
         dM6tEf/mcC04XfFean3TpX9ve9nrprd9AV0PNjGB53QEBdi1HrDsFjPqKcuZQfkenlLF
         nuCg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Jayachandran C <jnair@caviumnetworks.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 041/202] [Variant 3/Meltdown] arm64: Turn on KPTI only on CPUs that need it
Date: Thu, 15 Feb 2018 16:15:41 +0100
Message-Id: <20180215151715.310098043@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481545594577550?=
X-GMAIL-MSGID: =?utf-8?q?1592482046801107500?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jayachandran C <jnair@caviumnetworks.com>


Commit 0ba2e29c7fc1 upstream.

Whitelist Broadcom Vulcan/Cavium ThunderX2 processors in
unmap_kernel_at_el0(). These CPUs are not vulnerable to
CVE-2017-5754 and do not need KPTI when KASLR is off.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpufeature.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -866,6 +866,13 @@ static bool unmap_kernel_at_el0(const st
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
