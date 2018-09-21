Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C94C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D46821522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D46821522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389426AbeIUNoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:44:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:7615 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389156AbeIUNoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:44:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 00:57:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,284,1534834800"; 
   d="scan'208";a="74816928"
Received: from labuser-z97x-ud5h.jf.intel.com (HELO intel.com) ([10.54.75.151])
  by orsmga007.jf.intel.com with ESMTP; 21 Sep 2018 00:57:02 -0700
Date:   Fri, 21 Sep 2018 00:59:30 -0700
From:   Manasi Navare <manasi.d.navare@intel.com>
To:     Damian Kos <dkos@cadence.com>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, quentin.schulz@bootlin.com,
        jartur@cadence.com, jbergsagel@ti.com, ltyrala@cadence.com,
        stelford@cadence.com,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        pgaj@cadence.com, piotrs@cadence.com
Subject: Re: [PATCH v4 2/5] drm/dp: fix link probing for devices supporting
 DP 1.4+
Message-ID: <20180921075929.GA28323@intel.com>
References: <1537455288-20223-1-git-send-email-dkos@cadence.com>
 <1537455288-20223-3-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537455288-20223-3-git-send-email-dkos@cadence.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch. Verified with the DP 1.4 spec and looks good to me.
Also look at the related patch that makes use of the correct extended capabilities:

https://patchwork.freedesktop.org/patch/249400/

Reviewed-by: Manasi Navare <manasi.d.navare@intel.com>

Manasi


On Thu, Sep 20, 2018 at 03:54:37PM +0100, Damian Kos wrote:
> From: Quentin Schulz <quentin.schulz@free-electrons.com>
> 
> DP 1.4 introduced a DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit in
> DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from
> DP_DPCD_REV to DP_ADAPTER_CAP should be retrieved starting from
> DP_DPCD_REV_EXTENDED. All registers are copied except DP_DPCD_REV,
> DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT which represent the
> "true capabilities" of DPRX device.
> 
> Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT
> might falsely return lower capabilities to "avoid interoperability
> issues with some of the existing DP Source devices that malfunction
> when they discover the higher capabilities within those three
> registers.".
> 
> Before DP 1.4, DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit was reserved
> and read 0 so it's safe to check against it even if DP revision is
> <1.4
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Signed-off-by: Damian Kos <dkos@cadence.com>
> ---
>  drivers/gpu/drm/drm_dp_helper.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index 8c6b9fd89f8a..735ebde5c2f0 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -370,10 +370,38 @@ int drm_dp_link_probe(struct drm_dp_aux *aux, struct drm_dp_link *link)
>  {
>  	u8 values[3];
>  	int err;
> +	unsigned int addr;
>  
>  	memset(link, 0, sizeof(*link));
>  
> -	err = drm_dp_dpcd_read(aux, DP_DPCD_REV, values, sizeof(values));
> +	/*
> +	 * DP 1.4 introduced a DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit in
> +	 * DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from
> +	 * DP_DPCD_REV to DP_ADAPTER_CAP should be retrieved starting from
> +	 * DP_DPCD_REV_EXTENDED. All registers are copied except DP_DPCD_REV,
> +	 * DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT which represent the
> +	 * "true capabilities" of DPRX device.
> +	 *
> +	 * Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT
> +	 * might falsely return lower capabilities to "avoid interoperability
> +	 * issues with some of the existing DP Source devices that malfunction
> +	 * when they discover the higher capabilities within those three
> +	 * registers.".
> +	 *
> +	 * Before DP 1.4, DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit was reserved
> +	 * and read 0 so it's safe to check against it even if DP revision is
> +	 * <1.4
> +	 */
> +	err = drm_dp_dpcd_readb(aux, DP_TRAINING_AUX_RD_INTERVAL, values);
> +	if (err < 0)
> +		return err;
> +
> +	if (values[0] & DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT)
> +		addr = DP_DP13_DPCD_REV;
> +	else
> +		addr = DP_DPCD_REV;
> +
> +	err = drm_dp_dpcd_read(aux, addr, values, sizeof(values));
>  	if (err < 0)
>  		return err;
>  
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
