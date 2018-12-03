Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE8CC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64152081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbcTxjnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64152081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeLCT0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:26:39 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38671 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbeLCT0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:26:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so6964182plb.5;
        Mon, 03 Dec 2018 11:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ADy8WHO6KK23d2P5AM45P0ryco29Y4uyIexYzDqh4to=;
        b=HbcTxjntcl2L7axqh4Wz2nPt3zpmvi7FzynCMxi2jaIUBEGXIpbAWGmEddAs+Td/bP
         ZRRirKH8aekC+pAAfAffkv0jf5sCmJH281zaUCDaNK4Bpe4eetLSbGWMjZneanMi4m+U
         wcu4SthTPYyY0ou8LtG2sufIxkoAo/Cbf7PThqVtIGyRCY6vaCxDMswc3mTNZO9i7ys5
         fUPOQTjWXPgByX9ctWzci6JmaBxcS0ZXLNGG5otSzuyFonrkVZzC4iSGMULDnXqYpGGT
         DXOpawsjVbUDDHdnXOykdOi+49EX3a7ZdCu/jMUhlc/yNAdROBMpgVCexxT2FDgdiix0
         AT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ADy8WHO6KK23d2P5AM45P0ryco29Y4uyIexYzDqh4to=;
        b=TFMID32dopNrwPdVDTBIDd+/Q4h6P7248WR6R0MgN3/UfaCwsgCBE1vVx/kM52vtmK
         6SG43CF9LsPjrrX+KDFN1XU24YtUfw/FR2Rd7xIuTZCfzLpdaB6pNlFNutdg2SPnvo9x
         146RGSS43bfz9PeoorOsKp05+4bwFcOjFvwQhL9cfy8liIqz2mkqK4WQGBsS7D7vp+57
         q8IsTIL9GYBWqb95ITFNWnTxnZgC0VVnkS4nLe7LHvI9pPi78XzyT7V4BQQZJxmFpbh1
         KUrcToGAlYV+yOdgvRlqZVPS2A3SVXPURuKO3vxO1HhBQFgLdjYcK0BsTPT2DrOmgT3S
         bRpg==
X-Gm-Message-State: AA+aEWauCs8XBTPjEVNCclCoVFAhv1EDZDofyIls17DgfLBsTklY57Us
        O/ray49x0VafsZTtsJu8/Kc=
X-Google-Smtp-Source: AFSGD/US83tCG3BOdmCFa8xvMcvWWCtg/K27CtUnXD/SCNrF5AVpVdD6RJ0NDgwd7Ko2mTu0NnuV9Q==
X-Received: by 2002:a17:902:3181:: with SMTP id x1mr16983279plb.58.1543865193258;
        Mon, 03 Dec 2018 11:26:33 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p7sm18364158pfa.22.2018.12.03.11.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 11:26:32 -0800 (PST)
Date:   Mon, 3 Dec 2018 11:26:29 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Teika Kazura <teika@gmx.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/1] Input: synaptics - enable SMBus for HP 15-ay000
 (SYN3221).
Message-ID: <20181203192629.GD257010@dtor-ws>
References: <20181116.130459.1796034910024118091.teika@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116.130459.1796034910024118091.teika@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 01:04:59PM +0900, Teika Kazura wrote:
> SMBus works fine for the touchpad with id SYN3221, used in the HP 15-ay000 series,
> 
> This device has been reported in these messages in the "linux-input" mailing list:
> * https://marc.info/?l=linux-input&m=152016683003369&w=2
> * https://www.spinics.net/lists/linux-input/msg52525.html
> 
> Reported-by: Nitesh Debnath <niteshkd1999@gmail.com>
> Reported-by: Teika Kazura <teika@gmx.com>
> Signed-off-by: Teika Kazura <teika@gmx.com>

Applied, thank you.

> ---
>  drivers/input/mouse/synaptics.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 55d33500d5..591b776f22 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -179,6 +179,7 @@ static const char * const smbus_pnp_ids[] = {
>  	"LEN0096", /* X280 */
>  	"LEN0097", /* X280 -> ALPS trackpoint */
>  	"LEN200f", /* T450s */
> +	"SYN3221", /* HP 15-ay000 */
>  	NULL
>  };
> 
> --
> 2.18.1

-- 
Dmitry
