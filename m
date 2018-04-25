Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755378AbeDYRL2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:11:28 -0400
Received: from mail-ot0-f174.google.com ([74.125.82.174]:35579 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754649AbeDYRL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:11:26 -0400
X-Google-Smtp-Source: AIpwx491oFbKigI48Mc6P/dndAPNdYQcH7aemjZC49+TgpHfjaCFgRdsRsw+UVUJ14gI3TYaH13HOQ==
Date: Wed, 25 Apr 2018 12:11:23 -0500
From: Rob Herring <robh@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Philippe CORNU <philippe.cornu@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH v2 1/2] dt-bindings/display/bridge: sii902x: add optional
 power supplies
Message-ID: <20180425171123.xhyoay3nu463btoq@rob-hp-laptop>
References: <20180425075314.19137-1-philippe.cornu@st.com>
 <16954794.QiYqgNKfkn@avalon>
 <e18d1a3b-a2eb-74f2-ab88-7bf01af0754b@st.com>
 <1559016.ZjzeSVB84W@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559016.ZjzeSVB84W@avalon>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 04:17:25PM +0300, Laurent Pinchart wrote:
> Hi Philippe,
> 
> On Wednesday, 25 April 2018 15:20:04 EEST Philippe CORNU wrote:
> > On 04/25/2018 11:01 AM, Laurent Pinchart wrote:
> > > On Wednesday, 25 April 2018 10:53:13 EEST Philippe Cornu wrote:
> > >> Add optional power supplies using the description found in
> > >> "SiI9022A/SiI9024A HDMI Transmitter Data Sheet (August 2016)".
> > >>
> > >> There is a single 1v2 supply voltage named vcc12 from which cvcc12
> > >> (digital core) and avcc12 (TMDS analog) are derived because according
> > >> to this data sheet:
> > >> "cvcc12 and avcc12 can be derived from the same power source"
> > > 
> > > Shouldn't the power supplies be mandatory, as explained by Mark in
> > > https://lists.freedesktop.org/archives/dri-devel/2018-April/172400.html
> > > ? 
> > 
> > Laurent,
> > Many thanks Laurent for your comment, I understood the merge of the two 
> > 1v2 power supplies but missed the "mandatory" part... maybe because this 
> > patch (with optional power supplies) already got the reviewed-by from 
> > Rob, I thought the discussion thread you pointed out was applicable 
> > "only" to totally new driver documentation.
> > 
> > So, on my side, as a "new user" of sii902x IC, no problem to put these 
> > power supplies as mandatory instead of optional properties but I would 
> > like to be sure this is applicable to both old and new bindings doc : )
> 
> We obviously need to retain backward compatibility, so on the driver side you 
> need to treat those power supplies as optional. From a DT bindings point of 
> view, however, I think they should be mandatory for new DT.

We don't really have a way to describe these 3 conditions (required for 
all, optional for all, and required for new). So generally we make 
additions optional. The exception sometimes is if we update all the dts 
files.

> > Rob,
> > could you please confirm these power supply properties should be 
> > "mandatory"?
> > if yes, should we then modify other optional properties like the 
> > reset-gpios too in the future?
> 
> The GPIOs properties are different in my opinion, as there's no requirement to 
> connect for instance the reset pin to a GPIO controllable by the SoC. The pin 
> could be hardwired to VCC, or connected to a system reset that is 
> automatically managed without SoC intervention. The power supplies, however, 
> are mandatory, in the sense that the chip will not work if you leave the power 
> supplies unconnected.

DT only needs to describe what matters to s/w. If a regulator is 
fixed and you don't need to know its voltage (or other read-only 
parameters), then there's not much point in putting it in DT. 

I'd probably base this more at a platform level and you either use 
regulator binding or you don't. It's perfectly valid that you want to do 
things like regulator setup, pin ctrl and muxing setup, etc. all in 
firmware and the OS doesn't touch any of that.

That's all a big can of worms which we shouldn't solve on this 2 line 
change. I think this change is fine as-is, so:

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
