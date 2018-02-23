Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs/ZATqz75KBraio2JC0M11xDWAcudbQPMmCXWh01x4fScQ1CvXBauaM0WpLqCa0k31RVmT
ARC-Seal: i=1; a=rsa-sha256; t=1519411176; cv=none;
        d=google.com; s=arc-20160816;
        b=IOdOCOYZ8iDKnXHCBLORwizyGC1hN1/JtPncbBUbHSE6aRZbGfaGSULPqDmX5LNM4R
         HuWcw/uEAV1Bc72oLzR7PIsVFg5OHqw3u7SmCIB/ZziJxDzozZ/HJz/pVeHJsggRn6D4
         WH0ogBvTk8KBmBul7eQKgpuvtLHuZUL+juhiXeKFbPVKoPoG9y8X3wKmI8XgksRR/iIW
         nEaVLn9keYRUZQdx8YGFYs5teA3oboEy+ivXhSpltcKNFg43UYO2Ae5G+iJx0qwF8vpX
         I5EDaw+EuIyRig6eJCB6OxT7MGRmsscTRcUXuKw29h3+zBRATTVw8ChGbOnFyQuxYMfX
         F20Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fcHJQDfNeQAw3PcTB+fGNhL0pSYoznIEy3JoO98a7pw=;
        b=FmsnDFBEXpP+BFvwN9j+mBdh098u0SGG9kquYJBwY9XeFmFZqOK2j+rqfvcvJYBG1n
         Y/tx82Gdk7feiXgpuOHifOXitMrohnRKf6xZRDGxrlIEP8jVkFD3qv6ZKFxkX0VbBZqG
         1nyQu00nT8OthkC6RoTb146IfRau+l0sxTdzK8+FLNlHKSP2xswxdEG5VeinlA/hhnbZ
         d2Pp+zQrit8GCFzS6UgN0VPuW5yK8dm98iebNgl4fzLbksfAdoEMWoZFbe/jFyPliqT5
         GtShWE2+TxvEooI9/wA/OjNWymC1Rh7bhPyppc+XH/g6F7RI2QTmltpu0rAfZ23SpxGO
         m9Dw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 146/193] net: hp100: remove unnecessary #ifdefs
Date: Fri, 23 Feb 2018 19:26:19 +0100
Message-Id: <20180223170348.766554154@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218094535087014?=
X-GMAIL-MSGID: =?utf-8?q?1593218094535087014?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 747a11279a442b913a57bf38934879babab3b58b upstream.

Building the hp100 ethernet driver causes warnings when both the PCI
and EISA drivers are disabled:

ethernet/hp/hp100.c: In function 'hp100_module_init':
ethernet/hp/hp100.c:3047:2: warning: label 'out3' defined but not used [-Wunused-label]
ethernet/hp/hp100.c: At top level:
ethernet/hp/hp100.c:2828:13: warning: 'cleanup_dev' defined but not used [-Wunused-function]

We can easily avoid the warnings and make the driver look slightly
nicer by removing the #ifdefs that check for the CONFIG_PCI and
CONFIG_EISA, as all the registration functions are designed to
have no effect when the buses are disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/hp/hp100.c |   18 ------------------
 1 file changed, 18 deletions(-)

--- a/drivers/net/ethernet/hp/hp100.c
+++ b/drivers/net/ethernet/hp/hp100.c
@@ -194,7 +194,6 @@ static const char *hp100_isa_tbl[] = {
 };
 #endif
 
-#ifdef CONFIG_EISA
 static struct eisa_device_id hp100_eisa_tbl[] = {
 	{ "HWPF180" }, /* HP J2577 rev A */
 	{ "HWP1920" }, /* HP 27248B */
@@ -205,9 +204,7 @@ static struct eisa_device_id hp100_eisa_
 	{ "" }	       /* Mandatory final entry ! */
 };
 MODULE_DEVICE_TABLE(eisa, hp100_eisa_tbl);
-#endif
 
-#ifdef CONFIG_PCI
 static const struct pci_device_id hp100_pci_tbl[] = {
 	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_J2585A, PCI_ANY_ID, PCI_ANY_ID,},
 	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_J2585B, PCI_ANY_ID, PCI_ANY_ID,},
@@ -219,7 +216,6 @@ static const struct pci_device_id hp100_
 	{}			/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(pci, hp100_pci_tbl);
-#endif
 
 static int hp100_rx_ratio = HP100_DEFAULT_RX_RATIO;
 static int hp100_priority_tx = HP100_DEFAULT_PRIORITY_TX;
@@ -2842,7 +2838,6 @@ static void cleanup_dev(struct net_devic
 	free_netdev(d);
 }
 
-#ifdef CONFIG_EISA
 static int hp100_eisa_probe(struct device *gendev)
 {
 	struct net_device *dev = alloc_etherdev(sizeof(struct hp100_private));
@@ -2884,9 +2879,7 @@ static struct eisa_driver hp100_eisa_dri
 		.remove  = hp100_eisa_remove,
         }
 };
-#endif
 
-#ifdef CONFIG_PCI
 static int hp100_pci_probe(struct pci_dev *pdev,
 			   const struct pci_device_id *ent)
 {
@@ -2955,7 +2948,6 @@ static struct pci_driver hp100_pci_drive
 	.probe		= hp100_pci_probe,
 	.remove		= hp100_pci_remove,
 };
-#endif
 
 /*
  *  module section
@@ -3032,23 +3024,17 @@ static int __init hp100_module_init(void
 	err = hp100_isa_init();
 	if (err && err != -ENODEV)
 		goto out;
-#ifdef CONFIG_EISA
 	err = eisa_driver_register(&hp100_eisa_driver);
 	if (err && err != -ENODEV)
 		goto out2;
-#endif
-#ifdef CONFIG_PCI
 	err = pci_register_driver(&hp100_pci_driver);
 	if (err && err != -ENODEV)
 		goto out3;
-#endif
  out:
 	return err;
  out3:
-#ifdef CONFIG_EISA
 	eisa_driver_unregister (&hp100_eisa_driver);
  out2:
-#endif
 	hp100_isa_cleanup();
 	goto out;
 }
@@ -3057,12 +3043,8 @@ static int __init hp100_module_init(void
 static void __exit hp100_module_exit(void)
 {
 	hp100_isa_cleanup();
-#ifdef CONFIG_EISA
 	eisa_driver_unregister (&hp100_eisa_driver);
-#endif
-#ifdef CONFIG_PCI
 	pci_unregister_driver (&hp100_pci_driver);
-#endif
 }
 
 module_init(hp100_module_init)
