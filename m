Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtuhfeV+12/q0BKYyh/rrVh5DKxdOUA34b8+PQLiVx4AD/rQ2qV1pLngHIZOKZocDVqqZjr
ARC-Seal: i=1; a=rsa-sha256; t=1519676206; cv=none;
        d=google.com; s=arc-20160816;
        b=P5FyvwjOJ71QO7P9QUzAd9CLVTLzd25o5GMljs5C5MZo48pnFLQ2dTcLgseLpOw6d0
         GPKWVdTCVuGM/jOz4HpYSVgIYv4SamAIkbsc0rhqDXeTQ3j/oYUjQH4I21Lmfgvk2BZi
         BTEKGr8Xmwuvi3HVdB3OxmbcCTKkhMahU4m+M+2LajgSrNlCvbofX36N7HALtX5l1HQ0
         1y3vGrihFr8j3blE2xy0ruY1byJnHxYN3oUm1ZQ6X/OsFhVevEssqtcyLWTS1F+rIy5o
         lHkwwuAg/5ClTY7ZsljI7guXdsVwzIZdU3ztcitW39mOJLgc2J5TiozDl/tTCSOM8lMM
         rN9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ai8tdKpH+KnPvg6WRsvvgsI7mcGfkaJ4KtfGzOuUAkE=;
        b=G6CVXnSQjIz12x2sv7mCK6vHTeokOTgRdvlBPAy9NW0+qZBWW1+9FipV9Ec5LKwahm
         vnreLFZuKy2COUF9AL1Q5QDRhE3ag6w5RzhkVWBXLAu9GDzeXkyckGhl2IMFrfwlBMeT
         jqtv02b2GHxu60cZHnQHoEAsqC4uRCeDuaQwpiERik+L7NjJ5Jkvzof8igl/s0sbbTB4
         +nxvcv4yn95fq4ciF213wcQuiHNPGIEFxbgzJ7VnrZXRuc7tYd6xQ27zLTWWCDo+x8Ko
         muaiENK1qHXeTA4pHuuHdvLQ+8SX4ZHCRvZmNoiL9Nz76584RVXoJJ9ocra+Xwl7osoj
         0+9g==
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
Subject: [PATCH 4.4 14/22] arm64: Disable unhandled signal log messages by default
Date: Mon, 26 Feb 2018 21:16:14 +0100
Message-Id: <20180226201559.356670419@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201558.681421374@linuxfoundation.org>
References: <20180226201558.681421374@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495943344886080?=
X-GMAIL-MSGID: =?utf-8?q?1593495997623501497?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -49,7 +49,7 @@ static const char *handler[]= {
 	"Error"
 };
 
-int show_unhandled_signals = 1;
+int show_unhandled_signals = 0;
 
 /*
  * Dump out the contents of some memory nicely...
