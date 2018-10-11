Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E265C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81502075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81502075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbeJKV4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:56:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbeJKV4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:56:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB50DC04F4D1;
        Thu, 11 Oct 2018 14:29:17 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8948D765BB;
        Thu, 11 Oct 2018 14:29:13 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] x86: baytrail/cherrytrail: Rework and move P-Unit PMIC semaphore handling
Date:   Thu, 11 Oct 2018 16:29:08 +0200
Message-Id: <20181011142911.13750-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 11 Oct 2018 14:29:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Changes in v3:
-Fix iosf_mbi_punit_mutex not being unlocked in error exit path
-Add a big comment describing the what-and-why of
 iosf_mbi_block_punit_i2c_access()

Changes in v2:
-Move mutex_unlock(&iosf_mbi_punit_mutex); to the callers of
 iosf_mbi_reset_semaphore()
-Use PCI_DEVICE_DATA() to pass the driver_data

See the commit message of the first patch for the why and what of this
series.

Also the whole purpose of posting this series for now is just to get the
first patch reviewed and merged, the others are more of a RFC until that
happens.

Once the first patch is merged we can look at using the new
iosf_mbi_[un]block_punit_i2c_access() functions in various drivers for the
AXP288 PMIC (and the TI dollarcove PMIC) to only take the P-Unit semaphore
once around a group of I2C accesses to the PMIC. The second patch is an
example of this.

The third patch is some trivial cleanup to the i2c-designware driver which
becomes possible after the first patch is merged. As mentioned in the commit
message of the first patch, that patch deliberately saves that cleanup for
later, so that it only touches i2c-designware-baytrail.c and not the main
i2c-designware*.c files, so that it can be merged through the x86 tree
without conflicts.

Wolfram can we have your ack for merging the i2c-designware-baytrail.c
changes through the x86 tree (assuming you are ok with moving all the
iosf_mbi magic out of that file into arch/x86/platform/intel/iosf_mbi.c)?

Regards,
 
Hans

