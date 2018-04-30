Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoFMSpHC8+Yj2w2DerF5SAKP6EhI2BZTVGTbd81we4oyaaLdGrVTOB70T+XDGQRiXTkqY0n
ARC-Seal: i=1; a=rsa-sha256; t=1525116366; cv=none;
        d=google.com; s=arc-20160816;
        b=zPW5znB6vMzl/sE0bdqWL+LlGARflHwuMA8VfmxrVXlHxJxbtSMttcPIepbjpTz6qm
         AhqIZhRUvhhfrocLPw0ql6IDIqIm8sS3/4+jkgjF6EdeYxfUJ1j/Xb3j57WnJ6/vw0oo
         68g6yKFlgqiUQFhMy6ruU8UbvajkYZ2UB2z5fQqCaxWKqfM20HU8Oo4Uu66l9Cb1Vt8v
         6T80bGa3Hk68sZWcWxOI8S3qCEhH6GtNR5Sk/WOd6oSVWwNNayBR5Ry+mS9vEGgF/icF
         OQTZlHeGWRUdIWJTpa7qKl1pY1xCWijiKTgwWrQa6hq4q0lgZMFELRs/Hg2yrozV0cZQ
         lBtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=+cqqRqnAmt42Yo7pJWUROHFnvb53JS3WNP+2HV2Wwpo=;
        b=w4n06o23QGlJrPqzL796rBpIYpYraRXGlq0Bc4MMXe3f2HoRU2vG/HgMHyqunc5Aol
         4B9YLKje2IrJ9IANT98zf/YcflVdeXu9LkojSJ/G40Fae8NK0L84kV3SuDRRmO/3Uecf
         shcZLcZWExPmmfiw18ipJknUHCSVLWvexsRnV5ChJeBPwrvU/42x+YWN+11xZh1WIsR3
         jWw61WTBYo9o2yk3leJAav+wBrI4iRdZH2/syT6ek+dfCcmxwHoQC9ve6dDiyulJwckH
         wqPrEQVitJkwezWfKShg6RU0tyGYB5+8PnAzuX1sjCW0pjmhTXY1cNhOpQ+emNN4rJJn
         zR5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC03622DAC
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
Subject: [PATCH 4.4 41/44] x86/smpboot: Dont use mwait_play_dead() on AMD systems
Date: Mon, 30 Apr 2018 12:24:52 -0700
Message-Id: <20180430190947.967684398@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200418723747238?=
X-GMAIL-MSGID: =?utf-8?q?1599200418723747238?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1442,6 +1442,8 @@ static inline void mwait_play_dead(void)
 	void *mwait_ptr;
 	int i;
 
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		return;
 	if (!this_cpu_has(X86_FEATURE_MWAIT))
 		return;
 	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
