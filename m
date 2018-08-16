Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CCCC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 11:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E24520C03
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 11:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E24520C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391315AbeHPOkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 10:40:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:36858 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbeHPOkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 10:40:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2018 04:42:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,247,1531810800"; 
   d="scan'208";a="225103910"
Received: from ajinkyax-mobl1.ger.corp.intel.com (HELO [10.252.50.225]) ([10.252.50.225])
  by orsmga004.jf.intel.com with ESMTP; 16 Aug 2018 04:42:10 -0700
Subject: Re: [RFC PATCH v4 1/2] drm: Add generic colorkey properties for
 display planes
To:     Dmitry Osipenko <digetx@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sinclair Yeh <syeh@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180807172202.1961-1-digetx@gmail.com>
 <20180807172202.1961-2-digetx@gmail.com>
 <20180808081608.GK30658@n2100.armlinux.org.uk> <2089566.PDTrKWWE8Q@dimapc>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <cbf46404-051b-312e-0201-7956229abd20@linux.intel.com>
Date:   Thu, 16 Aug 2018 13:42:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2089566.PDTrKWWE8Q@dimapc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 08-08-18 om 16:30 schreef Dmitry Osipenko:
> On Wednesday, 8 August 2018 11:16:09 MSK Russell King - ARM Linux wrote:
>> On Tue, Aug 07, 2018 at 08:22:01PM +0300, Dmitry Osipenko wrote:
>>> + * Glossary:
>>> + *
>>> + * Destination plane:
>>> + *	Plane to which color keying properties are applied, this planes takes
>>> + *	the effect of color keying operation. The effect is determined by a
>>> + *	given color keying mode.
>>> + *
>>> + * Source plane:
>>> + *	Pixels of this plane are the source for color key matching operation.
>> ...
>>
>>> +	/**
>>> +	 * @DRM_PLANE_COLORKEY_MODE_TRANSPARENT:
>>> +	 *
>>> +	 * Destination plane pixels are completely transparent in areas
>>> +	 * where pixels of a source plane are matching a given color key
>>> +	 * range, in other cases pixels of a destination plane are 
> unaffected.
>>> +	 * In areas where two or more source planes overlap, the topmost
>>> +	 * plane takes precedence.
>>> +	 */
>> This seems confusing to me.
>>
>> What you seem to be saying is that the "destination" plane would be the
>> one which is (eg0 the graphic plane, and the "source" plane would be the
>> the plane containing (eg) the video.  You seem to be saying that the
>> colorkey matches the video and determines whether the pixels in the
>> graphic plane are opaque or transparent.
> Your example is correct.
>
> With the "plane_mask" property we can specify any plane as the "source" for 
> color key, so it can been either a video plane or graphic plane and even both 
> at the same time.
I'm not sure we should specify plane mask from userspace.

Can't we make major loops? How do you want to handle those?
>> Surely that is the wrong way round - in video overlay, you want to
>> colorkey match the contents of the graphic plane to determine which
>> pixels from the video plane to overlay.
> The "transparent" mode makes the color-matched pixels to become transparent, 
> you want the inversion effect and hence that should be called something like a 
> "transparent-inverted" mode. Maarten Lankhorst was asking for that mode in his 
> comment to v3, I'm leaving for somebody else to add that mode later since 
> there is no real use for it on Tegra right now.
I would like it to be described and included, so I can convert the existing intel_sprite_set_colorkey_ioctl to atomic.

Then again, could transparent-inverted also be handled by setting transparent on the primary?


> So in your case the graphic plane will be the "source" plane (specified via 
> the colorkey.plane_mask property), video plane will be the "destination" plane 
> (plane to which the colorkey properties are applied) and the colorkey.mode 
> will be "transparent-inverted". Pixels of the "source" plane are being matched 
> and "destination" plane takes the effect of color keying operation, i.e. the 
> color-matched pixels of graphic plane leave the video plane pixels unaffected 
> and the unmatched pixels make the video plane pixels transparent.
>
>> If it's the other way around (source is the graphic, destination is the
>> video) it makes less sense to use the "source" and "destination" terms,
>> I can't see how you could describe a plane that is being overlaid on
>> top of another plane as a "destination".
> Tegra has a bit annoying limitations in regard to a reduced plane blending 
> functionality when color keying is enabled. I found that the best variant to 
> work around the limitations is to move the graphic plane on top of the video 
> plane and to make the graphic plane to match itself. I.e. the matched pixels 
> of graphic plane become transparent and hence poked by video plane.
>
>> I guess the terminology has come from a thought about using a GPU to
>> physically do the colorkeying when combining two planes - if the GPU
>> were to write to the "destination" plane, then this would be the wrong
>> way around.  For starters, taking the above example, the video plane
>> may well be smaller than the graphic plane.  If it's the other way
>> around, that has other problems, like destroying the colorkey in the
>> graphic plane when writing the video plane's contents to it.
> It all depends on a use-case scenario. It won't be easy for userspace to 
> generalize the usage of color keying, at best the color keying interface could 
> be generalized and then userspace may choose the best fitting variant based on 
> available HW capabilities.
There's TEST_ONLY for a reason, though I guess it makes generic color keying slightly more invovled for userspace. :)
>> So, in summary, I don't think "destination" and "source" are
>> particularly good terms to describe the operation, and I think you have
>> them swapped in your description of
>> "DRM_PLANE_COLORKEY_MODE_TRANSPARENT".
> Maybe the DRM_PLANE_COLORKEY_MODE_TRANSPARENT should become 
> DRM_PLANE_COLORKEY_MODE_TRANSPARENT_INVERTED? 
>
> Any more opinions?
>
>
>

