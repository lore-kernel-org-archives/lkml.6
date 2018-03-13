Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvHNrUN30WG0W0nN1V3YSA6kpccfXH5dC50/Qz3p9WwGNc67KNVknkW1R92rfoBRldsv2Ju
ARC-Seal: i=1; a=rsa-sha256; t=1520955301; cv=none;
        d=google.com; s=arc-20160816;
        b=yN5pwF896cSizrRb2RG5HoekV0ftPUwTcUzSN9VqU/fOZr2rT3u3rAD04qXXq8aGiF
         G6i2gviDqGeXqHRCWf2phg9neJJsyXQJKB4gXw2Y5Fw8DiZ7TO752j0uirqKWJlH4vD5
         OnHBjNaUb96GCiiGNtxvW/s9tI7+3Ogbx5QVR9Ik9cRtrO5xxopNaY6c/HS4XIJec8SF
         GDlZemZTi5+EuuOpba36gLjWI2FwzysAxUHT8HHWMHG93QZymAu6rXkjr9MM6BXmH9WN
         jwvPEYYusD5K+DaklefVjY3vWVH6eCQ7oO1vggISoc0KWFWhs6NmAU91bGUe4h4bOXc8
         l/Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7GVLwkBoBQvsqqw3nAk6UKRSkpB6+OGLB/eSxtj56TM=;
        b=MdGq/1gbKY3zIysG9Gi34SeF/KfG4Y7gWAtTXkcqEd7sk697fc1Vi4XVDJAuVTLVfw
         HzTMjH3D7WKCI6ct7ZeZOkLJN/GM4qfV390ngl7CxMkM3EU7qRY6FiGR4QlYcxioaIUL
         Cfaoqj0+Ycexz6aKR0GskxykzUMhVEoBpFD3hDi2OZ1SQufCMP6BZdfWbg3bqBVpC8KR
         D7YL1NwFizqH3RuM/JcAQjZ4Xjab5KYFdfXaZ3UmUt8tH7rq6e3slEx1WAAvCLO3jzDd
         E1vqW3q+zvWgJGCxeX83MFPJQyyRCSmtCKvmSttSJZ1n/R8YYYHj8oa9Lc2O+Aal6rUR
         OmfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jerry Hoemann <jerry.hoemann@hpe.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 4.14 003/140] watchdog: hpwdt: Check source of NMI
Date: Tue, 13 Mar 2018 16:23:26 +0100
Message-Id: <20180313152458.412390605@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837144430189035?=
X-GMAIL-MSGID: =?utf-8?q?1594837225758555251?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerry Hoemann <jerry.hoemann@hpe.com>

commit 838534e50e2e5c1e644e30ab6cb28da88eb31368 upstream.

Do not claim the NMI (i.e. return NMI_DONE) if the source of
the NMI isn't the iLO watchdog or debug.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/watchdog/hpwdt.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -52,6 +52,7 @@ static char expect_release;
 static unsigned long hpwdt_is_open;
 
 static void __iomem *pci_mem_addr;		/* the PCI-memory address */
+static unsigned long __iomem *hpwdt_nmistat;
 static unsigned long __iomem *hpwdt_timer_reg;
 static unsigned long __iomem *hpwdt_timer_con;
 
@@ -474,6 +475,11 @@ static int hpwdt_time_left(void)
 	return TICKS_TO_SECS(ioread16(hpwdt_timer_reg));
 }
 
+static int hpwdt_my_nmi(void)
+{
+	return ioread8(hpwdt_nmistat) & 0x6;
+}
+
 #ifdef CONFIG_HPWDT_NMI_DECODING
 /*
  *	NMI Handler
@@ -486,6 +492,9 @@ static int hpwdt_pretimeout(unsigned int
 	if (!hpwdt_nmi_decoding)
 		return NMI_DONE;
 
+	if ((ulReason == NMI_UNKNOWN) && !hpwdt_my_nmi())
+		return NMI_DONE;
+
 	spin_lock_irqsave(&rom_lock, rom_pl);
 	if (!die_nmi_called && !is_icru && !is_uefi)
 		asminline_call(&cmn_regs, cru_rom_addr);
@@ -842,6 +851,7 @@ static int hpwdt_init_one(struct pci_dev
 		retval = -ENOMEM;
 		goto error_pci_iomap;
 	}
+	hpwdt_nmistat	= pci_mem_addr + 0x6e;
 	hpwdt_timer_reg = pci_mem_addr + 0x70;
 	hpwdt_timer_con = pci_mem_addr + 0x72;
 
