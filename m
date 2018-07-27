Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBE2C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3551220862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3551220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389034AbeG0Xc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:32:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:43838 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728656AbeG0Xc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:32:28 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jul 2018 15:08:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,411,1526367600"; 
   d="scan'208";a="71070820"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jul 2018 15:08:34 -0700
Date:   Fri, 27 Jul 2018 15:08:34 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        bp@suse.de, x86@kernel.org
Subject: Re: [PATCH] x86/mce: Handle varying MCA bank counts
Message-ID: <20180727220833.GA30752@agluck-desk>
References: <20180727214009.78289-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727214009.78289-1-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 04:40:09PM -0500, Yazen Ghannam wrote:
> -	/* Don't support asymmetric configurations today */
> -	WARN_ON(mca_cfg.banks != 0 && b != mca_cfg.banks);
> -	mca_cfg.banks = b;
> +	mca_cfg.banks = max(mca_cfg.banks, b);

Should we change mca_cfg.banks to be a per-cpu variable?

	DEFINE_PER_CPU(int, mce_num_banks);

That would make it easier to make sure the places
that scan all banks only look at the ones that exist.

-Tony
