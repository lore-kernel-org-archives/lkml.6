Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtDm+TEN7qakYI1uSswCcHdraNrGlfClc4yzZTEksjQb07wFH8L0fU+tZsAsCH84Om2In7e
ARC-Seal: i=1; a=rsa-sha256; t=1519676488; cv=none;
        d=google.com; s=arc-20160816;
        b=vnLytS6gPRcQ61/JQm096qiKkAzAcmNQOCGtuyFioP7eNOjloCyFffNdPoMP9AHClZ
         ST2jWsUFDcFWdsEB24AHcInGVGk99c2zM16u3UIVEMO4yh83AJOywVXe5sDRuna7YNGo
         E98ljfVK9eBGcvv9sa6k2bsIsvpkyk9iurC7zTQK6MpHp1B0/eCVWHFo2OemOYukJMeI
         2H2UsLSCOkVJOqlLQrsRZcbjyg+HKWY3lHvi+OfQsRynw8bPbZzuKCXD0IQTV6C/sk+d
         x1+QwpUgdVzhS5PvsTCZsSAHDUwjmFM/7Dk9sZtZJ1u2fNiyb6IzPsJa+iQjLRd5hDa3
         /Cog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/QB82oLoZFAWMiPh+eiU2NKbfgr0lHGNuXMvusdLGg0=;
        b=yiPrFqfU/WJl1Q0cm2Du/5p0iVwHX65NAvJ+eW2Ze2RL4lvYyt4QSpDu9FXz7Cy9NR
         0FF978X8qxQ62irn7zWDHcXHWG1CQe4ZRmReKmpP8XojjRbToJh8oHbbjhz6oxj9s+KN
         39t3sNbKH7Np223sB1j19yHSENDHK7dg8dBD0yP0RYZ/f7nwWUGhNGzIzdM7WGLX84sp
         WRt028Ey7d78SIcGiVTgR3XR7lGIpbRXhkTaa+EPclcssf1FN5t+VyNUd1JkaipaCQjI
         rkJDsDiLbz+hkYDaQoPCTHjHHqoNKQipWpEthHkYMrhKkGnTtvZ3wp7rzgieCX+zQGHj
         IRvQ==
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
Subject: [PATCH 4.9 15/39] arm64: Disable unhandled signal log messages by default
Date: Mon, 26 Feb 2018 21:20:36 +0100
Message-Id: <20180226201644.357861004@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495943344886080?=
X-GMAIL-MSGID: =?utf-8?q?1593496293856113882?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -50,7 +50,7 @@ static const char *handler[]= {
 	"Error"
 };
 
-int show_unhandled_signals = 1;
+int show_unhandled_signals = 0;
 
 /*
  * Dump out the contents of some kernel memory nicely...
