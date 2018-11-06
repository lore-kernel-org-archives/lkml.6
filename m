Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E80C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8CC20685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8CC20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387842AbeKGAap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:30:45 -0500
Received: from mga03.intel.com ([134.134.136.65]:3507 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729711AbeKGAap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:30:45 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 07:05:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,472,1534834800"; 
   d="scan'208";a="105724667"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 06 Nov 2018 07:05:04 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 06 Nov 2018 17:05:03 +0200
Date:   Tue, 6 Nov 2018 17:05:03 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] of/property: Introduce of_fwnode_name()
Message-ID: <20181106150503.GE13048@kuha.fi.intel.com>
References: <20181105091727.25544-1-heikki.krogerus@linux.intel.com>
 <20181105091727.25544-4-heikki.krogerus@linux.intel.com>
 <CAL_Jsq+aRAv+9gDKwVi9xYQPYzXK4NMPjzfkuYB08+K6KTYXFg@mail.gmail.com>
 <20181106105803.GS10650@smile.fi.intel.com>
 <20181106122734.GC13048@kuha.fi.intel.com>
 <CAL_Jsq+kspp1GYrMjG1cC=CyCa2_jO1suFdD9fn+gOwKRYdhtw@mail.gmail.com>
 <20181106144037.GD13048@kuha.fi.intel.com>
 <20181106145537.GB10650@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106145537.GB10650@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 04:55:37PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 06, 2018 at 04:40:37PM +0200, Heikki Krogerus wrote:
> > On Tue, Nov 06, 2018 at 07:18:14AM -0600, Rob Herring wrote:
> 
> > > Looking at patch 4, if matching the name is what you want to do, then
> > > use the DT name matching functions. They were added in 4.19.
> > 
> > That is something that the of_fwnode_get_named_child_node() needs
> > to use (would have needed).
> > 
> > Regardless of what we do with that callback, fwnode_name() needs to
> > return the name in from that for example of_node_name_eq() takes as
> > the second parameter. So "node-name@unit-address" is not OK. Sorry for
> > not realizeing that before.
> > 
> > So I guess we need to either get the "node-name" from that full_name
> > member in of_fwnode_name() (Andy, are you OK with that?), or is there
> > already a helper that does it for us?
> 
> Looking into existing API I think we need something like
> 
> of_node_name_extract()
> 
> of_node_name_eq()
> {
> 	name = of_node_name_extract();
> 	return strlen()...strncmp()...;
> }
> 
> The question is who is going to allocate and free memory for the name out of it.

Maybe it would be best to just read the "name" device property in
fwnode_name() and not have of_fwnode_name at all.

> OTOH, of_fwnode_get_named_child_node() might need to copy that code which
> brings the consistency issue (several places to maintain the same set of rules,
> i.e. how we extract name out of full_name).
> 
> So, removal of name field shouldn't be done until we resolve the issue with
> of_fwnode_get_named_child_node().

thanks,

-- 
heikki
