Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC2BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D4421A12
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Iuox3Qpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D4421A12
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934388AbeGDJUD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:20:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45643 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932788AbeGDJT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:19:58 -0400
Received: by mail-ed1-f68.google.com with SMTP id g15-v6so3541001edr.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 02:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wC/XYKMCmn664Zzpxl06lbQIRYPV3gGjSzahvYp17zQ=;
        b=Iuox3QpgblJkVbtm9sz1xu8J+xhfhrkU9/DGI37dW8cn+tl3l8J+uy+3kc7Sh3h7Zg
         67Yi6yBo1U+RYvRPuwTFZ42v4zvruhXSW6+KKoCyOg1dKZhU/8oQaI9dxarhUnAgxq41
         7c+9e1K9ylu6RXram+0rdnMmWpY9wTwsq9Kjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=wC/XYKMCmn664Zzpxl06lbQIRYPV3gGjSzahvYp17zQ=;
        b=RFzLYfOzGbgnEVv0u4vAXeSjGUgyuAI3j1wnuGmFS8S2UoPHKOJ45YwTYl4Hv2XhRq
         RIUNTSQt/fbOir61PmqCqOno2IqIMd2QSYkLMi4h+NfRFshevjBW/h6Hmrwy7qi8TSpW
         St2MRerjtwXl/3Fkh7cSexbj2PIfTSVSRkn935GKs1+5p6ObPD03WhHYp81eccl4/+8H
         HFg36efp7jMRwyPe6ihrJpbAWincj2RIrk2rIx8zd+sXUbI1Lfqsmoxsv8UroV+Gwohk
         GYV7udqExXh8J7PUvdRo03h+sExApo5ylivFSV9akPIbzwJJrmvRc6EXvL0FMA1evMSX
         HmiA==
X-Gm-Message-State: APt69E3PPN5RZhdUmZ4Mj+Etu8v8fVRh3rILdchiRwZzDj+30vbVPJQB
        Oqo+KukRTH7EdFaP6BIX/N898w==
X-Google-Smtp-Source: AAOMgpdVMHVNoji8LAiMHJ/XHAhL0fb8vICVOCQaMVN7x9JqATBUlEGUSH/Uq1W/rf+h3iiActUpJQ==
X-Received: by 2002:a50:8561:: with SMTP id 88-v6mr1896060edr.181.1530695997221;
        Wed, 04 Jul 2018 02:19:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id m50-v6sm694510edc.94.2018.07.04.02.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 02:19:56 -0700 (PDT)
Date:   Wed, 4 Jul 2018 11:19:54 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v6] Add udmabuf misc device
Message-ID: <20180704091954.GQ3891@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20180703075359.30349-1-kraxel@redhat.com>
 <20180703083757.GG7880@phenom.ffwll.local>
 <20180704055338.n3b7oexltaejqmcd@sirius.home.kraxel.org>
 <20180704080807.GH3891@phenom.ffwll.local>
 <20180704085825.nfkv5i7ultaavjve@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704085825.nfkv5i7ultaavjve@sirius.home.kraxel.org>
X-Operating-System: Linux phenom 4.16.0-2-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 10:58:25AM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > > Hmm, does MAINTAINERS need an update then?  Maintainer and mailing lists
> > > listed in the "DMA BUFFER SHARING FRAMEWORK" entry are on Cc.
> > 
> > Yeah, maintainers entry with you as maintainer plus dri-devel as mailing
> > list plus drm-misc as repo would be good. Just grep for drm-misc.git for
> > tons of examples.
> 
> There is an *existing* entry covering drivers/dma-buf/, and I've dropped
> udmabuf.c into that directory, so I've assumed get_maintainers.pl picks
> up all relevant dma-buf folks ...
> 
> Covering udmabuf.c maintainance is a different issue.  I could just add
> myself to the existing entry, or create a new one specifically for
> udmabuf.

That's what I meant, do a more specific entry to add yourself just for
udmabuf.

> > > Who should be Cc'ed?
> > 
> > dim add-missing-cc ftw :-)
> 
> That just uses get_maintainer.pl according to the docs, so that wouldn't
> change things as that is wired up as sendemail.cccmd already.  Except
> that dim would probably add the list of people to the commit message.

Ah right, I totally missed that you have more on the mail's Cc: than on
the patch. I never do that, so always miss them :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
