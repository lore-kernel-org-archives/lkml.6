Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B47AC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4851206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVr5tkvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4851206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbeH2M0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:26:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44875 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeH2M0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:26:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id g6-v6so3579233lfb.11;
        Wed, 29 Aug 2018 01:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vlfthIophm+W0BXvmIg2MeNPvBiSLWsyHDfpEC2FHb8=;
        b=FVr5tkvk8sFRsvsuusp+Zb8gTwVWqqhF0PDq0eGWxxZm5ZlesdzIepqfwDvjk72CsC
         NsM6qCeH5Znd1KaTf+4VU5a16fdzYtf4B6zIVdtfTYrsZOPXT7ji5WSZgkKT9tZi1Ryc
         j7nlu2V4nUpXURSJQMlZKoDKMuSANMHs3TuFzFHS3kv8+EXUqYyoRbwBziuhFMwD4bp4
         CR1b2jXITWj/3quvd0V+Ow3aSPbkrvwNODYU1TSqvjVy7JcN1u/W+GU5gJRUxDP+nxF5
         C6WUDAF6qM8PmbYr6HxXuKFKu5VR+H0t9Ow2PxljAT1JzvSLfplnYcIN6546QaFVtnAA
         XGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vlfthIophm+W0BXvmIg2MeNPvBiSLWsyHDfpEC2FHb8=;
        b=TwciNyJ2yD5k4YHcn+SVm/LjyN26jXV6ytul+Em4iW3mJRLewD6074cyxKduTHLUhV
         WpaB25DfQrsUY/X/NeWb29QMhvuzsMaVCkS4H2P4IPcxkIJfD2SCd8EQ1daCELtpsemg
         zd+f8LgjFs1chdADDJ6Jtw2I9ttYArVSog4TWy5t9mmwQ9z2e+v4Ei7TU+AvKG+7NGgU
         A7gkA497/3PQB6wBxynB2Hz+ZNlv4U7/Gj1gEOYQEN1e22M2PhxDt1BMN2RvivrLYsDz
         pXzibsHfONGX2z7v5hRDMoh3qHBNt2G7qNzhP0vLaj8TyU6RrtXpjmrSzMh6kCqibtRT
         WXWA==
X-Gm-Message-State: APzg51DrJAJDdgh7nY0orJeWTW5zZZrtRUG1bbbsbu3+esyqrsD9br2N
        18pMkU2ulMaBv41uxHayT5al9Gcq
X-Google-Smtp-Source: ANB0VdbTtipgbRRIpnu+hIzh+5BcbRQJ3vNE3cCGHiZGgWZNIGmnCj9maR5EK1FjRKV2iXqKA+faFA==
X-Received: by 2002:a19:dd49:: with SMTP id u70-v6mr3727064lfg.135.1535531450656;
        Wed, 29 Aug 2018 01:30:50 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id c14-v6sm606332lfi.23.2018.08.29.01.30.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 01:30:50 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fuvsI-0007l0-A5; Wed, 29 Aug 2018 10:30:50 +0200
Date:   Wed, 29 Aug 2018 10:30:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] usb: core: phy: fix return value checking about
 devm_of_phy_get_by_index()
Message-ID: <20180829083050.GG28861@localhost>
References: <8263a8d0f87d595dd35efa5432d294d9f7b38719.1535507412.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8263a8d0f87d595dd35efa5432d294d9f7b38719.1535507412.git.chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 10:10:48AM +0800, Chunfeng Yun wrote:
> Use IS_ERR() instead of IS_ERR_OR_NULL() because devm_of_phy_get_by_index()
> never return NULL value;
> But still need ignore the error of -ENODEV, for more information, please
> refer to:
> [0] https://lkml.org/lkml/2018/4/19/88
> [1] https://patchwork.kernel.org/patch/10160181/
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> V2: keep the -ENODEV check
> ---
>  drivers/usb/core/phy.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
> index 9879767..e3cc743 100644
> --- a/drivers/usb/core/phy.c
> +++ b/drivers/usb/core/phy.c
> @@ -23,14 +23,11 @@ static int usb_phy_roothub_add_phy(struct device *dev, int index,
>  				   struct list_head *list)
>  {
>  	struct usb_phy_roothub *roothub_entry;
> -	struct phy *phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
> +	struct phy *phy;
>  
> -	if (IS_ERR_OR_NULL(phy)) {
> -		if (!phy || PTR_ERR(phy) == -ENODEV)
> -			return 0;
> -		else
> -			return PTR_ERR(phy);
> -	}
> +	phy = devm_of_phy_get_by_index(dev, dev->of_node, index);
> +	if (IS_ERR(phy))
> +		return (PTR_ERR(phy) == -ENODEV) ? 0 : PTR_ERR(phy);

I prefer not to use the terse ternary operator in general, and
especially so in this case where we are doing something unexpected (i.e.
we want to highlight that the -ENODEV case is special).

So please keep the current construct, and just replace IS_ERR_OR_NULL
and drop the !phy test.

I think separating the declaration and (non-trivial) initialisation of
phy here is a good thing that can remain in the patch, even if it's
arguable separate change.

>  
>  	roothub_entry = devm_kzalloc(dev, sizeof(*roothub_entry), GFP_KERNEL);
>  	if (!roothub_entry)

Thanks,
Johan
