Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq4/qPTqErSR1/2Y2Gka2H0YjWUDz6jOBtQ+qY+NdgF78BzzdAdMInSnAXGKLReaSXwvFYg
ARC-Seal: i=1; a=rsa-sha256; t=1524837602; cv=none;
        d=google.com; s=arc-20160816;
        b=qnEaAAYWwrC0rBLUTahsjD5CQNRBqWxRSUc3SnBnO++qOVwkZcwi2bpYiBoyHw4gYi
         hKwMgQATlmX+sd10L1pK1nxtCbtlBP/+qVzrXy3OyUgGAgFbRuOmkiFLZyzmDnwu+Njr
         o7bNflfqvihAAc7ojOH4WJA5nQljxNfgKUIg8Rb0QQMM5LBFqUU3fxSI0qeh9NXTPrSj
         NekJ7XxccyAEVtgkxbOwDPKSOnIgOX6MpYvUXl5/mNH4nMiJkmnW2R1hDABMRYXan3Bo
         OVQG0pqENoQqeF8KmkGEmzWQQs3xhCrU47dpiq/TRDlCBGTh9Cp8Q6PDP4jqjBLEppdt
         lx3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Y1H+Y/153Ihm0f4JRCLcfaPUywyhKAaVODFbsbW0ke0=;
        b=J8OjibZHg67swcabfjtYlu9gvMlGIR5gP85Kjx1pwgXGKG7aUMdKDDgqahrHnJaDCh
         BPS/eymk6mAmmg2nVvOdUdxLiBuVREcmAV9uOiuuyTOnMv1NDh60VWxWPkAufA/I2WTu
         KEKnkcrc9UxKXC1esAFgjRJH5fCO0xTTdGjqap828eGdZ5V9TYBOh3Ewpe6QbA56guEj
         Pr03a/Uqj7PANqzV3F2RmneCQcOr+RfuK4BCczLVfzscvwWGSWKBKPuJpPewL22BBVRd
         4dSn+SUirPqgMi2l9EJiOc8YqbpPzLU3itRnvuSQku0JV4gkb2FOnMGQYq6fHZRIjDuq
         Rb1g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801BF21837
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
Subject: [PATCH 3.18 02/24] x86/tsc: Prevent 32bit truncation in calc_hpet_ref()
Date: Fri, 27 Apr 2018 15:57:37 +0200
Message-Id: <20180427135631.684181554@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
References: <20180427135631.584839868@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908113837378273?=
X-GMAIL-MSGID: =?utf-8?q?1598908113837378273?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -399,7 +399,7 @@ static unsigned long calc_hpet_ref(u64 d
 	hpet2 -= hpet1;
 	tmp = ((u64)hpet2 * hpet_readl(HPET_PERIOD));
 	do_div(tmp, 1000000);
-	do_div(deltatsc, tmp);
+	deltatsc = div64_u64(deltatsc, tmp);
 
 	return (unsigned long) deltatsc;
 }
