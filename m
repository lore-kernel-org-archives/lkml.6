Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoNpij/W1eiHMr9IWBvpmS1Xd1s7lGKURqZuBr+1naIeNci6kh7sSNOZWjrLNQI1uHa7ouu
ARC-Seal: i=1; a=rsa-sha256; t=1526937864; cv=none;
        d=google.com; s=arc-20160816;
        b=twdaUE344V5AhOHdMQ3/kPbZPffSDDcPfZP/yxQkdq8tJ2epCcLWKpCKU3XiztHhd0
         oBc7gWQBZJDmDnQkN3DpdSGWKtYuSjR4qjPaTNoZ9Jarvhb/La8K7kCTqkKw58ELDfoa
         KtQBGvTJUN9BJd7D4NnL544duDpNYf4/5WxoNhtOJLaeJUjZMWUuM5K0MhgVNyJg0ttb
         rGlqnVV4aOwGq84D2DwPIjSTIMmEtLHqXMDbzw08iR51SGMsvVi23xPgkAvi1ybZFKAR
         4IuNX+quzvOfifKZYR/e2LhKyI/3PKw0lGwrSHBqYBGHZSesU7jeEPmv//Ziqms2gtvB
         kBFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=WkbeheK6R0/WTnlf1hTdjev+eWZQNby88WyzgGNxXjY=;
        b=MYHHtKun4W7JlhdCPH0zOP9dcABHP6p1uX/HRe08qcvzYSl/3Wqui/p6LSBZQENLRr
         9kW1qrcY4610DBZ0RlCedH0lbclaoLFOOwY11lHQihrBg026tWdHGRmCFHbYa0aoSvH8
         eHwmc+fdOBm1ounDKr0GK5GfLDCKYpwS3a54UirY74P8MaQrwsjWX1+kQBBI6IBtF5Wc
         C1Q4GxGODyjmT0RSU/Cz1Jx34G5PeHn+DqvKHSsKX2MQu15V4LPvYLrDEqF/BVzspPtj
         Jz8jNZetlNc6FGn/JptTQW1GyYh0g+z4tTb3UVJnLq6MytiSMb9dzJJEFxvqhyZU32bY
         BwNg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Co33qg4Y;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Co33qg4Y;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4.16 053/110] ARM: 8770/1: kprobes: Prohibit probing on optimized_callback
Date: Mon, 21 May 2018 23:11:50 +0200
Message-Id: <20180521210510.067746444@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109801592715270?=
X-GMAIL-MSGID: =?utf-8?q?1601110398388823631?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 70948c05fdde0aac32f9667856a88725c192fa40 upstream.

Prohibit probing on optimized_callback() because
it is called from kprobes itself. If we put a kprobes
on it, that will cause a recursive call loop.
Mark it NOKPROBE_SYMBOL.

Fixes: 0dc016dbd820 ("ARM: kprobes: enable OPTPROBES for ARM 32")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/probes/kprobes/opt-arm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -192,6 +192,7 @@ optimized_callback(struct optimized_kpro
 
 	local_irq_restore(flags);
 }
+NOKPROBE_SYMBOL(optimized_callback)
 
 int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *orig)
 {
