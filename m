Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELueldtVEjUR1n1LCjVpp7dfb+LDCR+n9lAfR28O5ShVxGHdZEiSRhD/rqwA/Xw0eafIdlNM
ARC-Seal: i=1; a=rsa-sha256; t=1521214222; cv=none;
        d=google.com; s=arc-20160816;
        b=vj8m6tNPsdzBs24eTeN4UVXuLd2gDvlnHzFmTqdlNSsYEIT9m3cd0yH8lW0yRPNjoQ
         +tFhQRA4W3zP5wkfNvNB+btZi1T9ej5nKBKjz4NfGWx7Xq79+E0K4aa/Xbe0slBL5Nzc
         A1wx4qJX1mEwFV91yf/MJ6q6VZGfrKag20h525K0XlgDkz5caP1aKAQ/g1jNRKbpmLxt
         /gdVznz+gxCTyNh/kLR/UKYyxj1NTwc/TEHybFifaLnOqNpnwjR1mFOzoNWDJ6cF4ccY
         /+5HEErJDoIGxwwGoBnR93RXhvX1gmWKiN8u0fHdK0S5pir0KBXFH+P4Tto8wMnNbWVg
         wjTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Z3GVr2i4nKrTAmZ5vbRyN6wIAMLhXmHlqx0okn19jUQ=;
        b=PNU5+H4JBUcYoXNw7+60p1qcpmVq0/3b6KXYaNs/mvrC8EKRu5irX7t+AgEC7US6M6
         Wga16qLiKwgklndtmh6hS5T5eOWiW6O1Zgxvc2txljE4wQJYK4xraO1XDTIE6Bj8gLvR
         49IcycB6PSHt5pW0K7KfCzF+sYyRWWBS6Z10MTNJlbmu7+WWVD9PRsOP9bQVGshFlzzu
         4A6BJBHHZDlorS23QnQWuTn/cp0mKotjwI3VzKk8/95sf/4tQMOtWNYkRglDFnWyB7Iu
         Uzb3t+KSToxmiHIvclkfEvHbJD0spjzvwEjelnVMveB1H9284kDd0tg+IJtI/ERXFEYl
         RbiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>,
	David Daney <david.daney@cavium.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"Steven J. Hill" <Steven.Hill@cavium.com>,
	linux-mips@linux-mips.org,
	James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.9 19/86] MIPS: OCTEON: irq: Check for null return on kzalloc allocation
Date: Fri, 16 Mar 2018 16:22:42 +0100
Message-Id: <20180316152318.629554982@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108602604550470?=
X-GMAIL-MSGID: =?utf-8?q?1595108724606543322?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit 902f4d067a50ccf645a58dd5fb1d113b6e0f9b5b upstream.

The allocation of host_data is not null checked, leading to a null
pointer dereference if the allocation fails. Fix this by adding a null
check and return with -ENOMEM.

Fixes: 64b139f97c01 ("MIPS: OCTEON: irq: add CIB and other fixes")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: David Daney <david.daney@cavium.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: "Steven J. Hill" <Steven.Hill@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.0+
Patchwork: https://patchwork.linux-mips.org/patch/18658/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/cavium-octeon/octeon-irq.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -2277,6 +2277,8 @@ static int __init octeon_irq_init_cib(st
 	}
 
 	host_data = kzalloc(sizeof(*host_data), GFP_KERNEL);
+	if (!host_data)
+		return -ENOMEM;
 	raw_spin_lock_init(&host_data->lock);
 
 	addr = of_get_address(ciu_node, 0, NULL, NULL);
