Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F14CC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E3F213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E3F213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404155AbeKTDwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:52:54 -0500
Received: from mga18.intel.com ([134.134.136.126]:17189 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390797AbeKTDwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:52:53 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 09:28:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,253,1539673200"; 
   d="scan'208";a="109824103"
Received: from tmuluk-mobl4.ger.corp.intel.com (HELO localhost) ([10.249.254.135])
  by orsmga002.jf.intel.com with ESMTP; 19 Nov 2018 09:28:25 -0800
Date:   Mon, 19 Nov 2018 19:28:24 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] tpm: add support for partial reads
Message-ID: <20181119172824.GB16252@linux.intel.com>
References: <154239067364.2880.13752725056462237016.stgit@tstruk-mobl1.jf.intel.com>
 <154239071144.2924.17574189056250189697.stgit@tstruk-mobl1.jf.intel.com>
 <20181118074832.GG5897@linux.intel.com>
 <90072f09-6388-b1f7-387b-42f056f8893d@intel.com>
 <20181119135800.GE8755@linux.intel.com>
 <b0efbbf8-6242-a48d-d984-b49d5fb20bb8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0efbbf8-6242-a48d-d984-b49d5fb20bb8@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 08:44:49AM -0800, Tadeusz Struk wrote:
> On 11/19/18 5:58 AM, Jarkko Sakkinen wrote:
> > Please explain a scenario where "!ret_size" would no work given that
> > both size and partial_data have always positive value?
> 
> Right, I only looked at the one line above before responding.
> I'll change it to !ret_size
> 
> > 
> > I don't understand. In order to maintain backwards compatibility you can
> > send a new command at any time.
> 
> No, currently it is not possible to send a new command until the previous
> response is consumed. -EBUSY is returned if one sends a new command before
> reading the previous response (or at least part of it). See:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/tpm/tpm-dev-common.c#n128

Ah, you are correct.

You should add a boolean flag instead of introducing a new variable for
holding amount that has been read because obviously one read operation
is enough for backwards compatibility.

The code could read the code to data_pending and then set

   priv->data_read = false;

We do not need the original amount for anything.

/Jarkko
