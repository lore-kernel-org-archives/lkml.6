Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+ILiBJdW3BqXO7Vu5JnNfP1J1vADppnOZqwX9efsXeslKLP/qAJWcHnykMG1zxPmzfsYbP
ARC-Seal: i=1; a=rsa-sha256; t=1523981434; cv=none;
        d=google.com; s=arc-20160816;
        b=YZdhqESXiUpgFYQK0XcM39SsE5Nt5YFcMLP3eYH8IvshB800KKWIQm0Ubi5tOXKa3g
         HzXgbvOmo1cftBXhw6xDVkdGjogorpPn/guKTT8JVtiOOQqhRjPE1IFScq4P33ZvkfcA
         eGk9avyvZ+d7Haebnj0vWLWd3NeJ4+if/jxmn6rrAaiHNLN7Yj09Mot2sw8IFws0fTp/
         ISEj8Jq6xUhsMA0Z+Oi8upQt9aso/Me4+FFfTEVUzX3zNn+DLzuxENhTltgeTbNXdzLk
         i55S7+XFWCvfGKgGn3gO/TINA1VnA9cRdnFilVldQ+Cu+y61f+y0hGvUJ4vK4SW27AzF
         22yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Clal5mOmSIUY1/XLZb4vuYzibPiUKoFO1CJg2/DnttA=;
        b=hrrSdT0VUhYhXBoBGjnzaUqqDlhYEMH4FZkaQpIEaPUFlQFidJcT5+P3Xt+UPtijrV
         s04u2CFbrnpwMr2yB5FCVumt/LJLWuANbLwx6CL6Ap71LvHSWWQdR+Y+Pzl7LJdNN0ug
         9FRxhZ9H5UgIL8gsw+JqFhC9reSljopwbqwvtk7ViGctgvB/MoqOdk8kqJvLPpqCKFdA
         rnn75K6RHO97VDxchxuCJGgFU6djlcwooQj6VkjZBLkKVRFPuQfdY+QdQRU7KKolVnoa
         iDAiw3DLdmX0DmOT68QFiRpV6pm/VOwNF8KPD8UetRF9hV4lp5mEae1JOvLSdmrjUFHM
         i7Ag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	Jayachandran C <jnair@caviumnetworks.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 34/66] arm64: Branch predictor hardening for Cavium ThunderX2
Date: Tue, 17 Apr 2018 17:59:07 +0200
Message-Id: <20180417155647.352640375@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010356550945880?=
X-GMAIL-MSGID: =?utf-8?q?1598010356550945880?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Jayachandran C <jnair@caviumnetworks.com>

commit f3d795d9b360523beca6d13ba64c2c532f601149 upstream.

Use PSCI based mitigation for speculative execution attacks targeting
the branch predictor. We use the same mechanism as the one used for
Cortex-A CPUs, we expect the PSCI version call to have a side effect
of clearing the BTBs.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpu_errata.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -252,6 +252,16 @@ const struct arm64_cpu_capabilities arm6
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
 		.enable = enable_psci_bp_hardening,
 	},
+	{
+		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
+		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
+		.enable = enable_psci_bp_hardening,
+	},
+	{
+		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
+		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
+		.enable = enable_psci_bp_hardening,
+	},
 #endif
 	{
 	}
