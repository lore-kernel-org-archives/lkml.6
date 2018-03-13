Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtip9Bmm8he9U3a84L+WFn2yHNJ8mV8KKhczpAzwPyG0mOMzBKRSKs8IWIz8oGqVCxSqf4v
ARC-Seal: i=1; a=rsa-sha256; t=1520955223; cv=none;
        d=google.com; s=arc-20160816;
        b=P4QEEsi6yH6PI5eEJgNr2NKpQAiPxPOM5YHnhK49I4zVmCUclhk3MZCQtbu1nHj76M
         6+F39QBY0OcZ8KngWvT+R7GyXjnYf2h6Lyl3UCFTUhjpa1gQW2wGcstT/Lga4BJyQsqg
         LkxU+JS4uRVQKvp3aDOQpPwLw8Wt8s7mBHruz+da9x8HyHQGjYgVhtnr8AHuMoVIvY04
         tBGOEML9uy4S76gltG4hbxsx6CMNUIi4eWDHygkheCxtmCYyScDktOgsCdwbwgo8qWre
         BF5X4enYfSKAuYV4UgD+kRJ617UoQvPV2FUG7YQMnEXcUcWtHtZb/q9Gz54OyqwqJnkZ
         dXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EohaFwRcw2i6Snyg/c6EBHjMhy8XjkwcZELeJm0EafI=;
        b=WWbVbvN+N65/3NrZBLDqHBicdcTu3gqZaS5dAfuCiMf9FVg8N3pWKYBzDXkz1Y6mMC
         RP6ya8GNnBNp2xZwe1Vioe0r9BAcsGv7+lQl4uPBYeZfGKPBNcwKfD5UujXEqoLJmCyD
         EMVO8ZYM/1HDsUvR9QFf9Fo1j/Y2bTRspsDwMWagT06IsGDHpTV+fgKwWazDu/5NRelf
         0CyLlBDTxCtgEG1AAuOxcAcy6P5UR1H0Li9eXwfD0oHQx0MtZrBu8yNQMcLP5kh0pojF
         aC5/eETk0DHMXJyiEoslDv6wgWbNAQLUKJ8CbId24QF7SfB3a7HQs8JOhEVjr4dHcxgz
         sFsw==
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
Subject: [PATCH 4.15 105/146] watchdog: hpwdt: Check source of NMI
Date: Tue, 13 Mar 2018 16:24:32 +0100
Message-Id: <20180313152328.544025086@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837144430189035?=
X-GMAIL-MSGID: =?utf-8?q?1594837144430189035?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
