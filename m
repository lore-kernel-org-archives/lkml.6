Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96313C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBE620645
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mKKj61kg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBE620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeIZPn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:43:59 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55354 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeIZPn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:43:58 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8Q9UGAm011510;
        Wed, 26 Sep 2018 04:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537954216;
        bh=26SoNfrqdeJA5EYOU++kU3cVs6/C9dWhrZRYBp67TJM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mKKj61kgoP6/siPPvPCik/tLPirzPlto9A9qwVY8BgsS1A5luppPuzxmbQut6mc9I
         fLaYWEMpfSc4sfcc6N1KBVMTNcW8PObTqJScmva0uqJV3Ce3CYEPQb6vi2lqvjJkK0
         4fKe/qcQe4gkCRrXsKf+VyxdX4S3ZIEnfMkUkDsA=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8Q9UGPW030881;
        Wed, 26 Sep 2018 04:30:16 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 26
 Sep 2018 04:30:16 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 26 Sep 2018 04:30:16 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8Q9UAhh011636;
        Wed, 26 Sep 2018 04:30:11 -0500
Subject: Re: [Intel-gfx] [PATCH 4/5] drm/omapdrm: Substitute format_is_yuv()
 with format->is_yuv
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Ayan Kumar Halder <ayan.halder@arm.com>
CC:     <liviu.dudau@arm.com>, <brian.starkey@arm.com>,
        <gustavo@padovan.org>, <maarten.lankhorst@linux.intel.com>,
        <seanpaul@chromium.org>, <airlied@linux.ie>,
        <jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
        <rodrigo.vivi@intel.com>, <intel-gfx@lists.freedesktop.org>,
        <hjc@rock-chips.com>, <heiko@sntech.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <laurent.pinchart@ideasonboard.com>, <sre@kernel.org>,
        <bparrot@ti.com>, <peter.ujfalusi@ti.com>, <afd@ti.com>,
        <dri-devel@lists.freedesktop.org>, <maxime.ripard@bootlin.com>,
        <wens@csie.org>, <malidp@foss.arm.com>, <nd@arm.com>
References: <1531847626-22248-1-git-send-email-ayan.halder@arm.com>
 <1531847626-22248-4-git-send-email-ayan.halder@arm.com>
 <20180718101741.GU5565@intel.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <57ef0cb3-c032-3854-cff5-78fbe2a5ed20@ti.com>
Date:   Wed, 26 Sep 2018 12:30:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718101741.GU5565@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/07/18 13:17, Ville Syrjälä wrote:
> On Tue, Jul 17, 2018 at 06:13:45PM +0100, Ayan Kumar Halder wrote:
>> drm_format_info table has a field 'is_yuv' to denote if the format
>> is yuv or not. The driver is expected to use this instead of
>> having a function for the same purpose.
>>
>> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
>> ---
>>  drivers/gpu/drm/omapdrm/dss/dispc.c | 26 ++++++++++----------------
>>  1 file changed, 10 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
>> index 84f274c..8d2d7a4 100644
>> --- a/drivers/gpu/drm/omapdrm/dss/dispc.c
>> +++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
>> @@ -1140,18 +1140,6 @@ static void dispc_ovl_set_color_mode(struct dispc_device *dispc,
>>  	REG_FLD_MOD(dispc, DISPC_OVL_ATTRIBUTES(plane), m, 4, 1);
>>  }
>>  
>> -static bool format_is_yuv(u32 fourcc)
>> -{
>> -	switch (fourcc) {
>> -	case DRM_FORMAT_YUYV:
>> -	case DRM_FORMAT_UYVY:
>> -	case DRM_FORMAT_NV12:
>> -		return true;
>> -	default:
>> -		return false;
>> -	}
>> -}
>> -
>>  static void dispc_ovl_configure_burst_type(struct dispc_device *dispc,
>>  					   enum omap_plane_id plane,
>>  					   enum omap_dss_rotation_type rotation)
>> @@ -1910,11 +1898,14 @@ static void dispc_ovl_set_scaling_uv(struct dispc_device *dispc,
>>  	int scale_x = out_width != orig_width;
>>  	int scale_y = out_height != orig_height;
>>  	bool chroma_upscale = plane != OMAP_DSS_WB;
>> +	const struct drm_format_info *info;
>> +
>> +	info = drm_format_info(fourcc);
> 
> Not sure Tomi wants drm usage (apart from the fourccs) inside the
> dss code.

Seems like I have missed this. No, I don't have anything against drm
usage inside dss. That's the way we've been moving after we managed to
get rid of omapfb links.

I'll pick this up.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
