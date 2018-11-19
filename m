Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7ACC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65B520870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRvrgPQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65B520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbeKTC6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:58:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730491AbeKTC6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:58:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8260C2086A;
        Mon, 19 Nov 2018 16:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645242;
        bh=ejxoV0wPQfnhrdNHuJrizZZuTIp6MXZa2wSMFnduVLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nRvrgPQSZUXumXwdo97UAjRajik05fDDKJV+UzdBVWdHd2uESt5wkWbBWJXpAEnYQ
         FRYf5DZLOcgkBKb/uB3pUV2afTj9iBSuKZGh4GQRN8p+Yd3xhit8gk15xnr30QNlIw
         fNa8dQVoy6GRD1hkbRirtRUHOlPK2wthkhRGZ22I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Avelar <omar.avelar@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Borislav Petkov <bp@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, elliott@hpe.com,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-edac <linux-edac@vger.kernel.org>,
        linux-nvdimm@lists.01.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ross Zwisler <zwisler@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 4.19 090/205] acpi/nfit, x86/mce: Handle only uncorrectable machine checks
Date:   Mon, 19 Nov 2018 17:26:37 +0100
Message-Id: <20181119162632.099116739@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vishal Verma <vishal.l.verma@intel.com>

commit 5d96c9342c23ee1d084802dcf064caa67ecaa45b upstream.

The MCE handler for nfit devices is called for memory errors on a
Non-Volatile DIMM and adds the error location to a 'badblocks' list.
This list is used by the various NVDIMM drivers to avoid consuming known
poison locations during IO.

The MCE handler gets called for both corrected and uncorrectable errors.
Until now, both kinds of errors have been added to the badblocks list.
However, corrected memory errors indicate that the problem has already
been fixed by hardware, and the resulting interrupt is merely a
notification to Linux.

As far as future accesses to that location are concerned, it is
perfectly fine to use, and thus doesn't need to be included in the above
badblocks list.

Add a check in the nfit MCE handler to filter out corrected mce events,
and only process uncorrectable errors.

Fixes: 6839a6d96f4e ("nfit: do an ARS scrub on hitting a latent media error")
Reported-by: Omar Avelar <omar.avelar@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>
CC: elliott@hpe.com
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Len Brown <lenb@kernel.org>
CC: linux-acpi@vger.kernel.org
CC: linux-edac <linux-edac@vger.kernel.org>
CC: linux-nvdimm@lists.01.org
CC: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Ross Zwisler <zwisler@kernel.org>
CC: stable <stable@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Tony Luck <tony.luck@intel.com>
CC: x86-ml <x86@kernel.org>
CC: Yazen Ghannam <yazen.ghannam@amd.com>
Link: http://lkml.kernel.org/r/20181026003729.8420-1-vishal.l.verma@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/mce.h       |    1 +
 arch/x86/kernel/cpu/mcheck/mce.c |    3 ++-
 drivers/acpi/nfit/mce.c          |    4 ++--
 3 files changed, 5 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -216,6 +216,7 @@ static inline int umc_normaddr_to_sysadd
 
 int mce_available(struct cpuinfo_x86 *c);
 bool mce_is_memory_error(struct mce *m);
+bool mce_is_correctable(struct mce *m);
 
 DECLARE_PER_CPU(unsigned, mce_exception_count);
 DECLARE_PER_CPU(unsigned, mce_poll_count);
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -534,7 +534,7 @@ bool mce_is_memory_error(struct mce *m)
 }
 EXPORT_SYMBOL_GPL(mce_is_memory_error);
 
-static bool mce_is_correctable(struct mce *m)
+bool mce_is_correctable(struct mce *m)
 {
 	if (m->cpuvendor == X86_VENDOR_AMD && m->status & MCI_STATUS_DEFERRED)
 		return false;
@@ -544,6 +544,7 @@ static bool mce_is_correctable(struct mc
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(mce_is_correctable);
 
 static bool cec_add_mce(struct mce *m)
 {
--- a/drivers/acpi/nfit/mce.c
+++ b/drivers/acpi/nfit/mce.c
@@ -25,8 +25,8 @@ static int nfit_handle_mce(struct notifi
 	struct acpi_nfit_desc *acpi_desc;
 	struct nfit_spa *nfit_spa;
 
-	/* We only care about memory errors */
-	if (!mce_is_memory_error(mce))
+	/* We only care about uncorrectable memory errors */
+	if (!mce_is_memory_error(mce) || mce_is_correctable(mce))
 		return NOTIFY_DONE;
 
 	/*


