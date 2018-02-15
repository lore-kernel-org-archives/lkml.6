Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2260JDtYgdr1Loz8s+ITYzIwb8R2uH+rItaazLXL628hO9kAPfB+rdMOUBTqaGAlnNvGjeCP
ARC-Seal: i=1; a=rsa-sha256; t=1518707998; cv=none;
        d=google.com; s=arc-20160816;
        b=plAC0mzGTIaCYcRp5YI0ygIH2d0iNPxISdrz4mYiWs7p46H3l7/QekXDetmK3fMN35
         ubmBL9F1BzuH7OPYhtWZaBb5z7lHFTxcqT6Ul+WdAQIDtnEVqAkZBE2oCJ8Kxp7Yg91q
         4492xQkWKnIJ+wrPKS12nhIc8AyY2EqjSjJsgE92FIRzncUkranR0zEDtqQrcHum3Z2S
         pZcBBB7jIUeNrvqylB5DFoLE3eBlhfWuofCeggWiC5eHgaUMurYQN4KPTczG0lmedIQb
         zyV3UZ4OV3vKTknTKMXca3hnvgFEnN5g+fk7rAZ5azhXp1efCQE8brm3BeFka3Sp+QNI
         GF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eMO4mlxeHE3+PY8aQL0tTXVfU8dKv0M1Z62z4pfM+fk=;
        b=Xuu5xqm45mdRak+hzpuppt/0Z3Wti63VQeHzbf9UOCIaB6miIrQ7iHkMjyKbmCouoC
         NmSr4grWxmw8bCPzoLcVBYyL/LDlYZWmjh9Yn8+/jp71SGHEUUYfeCPLd/Fh/pvuD+8w
         RblNCNGiPPGv+CqzW+e8B2uPh6nd3TrKob6beKt5EdyH7mWlhKKYg8ErXwYLSdVvwALz
         6fFR2B81yRW4OdYUiGGUbEcgUn9pIvTY3S/Q2NPyHW3YwvMn387ePPTVdsOpMnhd0lln
         B27jQm+UML03upIAnUsVzEIMUDDqkLLmbNjHG44nIOsEP7KDIdJ8b+oMO/qvi6eebXau
         gFsA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	Paul Mundt <lethal@linux-sh.org>,
	linux-sh@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 3.18 38/45] signal/sh: Ensure si_signo is initialized in do_divide_error
Date: Thu, 15 Feb 2018 16:17:29 +0100
Message-Id: <20180215144124.021242790@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480758766631562?=
X-GMAIL-MSGID: =?utf-8?q?1592480758766631562?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric W. Biederman <ebiederm@xmission.com>

commit 0e88bb002a9b2ee8cc3cc9478ce2dc126f849696 upstream.

Set si_signo.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
Fixes: 0983b31849bb ("sh: Wire up division and address error exceptions on SH-2A.")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/sh/kernel/traps_32.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -607,7 +607,8 @@ asmlinkage void do_divide_error(unsigned
 		break;
 	}
 
-	force_sig_info(SIGFPE, &info, current);
+	info.si_signo = SIGFPE;
+	force_sig_info(info.si_signo, &info, current);
 }
 #endif
 
