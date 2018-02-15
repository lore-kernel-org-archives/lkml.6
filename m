Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224pzQ35tA823QDdFnI5ac8QoyX4ehfLbFl0rtvsM7m8jMO6WnvQU0bz8yrSVD2pgPFHscVw
ARC-Seal: i=1; a=rsa-sha256; t=1518709118; cv=none;
        d=google.com; s=arc-20160816;
        b=DOdZbVTm7r093cRcLBE10lD7415ypCB0TM8rkFYYjI6kkFMNsST/bHfTdU3RBYkNAx
         81+lGhbVmqftpLkZPgWDtxhKwRCVWB2a82EzKrflBcYLxErFgoDg1GQ6CqamWaWI3FnE
         BhnMpvAfsEoLNLvpNExIhL7X2D6bWqnrt61K4j1i1Wju32I7Rxcale6Y6bAQnHzN/Nrt
         Tw2wv/K20qwAGNj7whiWBbqpQat3giajMGSctBXgt430m78TwQiZMl3hVdNhi3BqBpSg
         lo+mvH1hrJf+lzJA7SxtEhPriKMK5PKaEy0B3FeF3AjdVdCJZRd+/YGPsUVDxdmz1++d
         YImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CWGayyDgTResX+vr5DavRNCP5TQ55m3f4X2riU7jXlQ=;
        b=ld3LAeho7D0fkj/nYWD+eGZXULv1R//wPT+OlARRMRUYyijN1Aga1+0a4tnBvmAvkb
         510hAtX6R9LDU8g6TRGGOE6L0kBYL/4OnrFsObcbV+chtgmKfA8Y0woYAO3zQ9wgSadc
         cqeyImppEZIB1vcXUtpMUE1I62A86xurlIz1pqrMhzpKsXR1DBV1Lliihpw5IkwbAijw
         OWkj2FplzGgWRKkOLBoqcI7vpPbPYhGnoOueTNR3GciOGVUTmfiz+6376s9x3vpJxlgy
         ApU+3WPcVrrfEAY1KkH7nqoNxGNs3TTvmZobGGz3Pr/DTFBIbsHRKbQLlDN150zqFBE3
         Jtvw==
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
Subject: [PATCH 4.14 163/195] signal/sh: Ensure si_signo is initialized in do_divide_error
Date: Thu, 15 Feb 2018 16:17:34 +0100
Message-Id: <20180215151714.112990371@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480758766631562?=
X-GMAIL-MSGID: =?utf-8?q?1592481932100659028?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -609,7 +609,8 @@ asmlinkage void do_divide_error(unsigned
 		break;
 	}
 
-	force_sig_info(SIGFPE, &info, current);
+	info.si_signo = SIGFPE;
+	force_sig_info(info.si_signo, &info, current);
 }
 #endif
 
