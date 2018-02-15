Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226uIqVM9SKfLtPoYOEQv4xvU8DzsjuG5SqNRZtVgEV5ABYUTkz3/vRRa4TZAoIxT9LR/nuM
ARC-Seal: i=1; a=rsa-sha256; t=1518708687; cv=none;
        d=google.com; s=arc-20160816;
        b=gCEy4oBGUIVBtzchv5fdj3tn3hIDevdvfaw6Xi0woyPGZ7wdI0dPw3PfucIkWkgLA+
         vff0ERoWCcA3CNr9DsCwm/m7gcMSNYaIiyb4GFg4j1FPOTw81Tv6zddhKqcNiw+6ddbi
         c0WKIEEFt+UJdozODbIiJzaYsWJAiTIo9D79ICpX0ERBZ3JOTqUUYuaAsr2W/bML/mc9
         cT4i2A+NpeC/OcZSViJQpcKLDABe6QZj1x5h8D7vs2U9J9kCoevxty/Ek/RcRvPAMKFW
         VvgltZdHCACA9nHvKWGwt3Q9uMCheWlLncxs54WPKVgYcGohQCh/mMkiGmBLjKE0BdYf
         1ijA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KWIUqBZwpFm0YqwtBaYGTLdOqOZSYflaZpgfkDIX9ag=;
        b=yo2AN5qRsauJ3f6qC2C/O/vsYysrDhtUM6i7H0xqFBcMld0Bv8g1V3SJ22qWbghElP
         vr7m847TCrqNtbjiD9bgA6nPbZnN442sn5NO3SySDH90D2gKk+Hbb33RwyqFLt3+OqtF
         FFFjnlWj+/0UPHXula3pUWyZwmiFR1UCKTaIg9Wkw8WDznHHsL+7iV44NawaGBku++8r
         s9ODE60ozgg0+QEyAcB5WK8KGGcrxamTHPxOf/Rhq9ZOU3/GSyDXemGCPlOOMhazrEZr
         KNe3nIUbqf5p/40LnttspagRFnBPXDsygGUqxoUnuLpboRyAAg/E5RKFZnncaEIb2Uns
         PRjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 042/195] [Variant 3/Meltdown] arm64: Kconfig: Add CONFIG_UNMAP_KERNEL_AT_EL0
Date: Thu, 15 Feb 2018 16:15:33 +0100
Message-Id: <20180215151707.852352120@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481480355530880?=
X-GMAIL-MSGID: =?utf-8?q?1592481480355530880?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 084eb77cd3a8 upstream.

Add a Kconfig entry to control use of the entry trampoline, which allows
us to unmap the kernel whilst running in userspace and improve the
robustness of KASLR.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/Kconfig |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -806,6 +806,19 @@ config FORCE_MAX_ZONEORDER
 	  However for 4K, we choose a higher default value, 11 as opposed to 10, giving us
 	  4M allocations matching the default size used by generic code.
 
+config UNMAP_KERNEL_AT_EL0
+	bool "Unmap kernel when running in userspace (aka \"KAISER\")"
+	default y
+	help
+	  Some attacks against KASLR make use of the timing difference between
+	  a permission fault which could arise from a page table entry that is
+	  present in the TLB, and a translation fault which always requires a
+	  page table walk. This option defends against these attacks by unmapping
+	  the kernel whilst running in userspace, therefore forcing translation
+	  faults for all of kernel space.
+
+	  If unsure, say Y.
+
 menuconfig ARMV8_DEPRECATED
 	bool "Emulate deprecated/obsolete ARMv8 instructions"
 	depends on COMPAT
