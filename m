Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD368C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5A120652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5A120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeIFPm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:42:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:62654 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbeIFPm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:42:57 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 04:08:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,337,1531810800"; 
   d="scan'208";a="67995132"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga007.fm.intel.com with SMTP; 06 Sep 2018 04:07:57 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 06 Sep 2018 14:07:56 +0300
Date:   Thu, 6 Sep 2018 14:07:56 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/2] thunderbolt: Initialize after IOMMUs
Message-ID: <20180906110756.GY2283@lahna.fi.intel.com>
References: <20180903132012.23531-1-mika.westerberg@linux.intel.com>
 <20180903132012.23531-2-mika.westerberg@linux.intel.com>
 <20180905084746.xmckzskxzsdliz3e@wunner.de>
 <20180905094602.GH2283@lahna.fi.intel.com>
 <20180906081337.3mosfpfggfmoj633@wunner.de>
 <20180906103602.GV2283@lahna.fi.intel.com>
 <20180906110049.gfdhurvkvvdjw7zh@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906110049.gfdhurvkvvdjw7zh@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 01:00:49PM +0200, Lukas Wunner wrote:
> On Thu, Sep 06, 2018 at 01:36:02PM +0300, Mika Westerberg wrote:
> > On Thu, Sep 06, 2018 at 10:13:37AM +0200, Lukas Wunner wrote:
> > > So with this patch, you rely on the linker ordering nhi_init() after
> > > ir_dev_scope_init(), however to the best of my knowledge the link
> > > order is not guaranteed.
> > 
> > What says that?
> 
> Within the same initcall level, the ordering is determined by the Makefile
> AFAIK.  Someone changes the Makefile, your dependency scheme falls apart.

There are other drivers doing the same so they would fail as well. It is
common practice AFAIK.

> > > Looking at commit acb40d841257, which started this, I'm wondering
> > > why you did not simply export tbnet_init() and call it from the
> > > thunderbolt driver after the property stuff has been fully set up?
> > > After all, thunderbolt-net is useless without thunderbolt or am I
> > > missing something?  Then you could revert back to module_init().
> > 
> > The same reason you don't call PCI driver functions from PCI core. It
> > makes absolutely zero sense.
> > 
> > Thunderbolt is bus and provides driver API to drivers. We hopefully are
> > getting other service drivers (say SCSI over TBT) that are going to be
> > use the same interfaces.
> 
> Then add a blocking notifier chain into which these service drivers can
> hook.  Other buses have that as well.

It is really too complex to add notifier just for that. This works fine
and is not against any kernel principles I am aware of.
