Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpnKfh25awBXZk/Ox/GGJasb/ujYxqfKMn/uMIjg4oE/iH7ahOb3HqSlSgvi6oNPPkVYXTP
ARC-Seal: i=1; a=rsa-sha256; t=1525116535; cv=none;
        d=google.com; s=arc-20160816;
        b=bIVZahpeSoFCTa5eIyHdgJyBQshKVBgkU10jrt8w0mG5YkKjcIESy+4mZ/1lnmRGDP
         BJGjHbD3ilT5QWBGAZGrYGHh3gu9ZTu1F8ZY6kfWTfzelZz6NgwUPC0zja0lV1p1wb90
         wQXO+EZL0+8337Gi6aPqlzxFmeY3yaNXyjLvVChS95hrgKzOYIJphx31hUJywQZUejyy
         4z4Et2vUbhNowaPh+zf4s0m+Il+1Rx99rGtEEqcox5HKEWKZaLhKpYbHEf3/lujyuQ83
         /BO74i98cnFOKksncK/IV8Eqj0XPpxHBBusG+mx5nNZK3LnEOB1CgpDnuGNR9/ifvGEA
         SD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=TcUkpkahmBmxeNOXpX1ki5myqWzJFwPkW2h5D1R7JM4=;
        b=o8lYLnzn+Ce+RNWKUCEK3lOK1y4rcCbFv06ZqhceteasucV1UdRRFobjAf/MbhwV5e
         2Uutdl3KRzfMZZcQtst8PtyMCmLtj+x5zyct4kbR3Gr2OKypcODOv2V/FG1cGEXwBqi6
         4aiYPZtIjJtr5z75zaYe9GiXcLMCIXR4Y1FWHl3nQ4NmmYvrnahk0EBLSH4uUiCMYzip
         EU9MYtCQxBYjlx8A6x/fUYAioE8CQvfho4ThjENbX4QKvdZp1F1JrT5X0bB4tiDwVp9G
         7e6AbV+DKjHcHIGB53kiZQytXOdfJuNmxCtX2kTKi5aO/upmQvZ1ZjegOZBLmYcnUkbN
         fIdw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D350922DAC
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
Subject: [PATCH 4.16 108/113] x86/smpboot: Dont use mwait_play_dead() on AMD systems
Date: Mon, 30 Apr 2018 12:25:19 -0700
Message-Id: <20180430184019.766115001@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200418723747238?=
X-GMAIL-MSGID: =?utf-8?q?1599200596495203528?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1536,6 +1536,8 @@ static inline void mwait_play_dead(void)
 	void *mwait_ptr;
 	int i;
 
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		return;
 	if (!this_cpu_has(X86_FEATURE_MWAIT))
 		return;
 	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
