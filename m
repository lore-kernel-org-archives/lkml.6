Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E758BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B1A206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547107377;
	bh=g+HZmAv6nycUyIr/+HTW37IaogqN3fZYLU7bLiGKwWs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=sJQMGXu4P1Ne1JSt+hCfmp+PvbXPpLscntoiU9oEfTAcHLF7PgNsFfmD3PRn+Rlkv
	 r8Kj4z5Tfh7PjRYyGPzlzfahxnlFw9QfM7Senkr7knCZtCOk7u/zpRXUjEs34PdC9i
	 oN2gSNCijgC3E9PupEntLrLqj5hOm5hf2hk3ZKNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfAJIC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:02:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:51752 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfAJICz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:02:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 00:02:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,460,1539673200"; 
   d="scan'208";a="108778755"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga008.jf.intel.com with ESMTP; 10 Jan 2019 00:02:52 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Jack Pham <jackp@codeaurora.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jack Pham <jackp@codeaurora.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Clear req->needs_extra_trb flag on cleanup
In-Reply-To: <20181221232005.5301-1-jackp@codeaurora.org>
References: <20181221232005.5301-1-jackp@codeaurora.org>
Date:   Thu, 10 Jan 2019 10:02:51 +0200
Message-ID: <87pnt5c53o.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Jack Pham <jackp@codeaurora.org> writes:

> OUT endpoint requests may somtimes have this flag set when
> preparing to be submitted to HW indicating that there is an
> additional TRB chained to the request for alignment purposes.
> If that request is removed before the controller can execute the
> transfer (e.g. ep_dequeue/ep_disable), the request will not go
> through the dwc3_gadget_ep_cleanup_completed_request() handler
> and will not have its needs_extra_trb flag cleared when
> dwc3_gadget_giveback() is called.  This same request could be
> later requeued for a new transfer that does not require an
> extra TRB and if it is successfully completed, the cleanup
> and TRB reclamation will incorrectly process the additional TRB
> which belongs to the next request, and incorrectly advances the
> TRB dequeue pointer, thereby messing up calculation of the next
> requeust's actual/remaining count when it completes.
>
> The right thing to do here is to ensure that the flag is cleared
> before it is given back to the function driver.  A good place
> to do that is in dwc3_gadget_del_and_unmap_request().
>
> Signed-off-by: Jack Pham <jackp@codeaurora.org>
> ---
> Hi Felipe,
>
> There's probably zero chance this is making it to 4.20, so if you take
> this after 4.21-rc1 so be it. But should this be Cc: stable? If so it
> needs to be sent separately for <= 4.19 as needs_extra_trb was previously
> req->unaligned and req->zero.

we need a Cc stable, indeed. And a Fixes tag.

-- 
balbi
