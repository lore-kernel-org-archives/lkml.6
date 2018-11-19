Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21497C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E031C2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E031C2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbeKTAVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:21:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:8070 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbeKTAVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:21:45 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 05:58:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,252,1539673200"; 
   d="scan'208";a="250905002"
Received: from tmuluk-mobl4.ger.corp.intel.com (HELO localhost) ([10.249.254.135])
  by orsmga004.jf.intel.com with ESMTP; 19 Nov 2018 05:58:01 -0800
Date:   Mon, 19 Nov 2018 15:58:00 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] tpm: add support for partial reads
Message-ID: <20181119135800.GE8755@linux.intel.com>
References: <154239067364.2880.13752725056462237016.stgit@tstruk-mobl1.jf.intel.com>
 <154239071144.2924.17574189056250189697.stgit@tstruk-mobl1.jf.intel.com>
 <20181118074832.GG5897@linux.intel.com>
 <90072f09-6388-b1f7-387b-42f056f8893d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90072f09-6388-b1f7-387b-42f056f8893d@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 07:05:19PM -0800, Tadeusz Struk wrote:
> > When ret_size < 0? Shouldn't this be just "if (!ret_size)"?
> 
> What we want to check here is if ret_size is positive, which is a valid
> value, or if it is negative or zero, which is an invalid value, so in
> this case (!ret_size) will not work.

Please explain a scenario where "!ret_size" would no work given that
both size and partial_data have always positive value?

> >> 	/* Holds the resul of the last successful call to tpm_transmit() */
> >>  	size_t transmit_result;
> >> +	/* Holds the count how much of the response is still unread */
> >> +	size_t partial_data;
> > I'm otherwise happy how this look like but why call it partial_data.
> > You cannot really tell from the name anything about its contents as
> > data is very abstract term.
>  
> so I will rename these two to response_length and response_length_rem,
> how does this sound?

Yes, assuming that there would be a hard requirement to even have two
variables in the first place.

> > BTW, why you need the new variable anyway and not just decrease the
> > variable where the length is original stored?
> 
> We need to have two variables, otherwise how do we tell if some part of
> response was consumed to allow sending a new command?

I don't understand. In order to maintain backwards compatibility you can
send a new command at any time.

> The transmit_result is used for that. If it is zero then one can transmit
> a new command even if the whole response is not consumed. The new variable
> tracks how much of the response is still to be read. 

AFAIK you only need to track the latter, not both.

/Jarkko
