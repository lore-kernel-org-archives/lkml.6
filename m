Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48XV8TOQLlOAoHeoJgD6RhawuBxcQ+vffhiPj2yA7C6HoQBG6MEQtQ+KAQv2cj9FqZhNKI6
ARC-Seal: i=1; a=rsa-sha256; t=1523472567; cv=none;
        d=google.com; s=arc-20160816;
        b=JzLIsFmcToFcbF0s9Tdek4nlJzKnpY5yoPgGqm7bQq0+DeOzBs7TfnKT5DPLTyGitN
         Up7ICPTo0DGVgmVg0ynEzFVDHVIrspy/0AeRqtEkBwME7JzDY8d+P4fks2Oyo+HAwXV+
         kooA77uasGs0QyKdXIpH+gBAKDLx786nNc0FWuc05a3VkoOxUj8S8dyM843BNAewlv85
         ks+f4VX4NSUe26R8l4IjS/NkEP4uktzMhVVv2v9+Jk7Sp5+84tHdJNDhV5Xn8S/k0lyP
         0p1BEBcWPsTbh3a616lS5vP7yr1ZFaq9sAAusl6VlXe7eons7teXd+n/PURg+5gQO5a5
         rAMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FUB+rVf0aEr7SpewCmPVmbJ7rbjYXQokWjXJofvQsQk=;
        b=zsFeuXG4GANhzInthkW7m401PcO5iILGZ5Fd5KDyxfsPYKDCEB9oF8ArErNWFTsrMa
         A2ZJ2pcoGZQgM609O9QRA9JyfSD9WaweG09+iLj+C0iMqWZFbWOOhVlB6dgefzgu7Egj
         DP8cMcGIj9bAF2JiNoqBpeN/Fhu4a6bqk/iIh7e2QCkXpYKLh1kSmw/rQ4vRaE1MF/6w
         5MH54b0iukZDmHg3iRoOX7vA996R/NUvpgsNAxBlymcc0f/WUdjkQXe5jwI8asPAoQ6X
         ELmehL8tswTmQmKKSOHrfVh3goG0ddiqiQbjjYj/NYSKJviELred889mqqxTSsSha2Ul
         VUEg==
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
Subject: [PATCH 4.4 131/190] MIPS: mm: fixed mappings: correct initialisation
Date: Wed, 11 Apr 2018 20:36:17 +0200
Message-Id: <20180411183559.893091735@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476257945153867?=
X-GMAIL-MSGID: =?utf-8?q?1597476770256551307?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
