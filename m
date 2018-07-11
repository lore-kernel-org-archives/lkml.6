Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1855C38A24
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D97520C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aoE7ngQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D97520C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390201AbeGKUVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:21:50 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:47095 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390100AbeGKUVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:21:49 -0400
Received: by mail-oi0-f66.google.com with SMTP id y207-v6so51601946oie.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=otuIXIMsT8Ws7CaWZFCoF+N95OKBQHAukL2ZnO1BnYY=;
        b=aoE7ngQN3iH4NTZyzCIYJ2QqpW6p6VsT5AHsj8NtjGdC36fcc68ThvPhLOf6xvxKhu
         ht40Q+k1uTM2KZ9/E7Dvzg7M5DBP3MlQsMtDYSEqPpBj1LFMbeaPvKIKpdJ/KnqOkZn3
         TSsTHFZG1PIKmdzbOMnNHkSYKT6dll6MGAWKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=otuIXIMsT8Ws7CaWZFCoF+N95OKBQHAukL2ZnO1BnYY=;
        b=N0bkfdLZc5gv2dDPYU3n60Ryf1Ivpep8IvIlufsnWJqIZBe7WS771KM1eoVq6IxZWr
         sDpxXzNSGCcAlglAmfF1Shx6MqaJ2DGXt25Y70wGbRi12jw5NtpcrcVElrONs29dUNAn
         C7aGsDreTkc2TOYdzQ7/Hg+eyfnXx67hbsT9GoYrUv5B5UVEKjhAyU7gA6hP75rqFhE1
         YCRmNQDk/rEEknml4PW/hQENL8PpU8qELpOlwpGWlcmYi2bqI1u8fM2zNuuAneOCJtCo
         EFp2MPH9p14S3sztct6ZGHqrAp0msrZVqAIaVBExeubOi8VUFe4XxmRa6v5+e/z1+cMH
         P/kQ==
X-Gm-Message-State: AOUpUlH6lRyXwxw9eOBCD2hFyZkC/V74pywGeZZu0ejbnINFdnywVjod
        /2dRFOSBqMojU5bDDJgXJvM+eA==
X-Google-Smtp-Source: AAOMgpeKh70+2yb/NoFRklmFMA/hOYj/vHiCpOuQ8Kk341tQSyRt+QnMirETWFwtCbrB62UPlJay/Q==
X-Received: by 2002:aca:3a03:: with SMTP id h3-v6mr127432oia.270.1531340150211;
        Wed, 11 Jul 2018 13:15:50 -0700 (PDT)
Received: from localhost ([2600:3c00::f03c:91ff:fefc:c793])
        by smtp.gmail.com with ESMTPSA id y85-v6sm12195889oie.25.2018.07.11.13.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 13:15:49 -0700 (PDT)
Date:   Wed, 11 Jul 2018 20:15:48 +0000
From:   Dan Rue <dan.rue@linaro.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        chris.ruehl@gtsys.com.hk, Lars Persson <lars.persson@axis.com>
Subject: Re: [PATCH 4.9 181/310] net: phy: micrel: Restore led_mode and
 clk_sel on resume
Message-ID: <20180711201548.3rvad25yhcnr5h4e@linode.therub.org>
References: <20180411183622.305902791@linuxfoundation.org>
 <20180411183630.390575424@linuxfoundation.org>
 <CA+G9fYtR_3AXKvhrkE3WEZhVOX6XwJ1r38PLav1XKkz4L4eQZQ@mail.gmail.com>
 <1524154267.17017.15.camel@nxp.com>
 <CA+G9fYs00cOVxuWYkfUxkdYZX5NGeTgBpwimCJ7tJbANbZwGEA@mail.gmail.com>
 <223ffd4d-567e-6c5c-9581-5304494dd0b3@gmail.com>
 <1524164724.17017.35.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1524164724.17017.35.camel@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 10:05:24PM +0300, Leonard Crestez wrote:
> On Thu, 2018-04-19 at 11:32 -0700, Florian Fainelli wrote:
> > +Others who reported the same problem
> > On 04/19/2018 11:24 AM, Naresh Kamboju wrote:
> > > On 19 April 2018 at 21:41, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> > > > 
> > > > Looking at this dump I'm guessing that phydev->priv is NULL at the
> > > > start of kszphy_config_reset and this really shouldn't be happening.
> > > > 
> > > > The phydev->priv field is initialized by kszphy_probe but your
> > > > particular phy (KSZ9031) in linux-4.9.y does not seem to have .probe =
> > > > kszphy_probe assigned in the struct phy_driver ksphy_driver array.
> > > > 
> > > > In upstream this was added by commit bfe72442578b ("net: phy: micrel:
> > > > fix crash when statistic requested for KSZ9031 phy"). The message for
> > > > that patch claims to fix a kernel crash on this command:
> > > > 
> > > >     ethtool --phy-statistics eth0
> > > > 
> > > > Looking at the code this issue should affect linux-4.9.y on your board.
> > > > Naresh: can you please check?
> > > After reverting the patch i have run this command and kernel oops
> > > showed up.
> > > ethtool --phy-statistics eth0
> > > 
> > > PC is at kszphy_get_stats+0x74/0xa8
> > > 
> > > ethtool --phy-statistics eth0 crashed on x15
> > > 
> > Chris proposed the following patch, which has not been formally
> > submitted yet:
> > 
> > Meanwhile, Greg seems to have reverted the offending patch, so we should
> > be good with 4.9.95.
> 
> I don't object to reverting my patch from linux-4.14.y but it seems all
> the affected hardware would also be affected by the crash from ethtool
> --phy-statistics eth0. Adding bfe72442578b to stable would be great
> because it fixes more than the patch in the title.
> 
> In the other thread there is a mention that "Micrel KSZ8795",
> "Micrel KSZ886X Switch", "Micrel KSZ8061", and "Micrel KS8737" might
> still have problems after bfe72442578b. Is this because they have
> kszphy_config_init but not kszphy_probe? All versions of
> kszphy_config_init seem to check for a NULL priv.

To conclude this thread, bfe72442578b has been backported as of 4.9.112
and 'ethtool --phy-statistics eth0' no longer causes a NULL pointer
error.

Dan

> 
> --
> Regards,
> Leonard
