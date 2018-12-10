Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AE2C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6411220855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6411220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbeLJHgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:36:11 -0500
Received: from mga03.intel.com ([134.134.136.65]:20164 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbeLJHgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:36:10 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2018 23:36:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,337,1539673200"; 
   d="scan'208";a="128579031"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 09 Dec 2018 23:36:06 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 10 Dec 2018 09:36:05 +0200
Date:   Mon, 10 Dec 2018 09:36:05 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/3] device property: Introduce fwnode_get_name()
Message-ID: <20181210073605.GA24718@kuha.fi.intel.com>
References: <20181128115952.80890-1-heikki.krogerus@linux.intel.com>
 <20181128115952.80890-2-heikki.krogerus@linux.intel.com>
 <20181207172427.GA6642@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207172427.GA6642@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 11:24:27AM -0600, Rob Herring wrote:
> On Wed, Nov 28, 2018 at 02:59:50PM +0300, Heikki Krogerus wrote:
> > This helper returns the name of the node. The name is
> > primarily expected to be returned from a new fwnode
> > operation meant for this purpose, but when no name is
> > returned, the helper will also attempt to read a device
> > property "name".
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  drivers/base/property.c  | 36 ++++++++++++++++++++++++++++++++++++
> >  include/linux/fwnode.h   |  3 +++
> >  include/linux/property.h |  2 ++
> >  3 files changed, 41 insertions(+)
> > 
> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index 240ab5230ff6..8bd35b44d9ec 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -1156,6 +1156,42 @@ void fwnode_handle_put(struct fwnode_handle *fwnode)
> >  }
> >  EXPORT_SYMBOL_GPL(fwnode_handle_put);
> >  
> > +/**
> > + * fwnode_get_name - Copy the name of an fwnode to a buffer
> > + * @fwnode: Pointer to the node
> > + * @buf: Buffer where the name is copied to
> > + * @len: Size of the buffer
> > + *
> > + * Copies the node name of @fwnode to @buf. The routine attempts to first use
> > + * the get_name fwnode op of @fwnode, and if it fails, the routine attempts to
> > + * read a property "name".
> > + *
> > + * NOTE: @buf must be large enough to accommodate the name and trailing '\0'.
> > + *
> > + * Returns 0 on success or errno in case of an error.
> > + */
> > +int fwnode_get_name(const struct fwnode_handle *fwnode, char *buf, size_t len)
> > +{
> > +	const char *name;
> > +	int ret;
> > +
> > +	ret = fwnode_call_int_op(fwnode, get_name, buf, len);
> > +	if (ret == 0 || ret == -EOVERFLOW)
> > +		return ret;
> > +
> > +	ret = fwnode_call_int_op(fwnode, property_read_string_array,
> > +				 "name", &name, 1);
> 
> Do you expect this to work on DT? It does today, but I plan to change 
> that. 'name' is a fake property on FDT.
> 
> Again, I think this is all working at too low of a level. Name is used 
> either for matching or an informational string. For matching, this 
> should remain firmware specific. For imformational strings, 
> device_node.full_name works.

OK, I'll remove call.

thanks,

-- 
heikki
