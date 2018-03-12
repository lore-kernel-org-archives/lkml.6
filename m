Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELsQnC/5KODaAGQhbvYvY5oNvyzWznoTvwaqeoRaprLCPzaUaCuaXMQUh0ekYLsolXJtHD4O
ARC-Seal: i=1; a=rsa-sha256; t=1520824085; cv=none;
        d=google.com; s=arc-20160816;
        b=gHqURC8XHlSZH/Ve75IV3lA2uCfGpnRllufBwhneYUXavgw6uXUzijlqmjY+xGJK36
         tNuvDZfJziTVytnGBoLYG9wtpWGjM3jxTDVIiyDnXB3x1LMiLFktS4tkpn1+xAt+7qXe
         8m+/fd/9OpqBnUwBTji2wovr7Hty59TDMhmk7OYlnKEpPuN/7whe6Sk7h76/iciVReTp
         TD7l2eWoPTw8pdVMtAMcC7urYixn5Ur6OVP5+nqBT4a+f1/sv+zDTyFjQSp8BLnkVKsp
         Y50n5ICLHUEOOkxSXcUCXeQtGvJvqHV2RGXU6INWm+EbleyMWsKaCeCzKgZg5lE2YW45
         Yclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=qPD1gtJlrp2HEVedFTyvP+pScuy+a6PY6cUffllHPkU=;
        b=YIgqlMtFyYh651xTr/Dfw0tUe0JfO6YqA9Jc4SUMKSzTpxR51DBw6xEcwqUEuzpbrP
         5/TcLB5dIidz3AXU+kHiO3hkGrLhGi+NaDLxuqUxxvCgyeV11ZQs8pZQXQvWQAsmCU4D
         hnSEbu9nYcck2rFryqlc0LkWpjZcNnjsdNfhB2FaMaDOO0qWiAnK/cWxsZIeSaY1uWGz
         Cf3SfWK4wnpt2/axOIUQksCBgZEYgkD9sk2X/HzPH3uVa8U1Hmxy5w5x2RzswIj1GnOv
         7D4SbbGcZbXG6u7TOaWD2GwZlM5x1mlWHw39FMlx8oH1+ZoMJmUwdM3rHeEsSzVihX7x
         xazg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Paul Turner" <pjt@google.com>,
 "Borislav Petkov" <bp@suse.de>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Andrew Lutomirski" <luto@kernel.org>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Andi Kleen" <andi@firstfloor.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Tom Lendacky" <thomas.lendacky@amd.com>,
 "Jiri Kosina" <jikos@kernel.org>,
 "Dave Hansen" <dave.hansen@intel.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.126225421@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 16/76] x86/alternatives: Fix optimize_nops() checking
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699636412875983?=
X-GMAIL-MSGID: =?utf-8?q?1594699636412875983?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit 612e8e9350fd19cae6900cf36ea0c6892d1a0dca upstream.

The alternatives code checks only the first byte whether it is a NOP, but
with NOPs in front of the payload and having actual instructions after it
breaks the "optimized' test.

Make sure to scan all bytes before deciding to optimize the NOPs in there.

Reported-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Andrew Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Cc: Paul Turner <pjt@google.com>
Link: https://lkml.kernel.org/r/20180110112815.mgciyf5acwacphkq@pd.tnic
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/alternative.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -326,9 +326,12 @@ done:
 static void __init_or_module optimize_nops(struct alt_instr *a, u8 *instr)
 {
 	unsigned long flags;
+	int i;
 
-	if (instr[0] != 0x90)
-		return;
+	for (i = 0; i < a->padlen; i++) {
+		if (instr[i] != 0x90)
+			return;
+	}
 
 	local_irq_save(flags);
 	add_nops(instr + (a->instrlen - a->padlen), a->padlen);
