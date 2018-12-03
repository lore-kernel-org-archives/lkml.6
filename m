Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175E1C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC77820878
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC77820878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbeLCM0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:26:30 -0500
Received: from mga09.intel.com ([134.134.136.24]:24968 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbeLCM03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:26:29 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 04:25:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,310,1539673200"; 
   d="scan'208";a="126613955"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 03 Dec 2018 04:25:35 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 03 Dec 2018 14:25:34 +0200
Date:   Mon, 3 Dec 2018 14:25:34 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     chenyu56@huawei.com, USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v1 07/12] usb: roles: Find the usb role switch by also
 matching against the device node
Message-ID: <20181203122534.GD24338@kuha.fi.intel.com>
References: <20181203034515.91412-1-chenyu56@huawei.com>
 <20181203034515.91412-8-chenyu56@huawei.com>
 <CAHp75VfUKAQ+Q0cQz-4-=i2JL9uACBX1bVvCeNjZLL1HStDGKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfUKAQ+Q0cQz-4-=i2JL9uACBX1bVvCeNjZLL1HStDGKQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 03, 2018 at 10:17:20AM +0200, Andy Shevchenko wrote:
> On Mon, Dec 3, 2018 at 5:45 AM Yu Chen <chenyu56@huawei.com> wrote:
> >
> > This patch adds code for supporting find usb role switch by matching against
> > the device node described using of_graph.
> 
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> >  #include <linux/slab.h>
> > +#include <linux/of.h>
> > +#include <linux/of_graph.h>
> 
> Keep it ordered.
> 
> > +static int __switch_match_by_of_node(struct device *dev, const void *name)
> > +{
> > +       if (!dev->parent || !dev->parent->of_node)
> > +               return 0;
> > +
> > +       return of_node_name_eq(dev->parent->of_node, (const char *)name);
> > +}
> 
> I think Heikki has introduced some more generic function for this.

Yes, for this I'm proposing a new function fwnode_get_name() that
should allow us to support ACPI as well as OF platforms:
https://lkml.org/lkml/2018/11/28/784

> >         sw = device_connection_find_match(dev, "usb-role-switch", NULL,
> >                                           usb_role_switch_match);
> 
> > +       sw = of_graph_find_match_by_type(dev, "usb-role-switch");
> 
> Why this is here?! device_connection_find_match() should take care for OF case.

Exactly. device_connection_find_match() needs to parse the graph (OF
and ACPI), and I already made proposal (RFC) for that:
https://lkml.org/lkml/2018/10/24/619

I have prepared a more finalized version of those patches. I've been
waiting for that fwnode_get_name() to be accepted before sending it
out since we are going to need that function, but I'll send a new RFC
if nothing happens soon with that fwnode_get_name() series.


Br,

-- 
heikki
