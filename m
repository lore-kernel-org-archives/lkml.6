Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B70C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B1520855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B1520855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbeK0B1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:27:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:54252 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbeK0B1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:27:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 06:32:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,282,1539673200"; 
   d="scan'208";a="103300117"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga003.jf.intel.com with ESMTP; 26 Nov 2018 06:32:46 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gRHwL-0001pW-Gv; Mon, 26 Nov 2018 16:32:45 +0200
Date:   Mon, 26 Nov 2018 16:32:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/15] platform/x86: i2c-multi-instantiate: Count
 I2cSerialBus() resources
Message-ID: <20181126143245.GK10650@smile.fi.intel.com>
References: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
 <20181120155924.10773-10-andriy.shevchenko@linux.intel.com>
 <0241e59f-f00b-f1be-9861-62d5da184b24@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0241e59f-f00b-f1be-9861-62d5da184b24@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 01:03:35PM +0100, Hans de Goede wrote:
> On 20-11-18 16:59, Andy Shevchenko wrote:

> > -	multi->num_clients = i;
> > +	multi->num_clients = ret;
> >   	for (i = 0; i < multi->num_clients; i++) {
> >   		memset(&board_info, 0, sizeof(board_info));
> 
> Now you end up indexing inst_data with i without checking that inst_data
> holds enough data. Not using all of inst_data in case there are less
> I2cSerialBus resources then inst_data entries is fine. But you need to
> deal with the case when there are more I2cSerialBus resources then inst_data
> entries, either by erroring out or ignoring the extra I2cSerialBus resources.

I think returning an error here is to be on safer side.

> Also it might be better to make the i2c_multi_inst_count_resources() function
> a generic helper under drivers/acpi, so that it can be used in other places,
> see my comments to the BOSC0200 patch.

I would rather to avoid touching BOSC0200 right now and keep that function
inside i2c-multi-instantiate.


-- 
With Best Regards,
Andy Shevchenko


