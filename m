Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23545C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D352C2083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549297678;
	bh=b0829MrkcBiWpP5jXTedc8EzyjD6B15lFUTtNl+QbmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ni30hzvp6ezFLhqdZKj+P5j0Aw0lmSHfjnTRRBamAm/7jd/r9m4l/ie8ixXpJqwKD
	 fnBtxMywx97FfeOHkoxWxXg2Whr9MRMuEwNIK3QtlWQ//HWkz/KySxy2m8j3cXhPw2
	 zoUyja5EDktdh4XIiBzuu2lrdCslWCfhgMFv0vmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfBDQ15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:27:57 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37847 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbfBDQ15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:27:57 -0500
Received: by mail-lf1-f68.google.com with SMTP id n23so365625lfl.4;
        Mon, 04 Feb 2019 08:27:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m1DGRjJ+JA0oWyFsMeauDSF1oSaIekBhJEvdxqhG//w=;
        b=R+hVgzuu+Dp4MIb+UYXBPTDta4S3PvkhBcdxnx/zqDFZ0faF9LpFmlRrlNwrc1YRat
         AtY+VfiZp9UzkNVrWHWipnND0HDEgDlnHQlPoCf64v0sfVN5sYeoKsyEZGR2K7dL/8HO
         LWR8L9o7QiYr8TwUlOeEhTnKZsjnxz92GNu/teSSKJlUlD/32oi4tPIDC0wBcJBxDNKg
         w54C7f4YWWTvOUfWSl1pf3fji/lnPCme8yfMULtNrDfuyV5bHVZ+dlxxQsBC5lVjt2kd
         LfFBgmjne0OJYP5s/A4ajwLR0u9Rv6tXQ2HBm+XEYFVjFlDcIXi0QOuWcSJQ/9g2Ly+z
         HH0w==
X-Gm-Message-State: AHQUAubNjtDpWuSPyNyXPyf7vAkJf5zCG/7s30rsQ7u0eY+bFglCsN6s
        x0KVht/8OcHJt8OQ0dsZHDE=
X-Google-Smtp-Source: AHgI3IbfIlfGOxRaX3wSHkpshbP7lpIvOPDyFQgbV1n9WrsU54Tc5qNAGXagwucXUVk2xmt9JVOksw==
X-Received: by 2002:ac2:5145:: with SMTP id q5mr160901lfd.46.1549297674731;
        Mon, 04 Feb 2019 08:27:54 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q11sm2064103lfb.28.2019.02.04.08.27.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 08:27:53 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gqh68-0006ww-Fn; Mon, 04 Feb 2019 17:27:53 +0100
Date:   Mon, 4 Feb 2019 17:27:52 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karoly Pados <pados@pados.hu>
Subject: Re: [PATCH] USB: serial: cp210x: add GPIO support for CP2104
Message-ID: <20190204162752.GI4686@localhost>
References: <20190128055717.31162-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128055717.31162-1-icenowy@aosc.io>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 01:57:17PM +0800, Icenowy Zheng wrote:
> The CP2104 chips feature 4 controllable GPIO pins, which are similar to
> the ones on CP2102N chip (output-only when push-pull, output or
> simulated input mode when open-drain).
> 
> Add support for the GPIO pins for cp210x driver. The pin get/set routine
> is shared with CP2102N, but the pinconf initialization code is not
> shared because the acquisition of GPIO configuration in OTP ROM is
> similar to CP2105, not CP2102N.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Thanks for the patch, all nice and clean.

Now applied.

Johan
