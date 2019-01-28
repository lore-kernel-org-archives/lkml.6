Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DACAC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786C32177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfA1PqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:46:24 -0500
Received: from mga03.intel.com ([134.134.136.65]:28750 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfA1PqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:46:23 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 07:46:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,534,1539673200"; 
   d="scan'208";a="142045620"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 28 Jan 2019 07:46:18 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 28 Jan 2019 17:46:18 +0200
Date:   Mon, 28 Jan 2019 17:46:18 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] usb: typec: mux: Find the muxes by also matching
 against the device node
Message-ID: <20190128154618.GI7262@kuha.fi.intel.com>
References: <20190125131519.88416-1-heikki.krogerus@linux.intel.com>
 <20190125131519.88416-5-heikki.krogerus@linux.intel.com>
 <CAHp75VfG9LDOfz9K0jYvGOK=j1uDmyg=eeRMur7hnw2rF9qx+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfG9LDOfz9K0jYvGOK=j1uDmyg=eeRMur7hnw2rF9qx+Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 11:53:54AM +0200, Andy Shevchenko wrote:
> On Fri, Jan 25, 2019 at 3:17 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > When the connections are defined in firmware, struct
> > device_connection will have the fwnode member pointing to
> > the device node (struct fwnode_handle) of the requested
> > device, and the endpoint will not be used at all in that
> > case.
> 
> >  static void *typec_mux_match(struct device_connection *con, int ep, void *data)
> >  {
> > +       const struct typec_altmode_desc *desc = data;
> >         struct typec_mux *mux;
> 
> > +       bool match = !con->id;
> 
> I don't see how this assignment is used.

That definitely deserves a comment at least.

This series adds support for the "device graph" to the device
connection API, but it is also possible to describe connections with
normal references (fwnode_property_get_reference_args()). With normal
references we don't need to do any extra identification like we do
with device graph.

The idea is to supply the connection id only if it has not been
"consumed" already (device graph case). If it has been "consumed", we
know there is no need for any extra connection identification (normal
references), and we can jump straight to the next stage -> find the
mux..

> > +       size_t nval;
> > +       u16 *val;
> > +       int i;
> > +
> > +       if (!con->fwnode) {
> > +               list_for_each_entry(mux, &mux_list, entry)
> > +                       if (!strcmp(con->endpoint[ep], dev_name(mux->dev)))
> > +                               return mux;
> > +               return ERR_PTR(-EPROBE_DEFER);
> > +       }
> > +
> > +       if (match)
> > +               goto find_mux;

..here.

I'll change this so that the match variable is introduced without
setting default value. Instead, how about this:

        /*
         * Check has the identifier already been "consumed". If it
         * has, no need to do any extra connection identification.
         */
        match = !con->id;
        if (match)
                goto find_mux;

thanks,

-- 
heikki
