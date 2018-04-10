Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+gqyKvUD43b/48+XjqzIGtsn1EJXbOQjcH0lBt0qTKLPvT1PcEW6daAC7wt2rjnBkYOdTL
ARC-Seal: i=1; a=rsa-sha256; t=1523399911; cv=none;
        d=google.com; s=arc-20160816;
        b=YMnoQXVoCf+FzAmMpi/rnLpO4jnMBzvYbFHow9OKW4Lh3QjjXvDCPbdTdHmvhAd+lc
         vHMy0KYnWsuL3fXPfPSYnkDNyZ2LdV69ZMizhCiGAMoM5wFKXUs0o8gopV5jwzO4Yhu0
         JWHdCEpSdCWyTpcPfn8sHR20ohYGjirUlolR+4gDnq3Lx7MI3U7x48c7xqs+paoyEvMK
         UR8rAsu1lUrlveFkJAmSn2w9aNGDmXT2UvE+z0f83NpI1RFgF+alXi6+GzrIChAgBY+5
         3L4ogtyUq+SwK6tzJiHNIL6Uq8l3GbWai6qRobO1T0H/fk2OuFa3VbSfpMsmJJAMw87I
         fs9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0z7NW5/D19ZIXZBgmgYk4TYK4tvUbR6DEWfpq9oTjb8=;
        b=LZnk4iUAWKTPa5HfBqpYiswvWqEUYrCXoFhif5PYft8DA2K1sHCqFyg+71A6xOUejg
         tPHJZGyZJoY6v608D4w2OM7tM2mMpvIjlldJhwuw7ZS2h0eaTqCwTpoGr4Ix2ijI4NWs
         06fA8jn1TPN0shc0qQKOqLrl8CYAq2bkIoGG/vT7wlrWxZIKChJYv44YIjLL2z+3p12k
         dIGDqACuEg6d7vA2sCs4xKNM8ZDuSdN02kONgEmgM/n4r1PB42mUTDCVguuBmQWGH+4d
         nnuDUXlHpYG7Bst+938IgIG3e0UNrFHhfSPF0GgIBA2fJxJqqGXdBWeA8C9qG3Mybwda
         0r4w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ashok Raj <ashok.raj@intel.com>,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: [PATCH 4.14 090/138] x86/microcode/intel: Writeback and invalidate caches before updating microcode
Date: Wed, 11 Apr 2018 00:24:40 +0200
Message-Id: <20180410212912.624163472@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400130975007180?=
X-GMAIL-MSGID: =?utf-8?q?1597400585831930621?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ashok Raj <ashok.raj@intel.com>

commit 91df9fdf51492aec9fed6b4cbd33160886740f47 upstream.

Updating microcode is less error prone when caches have been flushed and
depending on what exactly the microcode is updating. For example, some
of the issues around certain Broadwell parts can be addressed by doing a
full cache flush.

[ Borislav: Massage it and use native_wbinvd() in both cases. ]

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Link: http://lkml.kernel.org/r/1519352533-15992-3-git-send-email-ashok.raj@intel.com
Link: https://lkml.kernel.org/r/20180228102846.13447-4-bp@alien8.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/microcode/intel.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -600,6 +600,12 @@ static int apply_microcode_early(struct
 		return UCODE_OK;
 	}
 
+	/*
+	 * Writeback and invalidate caches before updating microcode to avoid
+	 * internal issues depending on what the microcode is updating.
+	 */
+	native_wbinvd();
+
 	/* write microcode via MSR 0x79 */
 	native_wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
@@ -816,6 +822,12 @@ static enum ucode_state apply_microcode_
 		return UCODE_OK;
 	}
 
+	/*
+	 * Writeback and invalidate caches before updating microcode to avoid
+	 * internal issues depending on what the microcode is updating.
+	 */
+	native_wbinvd();
+
 	/* write microcode via MSR 0x79 */
 	wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
