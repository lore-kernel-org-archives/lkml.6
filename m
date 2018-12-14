Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514C5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B942080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BU7/GzGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbeLNWWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:22:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48718 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbeLNWWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:22:45 -0500
Received: from zn.tnic (p200300EC2BCFEF00117646AD7F85DA05.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:ef00:1176:46ad:7f85:da05])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8961F1EC06E5;
        Fri, 14 Dec 2018 23:22:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544826163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=twhJYydhv0l2xNNnFanMZqK8fN8CSK2XkVlPidB2xdo=;
        b=BU7/GzGdnAAn4wzQlFDh5VbQGaBnS0nGpFSKXJeHDh1qtWtinZvXhQRFxy2XbRZo+ppiry
        4QhCBUFxIG9eIhRLNi1/jW23xWOk/RO3E0lS6m36sN/SIT6tGr7YpNdgz5AXkzn8agLypH
        4wkRapt7raStYpRM7xjk6wtU3WpqJ9k=
Date:   Fri, 14 Dec 2018 23:22:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Schoebel-Theuer <tst@schoebel-theuer.de>
Cc:     linux-kernel@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] acpi / apei: fix NULL deref during init
Message-ID: <20181214222236.GK11710@zn.tnic>
References: <20181214181514.29891-1-tst@schoebel-theuer.de>
 <20181214202406.GI11710@zn.tnic>
 <c8d62037-4a26-e18b-51a3-73fc99e76e5b@schoebel-theuer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c8d62037-4a26-e18b-51a3-73fc99e76e5b@schoebel-theuer.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 10:27:25PM +0100, Thomas Schoebel-Theuer wrote:
> please take a look at the stacktrace. For some reason, and only at that
> specific hardware, the condition is false, there but later the indicated
> error exit is taken whose message you can see immediately before the stack
> trace.

Yes, but if you say "for some reason", then we still don't know what
the root cause is. So before we do any fixing, let's find out what the
problem is first.

Can you pls run this debugging hunk ontop of -rc6, on the box and send
me full dmesg? Privately is fine too.

Thx.

---
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 7389db538c30..5166639b7280 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -667,6 +667,9 @@ void __init pci_mmcfg_early_init(void)
 			acpi_sfi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
 		__pci_mmcfg_init(1);
 
+		pr_info("%s: setting apei filter\n", __func__);
+		dump_stack();
+
 		set_apei_filter();
 	}
 }
diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index da370e1d31f4..e87b183ca73d 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -494,6 +494,9 @@ int apei_resources_request(struct apei_resources *resources,
 	if (rc)
 		goto nvs_res_fini;
 
+	pr_info("%s: 1, arch_apei_filter_addr: 0x%px\n",
+		__func__, arch_apei_filter_addr);
+
 	if (arch_apei_filter_addr) {
 		apei_resources_init(&arch_res);
 		rc = apei_get_arch_resources(&arch_res);
@@ -552,6 +555,9 @@ int apei_resources_request(struct apei_resources *resources,
 		release_mem_region(res->start, res->end - res->start);
 	}
 arch_res_fini:
+	pr_info("%s: arch_res_fini, arch_apei_filter_addr: 0x%px\n",
+		__func__, arch_apei_filter_addr);
+
 	if (arch_apei_filter_addr)
 		apei_resources_fini(&arch_res);
 nvs_res_fini:

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
