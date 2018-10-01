Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D67AC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A2E208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A2E208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbeJAUuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:50:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:22296 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729386AbeJAUup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:50:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2018 07:12:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,327,1534834800"; 
   d="scan'208";a="91115618"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2018 07:12:42 -0700
Date:   Mon, 1 Oct 2018 22:18:10 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        H Peter Anvin <hpa@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Stuart R . Anderson" <stuart.r.anderson@intel.com>,
        alan@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/earlyprintk: Add a force option for pciserial
 device
Message-ID: <20181001141810.fbo3amfqnr5243mc@shbuild888>
References: <20180928094008.23138-1-feng.tang@intel.com>
 <20180929163458.GA25608@zn.tnic>
 <20180930131619.jecqh4umrkmifavb@shbuild888>
 <20181001123916.GC7269@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001123916.GC7269@zn.tnic>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Mon, Oct 01, 2018 at 02:39:16PM +0200, Borislav Petkov wrote:
> On Sun, Sep 30, 2018 at 09:16:19PM +0800, Feng Tang wrote:
> > Got your point. As the following [,baudrate] is also optional, and this
> > "force" could be the last option for pciserial. The check may be
> > 
> > 	if (!strncmp(s, "force,", 6) || !strncmp(s, "force ", 6)) {
> > 		force = 1;
> > 		s += 6;
> > 	}
> 
> You have !strncmp(s, "force,", 6) twice in there. I have no clue what
> you're trying to say.

I was trying to address your last comments:

"No, you need to force the presence of "," otherwise cmdlines like this:

earlyprintk=pciserial,0:XX.X,forcedoodoo

work too."

As I rechecked, the baud rate for pciserial is optional, so there may
be no ",baudrate" following the "force". So this 2 strncmp is to
cover conditions for with and without baudrate.

> 
> > Do you mean this? 
> > 
> > 	if (((classcode >> 16 != PCI_CLASS_COMMUNICATION_MODEM) &&
> > 	     (classcode >> 16 != PCI_CLASS_COMMUNICATION_SERIAL)) ||
> > 	   (((classcode >> 8) & 0xff) != 0x02)) /* 16550 I/F at BAR0 */ {
> > 		if (!force)
> > 			return;
> > 	}
> 
> Yes.

Ok, thanks


Thanks,
Feng
