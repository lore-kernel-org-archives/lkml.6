Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs7WIth1QIsqbUAehoNoMYzNSHugwMX8is6UPlUkLxsWyRAlbY2KxhsYqkfw/2p3cNh7DeH
ARC-Seal: i=1; a=rsa-sha256; t=1521214409; cv=none;
        d=google.com; s=arc-20160816;
        b=EWwVN3y7qaVDR6ToKBEuj1Sfd9LjL3TJLRYJcgxwERTJdotLrdFo9sY2FFcYv8WlHR
         eZ6aoriUkZuibq1AE90chZurj1Siz40cuZ8nL5EIgST8l8uAFatLmg0MAuFflzJpl3xV
         HcokaywYzZ7ruO0sJKnKs2ceNiWBKiA4PA5SL9haP0nKpBcOA+GGc3Kx47HjFjkSjI92
         2eGwV1qvQFnWLUXVkalzGjj6IF0KrAb77dCqm6m9lv7iO0mRM+ewD7oP+R3Izfmk/Ju/
         CvYcOM1YTrwArYL9V2r87HjDNUUO2h2YW4mhKK7+nxbPkbf3E8xhbJUEdgPBCCx/ch2t
         0Jhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=A3E36YzjwoMCgLHS+JiIQnvKce+qnIbHMs/trqEeEns=;
        b=dyYCTiwDh90LzUNSbULEtvTOh2hko297W84gxrutOEjnFf/3dnRsMdEuaG9iG9z0Rv
         9bVZwNV29Ylczb2/50LdNAw3+hdpRKh0zTMeDAiIEagkn+28a7xUOdm2NHojo+TW9VMI
         zcpJJ2XZlvVAXsrot5CxSnKgHY7mKC47/2Ep4Z0XKcqCftSHIubfZJQjMP4eEkh0o/hO
         xGzjGykExp/cEHeQJ6x77DBAKh4d49qzX4Uj++QfcE1m/UnaprSEptQAaQv2jbbKrqhc
         +kKRSvvh5cndS6VIdMZEK19h5lK5uo+slc2DyJffFYfkNgNhy77z2oniWbmQtTnoDN4s
         vpfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jerry Hoemann <jerry.hoemann@hpe.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 4.9 48/86] watchdog: hpwdt: Check source of NMI
Date: Fri, 16 Mar 2018 16:23:11 +0100
Message-Id: <20180316152320.665528994@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108559670473312?=
X-GMAIL-MSGID: =?utf-8?q?1595108919998656087?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 
