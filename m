Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDBDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0DC208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0DC208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbeH0K5L convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 06:57:11 -0400
Received: from gloria.sntech.de ([185.11.138.130]:49494 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbeH0K5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 06:57:11 -0400
Received: from wd0180.dip.tu-dresden.de ([141.76.108.180] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fuBgY-0006hA-Gq; Mon, 27 Aug 2018 09:11:38 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sandy Huang <hjc@rock-chips.com>
Cc:     Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>, seanpaul@chromium.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] devicetree/bindings: display: Add document for rockchip RGB output
Date:   Mon, 27 Aug 2018 09:11:37 +0200
Message-ID: <7915686.3ERLj9EHQN@phil>
In-Reply-To: <725cc93f-a441-22bc-ef58-b4b38ec34e17@rock-chips.com>
References: <1529997340-156879-1-git-send-email-hjc@rock-chips.com> <20180703182559.GA12809@rob-hp-laptop> <725cc93f-a441-22bc-ef58-b4b38ec34e17@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandy,

trying to move this forward a bit :-)

Am Mittwoch, 4. Juli 2018, 14:09:56 CEST schrieb Sandy Huang:
> Hi Rob Herring,
> Thanks for your review.
> 
> 在 2018/7/4 2:25, Rob Herring 写道:
> > On Tue, Jun 26, 2018 at 03:15:39PM +0800, Sandy Huang wrote:
> >> This path add support rv1108 and px30 rgb output interface driver.
> > 
> > Bindings are for h/w, not drivers.
> > 
> I will update at next version as following:
> This patch add support rv1108 and px30 rgb output interface
> >>
> >> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> >> Link: https://patchwork.freedesktop.org/patch/msgid/1509522765-118759-1-git-send-email-hjc@rock-chips.com
> >> ---
> >>
> >> Changes in v4: Add support px30
> >> Changes in v3: None
> >> Changes in v2: None
> >>
> >> .../bindings/display/rockchip/rockchip-rgb.txt     | 73 ++++++++++++++++++++++
> >>   1 file changed, 73 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
> >> new file mode 100644
> >> index 0000000..077b9ad
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
> >> @@ -0,0 +1,73 @@
> >> +Rockchip RV1108 RGB interface
> >> +================================
> >> +
> >> +Required properties:
> >> +- compatible: matching the soc type:
> >> +	- "rockchip,px30-rgb";
> >> +	- "rockchip,rv1108-rgb";
> > 
> > This doesn't look right? What (and how) is getting programmed here
> > because you don't have any register interface.
> > 
> This is register for DRM encoder and connecter or bridge for some RGB 
> convert chips driver.
> so far we don't have any register for rgb interface, but it's most 
> probable need to config some register for rgb interface in feauture for 
> rockchip platform.

I think the basic-issue Rob was pointing out is that the devicetree
describes hardware blocks and not the software representation.

And the rgb output is not a separate block, but instead just a property
of the vop itself, hence should possibly not have a separate "device".

As I'm currently tinkering with rk3188 display support [0] - which only has
rgb output at all - I modified your patch a bit to to showcase how that
could look [1], where the soc vop struct simply has a feature flag
indicating indicating a raw rgb output and the rgb driver then
looks for bridges in the vop endpoints to distinguish them from
soc-internals output encoders.

Let me know what you think :-)
Heiko

[0] https://github.com/mmind/linux-rockchip/commits/wip/rk3188-lcdc
[1] https://github.com/mmind/linux-rockchip/commit/fe74d2c4d76bcb6035b7207753e6afb85335b6cd
needs also https://github.com/mmind/linux-rockchip/commit/c5a48c772f3564211dcd1ec71004de1d6dbb0307



