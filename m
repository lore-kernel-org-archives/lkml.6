Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2267lm1dGpVktJr4EHF1RCasPd2gVVOXdlym0ZZ6oMC4mbdxQ9hPVJjBTovM4KCriqnKm+ry
ARC-Seal: i=1; a=rsa-sha256; t=1519218402; cv=none;
        d=google.com; s=arc-20160816;
        b=v3Y3+Dxl9bHNLcjJxLFOE5SDmPGhYDEmPzzN2OpBLr82f1F8W2NsZTzSJMJAH7zvX5
         L/E2h1wfHDIsxSx2QjXoWmTf+T/keRSy62T24UjpPLOXMwfWz2S/D6eJD2hMGeDz0wzp
         H+vFD/4UHO+y5zf+G9AWCKmw3n/QNCWzOArys2LfKNHwpxgYCWnUfROwkxgOgj4K9oj5
         s6x/M8URRXjyVLxTeVSxjM5Y8d7HHVoxx734+egtF9ejPAllUDPXVlX/ulkNnzMSoCg/
         73biRUQZOs1Le6V+txsX2yl33R/LOEGmHnt76z3qcQUm3WXJK1FMZC7mrtjoD5nis3kB
         0vRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cxoNes1bUGZMCmnx0Zk0c54cZRyYsz4en8OWWSGXvB0=;
        b=V1NKhDSUOi26+9BYX4Ia+507hW/F0cLmFAKJSxZZcWISGJ/ieoZafaX/TcK/PC8k9L
         IeAlimDDwp9PveHbgjVabtus9I1/O+hklGzXRkdNsH3nNXJJqZB5lW/GLAPK+LapGVvI
         r34TY2IUqVPxai8oJjay1YkPi/xy3A78LmzTN2E13x5Dr01Hs0AZR5XBKRpGGHJlfo9A
         KIuvne+YzOmEmffLDZyNXevbafSxPZrgBrgtKF3PziojGSowLbfb4BsdaV3TP4YtAdgH
         2aADj3UGpNU7vdHD2k60yaIzos9EP6A2QEB6xPb7hU4aMR1qKuFDnBmlIB3gzvrUaCXl
         9BFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	Balbir Singh <bsingharora@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.15 019/163] powerpc/radix: Remove trace_tlbie call from radix__flush_tlb_all
Date: Wed, 21 Feb 2018 13:47:28 +0100
Message-Id: <20180221124531.198406709@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015431627887973?=
X-GMAIL-MSGID: =?utf-8?q?1593015955262231195?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

commit 8d81296cfcce89013a714feb8d25004a156f8181 upstream.

radix__flush_tlb_all() is called only in kexec path in real mode and any
tracepoints at this stage will make kexec to fail if enabled.

To verify enable tlbie trace before kexec.

$ echo 1 > /sys/kernel/debug/tracing/events/powerpc/tlbie/enable
== kexec into new kernel and kexec fails.

Fix this by not calling trace_tlbie from radix__flush_tlb_all().

Fixes: 0428491cba92 ("powerpc/mm: Trace tlbie(l) instructions")
Cc: stable@vger.kernel.org # v4.13+
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/tlb-radix.c |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -600,14 +600,12 @@ void radix__flush_tlb_all(void)
 	 */
 	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(1), "i"(ric), "r"(rs) : "memory");
-	trace_tlbie(0, 0, rb, rs, ric, prs, r);
 	/*
 	 * now flush host entires by passing PRS = 0 and LPID == 0
 	 */
 	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(0) : "memory");
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
-	trace_tlbie(0, 0, rb, 0, ric, prs, r);
 }
 
 void radix__flush_tlb_pte_p9_dd1(unsigned long old_pte, struct mm_struct *mm,
