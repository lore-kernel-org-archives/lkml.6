Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo0BhObx7vAjoSJu74BpduGZAHZEHuY5rlU7LbITFf54m1kzVhdQFM1scEFtsQd3iC0o4Pe
ARC-Seal: i=1; a=rsa-sha256; t=1524837775; cv=none;
        d=google.com; s=arc-20160816;
        b=hBGhtsPUSASMQoLnDbLvEpaSnaYbHLaVtk9KfveBZvi1ezc38YFnNXP+KVkMvPlnKn
         ii3p05ocz7D+hbCjj/9Xdo8ElQlaDgc23dJR7olLIbBqg5DLXYIMyZTQlMBucG+dB2tu
         k1q/8zZS0x56lnz7muN+dFvbJYkO3oLRW4Lr159nSxGSRI41ZIw5BXhUscsUL7w0WCDV
         4V4cB+ntm0BrdMbozmeCOYifwB9nUhnk2wxUx+HRqEIGj4/ZThO+Bid8X6D7uNaeYGCI
         AUInpbKG9xv0ynR6I80BnNPiz8skBHtvSiO/FOVzumpdA5AgZOyaSeNX94FELwhr8SCK
         d+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=ad8nTsbqwGkO3Ch7zisS4x0sAeXBnY8UuHfhXGhPCmM=;
        b=d3n0CpODxLY4GoTgKyHUEJZczd8h0YUMSUM3mDHi1Rtm5nJPtMXEbDSv/KeZQx1kFo
         32pun6db9ZJXBaKt4rZ3c3G18GnkWh6gnsO2rdsW83igykob5UtG7+pnhbLQ3ps8mPM9
         YhYBgnCFrlyFY2+Yxiix7IahV5L/1FdO3benW1Kv95gwJ/EIQogC2xACb1N++xtf/8hl
         1NX3R3DpnyytUpBJqKLpsBpiVKgst8NfsF4oSflmb5TeZJIC/QtnfQrRr0CZJci3DPwP
         0KMfbnMZwp4sYQK5n9jzWv9YHFyroBRxIYj5UrDlSFcXJ/czUnClVgcAqWOW7I9DLikA
         9N9w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B86218A0
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
Subject: [PATCH 4.9 02/74] x86/tsc: Prevent 32bit truncation in calc_hpet_ref()
Date: Fri, 27 Apr 2018 15:57:52 +0200
Message-Id: <20180427135709.998099721@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908113837378273?=
X-GMAIL-MSGID: =?utf-8?q?1598908295371872983?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -409,7 +409,7 @@ static unsigned long calc_hpet_ref(u64 d
 	hpet2 -= hpet1;
 	tmp = ((u64)hpet2 * hpet_readl(HPET_PERIOD));
 	do_div(tmp, 1000000);
-	do_div(deltatsc, tmp);
+	deltatsc = div64_u64(deltatsc, tmp);
 
 	return (unsigned long) deltatsc;
 }
