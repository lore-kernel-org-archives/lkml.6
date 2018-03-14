Return-Path: <rjw@rjwysocki.net>
X-Google-Smtp-Source: AG47ELsKEp/BWi+U8MRO5sGy0ZXWrj1UOpYrMj+47rLQISbnlrBMOXSFxUtoJTKqcmdJ019PaXiX
ARC-Seal: i=1; a=rsa-sha256; t=1521028597; cv=none;
        d=google.com; s=arc-20160816;
        b=uHesT6FFJZsF12xv3JZdLtZBh0yaNlqFQoaO4V6c2y/sdeXk9AVSgST/vNPxCmuKpx
         1HxVLI7qdYtDQf+UfW/qrYSAQvR7k61asXZTmIPK5eQlu+ZDlJIfF//CZUU6pk5NXxXB
         MN6AUIkRRzvai0jv83huWICdEI8EEY9Z2HklH28AZCpn+QAP1F++LKcWJIzYJ/gBl+p1
         nkYw7GiVkA1I8C/3xnAuIQ9UCkhPAs0KdFYjqKUtGkFRS1opLVWdV6uo7/HxVNxR2I2R
         koj8L+DZ7cJHCrtYXyQL9snf4wmI/EmQnoyqqKjS2uyqkqFqHlQHMInGk/By9qsRsqlz
         frYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=e6u6MhHqOvfsPV0Ok6J8Kw+bZYFUuf75WR0H0sJtfKc=;
        b=hze9pp6dHvldZbT7HTfODg48ECmr4y8fLam4ORd/LV6eebSP9g8uL1NGWGgeu67X3F
         /9tTpmvcp+5QLCaQj2lls9v4Gy3f+DrvjJDSh8OcMMvz06yNwi6dXMaDB7D0utAtBcFP
         dpmep5goQXSwqARN2EeThd8e4l0BdrVAPtZUeR5BGK8eAqzSakFxofeMauvujyvWcnop
         29AdJu0s0ZQ4QOy+iwOPxu42HovcL2QwmZqLsvgGmcdvtoWhD1V0NaJjI4VtIQelOKAk
         O+zg4mLa0sIncznBUnSoeyPKAdVVXQXQevfnvLmKERSP6moycBXTo5SyoUPqGnpXF9t1
         zN0g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Tomasz Figa <tfiga@chromium.org>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>, Lukas Wunner <lukas@wunner.de>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>, Sricharan R <sricharan@codeaurora.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Archit Taneja <architt@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v9 1/5] driver core: Find an existing link between two devices
Date: Wed, 14 Mar 2018 12:57:11 +0100
Message-ID: <2705105.V6KYPvoJqj@aspire.rjw.lan>
In-Reply-To: <CAAFQd5CQXY0Efv+2MC1kTVW5q4eZjJ=gwVaR-LA=3agnSSHzUw@mail.gmail.com>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org> <2217404.A2W3Iek6du@aspire.rjw.lan> <CAAFQd5CQXY0Efv+2MC1kTVW5q4eZjJ=gwVaR-LA=3agnSSHzUw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594812129788829883?=
X-GMAIL-MSGID: =?utf-8?q?1594914083437094048?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wednesday, March 14, 2018 12:50:54 PM CET Tomasz Figa wrote:
> On Wed, Mar 14, 2018 at 8:12 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, March 13, 2018 12:23:34 PM CET Tomasz Figa wrote:
> >> On Tue, Mar 13, 2018 at 7:34 PM, Vivek Gautam
> >> <vivek.gautam@codeaurora.org> wrote:
> >> > Hi Tomasz,
> >> >
> >> > On Tue, Mar 13, 2018 at 3:45 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> >> >> Hi Vivek,
> >> >>
> >> >> Thanks for the patch.
> >> >>
> >> >> On Tue, Mar 13, 2018 at 5:55 PM, Vivek Gautam
> >> >> <vivek.gautam@codeaurora.org> wrote:
> >> >>> The lists managing the device-links can be traversed to
> >> >>> find the link between two devices. The device_link_add() APIs
> >> >>> does traverse these lists to check if there's already a link
> >> >>> setup between the two devices.
> >> >>> So, add a new APIs, device_link_find(), to find an existing
> >> >>> device link between two devices - suppliers and consumers.
> >> >>
> >> >> I'm wondering if this API would be useful for anything else that the
> >> >> problem we're trying to solve with deleting links without storing them
> >> >> anywhere. Perhaps a device_link_del_dev(consumer, supplier) would be a
> >> >> better alternative?
> >> >
> >> > Yea, that sounds simpler i think. Will add this API instead of
> >> > find_link(). Thanks.
> >>
> >> Perhaps let's wait for a moment to see if there are other opinions. :)
> >>
> >> Rafael, Lucas, any thoughts?
> >
> > It is not clear to me what the device_link_del_dev(consumer, supplier) would do.
> 
> It would delete a link between consumer and supplier.

If there's one I suppose.

I'm wondering if you are somehow trying to address the same problem as the
device links reference counting patch from Lukas that has been queued up for 4.17
already.

Thanks,
Rafael
