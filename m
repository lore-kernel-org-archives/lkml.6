Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2179907-1518720352-2-7151274674617405637
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720351; b=Cx0ylStFiaCtAe3snINKra1x9/KOOcrxluimDCoOvOP2ZOE
    LHgzmL23GgS++t9b1ILTVGBJSPJZsEncoKEGZoJ/kHDPfFMSo9vy09NCafbXc0G/
    mUtIgZAq4Q30Vfzzq1I4GYstctfk2w1Z+lL4lnmJyLZxKfiv5EvYP3Qg0ef3i+Z2
    NidXy0ceBqJopK/BoXUQV1zGyg1mXv7C8trzWedkcFImxAgkhtVjtHKeD879EaKg
    KddcENxT+bJHM7G6ZFm8Dj13ICPKFa3Ty146lEXAdiKmKGjo56z6iiyAtV0yuvTY
    4zJAs33bul4+TxF34naFQM92aGdHysl8C6+nzrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720351; bh=PKMSvQ6UD9enXgLyfhppuqLG/A
    KV4XN9AoC6uYGmokE=; b=MPl7ZG77pzqjA4nWNj+mBaxWo+tFG7CrBnyFm57eWj
    N+VZRU2xBmExzqeUWdXC0KW7fDdACjhRrHc8BZremSwnYSBqPevPedVLa8aiE29p
    P5j1IYPr84tLhD5y1nZSmcorqQQub+fFODysQPhLMkJi7wHJ9AaJ599tA26IQe5M
    ntqHBz76MoGfsdQU3nIkBy6xfEJVibp7O0rYiQAJs6jP8u7exSOOvwrKlBKEv4PE
    I/RXyUPtQr566EXC85z/f0D2M4JZA28AmpvhgSG3AdmDUJF5DahP7j7/7WAnikUk
    2YzaSWEQV2TKv5ll6fu7E/dP54snex2Dn9U7WN9QuxxQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162606AbeBOSph (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:45:37 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50288 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162468AbeBOPWx (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:22:53 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 013/108] powerpc/pseries: Query hypervisor for RFI flush settings
Date: Thu, 15 Feb 2018 16:16:10 +0100
Message-Id: <20180215151224.307039604@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Neuling <mikey@neuling.org>

commit 8989d56878a7735dfdb234707a2fee6faf631085 upstream.

A new hypervisor call is available which tells the guest settings
related to the RFI flush. Use it to query the appropriate flush
instruction(s), and whether the flush is required.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/powerpc/platforms/pseries/setup.c |   37 ++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -499,6 +499,39 @@ static void __init find_and_init_phbs(vo
 	of_pci_check_probe_only();
 }
 
+static void pseries_setup_rfi_flush(void)
+{
+	struct h_cpu_char_result result;
+	enum l1d_flush_type types;
+	bool enable;
+	long rc;
+
+	/* Enable by default */
+	enable = true;
+
+	rc = plpar_get_cpu_characteristics(&result);
+	if (rc == H_SUCCESS) {
+		types = L1D_FLUSH_NONE;
+
+		if (result.character & H_CPU_CHAR_L1D_FLUSH_TRIG2)
+			types |= L1D_FLUSH_MTTRIG;
+		if (result.character & H_CPU_CHAR_L1D_FLUSH_ORI30)
+			types |= L1D_FLUSH_ORI;
+
+		/* Use fallback if nothing set in hcall */
+		if (types == L1D_FLUSH_NONE)
+			types = L1D_FLUSH_FALLBACK;
+
+		if (!(result.behaviour & H_CPU_BEHAV_L1D_FLUSH_PR))
+			enable = false;
+	} else {
+		/* Default to fallback if case hcall is not available */
+		types = L1D_FLUSH_FALLBACK;
+	}
+
+	setup_rfi_flush(types, enable);
+}
+
 static void __init pSeries_setup_arch(void)
 {
 	set_arch_panic_timeout(10, ARCH_PANIC_TIMEOUT);
@@ -515,7 +548,9 @@ static void __init pSeries_setup_arch(vo
 
 	fwnmi_init();
 
-	/* By default, only probe PCI (can be overriden by rtas_pci) */
+	pseries_setup_rfi_flush();
+
+	/* By default, only probe PCI (can be overridden by rtas_pci) */
 	pci_add_flags(PCI_PROBE_ONLY);
 
 	/* Find and initialize PCI host bridges */
