Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeBYQf2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 11:35:28 -0500
Received: from agrajag.zerfleddert.de ([88.198.237.222]:50646 "EHLO
        agrajag.zerfleddert.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbeBYQfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 11:35:24 -0500
Date: Sun, 25 Feb 2018 17:27:30 +0100
From: Tobias Jordan <Tobias.Jordan@elektrobit.com>
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [SIL2review] [PATCH] i2c: img-scb: fix PM device usage count
Message-ID: <20180225172730.2b443978@denkmatte>
In-Reply-To: <20180225132014.GA8844@osadl.at>
References: <20180224224303.3mpwhal2axcr6aos@agrajag.zerfleddert.de>
        <20180225132014.GA8844@osadl.at>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sun, 25 Feb 2018 13:20:14 +0000 Nicholas Mc Guire wrote:

> the decrement though is conditional:
>   pm_runtime_put_noidle
>   -> atomic_add_unless(&dev->power.usage_count, -1, 0);  

pm_runtime_put_noidle is playing it safe by not decrementing past 0, I
think that's a good thing.

> Also just wondering - could one not decrement in pm_runtime_get_sync
> on the error path rather than defering this to the caller and fixing
> it there ?

That's what I've asked linux-pm in the linked discussion:

> > https://marc.info/?l=linux-pm&m=151904483924999&w=2

As far as I've understood the idea is that most "error" return values
actually are a result of disabled runtime PM, and that should be
transparent to the caller. Looking at the code, that's what the vast
majority of callers do - they just ignore the return value of
pm_runtime_get_sync, and somewhere later have an
unconditional pm_runtime_put_... call.

So the only issue are callers that don't ignore the pm_runtime_get_sync
return value, probably because they're having some kind of special
requirements for error handling. For those, they need to ensure that a
proper _put_ is done somewhere in the error path.

> Reviewed-by: Nicholas Mc Guire <der.herr@hofr.at>

Thanks for the review!,

Tobias
