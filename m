Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAB6C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F842077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F842077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbeJKRxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:53:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbeJKRxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:53:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 78C34308338F;
        Thu, 11 Oct 2018 10:26:31 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33396282F9;
        Thu, 11 Oct 2018 10:26:29 +0000 (UTC)
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
Subject: [PATCH v2 0/3] x86: baytrail/cherrytrail: Rework and move P-Unit PMIC semaphore handling
Date:   Thu, 11 Oct 2018 12:26:24 +0200
Message-Id: <20181011102627.7418-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 11 Oct 2018 10:26:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

New in v2 are some minor tweaks to the first patch based on Andy's review.

See the commit message of the first patch for the why and what of this
series.

Also the whole purpose of posting this series for now is just to get the
first patch reviewed and merged, the others are more of a RFC until that
happens.

Once the first patch is merged we can look at using the new
iosf_mbi_[un]block_punit_i2c_access() functions in various drivers for the
AXP288 PMIC (and the TI dollarcove PMIC) to only take the P-Unit semaphore
once around a group of i2c accesses to the PMIC. The second patch is an
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

