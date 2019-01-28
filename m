Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFE1C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B4B2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfA1P1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:27:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:55298 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfA1P1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:27:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 07:27:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,534,1539673200"; 
   d="scan'208";a="142040230"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 28 Jan 2019 07:27:27 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 28 Jan 2019 17:27:27 +0200
Date:   Mon, 28 Jan 2019 17:27:27 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] platform/x86: intel_cht_int33fe: Remove connection
 for the alt mode mux
Message-ID: <20190128152727.GG7262@kuha.fi.intel.com>
References: <20190125131519.88416-1-heikki.krogerus@linux.intel.com>
 <20190125131519.88416-2-heikki.krogerus@linux.intel.com>
 <CAHp75Vf1w6fOUp968S=5=-3jsG6x6JAcwR=uxzk9eMjXc7H_ZQ@mail.gmail.com>
 <5642f1df-44b5-8293-3ce6-b244f95498ba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5642f1df-44b5-8293-3ce6-b244f95498ba@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Mon, Jan 28, 2019 at 11:44:29AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 28-01-19 10:45, Andy Shevchenko wrote:
> > On Fri, Jan 25, 2019 at 3:17 PM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > > 
> > > Driver for fusb302 does not support alternate modes, so the
> > > connection is not really needed for now. Removing that
> > > connection description allows us to improve the USB Type-C
> > > mux API.
> > > 
> > 
> > Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > supposed to go via USB tree.
> 
> I missed the original posting of this, so let me reply here:
> 
> Nack to this change, I've a patch-set in the works to
> make display-port over type-c work with 2 devices with a fusb302
> mux and that needs this connection.

I can add the connections back in this series after the API
modification patches, but should the connections be added back only
after we actually support the alt mode in the driver?

Btw. I'm preparing patches where I remove struct tcpc_config
completely. We can do that by taking advantage of the software fwnodes
(I'll send the patches RFC to give you an idea what I'm talking about).

That's related as we don't need struct tcpc_config for anything else
except for alternate modes (which no driver supports currently) after
that series, and even with the alt modes, it's only a question of
supplying DT bindings that define the appropriate device properties.

Also, as a "heads-up": As I explained in the cover-letter, my plan is
to take advantage of the software fwnodes also with the connections.
By adding support for reference handling to the software nodes, we
don't need to maintain the list of connections as we do today. And
more importantly, we don't need to match using device names, which is
always fragile.

That means we will change the connection registration, actually,
remove connection registration :-). The connections after that can
always be described in the fwnode for the device.


thanks,

-- 
heikki
