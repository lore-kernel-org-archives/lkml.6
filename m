Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2AB7FC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9F1208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9F1208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935531AbeFMMdx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:33:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:3082 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935244AbeFMMdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:33:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2018 05:33:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,218,1526367600"; 
   d="scan'208";a="63731890"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 13 Jun 2018 05:33:47 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 13 Jun 2018 15:33:48 +0300
Date:   Wed, 13 Jun 2018 15:33:48 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Mats Karrman <mats.dev.list@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 2/8] usb: typec: helper for checking cable plug
 orientation
Message-ID: <20180613123348.GB2847@kuha.fi.intel.com>
References: <20180608112941.26332-1-heikki.krogerus@linux.intel.com>
 <20180608112941.26332-3-heikki.krogerus@linux.intel.com>
 <595c8953-040a-5697-0f79-ea6622d88bcb@gmail.com>
 <20180612221842.GA16275@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612221842.GA16275@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 03:18:42PM -0700, Guenter Roeck wrote:
> On Tue, Jun 12, 2018 at 08:56:31PM +0200, Mats Karrman wrote:
> > Hi Heikki,
> > 
> > On 2018-06-08 13:29, Heikki Krogerus wrote:
> > 
> > >This adds function typec_get_orientation() that can be used
> > >for checking the current cable plug orientation.
> > >
> > >Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > >---
> > >  drivers/usb/typec/class.c | 11 +++++++++++
> > >  include/linux/usb/typec.h |  1 +
> > >  2 files changed, 12 insertions(+)
> > >
> > >diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > >index 53df10df2f9d..02db9bcbac0c 100644
> > >--- a/drivers/usb/typec/class.c
> > >+++ b/drivers/usb/typec/class.c
> > >@@ -1279,6 +1279,17 @@ int typec_set_orientation(struct typec_port *port,
> > >  }
> > >  EXPORT_SYMBOL_GPL(typec_set_orientation);
> > >+/**
> > >+ * typec_get_orientation - Get USB Type-C cable plug orientation
> > >+ * @port: USB Type-C Port
> > >+ *
> > >+ * Get current cable plug orientation for @port.
> > >+ */
> > >+enum typec_orientation typec_get_orientation(struct typec_port *port)
> > >+{
> > >+	return port->orientation;
> > >+}
> > 
> > +EXPORT_SYMBOL_GPL(typec_get_orientation);
> > 
> > Isn't this a candidate for an inline?
> > 
> 
> Currently struct typec_port is class private. To make this function inline,
> struct typec_port would have to be moved from drivers/usb/typec/class.c to
> include/linux/usb/typec.h. That doesn't sound like a good idea to me.

Yes, let's keep the structure protected.

But thanks for the report, I'll fix it.


Br,

-- 
heikki
