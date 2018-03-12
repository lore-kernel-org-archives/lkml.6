Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELuSvKu7oFOG7RRpRsiv+7IhvdI6dPSeGmVQ/tHVW555zV9+1SDxfTDOAbiPZPW7ulHSYYkv
ARC-Seal: i=1; a=rsa-sha256; t=1520824083; cv=none;
        d=google.com; s=arc-20160816;
        b=oNgMWskRFqM+nQ5UOHHRpj8ReGHcp9V+r+jwSb4eX2mQNz9yBKaieRkK+LgqD3M9N1
         DknQcHxnHTZ3p+Pvrsyk/SJfM/q+2zRoYGWYxLANJNNwxZ9Vm9sCVmleLyG2THbHaovV
         IpyLbYcYrGrxsFSYWaVaXbx0qTPPcqPjTDAEp3NFVqcxOtan+gGFgoj5GA+l9G/5zs/F
         4LxFUpt2Smaw4qc+MyzB2wgidiQEDraB+d4AybI8LByBxcMaV0U1bKZ+ykhZP6tFoQgH
         t3T6GdGtF0OQcqdAo6zwSPEhJ11Y3W1CTE7yqK/bNx8G8E513flr1LGjDDMXOJ0UnkGu
         lYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=wSD8m/d9LC1y4yw3+hWBMVUDcD4oEy/MIrG03fagOms=;
        b=ovkD7IV7RkE0JoJyU/hB/WlSuIrmrhTGOnRnUen4iyBo8xREFpVfWnduSIr55Li0ku
         RjVgCR/wXM4lyYK3Dgdvn+EXqPYtwNvwstxZFy01g5oQlJ/pOIfQpNxnIdI4yU7hp2s2
         tNOjdotuqLpLTWQkNwEqwviUHQYQZso1xVuPDXhXJHw/TCNBl6kHu4Jkof9Y9aXVxz0/
         /nFfjwXvTcEmpkFQ3zPJ2Jf9OY4nqV2dorjES1SEbkF5T8EkR2m0JvOq7zsmO7E6l/g0
         Jazw42x0dhgtS3Sji62UFMh3eZ8XlY+BO4wiSxOndk6nMj0eFZBphlBFSJZ5TyvZT+dl
         EfFw==
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
 "Dave Hansen" <dave.hansen@intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Jiri Kosina" <jikos@kernel.org>,
 "Borislav Petkov" <bp@suse.de>,
 "Andi Kleen" <andi@firstfloor.org>,
 "Tom Lendacky" <thomas.lendacky@amd.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Paul Turner" <pjt@google.com>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Andrew Lutomirski" <luto@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Andi Kleen" <ak@linux.intel.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.379844244@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 052/104] x86/alternatives: Fix optimize_nops() checking
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699636412875983?=
X-GMAIL-MSGID: =?utf-8?q?1594699633715213598?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -324,9 +324,12 @@ done:
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
