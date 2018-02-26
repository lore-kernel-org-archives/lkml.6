Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuIvG0X8b0H2ywzX8PbIru5XUlp/wz+JFRI84phUWRMJ8kQ2UEyAiVB0+0/m9EdhoojFHSd
ARC-Seal: i=1; a=rsa-sha256; t=1519676761; cv=none;
        d=google.com; s=arc-20160816;
        b=L0FtQr8hYglx8ojA8SsaeQ8kKJ42qCkYVJ4VFu8g5itoB7EJ3B7Ja4bDxeglxeveiC
         D+NFlToCbT6/g7Sfzz63uwDl7YgUQ1avSSplFPSeVVgHMrJrYjbqP8amh90v9Ez6r7Dv
         Lp5qZ4Eox6zcWmL3WkvBsYLbzUNEV5KXw13/0TVzKH/dqs+GgXZfkftjhbU8yi9uj47z
         aPV0/SXjRgOld7kVMWVB2aQaWQv4ZiokkzqflyVOcbZUA7GKWxaQkBP022EosMmXxgsI
         H5EY8iC4EVX0HvuEwwVs+0eijgaVBuMxwfvkipCq0WimmREFKqic8+/zs1tux/3SzY3m
         CCNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TDypZqpluCxqUM7XgU2OLUjVDwIuiEpGfLt+cCIr5kg=;
        b=QYidw6bjU5TfqbJ6De1jjHHXuw/t6QtkRwZETaW425jzN6eGya7+iYrPRcrm9XRB+5
         3M1wCANB18MbMZ+d0bSqdbTyz5GLE7bFAPLIbN9mqWZJnmD3oYLyjWVGVYzpgAaXpY5T
         QFBkU+er5JGSLB15D+ThEY5OeM6adxsuWIeEkj4RfSXRq7707trjSWWOz1OuPLBvgN0X
         3OyVxPavKtiYU7ZZ1n6Dxv/EqwSrTICN6hdLvFZBSYHtwONVsWioZ4Nmh2Wm6vSVDpNo
         BpV2f8ZvkcQ9UW/sXhSDyd3dUDt6/cV1s+LG5UcMA6dVLeyelwoAdR+0y9MJhnB3aVfm
         GjMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Weiser <michael.weiser@gmx.de>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.14 34/54] arm64: Disable unhandled signal log messages by default
Date: Mon, 26 Feb 2018 21:22:11 +0100
Message-Id: <20180226202146.085107460@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495943344886080?=
X-GMAIL-MSGID: =?utf-8?q?1593496579206251669?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Weiser <michael.weiser@gmx.de>

commit 5ee39a71fd89ab7240c5339d04161c44a8e03269 upstream.

aarch64 unhandled signal kernel messages are very verbose, suggesting
them to be more of a debugging aid:

sigsegv[33]: unhandled level 2 translation fault (11) at 0x00000000, esr
0x92000046, in sigsegv[400000+71000]
CPU: 1 PID: 33 Comm: sigsegv Tainted: G        W        4.15.0-rc3+ #3
Hardware name: linux,dummy-virt (DT)
pstate: 60000000 (nZCv daif -PAN -UAO)
pc : 0x4003f4
lr : 0x4006bc
sp : 0000fffffe94a060
x29: 0000fffffe94a070 x28: 0000000000000000
x27: 0000000000000000 x26: 0000000000000000
x25: 0000000000000000 x24: 00000000004001b0
x23: 0000000000486ac8 x22: 00000000004001c8
x21: 0000000000000000 x20: 0000000000400be8
x19: 0000000000400b30 x18: 0000000000484728
x17: 000000000865ffc8 x16: 000000000000270f
x15: 00000000000000b0 x14: 0000000000000002
x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: 0008000020008008
x9 : 000000000000000f x8 : ffffffffffffffff
x7 : 0004000000000000 x6 : ffffffffffffffff
x5 : 0000000000000000 x4 : 0000000000000000
x3 : 00000000004003e4 x2 : 0000fffffe94a1e8
x1 : 000000000000000a x0 : 0000000000000000

Disable them by default, so they can be enabled using
/proc/sys/debug/exception-trace.

Cc: <stable@vger.kernel.org>
Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/traps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -56,7 +56,7 @@ static const char *handler[]= {
 	"Error"
 };
 
-int show_unhandled_signals = 1;
+int show_unhandled_signals = 0;
 
 /*
  * Dump out the contents of some kernel memory nicely...
