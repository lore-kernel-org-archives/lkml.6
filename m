Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoweEuBjXfikEK+cobZlZWbAEartFmcXdslnwDm3s5wrjvGQ6FmvVS9PF5K8W11x9ngV29l
ARC-Seal: i=1; a=rsa-sha256; t=1524837638; cv=none;
        d=google.com; s=arc-20160816;
        b=lKkkrPZY7kIo9HtIZ1EXm5ozfuKgS60XORttu+JXoAUSc2kk03F/rwqV3icE/9SXmc
         BW1ZUeebq5dJwVkV4j8CH7p0Ik/ZBmAOMRi2OTjP81HrNkIP/s6nKUEScjyUvEIRcP/O
         KY0wpHFVA6SRk0mlxw8dRyqntgDGOTu8Q7Chbb+lprDahp/PmGy7zEsqyi2GrTStumne
         7+O+KN5mKIhGImXnb/PlOUh894DlnDn8Jq0g7/qZPgHBHWAGY3j7HgyMlo4ja5/J3J34
         wlwW88Vhv3tmB0PIxltWtvdllTLZe2goOhDHkwIEh+A+y4ixnbqo5d/1+b6Rk4Xav7kE
         /ErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=EzWiRHQcKIwT/XuSTbb38cE1y0A6UpeRuZye1yG1tjI=;
        b=kefastLIKqFyBsEfGq9NBYsE6HJZRjNPh1FJZD3Ei6uSEIKAQgza++lYcZe+8+oR9S
         qH9oTeY1aTTZv2zVqmsLfIc2MDKkC/1eO3idwvN9SmWfBZSJLiZbfzBAVgtAbFBJNus0
         rMj2pK0tVQJp9rAgSHtfb2ErEpIFOYybSyrblzIrVQIL+oi59PtXwMHugwYnKzuql9hd
         DlPm1lcnW1dBCJLrtD0/W6ZvnZpcEo/CoV0GnWfh/7TcPecdIoTZQh3j+g76vFgwDHPp
         Z9n9AmbhSAhwTdUgLKKrZ8taha0oPb1d/2+T3Ur0zuUKdSR0JVb8XpovauRX7I56tOrJ
         vo8w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD4321897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xiaoming Gao <newtongao@tencent.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	peterz@infradead.org,
	hpa@zytor.com
Subject: [PATCH 4.4 02/50] x86/tsc: Prevent 32bit truncation in calc_hpet_ref()
Date: Fri, 27 Apr 2018 15:58:04 +0200
Message-Id: <20180427135655.769458519@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908113837378273?=
X-GMAIL-MSGID: =?utf-8?q?1598908151679119687?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -408,7 +408,7 @@ static unsigned long calc_hpet_ref(u64 d
 	hpet2 -= hpet1;
 	tmp = ((u64)hpet2 * hpet_readl(HPET_PERIOD));
 	do_div(tmp, 1000000);
-	do_div(deltatsc, tmp);
+	deltatsc = div64_u64(deltatsc, tmp);
 
 	return (unsigned long) deltatsc;
 }
