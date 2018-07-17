Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD35ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9AC2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NTXbPzt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9AC2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbeGQVNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:13:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeGQVNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RT9m9Jo/4f2z1JheJt0va8jBUyLU1K3xlQqo3pocaRo=; b=NTXbPzt/QX+r833Ap6UR4ycoY
        qooR9pt2aQ86f+q1EwGUxJOET271mcHWLqhfauG+jro/fmRLuefATOUNK0ijmOB3HIgnoTCSTHdkI
        wblUUtG73mq3tg3A1DogSRv5rP+HgSBtsJX0m0+LIqt6rltOXF8ZN9Dt7SRnP33nktmhyrU9TWmOA
        OLNxrYNLU4EB7VGUQhIgeIkgxhMpHo5PD2aYKdtdLPmD2nFpyK2g7nFzcNtVvJdakjR1i67cfBqYg
        k3udd3vJddI9BsI3ct/hgS7h8snAjuc2Dx9KJ/q058zxtjZBC1+qN3q8l9a61BwgFhnNdGe8FOSAk
        8WYpaQMVg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffWkO-0000Bq-Ld; Tue, 17 Jul 2018 20:39:00 +0000
Date:   Tue, 17 Jul 2018 13:39:00 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Martin Mares <mj@ucw.cz>, Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: lspci: Display path to device
Message-ID: <20180717203900.GA1771@bombadil.infradead.org>
References: <20180717170204.30470-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717170204.30470-1-logang@deltatee.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 11:02:00AM -0600, Logan Gunthorpe wrote:
> The second patch expands the new helper to optionally take a path of
> PCI devfns. This is to address Alex's renumbering concern when using
> simple bus-devfns. The implementation is essentially how he described it and
> similar to the Intel VT-d spec (Section 8.3.1).

I don't like telling the user to grovel around lspci -t by hand.  It's
not many lines of code to add a new -P option to lspci to show the path
to each device instead of bus:dev.fn

Here's three examples, first without, then with -P.

(my laptop):
6d:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM961/PM961
00:1d.0/00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM961/PM961

(tests/PCI-X-bridges-and-domains):
0002:42:00.0 Ethernet controller: Trident Microsystems 4DWave DX (rev 26)
0002:00:02.4/01.0/00.0 Ethernet controller: Trident Microsystems 4DWave DX (rev 26)

(my Nehalem system):
04:00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic SAS2008 PCI-Express Fusion-MPT SAS-2 [Falcon] (rev 02)
00:03.0/00.0/00.0/00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic SAS2008 PCI-Express Fusion-MPT SAS-2 [Falcon] (rev 02)

The Nehalem system makes an interesting testcase because it exposes some
registers in fake PCIe devices that aren't behind the root ports.  eg:

ff:06.3 Host bridge: Intel Corporation Xeon 5500/Core i7 Integrated Memory Controller Channel 2 Thermal Control Registers (rev 04)

Martin, what do you think to this patch?  Also, I'm happy to send you
the lspci -xxxx from the Nehalem system to add to tests/

diff --git a/lspci.c b/lspci.c
index 3bf1925..ae0fdd2 100644
--- a/lspci.c
+++ b/lspci.c
@@ -19,6 +19,7 @@ int verbose;				/* Show detailed information */
 static int opt_hex;			/* Show contents of config space as hexadecimal numbers */
 struct pci_filter filter;		/* Device filter */
 static int opt_tree;			/* Show bus tree */
+static int opt_path;			/* Show bridge path */
 static int opt_machine;			/* Generate machine-readable output */
 static int opt_map_mode;		/* Bus mapping mode enabled */
 static int opt_domains;			/* Show domain numbers (0=disabled, 1=auto-detected, 2=requested) */
@@ -29,7 +30,7 @@ char *opt_pcimap;			/* Override path to Linux modules.pcimap */
 
 const char program_name[] = "lspci";
 
-static char options[] = "nvbxs:d:ti:mgp:qkMDQ" GENERIC_OPTIONS ;
+static char options[] = "nvbxs:d:tPi:mgp:qkMDQ" GENERIC_OPTIONS ;
 
 static char help_msg[] =
 "Usage: lspci [<switches>]\n"
@@ -247,6 +248,34 @@ sort_them(void)
 
 /*** Normal output ***/
 
+static void
+show_slot_path(struct pci_dev *p)
+{
+  struct pci_dev *d = NULL;
+
+  if (opt_path && p->bus)
+    {
+      for (d = p->access->devices; d; d = d->next) {
+	if (d->hdrtype == -1)
+	  d->hdrtype = pci_read_byte(d, PCI_HEADER_TYPE) & 0x7f;
+	if (d->hdrtype != PCI_HEADER_TYPE_BRIDGE &&
+	    d->hdrtype != PCI_HEADER_TYPE_CARDBUS)
+	  continue;
+	if (pci_read_byte(d, PCI_SECONDARY_BUS) > p->bus)
+	  continue;
+	if (pci_read_byte(d, PCI_SUBORDINATE_BUS) < p->bus)
+	  continue;
+	show_slot_path(d);
+	break;
+      }
+    }
+
+  if (d)
+    printf("/%02x.%d", p->dev, p->func);
+  else
+    printf("%02x:%02x.%d", p->bus, p->dev, p->func);
+}
+
 static void
 show_slot_name(struct device *d)
 {
@@ -254,7 +283,7 @@ show_slot_name(struct device *d)
 
   if (!opt_machine ? opt_domains : (p->domain || opt_domains >= 2))
     printf("%04x:", p->domain);
-  printf("%02x:%02x.%d", p->bus, p->dev, p->func);
+  show_slot_path(p);
 }
 
 void
@@ -989,6 +1018,9 @@ main(int argc, char **argv)
       case 'x':
 	opt_hex++;
 	break;
+      case 'P':
+	opt_path++;
+	break;
       case 't':
 	opt_tree++;
 	break;
diff --git a/lspci.man b/lspci.man
index 35b3620..565dd5b 100644
--- a/lspci.man
+++ b/lspci.man
@@ -95,6 +95,9 @@ PCI bus instead of as seen by the kernel.
 .B -D
 Always show PCI domain numbers. By default, lspci suppresses them on machines which
 have only domain 0.
+.TP
+.B -P
+Name PCI devices by path through each bridge, instead of by bus number.
 
 .SS Options to control resolving ID's to names
 .TP
