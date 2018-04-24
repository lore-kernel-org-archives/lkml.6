Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbeDXWgF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 18:36:05 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36382 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeDXWf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 18:35:58 -0400
X-Google-Smtp-Source: AB8JxZocFVbh1HqWP9sXZdNwSIq7P+PNe9mWG4SMaQXkF8kAqoiK1vugcWRlUAhxiA9GDRXz5nNFwA==
From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund@ragnatech.se>
X-Google-Original-From: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Date: Wed, 25 Apr 2018 00:35:54 +0200
To: Colin Ian King <colin.king@canonical.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: media: rcar-vin: add group allocator functions
Message-ID: <20180424223554.GE27674@bigcity.dyn.berto.se>
References: <12ca5ca8-a582-5899-6dd5-c064e4b54e2b@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12ca5ca8-a582-5899-6dd5-c064e4b54e2b@canonical.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

Thanks for reporting this. I wonder why smatch and sparse did not catch 
this, the fault can't be mine for writing such a obviously bad thing 
right :-)

I have a patch to address this, just need to test it before posting.

On 2018-04-24 14:14:02 +0100, Colin Ian King wrote:
> Hi there,
> 
> While running static analysis on linux-next today a null pointer
> dereference issue was detected by CoverityScan. The following commit
> introduced the issue:
> 
> commit 3bb4c3bc85bf77a76c921671800bde2e1bf82a88
> Author: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Date:   Sat Apr 14 07:57:18 2018 -0400
> 
>     media: rcar-vin: add group allocator functions
> 
> The analysis is as follows:
> 
> 339 static void rvin_group_put(struct rvin_dev *vin)
> 340 {
> 341        mutex_lock(&vin->group->lock);
> 342
>    1. assign_zero: Assigning: vin->group = NULL.
> 
> 343        vin->group = NULL;
> 344        vin->v4l2_dev.mdev = NULL;
> 345
>     CID 1468359 (#1 of 1): Explicit null dereferenced (FORWARD_NULL)
>     2. var_deref_op: Dereferencing null pointer vin->group.
> 
> 346        if (WARN_ON(vin->group->vin[vin->id] != vin))
> 347                goto out;
> 348
> 
> vin->group is NULL however the WARN_ON is dereferencing it, causing an
> OOPS.  I don't know how this should be fixed, hence I am sending this
> bug report.
> 
> Regards,
> 
> Colin

-- 
Regards,
Niklas Söderlund
