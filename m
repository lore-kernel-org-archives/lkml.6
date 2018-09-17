Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E316ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2627E2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="xJOEdVNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2627E2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbeIRFHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:07:05 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:60166 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbeIRFHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:07:05 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 2D3A75C05D1;
        Tue, 18 Sep 2018 01:37:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537227445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XN35WvwzjX5Wtj5t1OzO4YCiizmzxdLyF942ZqhdU6Y=;
        b=xJOEdVNQmi3/c35N1THt725VnghtKNzPlRsmXA+rc7VMutZsyFw/LizGScJFcecVCKKWJt
        yiuxxttpY55QgWK+eqKG48Pd97ljJgqGIb9+lzjG9kIjqAEAf+bbLZrmZ3egtxhzjF9reK
        X3PFb1e9KgS6899j9btOjdDe7iVDdjk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 17 Sep 2018 16:37:25 -0700
From:   Stefan Agner <stefan@agner.ch>
To:     Sean Paul <sean@poorly.run>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Robert Chiras <robert.chiras@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        dri-devel@lists.freedesktop.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [RESEND 0/5] drm/mxsfb: Fix runtime PM for unpowering lcdif block
In-Reply-To: <20180917191602.GP188300@art_vandelay>
References: <cover.1537191359.git.leonard.crestez@nxp.com>
 <20180917191602.GP188300@art_vandelay>
Message-ID: <80da134658da77f0d3f8fda6894ab756@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.09.2018 12:16, Sean Paul wrote:
> On Mon, Sep 17, 2018 at 04:42:10PM +0300, Leonard Crestez wrote:
>> Adding lcdif nodes to a power domain currently doesn't work, it results
>> in black/corrupted screens or hangs. While the driver does enable
>> runtime pm it does not deal correctly with the block being unpowered.
>>
>> ---
>>
>> All patches in this series have review tags from a while ago and I
>> tested them again on top of next-20180913. No changes since last
>> version: https://lkml.org/lkml/2018/8/27/299
>>
>> This series stalled so I reached out to Marek on IRC and he was
>> surprised to be listed as maintainer
> 
> Hopefully not too surprised since Marek added themself to MAINTAINERS when
> adding the driver :-)

There have been some confusion about the DRM development processes around the mxsfb already in the past.

I guess in general it would be quite clear: Marek as maintainer of mxsfb should pick up the patches and send a pull request to the next level of maintainer, which in DRM case would be David Airlie:

https://01.org/linuxgraphics/gfx-docs/maintainer-tools/repositories.html

> 
> I suppose we should probably move this to drm-misc since it qualifies as a
> "small driver" and needs a home. Looking through git history shows the last
> mxsfb-specific change was back in 02/17. Everything else has been drm-wide
> refactors. Thoughts?
> 
> Marek/Leonard: Care to sign up to be listed as a reviewers?
> 

drm-misc seems to make sense. I volunteer to be listed as reviewer or co-maintainer.

I am actually maintainer for the DCU driver (another display controller IP used in NXP products). I should probably move that to drm-misc too...

--
Stefan

> Sean
> 
>> and asked me to resend and add
>> Daniel Vetter.
>>
>> Perhaps it would help to clarify that the pengutronix people should feel
>> free to push patches in this area?
>>
>> Right now drm/imx is mostly for IPUv3 but there are other display output
>> paths on imx, such as the LCDIF supported by this driver. This LCDIF
>> block is included on imx8 so still quite relevant.
>>
>> Leonard Crestez (5):
>>   drm/mxsfb: Move axi clk enable/disable to crtc enable/disable
>>   drm/mxsfb: Fix initial corrupt frame when activating display
>>   drm/mxsfb: Add pm_runtime calls to pipe_enable/disable
>>   drm/mxsfb: Add PM_SLEEP support
>>   drm/mxsfb: Switch to drm_atomic_helper_commit_tail_rpm
>>
>>  drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 53 +++++++++++++++++++-----------
>>  drivers/gpu/drm/mxsfb/mxsfb_drv.c  | 40 ++++++++++++++++++++++
>>  2 files changed, 74 insertions(+), 19 deletions(-)
>>
>> --
>> 2.17.1
>>
