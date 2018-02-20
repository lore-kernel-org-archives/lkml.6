Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753462AbeBTRpr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 12:45:47 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:41934 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbeBTRpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 12:45:44 -0500
X-Google-Smtp-Source: AH8x224bETPqvBgZi7GNaQ2/P0nsvKlBmnh7uKl5plzultkntS5v96vvORgc+ALiwtSg5Fx30lNzyw==
Date: Tue, 20 Feb 2018 18:45:40 +0100
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 2/3] HID: steam: add serial number information.
Message-ID: <20180220174540.GA8231@casa>
References: <20180213120308.23879-2-rodrigorivascosta@gmail.com>
 <CAO-hwJK5sos9=RDajS_cXBzfePqf6TJs3Z-jk568sumR-zjqdw@mail.gmail.com>
 <20180215221633.GA18755@casa>
 <CAO-hwJLjFaP3ZLoM+EDbruoRhOyPPFXmo7FWGoXESc9XgkD4Kg@mail.gmail.com>
 <20180216090243.GB18755@casa>
 <CAO-hwJKuWWiNX63=X1GSEQQ1cPhi35g6NuX7gsFNGj_s0UdM+Q@mail.gmail.com>
 <20180216095722.GC18755@casa>
 <CAO-hwJ+9Jvd8x5dRaerstzeNNgY4_mUar77BB1k2ctxaOCJLtQ@mail.gmail.com>
 <20180216205939.GA17329@casa>
 <CAO-hwJ+MW=3X=pSrmPf=Xp7fW0X4d2GJJj_0rf0yCTmFsnfD1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+MW=3X=pSrmPf=Xp7fW0X4d2GJJj_0rf0yCTmFsnfD1g@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 05:49:02PM +0100, Benjamin Tissoires wrote:
> On Fri, Feb 16, 2018 at 9:59 PM, Rodrigo Rivas Costa
> > But about that +7 in hid_alloc_report_buf(), isn't it to make room for
> > the implement()/extract() functions? And IIUIC those are not used for
> > raw_requests... they are instead passed directly to usb_control_msg()
> > (or whatever the ll driver does). That's the point of being raw, isn't
> > it?
> >
> > If I'm right with that, would it make sense to go back to kzalloc(65)?
> >
> > If I'm wrong, then if you agree, I'll default to:
> >
> >         hid_hw_raw_request(steam->hid_dev, 0x00,
> >                 buf, hid_report_len(r) + 1, /* count the request number */
> >                 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> >
> > Then, if hid_report_len() is ever updated to return the +1, this one
> > should be removed. And even if it is not, we still have +6 extra bytes
> > from hid_alloc_report_buf(), so no real harm done.
> 
> I am fine with your analysis except for the last point :)
> We need all 7 extra bytes, not 6 (in implement()). However, as you
> said, implement() is not used in the low_level transport functions, so
> there is no point bike shedding for ages.
> 
> I'd say please stick to hid_report_alloc_buf (maybe add a comment
> about the missing report ID added by usb), and use hid_report_len(r) +
> 1 while calling hid_hw_raw_request(). This way, we can always fix the
> behavior later and have something which will not break.
> 
> How does that sound?
It sound fine to me. I'll try to write a small comment explaining the
+1.

Thanks
Rodrigo
