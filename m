Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0094C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B102C206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B102C206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbeJBUMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:12:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:51267 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729670AbeJBUMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:12:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2018 06:28:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,332,1534834800"; 
   d="scan'208";a="95771210"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga001.jf.intel.com with SMTP; 02 Oct 2018 06:28:50 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 02 Oct 2018 16:28:49 +0300
Date:   Tue, 2 Oct 2018 16:28:49 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     Manasi Navare <manasi.d.navare@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>, stelford@cadence.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        pgaj@cadence.com,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        jartur@cadence.com, ltyrala@cadence.com,
        linux-rockchip@lists.infradead.org, piotrs@cadence.com,
        devicetree@vger.kernel.org, jbergsagel@ti.com,
        Rob Herring <robh+dt@kernel.org>, Sean Paul <sean@poorly.run>,
        Damian Kos <dkos@cadence.com>,
        linux-arm-kernel@lists.infradead.org,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH v4 2/5] drm/dp: fix link probing for devices supporting
 DP 1.4+
Message-ID: <20181002132849.GR9144@intel.com>
References: <1537455288-20223-1-git-send-email-dkos@cadence.com>
 <1537455288-20223-3-git-send-email-dkos@cadence.com>
 <20180921075929.GA28323@intel.com>
 <20181001092708.ow4rxgzp4haax76k@qschulz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181001092708.ow4rxgzp4haax76k@qschulz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 11:27:08AM +0200, Quentin Schulz wrote:
> Hi Manasi,
> 
> On Fri, Sep 21, 2018 at 12:59:30AM -0700, Manasi Navare wrote:
> > Thanks for the patch. Verified with the DP 1.4 spec and looks good to me.
> > Also look at the related patch that makes use of the correct extended capabilities:
> > 
> > https://patchwork.freedesktop.org/patch/249400/
> > 
> 
> If I'm not mistaken, you could get rid of the patch in the Intel driver
> when we have this one merged. Is there any reason not to, have I missed
> something?

i915 (and most other drivers) don't use this code. Also as mentioned in
that thread you should probably validate that the data in the extended
caps looks sane, otherwise the entire point of having it for compatibility
with older source devices is lost.

> 
> Thanks,
> Quentin
> 
> > Reviewed-by: Manasi Navare <manasi.d.navare@intel.com>
> > 
> > Manasi
> > 
> > 
> > On Thu, Sep 20, 2018 at 03:54:37PM +0100, Damian Kos wrote:
> > > From: Quentin Schulz <quentin.schulz@free-electrons.com>
> > > 
> > > DP 1.4 introduced a DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit in
> > > DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from
> > > DP_DPCD_REV to DP_ADAPTER_CAP should be retrieved starting from
> > > DP_DPCD_REV_EXTENDED. All registers are copied except DP_DPCD_REV,
> > > DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT which represent the
> > > "true capabilities" of DPRX device.
> > > 
> > > Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT
> > > might falsely return lower capabilities to "avoid interoperability
> > > issues with some of the existing DP Source devices that malfunction
> > > when they discover the higher capabilities within those three
> > > registers.".
> > > 
> > > Before DP 1.4, DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit was reserved
> > > and read 0 so it's safe to check against it even if DP revision is
> > > <1.4
> > > 
> > > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> > > Signed-off-by: Damian Kos <dkos@cadence.com>
> > > ---
> > >  drivers/gpu/drm/drm_dp_helper.c | 30 +++++++++++++++++++++++++++++-
> > >  1 file changed, 29 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> > > index 8c6b9fd89f8a..735ebde5c2f0 100644
> > > --- a/drivers/gpu/drm/drm_dp_helper.c
> > > +++ b/drivers/gpu/drm/drm_dp_helper.c
> > > @@ -370,10 +370,38 @@ int drm_dp_link_probe(struct drm_dp_aux *aux, struct drm_dp_link *link)
> > >  {
> > >  	u8 values[3];
> > >  	int err;
> > > +	unsigned int addr;
> > >  
> > >  	memset(link, 0, sizeof(*link));
> > >  
> > > -	err = drm_dp_dpcd_read(aux, DP_DPCD_REV, values, sizeof(values));
> > > +	/*
> > > +	 * DP 1.4 introduced a DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit in
> > > +	 * DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from
> > > +	 * DP_DPCD_REV to DP_ADAPTER_CAP should be retrieved starting from
> > > +	 * DP_DPCD_REV_EXTENDED. All registers are copied except DP_DPCD_REV,
> > > +	 * DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT which represent the
> > > +	 * "true capabilities" of DPRX device.
> > > +	 *
> > > +	 * Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT
> > > +	 * might falsely return lower capabilities to "avoid interoperability
> > > +	 * issues with some of the existing DP Source devices that malfunction
> > > +	 * when they discover the higher capabilities within those three
> > > +	 * registers.".
> > > +	 *
> > > +	 * Before DP 1.4, DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit was reserved
> > > +	 * and read 0 so it's safe to check against it even if DP revision is
> > > +	 * <1.4
> > > +	 */
> > > +	err = drm_dp_dpcd_readb(aux, DP_TRAINING_AUX_RD_INTERVAL, values);
> > > +	if (err < 0)
> > > +		return err;
> > > +
> > > +	if (values[0] & DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT)
> > > +		addr = DP_DP13_DPCD_REV;
> > > +	else
> > > +		addr = DP_DPCD_REV;
> > > +
> > > +	err = drm_dp_dpcd_read(aux, addr, values, sizeof(values));
> > >  	if (err < 0)
> > >  		return err;
> > >  
> > > -- 
> > > 2.17.1
> > > 
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel



> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


-- 
Ville Syrjälä
Intel
