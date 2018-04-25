Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Lwp26Gq82cvlDIHsICuT9LEVLZphBl8Zo+/KsD0cl9sZo0i+GAtVjoN6305Y+IJEckbGt
ARC-Seal: i=1; a=rsa-sha256; t=1524653049; cv=none;
        d=google.com; s=arc-20160816;
        b=Euc83D8PxwdMzcwrOMJ9zK4WRxoMZ1WQD38sNLZM7LjfOLCxnrKx770A/x102kCiub
         H4aojNnhMvlUt9eLjhijZbr4zlvfszvsPx3zHNrUeB0FeEDYxOzJ/+32pj0xNlRWFY1g
         h+ayrmXTmw7SM99QBEHvNPW0ZJXzfD8OasWIyCU4Wsxfo05rH477s9K+e1pyd59pl+3C
         MaOjdaacw5GEjHuIm2khTt2zqS/cC3lTFno2RJ8edjKdLAWKWJonxBPCK097EUd7/FnR
         BSuHs+8xM1MSnWAeRoPxbzDf3ic8nlohKgTCVIZib9fHAzX6KAikXNnAsV4LbHNWh/ro
         5EGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2+qztCyquD1OyyKtd8KWHZVk9a4uRPpHImlZAoLQPbQ=;
        b=yVGiL8xcyz5D0ydu45pWGQ7EsRDIJn2gVLfvMLwfcmMsX/mQ7kN+jsd/9Zajj+M6wR
         chgtJ7uNj54Vx4QwqI+WbdICvV723Zu7/B5jc496v0DqHKkuAx7Lily0113+GTDq7OcV
         Hu8lmfgrNguYremZ9LVkctj9VKVvA0Suknc2RSdW56IeaHrjqD6o98IWLjLCIXYKdNTB
         RPtYbmowKcr1f37y7vD0U3eWMYY6AHiW8hDZ5ekBFpquQMN8smmlmEZ1SOYelJ4yDDa3
         +rKtJhyH/GzeXlrl3zgPy1SMgzj3VMIs7oPBPh3sBfHd3tSchiUiU282S1iIMrTWBVIx
         CLUg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mike Travis <mike.travis@hpe.com>,
	Andrew Banman <andrew.banman@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Russ Anderson <russ.anderson@hpe.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 165/183] x86/platform/UV: Fix GAM Range Table entries less than 1GB
Date: Wed, 25 Apr 2018 12:36:25 +0200
Message-Id: <20180425103249.151523954@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714596143617664?=
X-GMAIL-MSGID: =?utf-8?q?1598714596143617664?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "mike.travis@hpe.com" <mike.travis@hpe.com>


[ Upstream commit c25d99d20ba69824a1e2cc118e04b877cd427afc ]

The latest UV platforms include the new ApachePass NVDIMMs into the
UV address space.  This has introduced address ranges in the Global
Address Map Table that are less than the previous lowest range, which
was 2GB.  Fix the address calculation so it accommodates address ranges
from bytes to exabytes.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Andrew Banman <andrew.banman@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russ Anderson <russ.anderson@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180205221503.190219903@stormcage.americas.sgi.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/apic/x2apic_uv_x.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1140,16 +1140,25 @@ static void __init decode_gam_rng_tbl(un
 
 	uv_gre_table = gre;
 	for (; gre->type != UV_GAM_RANGE_TYPE_UNUSED; gre++) {
+		unsigned long size = ((unsigned long)(gre->limit - lgre)
+					<< UV_GAM_RANGE_SHFT);
+		int order = 0;
+		char suffix[] = " KMGTPE";
+
+		while (size > 9999 && order < sizeof(suffix)) {
+			size /= 1024;
+			order++;
+		}
+
 		if (!index) {
 			pr_info("UV: GAM Range Table...\n");
 			pr_info("UV:  # %20s %14s %5s %4s %5s %3s %2s\n", "Range", "", "Size", "Type", "NASID", "SID", "PN");
 		}
-		pr_info("UV: %2d: 0x%014lx-0x%014lx %5luG %3d   %04x  %02x %02x\n",
+		pr_info("UV: %2d: 0x%014lx-0x%014lx %5lu%c %3d   %04x  %02x %02x\n",
 			index++,
 			(unsigned long)lgre << UV_GAM_RANGE_SHFT,
 			(unsigned long)gre->limit << UV_GAM_RANGE_SHFT,
-			((unsigned long)(gre->limit - lgre)) >>
-				(30 - UV_GAM_RANGE_SHFT), /* 64M -> 1G */
+			size, suffix[order],
 			gre->type, gre->nasid, gre->sockid, gre->pnode);
 
 		lgre = gre->limit;
