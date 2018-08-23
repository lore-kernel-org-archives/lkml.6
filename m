Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3B4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272C220A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hER3Kj+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272C220A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeHWLI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:08:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45023 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeHWLI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:08:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id q127-v6so3380509ljq.11;
        Thu, 23 Aug 2018 00:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PSVmcuwlhjdBsDwEeWUxtWzr/IM73mWl4ArwTqoL3sg=;
        b=hER3Kj+dv7DeoORnQ7lVRMF8XTakfBFclBzJgPRXNok4m/7mfjjJIZvE3dU+26qFYc
         4yBQ/19oan4zd3s7yyZIwp+un8G1wHdGaNEqnexEJzcXn5W2wBdPL7d2Hdtd7va2GO6V
         K1V9cPaC0FMn18N7RFxlCoBo4PuVt9gqi3fPNgWe0jI4++1ZYYNnk2heXcK+OUn8LOJa
         CA7X9u8GUxaFO7YFWcL9rbvo7cUdOn00yGmDZVe3G/sYabKsx4LmOjeWb6UrjWJFOmYI
         7fQ4ClPIJWJQd60zU5aM2D1/c20VTVKl/82bu/kYsXzZFMiHV9+r380yWffc/55V/0c1
         iC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PSVmcuwlhjdBsDwEeWUxtWzr/IM73mWl4ArwTqoL3sg=;
        b=dyssjDj0uG6lZIieLf5oqRrA1EHEgirryKYn2/JY9uO8WZW06o76gZG+MWhZqQXVjc
         e/mW54qcHdf032Xo+2+bSAOb0XS8zOTtB4TNZgD1ZvjA6boJo6n7qKXD860JZeyaynih
         /cFs7gtNDqHRXlrxxoXyEb/dOEQLdcTZSCkMRoFFpF6qsNh173yHABl4xuuf6N0HO66o
         B1ywGorE1eHwpBp611kI4pzspNiPJwPe9KPiuaZ7HUR5iHmZnFfLVqWiDdVRxcbZcOC0
         YI9XZKE0iQg3PJNpx29ZinIBu/xHyD+tNybZO0tC2lM5VPjChCrCP9BBz4XHQNCaPg11
         ja7A==
X-Gm-Message-State: AOUpUlEG8on6f+ZsClcKT9AsSWj9MQLdgfBqs0pI4JZN3bwAOOiAHzmc
        EIAPNbnAYlK/aj+VrfwpgY8=
X-Google-Smtp-Source: AA+uWPz5UUZcGClHPR1TqYHMSFVgdIlRQ4Pzj3U1GOBN43bwFz9SSfLYEGS6wL5/BHxVO/Ov+rekgw==
X-Received: by 2002:a2e:5687:: with SMTP id k7-v6mr41199212lje.105.1535010037503;
        Thu, 23 Aug 2018 00:40:37 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id u191-v6sm625033lja.13.2018.08.23.00.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 00:40:36 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fskEN-0007Ao-TH; Thu, 23 Aug 2018 09:40:35 +0200
Date:   Thu, 23 Aug 2018 09:40:35 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@vger.kernel.org>, NeilBrown <neilb@suse.de>,
        Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 9/9] power: supply: twl4030-charger: fix OF sibling-node
 lookup
Message-ID: <20180823074035.GQ14967@localhost>
References: <20180822105547.9634-1-johan@kernel.org>
 <20180822105547.9634-10-johan@kernel.org>
 <20180822213658.uuzsalnlxbayc4ml@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822213658.uuzsalnlxbayc4ml@earth.universe>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 11:36:58PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Aug 22, 2018 at 12:55:47PM +0200, Johan Hovold wrote:
> > Use the new of_get_compatible_child() helper to lookup the usb sibling
> > node instead of using of_find_compatible_node(), which searches the
> > entire tree and thus can return an unrelated (non-sibling) node.
> > 
> > This also addresses a potential use-after-free (e.g. after probe
> > deferral) as the tree-wide helper drops a reference to its first
> > argument (i.e. the parent device node).
> > 
> > While at it, also fix the related phy-node reference leak.
> > 
> > Fixes: f5e4edb8c888 ("power: twl4030_charger: find associated phy by more reliable means.")
> > Cc: stable <stable@vger.kernel.org>     # 4.2
> > Cc: NeilBrown <neilb@suse.de>
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> 
> Reviewed-by: Sebastian Reichel <sre@kernel.org>

Thanks for reviewing.

Johan
