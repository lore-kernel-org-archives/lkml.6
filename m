Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971568AbeCSUvI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:51:08 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42310 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967942AbeCSUu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:50:59 -0400
X-Google-Smtp-Source: AG47ELtsnDxSumkANeg15OoTDHrQaPNSqy1CyTUX2SO3PLw1BjkOGKQ542G9xLm42MSW/1I0485dvQ==
Date: Mon, 19 Mar 2018 13:50:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Adrian Fiergolski <adrian.fiergolski@cern.ch>
Subject: Re: [RFC PATCH 1/2] i2c: Add i2c_verify_device_id() to verify device
 id
Message-ID: <20180319205056.GA11941@roeck-us.net>
References: <1521475859-16765-1-git-send-email-linux@roeck-us.net>
 <99548eb6-1958-b2a1-1f2c-ba995f8965ee@axentia.se>
 <20180319184850.GB23774@roeck-us.net>
 <11684f49-dee5-7037-f5c9-5bb8becf114f@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11684f49-dee5-7037-f5c9-5bb8becf114f@axentia.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 08:55:55PM +0100, Peter Rosin wrote:
> On 2018-03-19 19:48, Guenter Roeck wrote:
> > On Mon, Mar 19, 2018 at 05:47:05PM +0100, Peter Rosin wrote:
> >> I also wonder if NXP will ever release a chip with part-id 0 and
> >> die-revision 0? If not, an all zero struct i2c_device_identity
> >> could be used instead of manufacturer_id 0xffff and that would
> >> simplify the pca954x driver code a bit more. But I guess we can
> >> never know the answer to that question. And even if we did, the
> >> answer might change later. But it would be nice...
> >>
> > 
> > That would be nice. You could ask at i2c.support@nxp.com, but I guess
> > it would always be somewhat risky since the standard doesn't restrict
> > its use, and some product manager at NXP might decide in the future
> > that a device ID of 0x00 would be "cool".
> 
> No need to bother NXP, PCA9848 has already claimed 0-0-0. Sigh.
> 
> But while I googled that I found old datasheets for the chips PCA9672
> through PCA9675 which use a different layout for the three bytes in
> the device id. They have 8 manufacturer bits, 7 category bits, 6 bits
> of feature indication and then 3 bits of revision. The top category
> bits are zero so it is compatible for NXP chips. But since noone else
> has implemented this, it is probably safe, but still a little bit
> disturbing.
> 

The PCA9570 datasheet is especially interesting.

"9 bits with the part identification, assigned by manufacturer, the 7 MSBs with
the category ID and the 6 LSBs with the feature ID (for example PCA9570 4-bit I/O
expander)"

Maybe there is a magic compression scheme to squash 7 MSBs and 6 LSBs into
a 9-bit field, or the category and feature IDs have quite some overlap,
or the document would benefit from some proof-reading.

> I also found that NXP apparently uses the same part id (0x100) and die
> revision (0) for PCA9570 and PCA9670. That seems odd.
> 
... especially since one has 4 channels and the other has 8 channels.
It would be interesting to see if reality and datasheets match; this might
as well be a curt-and-paste error. Of course, it might as well be that both
chips use the same die and that some pins are just not exposed on the 4 channel
version.

> Example old datasheet (2006):
> https://www.digchip.com/datasheets/download_datasheet.php?id=1098812&part-number=PCA9672
> 
On the other side this has been corrected in more recent datasheet versions,
so I would not be too concerned about that.

Guenter
