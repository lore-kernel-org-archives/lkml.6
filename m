Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49Em0pND9jk7gxPagPZWpOnWwgl0rrFMM9lrtwYwv5cO0wsFVScn8nXU6iuXhXLQLS/JnzT
ARC-Seal: i=1; a=rsa-sha256; t=1522168641; cv=none;
        d=google.com; s=arc-20160816;
        b=HeFr/3lwkHPBkVuqxN62l1nzqrJDYAK8hquY9Lv+n7YovbCykXCODv49umhFBD/6X9
         FfI8OGweJvSfJY034SelNsJrpH/Juw8hmJK+U+9VO/L7vCHRTAycqPOkqoPSV7N1mj1q
         bpWFEAD50pOp/ELPyz5pfk1A7utQkf8FJ5uacLgaRe5XYetBPX3pEnjGIKB3zikxjas9
         O4WtZ7JFsdbwBoPSx39CK6coQ2jYmRjTT6sQ6h487OBQjeuFTBWNJrxHT/JAj5+y1TLu
         V8f95r8g8InfdujuQ/vYqcvblEqpe8ZpDUC5cX52iVVWcCof9QyD08v4vcB2pjOrPG+7
         iDiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bZuCrGXJYE/SwwMhcna5pQHeR85Ahx7vPV6tHIKILvc=;
        b=SrH7V//6/+6GuLLh/A4ldXjVPXZjSX9vvbvv1h4v6P7FwHHiL/kIuLQsCCtKEVtZLJ
         yHYayU9dbrKAfEZKbOct8BhI0LVRj2HczBBpjfKJH1fZFVGoBiquoGt/FFDqJ7dRC8A3
         IOQ2UEiATbtRm9ji5PjIDWzPQn62UEkoabWXZoqx7YKNl0yeD9P6mW9LVvErNR0dgA3L
         Ak7Mm5Giyrv/SrwgJNOWxv2j/Ei5vfFkf1gmryaQuTbHs/kW+O0O8bfKazjrPh04dt36
         X6zmuOAyerGj4KsjwhkAimts31qVMXfRO83UXHktyy6DdA6ZzwuFkHv6RY6GLEAX92mh
         gmLw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 080/101] x86/vsyscall/64: Use proper accessor to update P4D entry
Date: Tue, 27 Mar 2018 18:27:52 +0200
Message-Id: <20180327162754.977527036@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109505147946951?=
X-GMAIL-MSGID: =?utf-8?q?1596109505147946951?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Ostrovsky <boris.ostrovsky@oracle.com>

commit 31ad7f8e7dc94d3b85ccf9b6141ce6dfd35a1781 upstream.

Writing to it directly does not work for Xen PV guests.

Fixes: 49275fef986a ("x86/vsyscall/64: Explicitly set _PAGE_USER in the pagetable hierarchy")
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180319143154.3742-1-boris.ostrovsky@oracle.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/vsyscall/vsyscall_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -355,7 +355,7 @@ void __init set_vsyscall_pgtable_user_bi
 	set_pgd(pgd, __pgd(pgd_val(*pgd) | _PAGE_USER));
 	p4d = p4d_offset(pgd, VSYSCALL_ADDR);
 #if CONFIG_PGTABLE_LEVELS >= 5
-	p4d->p4d |= _PAGE_USER;
+	set_p4d(p4d, __p4d(p4d_val(*p4d) | _PAGE_USER));
 #endif
 	pud = pud_offset(p4d, VSYSCALL_ADDR);
 	set_pud(pud, __pud(pud_val(*pud) | _PAGE_USER));
