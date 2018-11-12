Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D63C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316C0223B0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spCpDnVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316C0223B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbeKLT2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:28:20 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:35019 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeKLT2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:28:20 -0500
Received: by mail-lj1-f175.google.com with SMTP id x85-v6so6985030ljb.2;
        Mon, 12 Nov 2018 01:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f8xARL2MzUBw0T+3dCa9+XWGdFBqSsgY7D+SM7uXE/E=;
        b=spCpDnVawQvN1O2vxqVVy7k1kQZjMQpj7HQ7FaAQBR0ukMCxqSVeUZDsIwBEvd1glS
         EikKQTAtFF/+2cuVnq36bNnCacYHC40u7WsdvYsxiV/iqZV/E9tJkqgqLd3ThS7WQQQV
         boetAT7pojPR2KFnxm3Nf3XYIlf+mDjP3hKKBLS9BvyDBLiJJsz4ztpLK7WMtXVlwHxD
         eM/Pt2FrpNYypGDSAUT+JkUgQb0zCy5HlFywAJ+9t+9mIokqBJa0LG0bPopNue2639Aw
         ESAZsLEUMTtvWGflgTbno4Mff2dLW9PPbtG8YZkpw+wbhtrxcwIcFek2XoZU6qHtJcD8
         IAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=f8xARL2MzUBw0T+3dCa9+XWGdFBqSsgY7D+SM7uXE/E=;
        b=qisoctYAi4uwuTIR/PuOgQTL68itZYM4SrcwkfxhEsQO4h3jmKSqgF9jdZ114ndI+3
         V62yqm4XF8vm2x4mygJXMXDEWdFJEKahL1bhVly189+XvuOxUHtfXo2PzKBMN5MPYxkf
         zgLVIipiTIgPXxB2+YHwTmjbpsXgHXoNFtGLuj/k0bK0p2SIWmiEdAhvGnsgAkM7yAQo
         kVt7SW3+38CRT+pGM+94Zh4296/kO571HnBAR9HLBrbTrnCczLzCb36h1U7DyD5g3T+w
         94oBfbSPqXaqPDat/hSlztzhul+D22ERImB7hFwUcf6XJkpJIS5fDPm6uhIJY1V++wfm
         c6PA==
X-Gm-Message-State: AGRZ1gLNiWB1pM/Nar9FFw/OJfCFdGoedmCXMOEadW74ARMykts0tt2v
        CbRMN6XNILdoD8Bb7cKoMVg=
X-Google-Smtp-Source: AJdET5f1w3XtHZwM1vMNL/ykBkhxcy//sJm3tRYl21/1hMvMl+QbrTkheqvI4NYqWxriLMP5hl+0mw==
X-Received: by 2002:a2e:8099:: with SMTP id i25-v6mr188400ljg.174.1542015355329;
        Mon, 12 Nov 2018 01:35:55 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id b17-v6sm2920192ljj.93.2018.11.12.01.35.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 01:35:54 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gM8dJ-00060H-R9; Mon, 12 Nov 2018 10:35:49 +0100
Date:   Mon, 12 Nov 2018 10:35:49 +0100
From:   Johan Hovold <johan@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH -next] USB: serial: mos7840: remove set but not used
 variables 'st, data1, iflag'
Message-ID: <20181112093549.GD13311@localhost>
References: <20181026122549.19036-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026122549.19036-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 08:25:49PM +0800, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/usb/serial/mos7840.c: In function 'mos7840_interrupt_callback':
> drivers/usb/serial/mos7840.c:604:14: warning:
>  variable 'st' set but not used [-Wunused-but-set-variable]
> 
> drivers/usb/serial/mos7840.c: In function 'mos7840_write':
> drivers/usb/serial/mos7840.c:1303:17: warning:
>  variable 'data1' set but not used [-Wunused-but-set-variable]
> 
> drivers/usb/serial/mos7840.c:1700:11: warning:
>  variable 'iflag' set but not used [-Wunused-but-set-variable]
> 
> They are never used since introduction in
> commit 3f5429746d91 ("USB: Moschip 7840 USB-Serial Driver")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks.

Johan
