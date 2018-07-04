Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647C2C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1535120837
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="i6fHUDvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1535120837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934200AbeGDIRB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:17:01 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44224 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934099AbeGDIQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:16:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id f12-v6so3414050edq.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 01:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1DRkCr9ug/slPuCZ/YPl0hBBtvOLBt5FTF0jZJKPt6g=;
        b=i6fHUDvX4nH6ATc3q+Xnz9HZe0CCh7XNTM1eOmK4b585r/H1UyKYZcrgo/YnekWkXN
         yPq/48hPyrrhnGNcVzvpAoAugFXXjWEQCI5Xsk6Vi7cYKIFyw3BN6AMC7H7fQQqkEIPA
         4FC8objY9GWZY6lW4lexG3fsy0FPtC8ePgpoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=1DRkCr9ug/slPuCZ/YPl0hBBtvOLBt5FTF0jZJKPt6g=;
        b=Tvrkr/NV+JG4uOplt/hqtpdUTLIRpi739TFovo28cNQWki40tTaB2xkTDnLENHphqL
         3O64GBAgSk1gS+6olHzr/C5Ufu+Iy8/8+PVQpMlAFktdSGOumQVDDsF/8/i9BqzV53H2
         mqvixrMDdrSFBK63goFTEhXdx990GLcymb4o1Nf1jawlA/tTwII2kPJaW4Pp26w6rA+8
         MmwOUtcz5xV8zvJPJD/0ES48Bvn8M8+nVcBD9zjzl2nEIicPPutOD+5VHVZAslLZU+T1
         MK6gsWmGyFGECA/agiwPfDEIFSvHWbJ7/4YoQlTiUmPGCG/bE6R/YOJBJ76L9jnOZ3JO
         q2lg==
X-Gm-Message-State: APt69E33U1v8x0etOtPOnM18UpK+V77dlwBPVWXoO/aGDH5RA6xwhbzL
        tw983PEpDU63lmz5IhpNRKw+Ww==
X-Google-Smtp-Source: AAOMgpcvIeEUk8YrA2sXxw1YmY3IvK23ZC8HaPpX3+5SXx8naEvl7JgcrF1O+Ueha8BmYZ3wZSCJqg==
X-Received: by 2002:a50:8b66:: with SMTP id l93-v6mr1654069edl.44.1530692211882;
        Wed, 04 Jul 2018 01:16:51 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id b22-v6sm1645860edn.0.2018.07.04.01.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 01:16:51 -0700 (PDT)
Date:   Wed, 4 Jul 2018 10:16:49 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Damian Kos <dkos@cadence.com>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        pgaj@cadence.com, ltyrala@cadence.com, stelford@cadence.com
Subject: Re: [PATCH 03/12] drm/dp: add helpers for
 drm_dp_set_adjust_request_pre_emphasis and drm_dp_set_adjust_request_voltage
Message-ID: <20180704081648.GI3891@phenom.ffwll.local>
Mail-Followup-To: Damian Kos <dkos@cadence.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        pgaj@cadence.com, ltyrala@cadence.com, stelford@cadence.com
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
 <1530612152-27555-4-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530612152-27555-4-git-send-email-dkos@cadence.com>
X-Operating-System: Linux phenom 4.16.0-2-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 11:02:14AM +0100, Damian Kos wrote:
> From: Quentin Schulz <quentin.schulz@free-electrons.com>
> 
> We already have functions to get the adjust request voltage and
> pre-emphasis for a lane so it makes also sense to be able to set them so
> that we can then easily update them via a DPCD write.
> 
> Add helpers for drm_dp_set_adjust_request_pre_emphasis and
> drm_dp_set_adjust_request_voltage that respectively set the
> pre-emphasis and voltage of a lane in the link status array.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Signed-off-by: Damian Kos <dkos@cadence.com>

Hm usually this is source dependent - some sources only have one
adj/pre-emph value for all lanes, some only 2 (for groups of 2), some for
all four. That's kinda why we don't have helpers for this stuff.

An excellent way to show that your new helpers are useful would be to go
through existing drivers and convert them over, where it makes sense. Same
kinda holds for patch 1.

Thanks, Daniel
> ---
>  drivers/gpu/drm/drm_dp_helper.c |   28 ++++++++++++++++++++++++++++
>  include/drm/drm_dp_helper.h     |    4 ++++
>  2 files changed, 32 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index 3bc2e98..ca2f469 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -120,6 +120,34 @@ u8 drm_dp_get_adjust_request_pre_emphasis(const u8 link_status[DP_LINK_STATUS_SI
>  }
>  EXPORT_SYMBOL(drm_dp_get_adjust_request_pre_emphasis);
>  
> +void drm_dp_set_adjust_request_voltage(u8 link_status[DP_LINK_STATUS_SIZE],
> +				       int lane, u8 volt)
> +{
> +	int i = DP_ADJUST_REQUEST_LANE0_1 + (lane >> 1);
> +	int s = ((lane & 1) ?
> +		 DP_ADJUST_VOLTAGE_SWING_LANE1_SHIFT :
> +		 DP_ADJUST_VOLTAGE_SWING_LANE0_SHIFT);
> +	int idx = i - DP_LANE0_1_STATUS;
> +
> +	link_status[idx] &= ~(DP_ADJUST_VOLTAGE_SWING_LANE0_MASK << s);
> +	link_status[idx] |= volt << s;
> +}
> +EXPORT_SYMBOL(drm_dp_set_adjust_request_voltage);
> +
> +void drm_dp_set_adjust_request_pre_emphasis(u8 link_status[DP_LINK_STATUS_SIZE],
> +					    int lane, u8 pre_emphasis)
> +{
> +	int i = DP_ADJUST_REQUEST_LANE0_1 + (lane >> 1);
> +	int s = ((lane & 1) ?
> +		 DP_ADJUST_PRE_EMPHASIS_LANE1_SHIFT :
> +		 DP_ADJUST_PRE_EMPHASIS_LANE0_SHIFT);
> +	int idx = i - DP_LANE0_1_STATUS;
> +
> +	link_status[idx] &= ~(DP_ADJUST_PRE_EMPHASIS_LANE0_MASK << s);
> +	link_status[idx] |= pre_emphasis << s;
> +}
> +EXPORT_SYMBOL(drm_dp_set_adjust_request_pre_emphasis);
> +
>  void drm_dp_link_train_clock_recovery_delay(const u8 dpcd[DP_RECEIVER_CAP_SIZE]) {
>  	if (dpcd[DP_TRAINING_AUX_RD_INTERVAL] == 0)
>  		udelay(100);
> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> index a488af0..6e64b2a 100644
> --- a/include/drm/drm_dp_helper.h
> +++ b/include/drm/drm_dp_helper.h
> @@ -946,6 +946,10 @@ u8 drm_dp_get_adjust_request_voltage(const u8 link_status[DP_LINK_STATUS_SIZE],
>  				     int lane);
>  u8 drm_dp_get_adjust_request_pre_emphasis(const u8 link_status[DP_LINK_STATUS_SIZE],
>  					  int lane);
> +void drm_dp_set_adjust_request_voltage(u8 link_status[DP_LINK_STATUS_SIZE],
> +				       int lane, u8 volt);
> +void drm_dp_set_adjust_request_pre_emphasis(u8 link_status[DP_LINK_STATUS_SIZE],
> +					    int lane, u8 pre_emphasis);
>  
>  #define DP_BRANCH_OUI_HEADER_SIZE	0xc
>  #define DP_RECEIVER_CAP_SIZE		0xf
> -- 
> 1.7.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
