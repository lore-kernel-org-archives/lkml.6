Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrsrm7xXq+ZWwtZcOJ+v4zP2MACZWbtgA/EnT1YDgXLdSD1DBzA7ZFgoXo5m/UspJtNAlGY
ARC-Seal: i=1; a=rsa-sha256; t=1525116463; cv=none;
        d=google.com; s=arc-20160816;
        b=jkYeS5RIWmiKLxVXsSH33qfKsSZ6QbhPW7WBxdJfAg7yvY7TB2Iy7cYzLOI607sLk1
         16AlVw37Z/2hTNF7VOtHZa3uinRnYeMqjf62td+TSQyHT6hHFcCsNN9zGEOuCuMQfrC7
         b7GJA1rVcR8z2fpxnvUhVXkybJCS4OGZjOloezyQHV94ZufnrQal2oiLASrTK0Wcomdc
         Gka5eJdM15HFkVvhB/3+rLzozIzwSlQ+yRCbDBb9178Po1t6NWitPdPLWwLxMd2/YmQe
         pzn7oFwzVurmtvoqo/pHot5+NqZ68ZtAZsbh1qpaI+NYSod0BFFCoSm0maEBwZ4MSJLK
         gkxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=4BCaLsfBnHLfGsC2Jwjf55gMHCvqdKzPdCgnZ2HOCRg=;
        b=pO6JtCJeBBGzSZcTOI13iyj0YKMppi0z3O/9DJBRQ096EOnFUeNM0FdyS5vYXTYgE/
         qThZaQdSA+HdVRb30jr5k6PQ3jguScHvOzf3cHAx2mGNJUAaOhhiejHPER0aGmNHiT/T
         L3F/qrhKoaS588yxXyTfzEcX/PFcwkjIMKED5XuGtEGlBn/jT3enI2ldGoiFx3HlDa5n
         8X6IrNDsc1wx5dHhU38kJAasITrRHYG4+k1uTnLqyBw/ZAiYYe1+NP8RC82+WSVIWAmH
         WqFDBI3jPjY2EzvKVQWST8raeyegZ54FBcLQFIMELMT5imnm+z06PH4seuWAR94RDjvb
         knfw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86A222DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Yazen Ghannam <Yazen.Ghannam@amd.com>
Subject: [PATCH 4.14 85/91] x86/smpboot: Dont use mwait_play_dead() on AMD systems
Date: Mon, 30 Apr 2018 12:25:07 -0700
Message-Id: <20180430184008.726821539@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200418723747238?=
X-GMAIL-MSGID: =?utf-8?q?1599200520500193185?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yazen Ghannam <yazen.ghannam@amd.com>

commit da6fa7ef67f07108a1b0cb9fd9e7fcaabd39c051 upstream.

Recent AMD systems support using MWAIT for C1 state. However, MWAIT will
not allow deeper cstates than C1 on current systems.

play_dead() expects to use the deepest state available.  The deepest state
available on AMD systems is reached through SystemIO or HALT. If MWAIT is
available, it is preferred over the other methods, so the CPU never reaches
the deepest possible state.

Don't try to use MWAIT to play_dead() on AMD systems. Instead, use CPUIDLE
to enter the deepest state advertised by firmware. If CPUIDLE is not
available then fallback to HALT.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: stable@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>
Link: https://lkml.kernel.org/r/20180403140228.58540-1-Yazen.Ghannam@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/smpboot.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1613,6 +1613,8 @@ static inline void mwait_play_dead(void)
 	void *mwait_ptr;
 	int i;
 
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		return;
 	if (!this_cpu_has(X86_FEATURE_MWAIT))
 		return;
 	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
