Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsxFt2IuGRp2Cv3NlDXCdOpG+xWTwnks0C3LkcfH6zOfxW9sic9dvyPHEoeAux55kvsXV6d
ARC-Seal: i=1; a=rsa-sha256; t=1520451623; cv=none;
        d=google.com; s=arc-20160816;
        b=TrZZ38Fd0YEBV/YcR8xtLphFRJ17q9UDSfsYek5DNLn0Okni9BUGSoO/ssPZL1jsJF
         03YRDc5AgrIW2Psg5WChmJuCy7THMhZnSji0JDXN98Xb/CbD4+HIZEUzGMctk1APbRXX
         MHkPTRifZIGMHWp8iJklXVyUdF39KmAFGXpl8AWbEsB2da8etE+n1y9Smpc/20ZjIZuB
         rNizFWZxxVFGY1eBgdvQLF/vD5vxu3PeJlA8mpppyrSUjeEaEafucLKm2uwgMwbE01N3
         1egEylEegIaryPDL9dqnqA2htgJxguAhnoZBPYPr2jpnFFO5ChjaZG/g14IvjmfG6taK
         Tksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=l/vzKjiZoESwr/MGxPf83a+ulsl6r3WMfGbDQi8XZos=;
        b=GVTFyDcMaZUCN1reB3JBy/Ity9zM3Xfv2s4E5u8skOTek5rGXeZrQF6QwUkQbOmIra
         9N6rGWHIVGkr9qS60wv7+02cUrhxPv+arYTMeb9RCshPQUgMzc5k9shrB7kffGkmoFdb
         P4H7lQcFpy0dL4dgKPI2NZ8S2EdiG80Q5yUbIzgiEoRUJwSl3zWaAv9OLMAiWoH2CEEw
         /n9GDDoapMHOXMu8Cuq7OBLVDVumooOhPYKW70+JxTkDnF2F+92EHA/Z4UZCzjaH2NiX
         eriAIK3CYtgc/U011qpEtMP3uxEuDEZt1PvlGacA7PIjB4u+AEaDux2fLk1I7TdayjKk
         HuqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 4.15 024/122] parisc: Use cr16 interval timers unconditionally on qemu
Date: Wed,  7 Mar 2018 11:37:16 -0800
Message-Id: <20180307191732.804911620@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309081003158357?=
X-GMAIL-MSGID: =?utf-8?q?1594309081003158357?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit 5ffa8518851f1401817c15d2a7eecc0373c26ff9 upstream.

When running on qemu we know that the (emulated) cr16 cpu-internal
clocks are syncronized. So let's use them unconditionally on qemu.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # 4.14+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/include/asm/processor.h |    2 ++
 arch/parisc/kernel/time.c           |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -316,6 +316,8 @@ extern int _parisc_requires_coherency;
 #define parisc_requires_coherency()	(0)
 #endif
 
+extern int running_on_qemu;
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __ASM_PARISC_PROCESSOR_H */
--- a/arch/parisc/kernel/time.c
+++ b/arch/parisc/kernel/time.c
@@ -248,7 +248,7 @@ static int __init init_cr16_clocksource(
 	 * different sockets, so mark them unstable and lower rating on
 	 * multi-socket SMP systems.
 	 */
-	if (num_online_cpus() > 1) {
+	if (num_online_cpus() > 1 && !running_on_qemu) {
 		int cpu;
 		unsigned long cpu0_loc;
 		cpu0_loc = per_cpu(cpu_data, 0).cpu_loc;
