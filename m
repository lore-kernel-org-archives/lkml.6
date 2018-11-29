Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB30C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B70208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B75ejpqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B70208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732074AbeK3B2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:28:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:53710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731095AbeK3B2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:28:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B22FE20868;
        Thu, 29 Nov 2018 14:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501363;
        bh=Ur8gTTryXX49yFK11d7812a9I0fg9yXJ+SBgHUg+Vq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B75ejpqVSdXjVisyUs6E/1R9GLwtnsqJ3it5/pbcwfPWRiB6X09B+Oxckft45knX/
         8N5a8UziZ6zccKX00BSO9SA9r7EExygE5dUNXZ4kZIgrqWiaKoZhUUqWRfxQ1Fm9PO
         tvdb9Oz69ORLG5qpeJL4WO70eQRG1qKObSzrlwSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jean-Marc Lenoir <archlinux@jihemel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 4.9 24/92] ACPICA: AML interpreter: add region addresses in global list during initialization
Date:   Thu, 29 Nov 2018 15:11:53 +0100
Message-Id: <20181129140108.298098746@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140106.520639693@linuxfoundation.org>
References: <20181129140106.520639693@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Erik Schmauss <erik.schmauss@intel.com>

commit 4abb951b73ff0a8a979113ef185651aa3c8da19b upstream.

The table load process omitted adding the operation region address
range to the global list. This omission is problematic because the OS
queries the global list to check for address range conflicts before
deciding which drivers to load. This commit may result in warning
messages that look like the following:

[    7.871761] ACPI Warning: system_IO range 0x00000428-0x0000042F conflicts with op_region 0x00000400-0x0000047F (\PMIO) (20180531/utaddress-213)
[    7.871769] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver

However, these messages do not signify regressions. It is a result of
properly adding address ranges within the global address list.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200011
Tested-by: Jean-Marc Lenoir <archlinux@jihemel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/acpica/dsopcode.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -452,6 +452,10 @@ acpi_ds_eval_region_operands(struct acpi
 			  ACPI_FORMAT_UINT64(obj_desc->region.address),
 			  obj_desc->region.length));
 
+	status = acpi_ut_add_address_range(obj_desc->region.space_id,
+					   obj_desc->region.address,
+					   obj_desc->region.length, node);
+
 	/* Now the address and length are valid for this opregion */
 
 	obj_desc->region.flags |= AOPOBJ_DATA_VALID;


