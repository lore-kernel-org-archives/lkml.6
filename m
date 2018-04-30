Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrxWlAQR+LdjlQm4QNdJhNrOfRDrzGxaJCYqrz51iSJY4wZfhiehk77RkddIojxl6+2IKhg
ARC-Seal: i=1; a=rsa-sha256; t=1525116407; cv=none;
        d=google.com; s=arc-20160816;
        b=HZnWkciXyq5DdUfYALBeCyu1RQWpNwjXrPMyz/Vxw/41maCS4bZGV6efdLrQYjo6xz
         tZRLCBj7fKH50XtYr6Q26yKt4ATxJbY1r0mCx0Ns3hjIuEKeJ7KHi9lYi4xJQyvz/1Vu
         h1YKTiKPU7nnFst6fnW5WCz8Y8WTYfJndDZVb1DOKuRXKeiL4jjBE662XT/vhTkUjhho
         fvuMHA3fB89AtYqHzHkzqW9Sq3Xxr9o+ry7aaV1X575FlemmBbOioD41LZqvPjiAX6C+
         RvD2U2CD2ZrDz69Lcyexpm6TyRNTU5Nujuliv/MTLg1q00GoHGPvnPMKqnRVKs/mFqUI
         FOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=H/EgJzDNcUZ4cPK6rZIEwQOeDwn/Roqh2oEw5A1wWVs=;
        b=FLcu4hK+FW8x37GeVcr+JVtidYQKph6k5/54gAgb0+331+FhiAOFYY+2qrrveQSl54
         3XfSn4N73KTwj01H5DAXgYtTHmUIMPl7W2nNiu35jhhDCOGeP3QN0HX6mit+IHKACYKH
         GkLtiT/uOXTommewrBLrLU6tci7oPyLp/GTw/m284AdOp2gGOJOkSGl1dDH+sddpCzjG
         +DjWJzuewbifYYdYakrZmdKHfwlrpJRF5Rc1sKB1GTcl/bh5QyCLYdnCxecR/LhesKVf
         ecxJOD1PUxUFwT7XSQRx3sVWeSutTE9FvfAAEvlQoh4EWjJiPxnfnKAuwfZSYuifd32u
         hAqA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D78A22DCB
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
Subject: [PATCH 4.9 59/61] x86/smpboot: Dont use mwait_play_dead() on AMD systems
Date: Mon, 30 Apr 2018 12:25:02 -0700
Message-Id: <20180430183956.262525567@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200418723747238?=
X-GMAIL-MSGID: =?utf-8?q?1599200462866947465?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1591,6 +1591,8 @@ static inline void mwait_play_dead(void)
 	void *mwait_ptr;
 	int i;
 
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		return;
 	if (!this_cpu_has(X86_FEATURE_MWAIT))
 		return;
 	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
