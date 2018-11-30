Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A76C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F27204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F27204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeK3VHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:07:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52181 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeK3VHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:07:04 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAU9vUYx3261741
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Nov 2018 01:57:30 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAU9vUdX3261738;
        Fri, 30 Nov 2018 01:57:30 -0800
Date:   Fri, 30 Nov 2018 01:57:30 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Julien Thierry <tipbot@zytor.com>
Message-ID: <tip-8c25db0a5a67986106aa3da7ce165ff961aa7847@git.kernel.org>
Cc:     arend.vanspriel@broadcom.com, luto@kernel.org, bp@alien8.de,
        mingo@kernel.org, torvalds@linux-foundation.org,
        dave.hansen@intel.com, zhuyifei1999@gmail.com,
        natechancellor@gmail.com, jonathanh@nvidia.com,
        bhsharma@redhat.com, julien.thierry@arm.com, hdegoede@redhat.com,
        marc.zyngier@arm.com, sai.praneeth.prakhya@intel.com,
        peterz@infradead.org, eric.snowberg@oracle.com,
        ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, matt@codeblueprint.co.uk,
        joe@perches.com, sedat.dilek@gmail.com
Reply-To: hdegoede@redhat.com, bhsharma@redhat.com, jonathanh@nvidia.com,
          julien.thierry@arm.com, mingo@kernel.org,
          torvalds@linux-foundation.org, dave.hansen@intel.com,
          natechancellor@gmail.com, zhuyifei1999@gmail.com,
          arend.vanspriel@broadcom.com, luto@kernel.org, bp@alien8.de,
          sedat.dilek@gmail.com, tglx@linutronix.de, hpa@zytor.com,
          matt@codeblueprint.co.uk, joe@perches.com,
          eric.snowberg@oracle.com, ard.biesheuvel@linaro.org,
          linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
          sai.praneeth.prakhya@intel.com, peterz@infradead.org
In-Reply-To: <20181129171230.18699-4-ard.biesheuvel@linaro.org>
References: <20181129171230.18699-4-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/fdt: Simplify the get_fdt() flow
Git-Commit-ID: 8c25db0a5a67986106aa3da7ce165ff961aa7847
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8c25db0a5a67986106aa3da7ce165ff961aa7847
Gitweb:     https://git.kernel.org/tip/8c25db0a5a67986106aa3da7ce165ff961aa7847
Author:     Julien Thierry <julien.thierry@arm.com>
AuthorDate: Thu, 29 Nov 2018 18:12:22 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 30 Nov 2018 09:10:30 +0100

efi/fdt: Simplify the get_fdt() flow

Reorganize the get_fdt() lookup loop, clearly showing that:

- Nothing is done for table entries that do not have fdt_guid
- Once an entry with fdt_guid is found, break out of the loop

No functional changes.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: YiFei Zhu <zhuyifei1999@gmail.com>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20181129171230.18699-4-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/libstub/fdt.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index a3614f9b5f75..0dc7b4987cc2 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -370,23 +370,24 @@ void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
 {
 	efi_guid_t fdt_guid = DEVICE_TREE_GUID;
 	efi_config_table_t *tables;
-	void *fdt;
 	int i;
 
-	tables = (efi_config_table_t *) sys_table->tables;
-	fdt = NULL;
+	tables = (efi_config_table_t *)sys_table->tables;
 
 	for (i = 0; i < sys_table->nr_tables; i++) {
-		if (efi_guidcmp(tables[i].guid, fdt_guid) == 0) {
-			fdt = (void *) tables[i].table;
-			if (fdt_check_header(fdt) != 0) {
-				pr_efi_err(sys_table, "Invalid header detected on UEFI supplied FDT, ignoring ...\n");
-				return NULL;
-			}
-			*fdt_size = fdt_totalsize(fdt);
-			break;
+		void *fdt;
+
+		if (efi_guidcmp(tables[i].guid, fdt_guid) != 0)
+			continue;
+
+		fdt = (void *)tables[i].table;
+		if (fdt_check_header(fdt) != 0) {
+			pr_efi_err(sys_table, "Invalid header detected on UEFI supplied FDT, ignoring ...\n");
+			return NULL;
 		}
+		*fdt_size = fdt_totalsize(fdt);
+		return fdt;
 	}
 
-	return fdt;
+	return NULL;
 }
