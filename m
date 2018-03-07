Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934078AbeCGQZz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:25:55 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37839 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933775AbeCGQZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:25:41 -0500
X-Google-Smtp-Source: AG47ELsBay4+fUOdYR3dYc4ixHx6OdM6EFneFpTO9p5G/mSOCjfDjaUldSAv8CiiuOl455Y3P7lT7w==
Date: Wed, 7 Mar 2018 16:25:37 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v3 1/2] mfd: arizona: Update reset pin to use GPIOD
Message-ID: <20180307162537.pryp3qz3lgm7a4zs@dell>
References: <20180220163540.6704-1-ckeepax@opensource.cirrus.com>
 <20180307132812.r5epcs26clpnh72t@dell>
 <20180307141509.e3dpxteodxeoy2k3@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180307141509.e3dpxteodxeoy2k3@localhost.localdomain>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Mar 2018, Charles Keepax wrote:

> On Wed, Mar 07, 2018 at 01:28:12PM +0000, Lee Jones wrote:
> > On Tue, 20 Feb 2018, Charles Keepax wrote:
> > > +	if (IS_ERR(pdata->reset)) {
> > > +		ret = PTR_ERR(pdata->reset);
> > > +		switch (ret) {
> > > +		case -ENOENT:
> > > +		case -ENOSYS:
> > > +			break;
> > > +		case -EPROBE_DEFER:
> > > +			return ret;
> > > +		default:
> > > +			dev_err(arizona->dev, "Reset GPIO malformed: %d\n",
> > > +				ret);
> > > +			break;
> > > +		}
> > 
> > I haven't seen a switch statement used in the error handling path
> > before.  There is probably good reason for that.
> > 
> 
> There are a fair few of them "grep -rI "switch (ret)" | wc -l" ==
> 205. Although to be fair that has rarely been an argument in
> somethings favour.

I didn't say "it has never been done", just that I hadn't seen it.

Besides, 205 uses is a very small amount in kernel code:

`git grep "if (ret" | wc -l` == 74710

> > What is the 'default' case?  -EINVAL?
> > 
> 
> I would guess most of the time yes, but I would rather not assume
> that. I can redo this as if's if you prefer it that way? The if is
> slightly less lines although I do think the switch is much
> clearer as to intent.
> 
> if (ret == -EPROBE_DEFER) {
> 	return ret;
> } else if (ret != -ENOENT && ret != -ENOSYS {
> 	dev_err(arizona->dev, ....);
> }

I don't know enough about the API to see why -ENOENT and -ENOSYS do
not deserve error messages.

What do the other users of the API do?

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
