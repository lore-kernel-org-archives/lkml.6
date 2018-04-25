Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49IG9WRxgWIQ/7lPFd4lqkL+7fBSJsJlGKJ9AT/eEUQYkNuuuv+oL8cpjzEYTy2aSIN6uqt
ARC-Seal: i=1; a=rsa-sha256; t=1524652676; cv=none;
        d=google.com; s=arc-20160816;
        b=xSVnSnytSTLJFY44DTQyoURbqIsbgJLiF0zrrUKkcpp4+5CFlUS4vJGCAZxVda75p0
         o5lKSPb+LQR1MnYQ29U/BiLxxUTpjUIeWb76lDkfkT5jIc+3J+66WzvdvZdkLqGtQic7
         U0uEb1RR6F1SmdQSSRLBsXq8uSK7sXXVhnHAWlfLgoXOu7LrOMYuLG5P96EFFhVSfzbt
         t+nmaA+Z8fXdMKBNNpQi2k/qqgROBpce3mugtdY+R5IVNrInyYIVKQk5OmnwvVFkYYDW
         BdaY8vqpatPWsVAlisoKCD4bPCqQRmIf8wS23H/kIiX519dgBK7lBBVKXxWsR7oN9eTW
         etfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NPnhIHT4yXgqCOr4H2/zUqleeYAINfJ6H9ryAnk0+L4=;
        b=Krdwh2DcMm9DggHRY0/I0wW+iUmAE6fFtlo/QX9lQRJDFMliK+YjRas9gOHVi3uDS3
         oO5RJ2VUpPcNx39DF2v3X4vvSiJKdd2b62GDNwco80fDDSziSgrB4dzPtGGsxWYezDkL
         sdvqtmzayLOKEQqgz98o5rXeMwUegQYBP/gdRc5bq3e+7qE3O3MPbfuh7L3YZma98JTr
         44K+wC1RkecSma0PQpvFHCC7n3Xdk8YYklK6cW6lWJwfQcytXxjGmuuHSHvr1KDtoLyB
         JqEMHl+T8kiZ+iz3Sd31LmccrZVZgFoZOt/cpxM2kkL6pwtjHN8hX1NpzuSNYnVFgXE7
         /FOg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xiaoming Gao <newtongao@tencent.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	peterz@infradead.org,
	hpa@zytor.com
Subject: [PATCH 4.14 005/183] x86/tsc: Prevent 32bit truncation in calc_hpet_ref()
Date: Wed, 25 Apr 2018 12:33:45 +0200
Message-Id: <20180425103242.822858601@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714017581239687?=
X-GMAIL-MSGID: =?utf-8?q?1598714205078002778?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiaoming Gao <gxm.linux.kernel@gmail.com>

commit d3878e164dcd3925a237a20e879432400e369172 upstream.

The TSC calibration code uses HPET as reference. The conversion normalizes
the delta of two HPET timestamps:

    hpetref = ((tshpet1 - tshpet2) * HPET_PERIOD) / 1e6

and then divides the normalized delta of the corresponding TSC timestamps
by the result to calulate the TSC frequency.

    tscfreq = ((tstsc1 - tstsc2 ) * 1e6) / hpetref

This uses do_div() which takes an u32 as the divisor, which worked so far
because the HPET frequency was low enough that 'hpetref' never exceeded
32bit.

On Skylake machines the HPET frequency increased so 'hpetref' can exceed
32bit. do_div() truncates the divisor, which causes the calibration to
fail.

Use div64_u64() to avoid the problem.

[ tglx: Fixes whitespace mangled patch and rewrote changelog ]

Signed-off-by: Xiaoming Gao <newtongao@tencent.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: peterz@infradead.org
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/38894564-4fc9-b8ec-353f-de702839e44e@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/tsc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -316,7 +316,7 @@ static unsigned long calc_hpet_ref(u64 d
 	hpet2 -= hpet1;
 	tmp = ((u64)hpet2 * hpet_readl(HPET_PERIOD));
 	do_div(tmp, 1000000);
-	do_div(deltatsc, tmp);
+	deltatsc = div64_u64(deltatsc, tmp);
 
 	return (unsigned long) deltatsc;
 }
