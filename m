Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35136C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0459D2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0459D2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeJCAnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 20:43:50 -0400
Received: from relay2.sgi.com ([192.48.180.65]:60083 "EHLO relay.sgi.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727381AbeJCAnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 20:43:50 -0400
Received: from stormcage.americas.sgi.com (stormcage.americas.sgi.com [128.162.236.70])
        by relay2.corp.sgi.com (Postfix) with ESMTP id AC8E8304043;
        Tue,  2 Oct 2018 10:59:10 -0700 (PDT)
Received: by stormcage.americas.sgi.com (Postfix, from userid 5508)
        id C547F200FAD03; Tue,  2 Oct 2018 13:01:44 -0500 (CDT)
Message-Id: <20181002180144.636925675@stormcage.americas.sgi.com>
User-Agent: quilt/0.46-1
Date:   Tue, 02 Oct 2018 13:01:44 -0500
From:   Mike Travis <mike.travis@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Hedi Berriche <hedi.berriche@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Borislav Petkov <bp@alien8.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Xiaoming Gao <gxm.linux.kernel@gmail.com>,
        Rajvi Jingar <rajvi.jingar@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH 0/2] Fix TSC ADJUST breakage causing TSC failure
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fix a breakage caused by enabling early tsc initialization which bypasses
a check that disables the forcing of TSC ADJUST to 0 for chassis 0.
This is common on systems where all the chassis start up asynchronously
so which chassis should have a TSC ADJUST value of 0 is not predictable.

The solution is to add a check earlier than this early tsc init to
disable the potential of it incorrectly adjusting TSC ADJUST values that
are already correctly initialized.

*  Patch 1 adds an early callable function (after efi_init) that will
   check if this system might be a UV system.

*  Patch 2 adds code to tsc_early_init() which disables adjusting the
   TSC ADJUST value if it's a UV system.  This allows the later tsc_init
   function to test the tsc_async_resets flag that indicates the system
   chassis start up asynchronously, so which chassis should have a TSC
   ADJUST value of 0 is not predictable.  Further references are in
   the patch.

-- 
