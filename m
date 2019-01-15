Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97BFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE7420645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571374;
	bh=aNuAfX0UHbn3AsFZx39W2lmauganbDdXLufJfMcLrnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ziNQXn53rS2oBpU+SiXRm2if10CJ2BOUObYdgTyftQquTLrteI6IlFkpzRlGTZjke
	 /AMMRw2KxtYSl0kT110ZoOIRtKDFQr60b6SNzrJTtOH+aGh8b3Z0BdmNFFaWXdRKQm
	 LJ+Bf/V9lwWH5pDfv1Ih0iff+dsJdhVGQAm4/tNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388119AbfAOQ4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:56:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:58718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732888AbfAOQlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:41:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E7FC20859;
        Tue, 15 Jan 2019 16:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570511;
        bh=aNuAfX0UHbn3AsFZx39W2lmauganbDdXLufJfMcLrnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vQThyL66hJbU8zsOXutzhemLinh5o8CjQtFl/IQENZJgrNTM09mqolpf/maiwrE1+
         5SvGWm6eg4b2ruQjh/qR6YoMzCZgrhK/3ht0A0wvyg+lEwCegVSJ9aZOJNfPOQ1hnJ
         RwqxOOZ/EB650IsvTy2EgndzGPjXZLDiSsykF5Xk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.19 21/50] ACPI: power: Skip duplicate power resource references in _PRx
Date:   Tue, 15 Jan 2019 17:35:57 +0100
Message-Id: <20190115154911.173166964@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154909.933241945@linuxfoundation.org>
References: <20190115154909.933241945@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 7d7b467cb95bf29597b417d4990160d4ea6d69b9 upstream.

Some ACPI tables contain duplicate power resource references like this:

        Name (_PR0, Package (0x04)  // _PR0: Power Resources for D0
        {
            P28P,
            P18P,
            P18P,
            CLK4
        })

This causes a WARN_ON in sysfs_add_link_to_group() because we end up
adding a link to the same acpi_device twice:

sysfs: cannot create duplicate filename '/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/808622C1:00/OVTI2680:00/power_resources_D0/LNXPOWER:0a'
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.12-301.fc29.x86_64 #1
Hardware name: Insyde CherryTrail/Type2 - Board Product Name, BIOS jumperx.T87.KFBNEEA02 04/13/2016
Call Trace:
 dump_stack+0x5c/0x80
 sysfs_warn_dup.cold.3+0x17/0x2a
 sysfs_do_create_link_sd.isra.2+0xa9/0xb0
 sysfs_add_link_to_group+0x30/0x50
 acpi_power_expose_list+0x74/0xa0
 acpi_power_add_remove_device+0x50/0xa0
 acpi_add_single_object+0x26b/0x5f0
 acpi_bus_check_add+0xc4/0x250
 ...

To address this issue, make acpi_extract_power_resources() check for
duplicates and simply skip them when found.

Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
[ rjw: Subject & changelog, comments ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/power.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -131,6 +131,23 @@ void acpi_power_resources_list_free(stru
 	}
 }
 
+static bool acpi_power_resource_is_dup(union acpi_object *package,
+				       unsigned int start, unsigned int i)
+{
+	acpi_handle rhandle, dup;
+	unsigned int j;
+
+	/* The caller is expected to check the package element types */
+	rhandle = package->package.elements[i].reference.handle;
+	for (j = start; j < i; j++) {
+		dup = package->package.elements[j].reference.handle;
+		if (dup == rhandle)
+			return true;
+	}
+
+	return false;
+}
+
 int acpi_extract_power_resources(union acpi_object *package, unsigned int start,
 				 struct list_head *list)
 {
@@ -150,6 +167,11 @@ int acpi_extract_power_resources(union a
 			err = -ENODEV;
 			break;
 		}
+
+		/* Some ACPI tables contain duplicate power resource references */
+		if (acpi_power_resource_is_dup(package, start, i))
+			continue;
+
 		err = acpi_add_power_resource(rhandle);
 		if (err)
 			break;


