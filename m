Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D12C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AE020873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GzMIrTld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfANKGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:06:02 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36650 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfANKGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:06:00 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so18160445edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=31n6q9gHjvwQ8HUcLFEyEeRyWzXo+P9WHYJIC1waV1I=;
        b=GzMIrTldTY5X354pq6qiV+EXzAMdM86Sg6lGpmfcDNZVI4880Yj6bX+93vsfPuoIPI
         S4VPGjtU5zju+vsYOsJVm9OBVymSF33Sq0qyid79WYqnsmzG6DxOyjYk38kSRNB4mXo2
         /uFDcvkMbpc8m0gojkYCN0tDMPJSJNmoZM5Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=31n6q9gHjvwQ8HUcLFEyEeRyWzXo+P9WHYJIC1waV1I=;
        b=iyk/yaYKQWdJ6UaHMnCDBN47heOgl3CQAc5HX/A3/IqOrd/VwnwT8tOl9dEDpwJkce
         XdjPwr76GsC+keGuo53TksA4jByxx4ZNGgWgbr0Bjn6x0jWekAX2Z1nkeDyt/z96V/Ai
         j1j2ZDQAvQrvYB0oEP4V2YSiRJqD7hynaIw3GTR+YeGLm44CY/KxFEk/ZBmfEvtlmAsK
         eCp1a+W9hfmPy/noUG4U7ufqfP2Wp1Qhfi4PxUXMUcw4mTd4d3/e0hTuWNWgdfyaJybe
         j95z/j0GYHKf6l8BIiUoB9LkPil1J4caLmNPXmfBIAcvqVnk51yV0wnQ41fFHfkrjHC1
         k9xw==
X-Gm-Message-State: AJcUukej83PYJdLign13p6nNOr1YoKsHYTUWgZMBukFImS77nzYaHfSO
        Tl+AYOp38t5ZWnLOv0bm1btk3Q==
X-Google-Smtp-Source: ALg8bN4nZrWkCsQEb2QLSbmu7yWl951UtmaS41OrKfjpqVinoMnVAMbr5lU2HQbwuQRUJhm4APVzHA==
X-Received: by 2002:a17:906:340a:: with SMTP id c10-v6mr19939655ejb.130.1547460358897;
        Mon, 14 Jan 2019 02:05:58 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id s5-v6sm2265009eji.25.2019.01.14.02.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 02:05:58 -0800 (PST)
Date:   Mon, 14 Jan 2019 11:05:56 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Sandy Huang <hjc@rock-chips.com>,
        kernel-janitors@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] drm/rockchip: add missing of_node_put
Message-ID: <20190114100556.GC10517@phenom.ffwll.local>
Mail-Followup-To: Heiko Stuebner <heiko@sntech.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Sandy Huang <hjc@rock-chips.com>, kernel-janitors@vger.kernel.org,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1547369264-24831-1-git-send-email-Julia.Lawall@lip6.fr>
 <1547369264-24831-4-git-send-email-Julia.Lawall@lip6.fr>
 <3397932.PmTvevuZIG@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3397932.PmTvevuZIG@phil>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 07:48:49PM +0100, Heiko Stuebner wrote:
> Am Sonntag, 13. Januar 2019, 09:47:43 CET schrieb Julia Lawall:
> > The device node iterators perform an of_node_get on each iteration, so a
> > jump out of the loop requires an of_node_put.
> > 
> > The semantic patch that fixes this problem is as follows
> > (http://coccinelle.lip6.fr):
> > 
> > // <smpl>
> > @@
> > expression root,e;
> > local idexpression child;
> > iterator name for_each_child_of_node;
> > @@
> > 
> >  for_each_child_of_node(root, child) {
> >    ... when != of_node_put(child)
> >        when != e = child
> > +  of_node_put(child);
> > ?  break;
> >    ...
> > }
> > ... when != child
> > // </smpl>
> > 
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> I've added a fixes+stable tag and applied it to drm-misc-fixes

All of them or just this one here? These cleanup patches have a high
chance of falling through cracks, so taking them all usually works out
better ...
-Daniel

> 
> Thanks for catching that
> Heiko
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
