Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELueeGRw7CT34mNMcxGI60d5hZJe/Tzv1Om+43ZAo2J7gT8kQ1eFaDpP0xUCN37ntzXFwPLq
ARC-Seal: i=1; a=rsa-sha256; t=1520452095; cv=none;
        d=google.com; s=arc-20160816;
        b=GwwhJMzrfVk3oJPFsfF9jLlic+GSni9BKeCzYaRZcDc5j9V/RLr0PY/35atpRboZon
         lPvRxd0T+XOq3sTAwmxiia7D6GucedX6Kp8ASE7oZWE2ZnP4CGzTjptZ8rBTLafWykgH
         AUiFCJdS33jmPqHIKTyLdSUfaq2oIgeXiRPNt9mJHdOW4Hj7LxHQCADlGE1cklhYpMZP
         /FEq3JngldIVFQJKXUlRXxXKL2iGeH/1uRqT8q97k8mIS15ngg7URWQDKo5CiSTB/mrf
         UStpFGbPj54pL3cINn2al211wYo9UTMzhIyALoLzQXNJgQCuzxsgjOTRoT44wb/FGB5t
         3ntA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QZpZKk0KJhqikY5ByRXDrEAFFc1i/2+3FLKeqsPJ1B4=;
        b=jsKgQgsrJ/AKeI9IRF03MMDj5WWMxy1lNfleR1NHpmYVGTIMvvpKIuDaCS1iOzNSoY
         BFSfGaNsGYRdN0/ByNE06XxTrmoawVHSrbbshXoHEShRrpwoVaEQpAV//PHv0GqFhq2x
         k+sK4Ex8oWvTm1+ckHhSfLabNoe+2ptD6CW5mJ2LpYhdDpqp3u1owgxhoPiFdbmZn320
         O8g0eRYr8JMYpxb3pdRkCb1YrOXZUp60wBKJY/1BotK6nFNYmgRM7hi+5YlOg6S9cmE/
         Y3smT85kbIl5fFzMGLswxsAI/vxaP2LRfy4fCCjHsfLXuQn0wEf1gxs/PNfNGzTxLJ9g
         ynMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan Beulich <jbeulich@suse.com>,
	Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 091/110] x86/mm: Fix {pmd,pud}_{set,clear}_flags()
Date: Wed,  7 Mar 2018 11:39:14 -0800
Message-Id: <20180307191051.497470724@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309285828589431?=
X-GMAIL-MSGID: =?utf-8?q?1594309576256186534?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Beulich <JBeulich@suse.com>

commit 842cef9113c2120f74f645111ded1e020193d84c upstream.

Just like pte_{set,clear}_flags() their PMD and PUD counterparts should
not do any address translation. This was outright wrong under Xen
(causing a dead boot with no useful output on "suitable" systems), and
produced needlessly more complicated code (even if just slightly) when
paravirt was enabled.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/5A8AF1BB02000078001A91C3@prv-mh.provo.novell.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/pgtable.h       |    8 ++++----
 arch/x86/include/asm/pgtable_types.h |   10 ++++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -350,14 +350,14 @@ static inline pmd_t pmd_set_flags(pmd_t
 {
 	pmdval_t v = native_pmd_val(pmd);
 
-	return __pmd(v | set);
+	return native_make_pmd(v | set);
 }
 
 static inline pmd_t pmd_clear_flags(pmd_t pmd, pmdval_t clear)
 {
 	pmdval_t v = native_pmd_val(pmd);
 
-	return __pmd(v & ~clear);
+	return native_make_pmd(v & ~clear);
 }
 
 static inline pmd_t pmd_mkold(pmd_t pmd)
@@ -409,14 +409,14 @@ static inline pud_t pud_set_flags(pud_t
 {
 	pudval_t v = native_pud_val(pud);
 
-	return __pud(v | set);
+	return native_make_pud(v | set);
 }
 
 static inline pud_t pud_clear_flags(pud_t pud, pudval_t clear)
 {
 	pudval_t v = native_pud_val(pud);
 
-	return __pud(v & ~clear);
+	return native_make_pud(v & ~clear);
 }
 
 static inline pud_t pud_mkold(pud_t pud)
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -323,6 +323,11 @@ static inline pudval_t native_pud_val(pu
 #else
 #include <asm-generic/pgtable-nopud.h>
 
+static inline pud_t native_make_pud(pudval_t val)
+{
+	return (pud_t) { .p4d.pgd = native_make_pgd(val) };
+}
+
 static inline pudval_t native_pud_val(pud_t pud)
 {
 	return native_pgd_val(pud.p4d.pgd);
@@ -344,6 +349,11 @@ static inline pmdval_t native_pmd_val(pm
 #else
 #include <asm-generic/pgtable-nopmd.h>
 
+static inline pmd_t native_make_pmd(pmdval_t val)
+{
+	return (pmd_t) { .pud.p4d.pgd = native_make_pgd(val) };
+}
+
 static inline pmdval_t native_pmd_val(pmd_t pmd)
 {
 	return native_pgd_val(pmd.pud.p4d.pgd);
