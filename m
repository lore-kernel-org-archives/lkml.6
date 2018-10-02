Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7369C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6FB206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6FB206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbeJBWuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:50:00 -0400
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:54110 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729393AbeJBWuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:50:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id ABCE318065974;
        Tue,  2 Oct 2018 16:05:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: week36_3351457d10957
X-Filterd-Recvd-Size: 3293
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Tue,  2 Oct 2018 16:05:52 +0000 (UTC)
Message-ID: <61d7bd590527166c58670b4c0ab65a08710f81cf.camel@perches.com>
Subject: Re: [PATCH] efi/fdt: Indentation fix
From:   Joe Perches <joe@perches.com>
To:     Julien Thierry <julien.thierry@arm.com>, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 02 Oct 2018 09:05:51 -0700
In-Reply-To: <1538389776-8432-1-git-send-email-julien.thierry@arm.com>
References: <1538389776-8432-1-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-01 at 11:29 +0100, Julien Thierry wrote:
> Closing bracket seems to end a for statement when it is actually ending
> the contained if.
> 
> No functional change/fix, just fix the indentation.
[]
> diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
[]
> @@ -381,7 +381,7 @@ void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
>  			}
>  			*fdt_size = fdt_totalsize(fdt);
>  			break;
> -	 }
> +		}
> 
>  	return fdt;
>  }

Hello Julian.

[trivial style bikeshedding follows]

I think it better to add braces to the for loop so
this stands out better.

Also, I would generally write this so the if test is
reversed and uses a continue so the match block saves
an indent level.

This is the only use efi_guidcmp with a == test in
drivers/firmware, so perhaps remove that and use ! as
the other uses have no == or != test.

Lastly, a direct return might be better and the return
fdt could be removed and converted to return NULL.

Something like:
---
 drivers/firmware/efi/libstub/fdt.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 8830fa601e45..2d0b895e2f67 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -366,22 +366,23 @@ void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
 {
 	efi_guid_t fdt_guid = DEVICE_TREE_GUID;
 	efi_config_table_t *tables;
-	void *fdt;
 	int i;
 
-	tables = (efi_config_table_t *) sys_table->tables;
-	fdt = NULL;
+	tables = (efi_config_table_t *)sys_table->tables;
 
-	for (i = 0; i < sys_table->nr_tables; i++)
-		if (efi_guidcmp(tables[i].guid, fdt_guid) == 0) {
-			fdt = (void *) tables[i].table;
-			if (fdt_check_header(fdt) != 0) {
-				pr_efi_err(sys_table, "Invalid header detected on UEFI supplied FDT, ignoring ...\n");
-				return NULL;
-			}
-			*fdt_size = fdt_totalsize(fdt);
-			break;
-	 }
+	for (i = 0; i < sys_table->nr_tables; i++) {
+		void *fdt;
+
+		if (efi_guidcmp(tables[i].guid, fdt_guid))
+			continue;
+		fdt = (void *)tables[i].table;
+		if (fdt_check_header(fdt) != 0) {
+			pr_efi_err(sys_table, "Invalid header detected on UEFI supplied FDT, ignoring ...\n");
+			return NULL;
+		}
+		*fdt_size = fdt_totalsize(fdt);
+		return fdt;
+	}
 
-	return fdt;
+	return NULL;
 }


