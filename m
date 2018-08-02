Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D39C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 05:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA05208D5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 05:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKRvFvip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA05208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbeHBHEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 03:04:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46129 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbeHBHEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 03:04:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id u24-v6so582234pfn.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 22:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CVV6GxsUcJeRGPhJi/N77jIMDcYQUQ/caLWlrwsWR+4=;
        b=mKRvFvipceBR3y8hsiGSU/kW7KLnbjSv3Z4t2H//mJuCemzw8DdS20BQfiOmT0SnOL
         jKnTZ+7nmDl35iOR7N9tJE4K7e1UeKIzCHEJPbvsJ4HDqRLmrSO22PVh+Noj8RWQhPBv
         a8w75X8IgKNf1ZEqdZTkTZiGFKPWVE/J1njHh4IOs/NjbLCwhj0UZDDpAm+CFDSpsdmY
         C818dY0jKjS2yuSeeHdaNLnP9HHpc0B/cqUTEuPPJtdZH52Z8jFzQYyWEWDFH3y2lLrt
         5DRH47Xxp7gfMzNoV+9JZWKXWChAV8+kEj7LI00jh8PKCGvYaTFBo0TBiB6g6vbc63rz
         qClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CVV6GxsUcJeRGPhJi/N77jIMDcYQUQ/caLWlrwsWR+4=;
        b=RqvLJKxkLmxyFrytXjw0NryxPewcaR5dzoF3mNB75yLS2wiNajCYsDJAl2ST3MahSt
         UZCeKI9hLMqypiYKkfxvxiKjea9S20WdbET3zrg4rNfzOB7YygH+ZFFuLKKBlDvbaIP/
         vsBk/5D1g1qCFxdm3Gdf9+lkvzfIMolkZWryPzMlziRSduNWZ92g/JK8bi1W2sSA6/xG
         xgW6y3Afcl76alfXM+stAq8kp7hWEDsG3jyi78h/68i9RSppiMJVSUhqxSVGqzMA6yWt
         rULXu/5uyIQe8CHa+nC5EDx7q0cy4Lo9XCRPFqXBf3hocvXuEsk6XmdXjZk99mbuS0V0
         KEKg==
X-Gm-Message-State: AOUpUlGbypAg+q9tLNlgYh75MN9dXmHoxD7qxak2JFGnEARwGrQA/4HJ
        /la7j9JDG6WYtCeGkcEGT3A=
X-Google-Smtp-Source: AAOMgpfXkLMHDUTI9BO3Xfm04uPKmovJMF3eEG4wX7+303+s6caWaRizfhNVM4JkH2eesLHtxmhUMw==
X-Received: by 2002:a63:e14a:: with SMTP id h10-v6mr1277468pgk.358.1533186913261;
        Wed, 01 Aug 2018 22:15:13 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id y4-v6sm929536pfm.137.2018.08.01.22.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 22:15:11 -0700 (PDT)
Date:   Thu, 2 Aug 2018 14:15:07 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Tino Lehnig <tino.lehnig@contabo.de>
Cc:     ngupta@vflare.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Zram writeback feature unstable with heavy swap utilization -
 BUG: Bad page state in process...
Message-ID: <20180802051507.GA86392@rodete-desktop-imager.corp.google.com>
References: <1684cefc-c920-d53c-8d2d-c32da213a045@contabo.de>
 <15e3a0af-7e02-83fb-4b72-b05f6d7ded71@contabo.de>
 <20180726103001.GC221405@rodete-desktop-imager.corp.google.com>
 <b914205b-f3eb-7c0e-cd60-88c34341f84a@contabo.de>
 <20180727091431.GA229060@rodete-desktop-imager.corp.google.com>
 <4e0ab1cd-ea7a-0916-eb85-0396c61bd949@contabo.de>
 <20180727120517.GB229060@rodete-desktop-imager.corp.google.com>
 <54eddd07-9fe5-0a83-0d2f-556726f64516@contabo.de>
 <20180727225850.GC229060@rodete-desktop-imager.corp.google.com>
 <d2e9d4d2-92d8-0ec7-ab85-c264ffba1351@contabo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2e9d4d2-92d8-0ec7-ab85-c264ffba1351@contabo.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 08:09:33AM +0200, Tino Lehnig wrote:
> On 07/28/2018 12:58 AM, Minchan Kim wrote:
> > I made a mistake on previous patch.
> > Could you test this patches?
> 
> Thanks! Looking good so far! No errors whatsoever with the new patch. I will
> let my test workload running for while to be sure, but I think we are good.

Thanks for the confirming, Tino.
I belive you didn't see any problem until now so I sent formal patch with
your 'Tested-by" SoB.
https://lore.kernel.org/lkml/20180802051112.86174-1-minchan@kernel.org/
If you see any problem, feel free to reply that thread.

Thanks for the report and help!
