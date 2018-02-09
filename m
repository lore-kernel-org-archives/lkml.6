Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1472218-1518185768-2-16358613700169035638
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
    t=1518185767; b=C1/i/gKtpkIQwgd6BmCSsU0XftwPYimybZMYCmcAKpdFbyj
    cT3RDvRLNk7jalSwt4aEyNB/1Fo/zcQUJFXSGnO2fpxm5ykIeXTrijo2p6BJbJJi
    pPRZ0DVQjIQWcmhclK9aQQWDxUkFuNtHMvEhRlYbxDuQmUghKZTqYs0k2skK5YAc
    U1B+nfHoiHkJ8kjiYJFUAwBwBdZceTqd/6mQmrB6qEIxcWKRwOjRuPtt/EXOAtuz
    tmG+PhZL0ya55Qd4K2tgQKWd6ofBXNu6ahglrlu3O4ghqz5PgUVPouRIjHw8B8h3
    +z91OH/IlSybvKuw8s3eZhEjPehDqbFy7FI8LzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185767; bh=ldry68c7hwOy/DD0jpgsZuAmET
    vz0YDuJKdRBuOP5Yg=; b=FbXIb8tHwEaX+Iq3zeULnMQXZxULArSD/xzPhoGWUe
    Rj24++660AlW/Yusg114xzxbUOXX7F8m+91hOI/x9tFaGzfi8u5/iuCpdpA98tBd
    eEBfZZnjeVzg9PYHQVmYF8q4+yQ4F3CfA3HJF9NsVNyA0GjshMUX5iDggOpyqJ8c
    x1RI3tMslytrHbP51MqLQwXXncJ9xYIwDxTeIFTOs2RRuZNvTzBqsJwX5X8Jr8Ml
    +e7vs8ZrI8HEXP/B2XajCDslFig2lqsKwoLi1rWhP8w7afU0oilWfVAy6xJbN9Oo
    H8fiU1rPcHu3rZ1ACgVTYjyYt4hljuk71l1BT/txuZiQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbeBINk5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:40:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48314 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752261AbeBINky (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:40:54 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 08/92] powerpc/pseries: Query hypervisor for RFI flush settings
Date: Fri,  9 Feb 2018 14:38:37 +0100
Message-Id: <20180209133931.874865385@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 arch/powerpc/platforms/pseries/setup.c |   35 +++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -450,6 +450,39 @@ static void __init find_and_init_phbs(vo
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
@@ -467,6 +500,8 @@ static void __init pSeries_setup_arch(vo
 
 	fwnmi_init();
 
+	pseries_setup_rfi_flush();
+
 	/* By default, only probe PCI (can be overridden by rtas_pci) */
 	pci_add_flags(PCI_PROBE_ONLY);
 
