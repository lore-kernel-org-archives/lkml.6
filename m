Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224yGyb2hshYufEWAm1e2t6DrdiPct5ZX0EpuRknPQz0S33M8iJvuCj4LTpQRalfME67SGu8
ARC-Seal: i=1; a=rsa-sha256; t=1519217987; cv=none;
        d=google.com; s=arc-20160816;
        b=FOFucwQSHfM8YmmpcLdjqWSnotI8PtJYt3UqIPssHUfydLP1EdpHhKvhgHA0t/pJi1
         xCc1DCYnNXQ/sZIY4zUmyB/J6YvvAlR0Dd2gIUfs84f1sPhuHEYbc907UKXce2VQo0kD
         GvZr56HyoRKL8BpspJGlzDwbLB8c8mvqfxwdQuAkcxMPmL8jau9lXntinQOE/rs1HGGu
         4rmreaHDYD1ye/rYiJQg8EQRTJeHLhKqoHQg9jqQ4d61zaoo2dHTNlZTgVkBd1iHdMtY
         OxhUeH3qMIws1tqV/hp5Ix/Q/ViTcDmsSCEDPz3xiXjLMmHEooGJsKhs6Io0YvTESQgq
         8ERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=g9d6LcMq+4VRcWi11RTTPW2ALjqzYwDNIW6jkIwWUkY=;
        b=oo1cl/uS5FwOpstO1L71wMKF2/Kr+nVH/9izJzemaSdfbfz5nGApIh7vXvEIBXUXLY
         hkvuetgVem3ey2Viwd+RKiC3se7mVLhxcpVjvVdqUR9kT9kzMM5pL5z4ksxEQD1rI1h6
         S8sFy0DNXQOZLgmZbNfw8tXKwUmdEjHpDxtYokxziMlvQszh6/Bv0b06WBKOEwrwu7PH
         wYaZCVOfBf5zHmzJFnvLTVXwXz3d5xHOWxvSIp1Ef/at/oaExYLY4hgCJQPGwU6UmPyr
         a3eKnvZUnlOACaoIsQY+4ry0vfBKFFXc5GQeqib4wdRuVYUO8zTuMkj2Dner5dZjE17+
         jBzw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arjan van de Ven <arjan.van.de.ven@intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	dave.hansen@intel.com,
	kvm@vger.kernel.org,
	pbonzini@redhat.com,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 049/167] x86/speculation: Correct Speculation Control microcode blacklist again
Date: Wed, 21 Feb 2018 13:47:40 +0100
Message-Id: <20180221124527.231407622@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015397085448987?=
X-GMAIL-MSGID: =?utf-8?q?1593015519918493871?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit d37fc6d360a404b208547ba112e7dabb6533c7fc upstream.

Arjan points out that the Intel document only clears the 0xc2 microcode
on *some* parts with CPUID 506E3 (INTEL_FAM6_SKYLAKE_DESKTOP stepping 3).
For the Skylake H/S platform it's OK but for Skylake E3 which has the
same CPUID it isn't (yet) cleared.

So removing it from the blacklist was premature. Put it back for now.

Also, Arjan assures me that the 0x84 microcode for Kaby Lake which was
featured in one of the early revisions of the Intel document was never
released to the public, and won't be until/unless it is also validated
as safe. So those can change to 0x80 which is what all *other* versions
of the doc have identified.

Once the retrospective testing of existing public microcodes is done, we
should be back into a mode where new microcodes are only released in
batches and we shouldn't even need to update the blacklist for those
anyway, so this tweaking of the list isn't expected to be a thing which
keeps happening.

Requested-by: Arjan van de Ven <arjan.van.de.ven@intel.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: arjan.van.de.ven@intel.com
Cc: dave.hansen@intel.com
Cc: kvm@vger.kernel.org
Cc: pbonzini@redhat.com
Link: http://lkml.kernel.org/r/1518449255-2182-1-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/intel.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -116,13 +116,14 @@ struct sku_microcode {
 	u32 microcode;
 };
 static const struct sku_microcode spectre_bad_microcodes[] = {
-	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0B,	0x84 },
-	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0A,	0x84 },
-	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x09,	0x84 },
-	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x0A,	0x84 },
-	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x84 },
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0B,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0A,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x09,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x0A,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x80 },
 	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
+	{ INTEL_FAM6_SKYLAKE_DESKTOP,	0x03,	0xc2 },
 	{ INTEL_FAM6_BROADWELL_CORE,	0x04,	0x28 },
 	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
 	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
