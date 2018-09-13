Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C78C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB0420839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cyua+R4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB0420839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbeIMQ3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:29:38 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35115 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbeIMQ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:29:37 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180913112035euoutp0220cf2cd3aa5142f7cb6296c8fb0023a8~T8a-E09nd2530225302euoutp02T
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 11:20:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180913112035euoutp0220cf2cd3aa5142f7cb6296c8fb0023a8~T8a-E09nd2530225302euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536837635;
        bh=j0Df09PgAGTSOznot+7KMtnTPaH0t2u1fyXySIkbIII=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=cyua+R4DN+NskiKB5/xaYIj6a7gfCWL44LpIGgcv1N0qv/4S00PRjVDSLnhLb3Aax
         Orq4dk/gge34bIN2kne5beRpq5SYj8sjyA+C6OjcWqZPqffatHxKmAUMoPPrUB9X4H
         GIq8QcYEG+mmfgguYqGUgcfHMvnPvwywYyF4b+w8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180913112033eucas1p19589e09ddf429fef076cd497f07d58cd~T8a97s9240075900759eucas1p1V;
        Thu, 13 Sep 2018 11:20:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BA.20.04441.1084A9B5; Thu, 13
        Sep 2018 12:20:33 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180913112032eucas1p1f2b270b3bdcc8a434130bf52d18d45fe~T8a8z3f662504225042eucas1p1P;
        Thu, 13 Sep 2018 11:20:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180913112032eusmtrp1b76c04cce03887ad5f75302baf553e4b~T8a8iU3RJ2710627106eusmtrp15;
        Thu, 13 Sep 2018 11:20:32 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-0b-5b9a48019a54
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 64.45.04128.0084A9B5; Thu, 13
        Sep 2018 12:20:32 +0100 (BST)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180913112031eusmtip1f80b49e1c8fd8fc3e01c708c6d6337dd~T8a7qX6TC0565505655eusmtip1I;
        Thu, 13 Sep 2018 11:20:31 +0000 (GMT)
Subject: Re: [PATCH v3 3/5] drm/dp: make dp_link_status and
 dp_get_lane_status usable from outside of the core
To:     Damian Kos <dkos@cadence.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     pgaj@cadence.com, ltyrala@cadence.com, stelford@cadence.com,
        jartur@cadence.com, piotrs@cadence.com
From:   Andrzej Hajda <a.hajda@samsung.com>
Date:   Thu, 13 Sep 2018 13:20:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535451894-2518-4-git-send-email-dkos@cadence.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se2xLYRjGfefW007nqLE3JhNFMJkhIh8TNvHHSYgQIrJGKI5trDOtjbln
        bl3ruhl6SpndXCqmZaPYkq1RG3bD2GRW02BmxJhZZEadif33e9/nfb/3eZKPJVXZzHA2PnGz
        oE/UJqgZBVV0v7s6HPGiZnJlVSg+XFVB4DRjO43Puato3NQ8HT/t/Mzg216XDPe2tNH4bMZO
        bH12F+H047ky7HhTT+MnrjMM7vD2kvjtz6k4+8tNCuc9ryVwyYssCl+0ORG+XlpC4/333DLc
        lOlG+KPPjqKG8XabHfE2+3bent5G8E+OHCZ4q9FC847L6Qxf/N1L87aKxXyz2UPwztzd/O2M
        ewTvcTXK+B6xlOKL620k/9URumhQjGLWWiEhPkXQR8xepYjLu6FJ6h61dd+VEtke5A0xITkL
        3DQ4YS6SmZCCVXEXEVQUOJFUfENgzs8ipeIrgvO+O/S/lfffTX1CAQJnQ2XfSjuC99fS/k4N
        4ZKgoeUU5ReCOJGGuh4rY0IsS3LxcPLRJv8Mw02AHmcD42eKGwuFZZ8JPw/lloPbm438rOQG
        Q4XFR/lZzkWBzdz0l0luJBS3nyElDoZG3znCfws4LwsHG+8S0nIK7H2UiSTb88B69SQp8RD4
        4Lkhk3gEPMw8REm8G9IsT0npISOCBzkFjCREQrmnlpYCTIBrrgipHQ2tL7tIfxu4QHjRPljy
        EwgZRaf62kowHlBJ06Og+fHNPgfBkFfTyRxDarFfSrFfMrFfMvH/3fOIuoyChWSDLlYwTEkU
        tkwyaHWG5MTYSWs26hzoz8d9+MvTcQt11q0uQxyL1AOVp8dZNCpam2JI1ZUhYEl1kPJolKhR
        KddqU7cJ+o0r9ckJgqEMhbCUOlgZGLZOo+JitZuFDYKQJOj/qQQrH74HWdtSuppinrXMXOBb
        cj3U+AHPDct2HDGNnzNAdf+dZVd5Vo6x8ELc/ter9v5MCF9W2xspDzgwaHVyecNxXaur49j8
        yZcmTosoGn069+iW8PnmkhUB1esV3A4iPjI1pDr/W8C7HzXRY3K662ZsD2rtGlFfWrgwtfLV
        J/lSscYdfSl6XEy+mjLEaaeEkXqD9jcAd/GqtAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+93HdpVWt/n6YVA26E3Tzcd+Rpl/xY2gkrDMFbbcdVrOye5W
        WVlRWjmz0khy2sxQEh1S87G0tLCVrMIozZyw1JIwfGWSKc7MtQL/+3DO93MOBw6FCy1kIJWS
        pmO1aYpUEc+beP27zblpEWOUh3Q7l6C8djuGLlwZIVGprZ1Ezt4I1PlzjIca+5r4aO7zEInu
        FGSi4g9PAMrJL+cjy5cuEnU0lfDQj745HH2dkaKy8XoCVXx8h6GW7lsEqjTVAvTwaQuJsptt
        fOS8aQNoeMAMov0Zs8kMGJP5NGPOGcKYjmt5GFN8pYhkLFU5PMY62UcyJnsM05vbhjG15eeY
        xoJmjGlr6uEzs8anBGPtMuHMhGXFnqXx4i1ajV7HBiVrON1WkVyCpGJJJBJLwyLFklDZoc3S
        cFFw1BYlm5pynNUGRx0WJ1fUydOnV53Mqm7hnwd9yw3Ai4J0GBycNOBuFtIVAFb+9vPUA+Dj
        0hHcwz7Q1WXgeTJDAFqGVQZAUT50OnzeLDcAb8qXNpHwTdY3wp3B6RRYNjHFdzeEtB3AsQID
        6W7w6PVwttbxd5CAjoIuhzvkRRH0avigdQxzsx8dB6vvD5KezDJoLxr4O9SLjoamXOe/BWuh
        y/Qe9/BKaB0p+ccBsGegFLsBhMYFunGBYlygGBcodwFRBXxZPadWqTmpmFOoOX2aSpyoUVvA
        /L80vJyuewQMo3tbAU0B0WLBoKhILiQVx7kMdSuAFC7yFVyPNsqFAqUi4xSr1SRo9aks1wrC
        54/LxwP9EjXz35emS5CES2QoUiILlYVGIFGA4G1IRryQVil07DGWTWe1/z2M8go8Dw5mF26P
        yTzCp/RfY41ylWPJ5CLJ4pn0/qQ4yl/2Kkm87UWNq2ac2pgddGk0c3Ku9nvA5atTt2mlNcG7
        dHafYzdxZldiW2H3RCdtt7XEFTQcSbae2MaH6z456nFX75rRA8q6Z/f6I8N27P91VH3BlhVb
        rKw+O7uzafPK6YuyOp8SEcElKyQbcC2n+AOYuUHPRQMAAA==
Message-Id: <20180913112032eucas1p1f2b270b3bdcc8a434130bf52d18d45fe~T8a8z3f662504225042eucas1p1P@eucas1p1.samsung.com>
X-CMS-MailID: 20180913112032eucas1p1f2b270b3bdcc8a434130bf52d18d45fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180828102610epcas4p37c400fbe4836e18dfd1862c3d12e8998
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180828102610epcas4p37c400fbe4836e18dfd1862c3d12e8998
References: <1535451894-2518-1-git-send-email-dkos@cadence.com>
        <CGME20180828102610epcas4p37c400fbe4836e18dfd1862c3d12e8998@epcas4p3.samsung.com>
        <1535451894-2518-4-git-send-email-dkos@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.08.2018 12:24, Damian Kos wrote:
> From: Quentin Schulz <quentin.schulz@bootlin.com>
>
> dp_link_status and dp_get_lane_status are pretty generic and can be used for
> other means, so let's make it "public".
>
> This adds drm_dp_link_status and drm_dp_get_lane_status to the header file and
> add the appropriate EXPORT_SYMBOL for it so that it can be used by other
> drivers, be they compiled built-in or as modules.

If you want to export them please document functions and their arguments.
Moreover, these functions are so tiny, so they can be defined as inline.


>
> Signed-off-by: Damian Kos <dkos@cadence.com>
No author sign-off.

Regards
Andrzej


> ---
>  drivers/gpu/drm/drm_dp_helper.c | 20 +++++++++++---------
>  include/drm/drm_dp_helper.h     |  3 +++
>  2 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index 4b5bf6ee7fa7..ee9ec2ccf878 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -43,19 +43,21 @@
>   */
>  
>  /* Helpers for DP link training */
> -static u8 dp_link_status(const u8 link_status[DP_LINK_STATUS_SIZE], int r)
> +u8 drm_dp_link_status(const u8 link_status[DP_LINK_STATUS_SIZE], int r)
>  {
>  	return link_status[r - DP_LANE0_1_STATUS];
>  }
> +EXPORT_SYMBOL(drm_dp_link_status);
>  
> -static u8 dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE],
> +u8 drm_dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE],
>  			     int lane)
>  {
>  	int i = DP_LANE0_1_STATUS + (lane >> 1);
>  	int s = (lane & 1) * 4;
> -	u8 l = dp_link_status(link_status, i);
> +	u8 l = drm_dp_link_status(link_status, i);
>  	return (l >> s) & 0xf;
>  }
> +EXPORT_SYMBOL(drm_dp_get_lane_status);
>  
>  bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
>  			  int lane_count)
> @@ -64,12 +66,12 @@ bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
>  	u8 lane_status;
>  	int lane;
>  
> -	lane_align = dp_link_status(link_status,
> -				    DP_LANE_ALIGN_STATUS_UPDATED);
> +	lane_align = drm_dp_link_status(link_status,
> +					DP_LANE_ALIGN_STATUS_UPDATED);
>  	if ((lane_align & DP_INTERLANE_ALIGN_DONE) == 0)
>  		return false;
>  	for (lane = 0; lane < lane_count; lane++) {
> -		lane_status = dp_get_lane_status(link_status, lane);
> +		lane_status = drm_dp_get_lane_status(link_status, lane);
>  		if ((lane_status & DP_CHANNEL_EQ_BITS) != DP_CHANNEL_EQ_BITS)
>  			return false;
>  	}
> @@ -84,7 +86,7 @@ bool drm_dp_clock_recovery_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
>  	u8 lane_status;
>  
>  	for (lane = 0; lane < lane_count; lane++) {
> -		lane_status = dp_get_lane_status(link_status, lane);
> +		lane_status = drm_dp_get_lane_status(link_status, lane);
>  		if ((lane_status & DP_LANE_CR_DONE) == 0)
>  			return false;
>  	}
> @@ -99,7 +101,7 @@ u8 drm_dp_get_adjust_request_voltage(const u8 link_status[DP_LINK_STATUS_SIZE],
>  	int s = ((lane & 1) ?
>  		 DP_ADJUST_VOLTAGE_SWING_LANE1_SHIFT :
>  		 DP_ADJUST_VOLTAGE_SWING_LANE0_SHIFT);
> -	u8 l = dp_link_status(link_status, i);
> +	u8 l = drm_dp_link_status(link_status, i);
>  
>  	return ((l >> s) & 0x3) << DP_TRAIN_VOLTAGE_SWING_SHIFT;
>  }
> @@ -112,7 +114,7 @@ u8 drm_dp_get_adjust_request_pre_emphasis(const u8 link_status[DP_LINK_STATUS_SI
>  	int s = ((lane & 1) ?
>  		 DP_ADJUST_PRE_EMPHASIS_LANE1_SHIFT :
>  		 DP_ADJUST_PRE_EMPHASIS_LANE0_SHIFT);
> -	u8 l = dp_link_status(link_status, i);
> +	u8 l = drm_dp_link_status(link_status, i);
>  
>  	return ((l >> s) & 0x3) << DP_TRAIN_PRE_EMPHASIS_SHIFT;
>  }
> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> index 06a478679781..9930b2b269f2 100644
> --- a/include/drm/drm_dp_helper.h
> +++ b/include/drm/drm_dp_helper.h
> @@ -952,6 +952,9 @@
>  #define DP_MST_LOGICAL_PORT_0 8
>  
>  #define DP_LINK_STATUS_SIZE	   6
> +
> +u8 drm_dp_link_status(const u8 link_status[DP_LINK_STATUS_SIZE], int r);
> +u8 drm_dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE], int lane);
>  bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
>  			  int lane_count);
>  bool drm_dp_clock_recovery_ok(const u8 link_status[DP_LINK_STATUS_SIZE],


