Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48auQmToS8wMN3FhFBUKLkdwWSTCMku9zSnlot3UOjWaE+u80u9MazHLJMjX8bCFiP6943m
ARC-Seal: i=1; a=rsa-sha256; t=1523473450; cv=none;
        d=google.com; s=arc-20160816;
        b=oQHqn4orZ28ex3942CdP1tqSdhYoU/bDL+LVex+NxmgY0iJZ3Op5vs1yOSHZXnP1Yq
         3uVp4cIRdhDXInm5/VlPpCynbzyVCygmZoTQXLBsGTIzKHOUlyNCel918MDe6ktwIEPa
         QLdQZBk4fWQW8Fmr7pVphUKbnbUgeH6CsegZy8FbdARhO1e/lAhc4ep0yWgUhhZ2962A
         Bz0V3SGQ1mBIDKqJiIcuoFi9OLtcTHZgIwaLHpvOYn9FZIQX9N774EMi/alTEdZyJR5i
         eONEldPa4wV9GpcEvc6fziM3MExNe2DFjGHHmJxb9kaQySDD1z5Pwf/03d2UL/ZiC6yp
         2Xsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3BfR8bPdlwarG22d+ysi4bTBXQY9VuyFf3nbFdcJ9+0=;
        b=aldllXAaMGWa6A1iLTmjHndUxdWRb6UgiP74xEA9ENmg5TWu5EwCFRdivp/Ri4AKkZ
         S/4KB2B8UJfc3ydI6E4Wu+UPCQkp8d595+R7WOrSUZ+EhguGo2bS2EWMB9vhdBqaFVq8
         tv6vitug9FQ+yxIxZ3pmfWquMjotBIjaHqOP1cxq5PlPCM6aQ5mMoYlX6Pg1/dwZ0v/y
         e+rG8hDRwiOqNc0Q8a5Wd3JF/2xlMvIqcfkCJ+UB9qBvvvgSacM6/4mr6wv6/FASoy2c
         8S2fv20658MhL7jYkXQIxlV2H6y/jz8CRr+wLlZ6Sluw3qQnEboRTNrS1pHB+455/o9t
         yUCg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
	linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 218/310] MIPS: mm: fixed mappings: correct initialisation
Date: Wed, 11 Apr 2018 20:35:57 +0200
Message-Id: <20180411183631.932894172@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476257945153867?=
X-GMAIL-MSGID: =?utf-8?q?1597477697001727300?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>


[ Upstream commit 71eb989ab5a110df8bcbb9609bacde73feacbedd ]

fixrange_init operates at PMD-granularity and expects the addresses to
be PMD-size aligned, but currently that might not be the case for
PKMAP_BASE unless it is defined properly, so ensure a correct alignment
is used before passing the address to fixrange_init.

fixed mappings: only align the start address that is passed to
fixrange_init rather than the value before adding the size, as we may
end up with uninitialised upper part of the range.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15948/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/mm/pgtable-32.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/mips/mm/pgtable-32.c
+++ b/arch/mips/mm/pgtable-32.c
@@ -51,15 +51,15 @@ void __init pagetable_init(void)
 	/*
 	 * Fixed mappings:
 	 */
-	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
-	fixrange_init(vaddr, vaddr + FIXADDR_SIZE, pgd_base);
+	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1);
+	fixrange_init(vaddr & PMD_MASK, vaddr + FIXADDR_SIZE, pgd_base);
 
 #ifdef CONFIG_HIGHMEM
 	/*
 	 * Permanent kmaps:
 	 */
 	vaddr = PKMAP_BASE;
-	fixrange_init(vaddr, vaddr + PAGE_SIZE*LAST_PKMAP, pgd_base);
+	fixrange_init(vaddr & PMD_MASK, vaddr + PAGE_SIZE*LAST_PKMAP, pgd_base);
 
 	pgd = swapper_pg_dir + __pgd_offset(vaddr);
 	pud = pud_offset(pgd, vaddr);
