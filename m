Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AE5C00449
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB44021473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB44021473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeJBIK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 04:10:29 -0400
Received: from relay1.sgi.com ([192.48.180.66]:47034 "EHLO relay.sgi.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbeJBIK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 04:10:28 -0400
Received: from stormcage.americas.sgi.com (stormcage.americas.sgi.com [128.162.236.70])
        by relay1.corp.sgi.com (Postfix) with ESMTP id 8BD8B8F8037;
        Mon,  1 Oct 2018 18:19:30 -0700 (PDT)
Received: by stormcage.americas.sgi.com (Postfix, from userid 5508)
        id 6DEEE201E6E17; Mon,  1 Oct 2018 20:22:04 -0500 (CDT)
Message-Id: <20181002012204.297193336@stormcage.americas.sgi.com>
User-Agent: quilt/0.46-1
Date:   Mon, 01 Oct 2018 20:22:04 -0500
From:   Mike Travis <mike.travis@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Hedi Berriche <hedi@sgi.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Borislav Petkov <bp@alien8.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ram Pai <linuxram@us.ibm.com>, Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Sinan Kaya <okaya@codeaurora.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fix community TSC ADJUST breakage causing TSC failure
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

*  Patch 1 adds an early callable function (right after efi_init) that
   will check if this system might be a UV system.

*  Patch 2 adds code into setup_arch() which disables the call to
   tsc_early_init.  This function calls the TSC adjust initialization
   functions before UV setup has checked if BIOS has set the multi-chassis
   sync flags.  Further references are in the patch.

-- 
