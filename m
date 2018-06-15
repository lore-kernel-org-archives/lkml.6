Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0667C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EB7208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JGrOrA8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EB7208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756529AbeFOVUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:20:14 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:46067 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756235AbeFOVUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:20:12 -0400
Received: by mail-ot0-f195.google.com with SMTP id a5-v6so12479406otf.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 14:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IvQcLUmg40zN4Lyh4h2eruH6akGuW2yN5v4YRJKLaeI=;
        b=JGrOrA8hjf9mfZniB9T985YW0eptF+JASV8H++mUgqLLuIlLTV2hCbY6fVNouBZFBm
         tz1mJihPZyJpr3sEGtzbfEcZg1Epa3V2vAoC8HmoV9AfQhaUQStRveWAAmnSsWSKprj4
         w/rbgkbZLsofJo0YNOQG7qSKgGVt0t1I5Wvs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IvQcLUmg40zN4Lyh4h2eruH6akGuW2yN5v4YRJKLaeI=;
        b=lKOHx49vrNgjVlqDb1wRJgrjFsrTey3Ynd3LskXxI9Q9trHFoVgmG0HnFvQYC44Am3
         WT5M4/Dy7jk3QK8VL/cUnwKrc35PUhhv9qgRHO5NxpM0ecCvs3/zx4IEFNIVRI6rZ2o8
         zMZER94XGBuOGKhZeXJFczj7MgnCZIRl1mRLZ3PUzPKmAkiLI+d1aElDkgIzecvJXgUA
         2IWIHbPHRQHlMXn+cfTVl33zS7rPWw6Q5MejZid6r2e4VhHOFt5PgMvSM+gL1rbkuzpS
         4mMwHMA7Q7ELGsLvRqZSGTv4eFo9iO7IcMZLPE4ElYHUy1T61ZcoOV9jVAGmy+j7RH0t
         QrRA==
X-Gm-Message-State: APt69E1piKu8Q0B5SgLaOqE38ZoQ045BBNpHfUN2LVBjxccTBCa0tcch
        OoQnO56Qp221hQc/7F//4tLg+G88/lA=
X-Google-Smtp-Source: ADUXVKK8lQGtdblNyWhdXENTRwZbKDRmxKOW6o5J3Z+BQl80mgu75ZrDJmmj56VTzsgbnLDP3RJFeQ==
X-Received: by 2002:a9d:126:: with SMTP id 35-v6mr1945675otu.167.1529097611667;
        Fri, 15 Jun 2018 14:20:11 -0700 (PDT)
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 200-v6sm6494722oib.49.2018.06.15.14.20.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 14:20:10 -0700 (PDT)
Received: by mail-oi0-f41.google.com with SMTP id k190-v6so10007054oib.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 14:20:10 -0700 (PDT)
X-Received: by 2002:aca:110c:: with SMTP id 12-v6mr1765698oir.303.1529097609401;
 Fri, 15 Jun 2018 14:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180529181740.195362-1-evgreen@chromium.org> <MWHPR04MB11372C75BFC9416BAF5E81A19A630@MWHPR04MB1137.namprd04.prod.outlook.com>
 <CAE=gft4LoNiRtxgTA_ZPghZGEVOzu_GAwMgqhs-8NCYVgj_AVw@mail.gmail.com>
 <MWHPR04MB11370AED823FB608218CB9AD9A600@MWHPR04MB1137.namprd04.prod.outlook.com>
 <CAE=gft5Vk3neDkyvmVf4CkBQQPVK=wXp=5jJ8n0uaosEwWUOAg@mail.gmail.com>
 <b844b80f-9f6f-10f7-6dfd-f92d905738e3@intel.com> <MWHPR04MB1137E9FA44BAC5EBE097589C9A790@MWHPR04MB1137.namprd04.prod.outlook.com>
 <CAE=gft4LRtYJH1DStr6F6iK7q+TMA3RDPhft=A_AFyKpFmyS5w@mail.gmail.com> <MWHPR04MB1137E1BB83293DE6B44ACCE39A7E0@MWHPR04MB1137.namprd04.prod.outlook.com>
In-Reply-To: <MWHPR04MB1137E1BB83293DE6B44ACCE39A7E0@MWHPR04MB1137.namprd04.prod.outlook.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 15 Jun 2018 14:19:33 -0700
X-Gmail-Original-Message-ID: <CAE=gft6DrUSkJCD94QSrv_Ojn_MF9A9bBzDTMUZUQEjDbgqodA@mail.gmail.com>
Message-ID: <CAE=gft6DrUSkJCD94QSrv_Ojn_MF9A9bBzDTMUZUQEjDbgqodA@mail.gmail.com>
Subject: Re: [PATCH 0/7] Enable UFS provisioning via Linux
To:     Stanislav.Nijnikov@wdc.com
Cc:     adrian.hunter@intel.com,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>, Alex.Lemberg@wdc.com,
        Avri.Altman@wdc.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 3:12 AM Stanislav Nijnikov
<Stanislav.Nijnikov@wdc.com> wrote:
>
>
>
> > -----Original Message-----
> > From: linux-scsi-owner@vger.kernel.org <linux-scsi-owner@vger.kernel.org> On Behalf Of Evan Green
> > Sent: Tuesday, June 12, 2018 10:43 PM
> > To: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
> > Cc: adrian.hunter@intel.com; Vinayak Holikatti <vinholikatti@gmail.com>; jejb@linux.vnet.ibm.com; martin.petersen@oracle.com;
> > linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org; Gwendal Grignou <gwendal@chromium.org>; Alex Lemberg
> > <Alex.Lemberg@wdc.com>; Avri Altman <Avri.Altman@wdc.com>
> > Subject: Re: [PATCH 0/7] Enable UFS provisioning via Linux
> >
> > On Sun, Jun 10, 2018 at 2:31 AM Stanislav Nijnikov
> > <Stanislav.Nijnikov@wdc.com> wrote:
> > >
> > > Hi Adrian,
> > >
> > > > -----Original Message-----
> > > > From: Adrian Hunter <adrian.hunter@intel.com>
> > > > Sent: Friday, June 8, 2018 3:31 PM
> > > > To: Evan Green <evgreen@chromium.org>; Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
> > > > Cc: Vinayak Holikatti <vinholikatti@gmail.com>; jejb@linux.vnet.ibm.com; martin.petersen@oracle.com; linux-
> > > > kernel@vger.kernel.org; linux-scsi@vger.kernel.org; Gwendal Grignou <gwendal@chromium.org>; Alex Lemberg
> > > > <Alex.Lemberg@wdc.com>; Avri Altman <Avri.Altman@wdc.com>
> > > > Subject: Re: [PATCH 0/7] Enable UFS provisioning via Linux
> > > >
> > > > On 04/06/18 17:59, Evan Green wrote:
> > > > > On Sun, Jun 3, 2018 at 3:21 AM Stanislav Nijnikov
> > > > > <Stanislav.Nijnikov@wdc.com> wrote:
> > > > >>
> > > > >>
> > > > >>
> > > > >>> -----Original Message-----
> > > > >>> From: linux-scsi-owner@vger.kernel.org <linux-scsi-owner@vger.kernel.org> On Behalf Of Evan Green
> > > > >>> Sent: Friday, June 1, 2018 5:44 PM
> > > > >>> To: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
> > > > >>> Cc: Vinayak Holikatti <vinholikatti@gmail.com>; jejb@linux.vnet.ibm.com; martin.petersen@oracle.com; linux-
> > > > >>> kernel@vger.kernel.org; linux-scsi@vger.kernel.org; Gwendal Grignou <gwendal@chromium.org>; Alex Lemberg
> > > > >>> <Alex.Lemberg@wdc.com>; Avri Altman <Avri.Altman@wdc.com>
> > > > >>> Subject: Re: [PATCH 0/7] Enable UFS provisioning via Linux
> > > > >>>
> > > > >>> Hi Stanislav. Thanks for taking a look. Responses below.
> > > > >>>
> > > > >>> On Thu, May 31, 2018 at 3:04 AM Stanislav Nijnikov
> > > > >>> <Stanislav.Nijnikov@wdc.com> wrote:
> > > > >>>>
> > > > >>>> Hi Evan,
> > > > >>>> I have some generic notes:
> > > > >>>> - Why to create new sysfs entries for the configuration descriptor fields if they are just duplication of fields in the device and
> > unit
> > > > >>> descriptors? And the sysfs representation of the device and unit descriptors is existing already.
> > > > >>>
> > > > >>> Well, UFS describes them as different descriptors. I worry that if I
> > > > >>> add a bunch of clever logic to hide the config descriptor behind other
> > > > >>> descriptors, there might be trouble later if 1) there is a quirky
> > > > >>> device that doesn't reflect the values between descriptors quite the
> > > > >>> same way or at the same time, or 2) if a later UFS spec adds more
> > > > >>> configuration descriptor fields that don't exactly reflect into other
> > > > >>> non-config descriptors, the cleverness will look awkward.
> > > > >>
> > > > >> No additional logic will be required to attach write functionality to the
> > > > >> existing entries instead of new defined ones. It will reduce the patch
> > > > >> size significantly. And there will be no need for the unit selector
> > > > >> mechanism which I'm not sure will be accepted by the SCSI community.
> > > > >>
> > > > >
> > > > > So this would be modifying the existing sysfs entries so that reads
> > > > > still come from the device and unit descriptors, but writes go to
> > > > > equivalent fields in the config descriptor? I can explore that
> > > > > approach. Alternatively, if the unit selector mechanism is not
> > > > > desired, I could dynamically create sysfs directories for each unit in
> > > > > the config descriptor, but still bring out the config descriptor
> > > > > values as separate entries. (I still worry a bit about smashing the
> > > > > descriptors together as the UFS spec called them out as different).
> > > >
> > > > If you use the unit attributes, how do you configure units that do not yet
> > > > exist?
> > >
> > > For example by adding the enable_lun writeable sysfs entry. I think both ways are
> > > viable and there are several pitfalls in each of them. Now it's up to Evan to decide
> > > how to implement this.
> > >
> > > >
> > > > Perhaps it is better to represent the configuration descriptors exactly as
> > > > they are defined in the specification.  Probably not worth exposing them at
> > > > all if the configuration is locked (attribute bConfigDescrLock == 1).
> > > >
> > > > Note also that the 2.1 spec. defines  bConfDescContinue which allows updates
> > > > to be grouped and committed together.
> > >
> > > The only question is how many devices are ready to get dozens of configuration
> > > descriptors related to first eight LUNs instead just one when this lock is enabled.
> > >
> > > Regards
> > > Stanislav
> >
> > Actually I could use some advice on this. It seems like folks are
> > opposed to the idea of having a cfg_unit file, whose value determines
> > which index to talk to in the unit_* files. (I personally liked that
> > approach, as it was simple, has precedence, and fit the requirements,
> > but oh well). My instinct favors Adrian's approach of keeping the
> > configuration descriptor separate, rather than hiding it behind the
> > device and unit descriptors, as I think it's more true to the UFS spec
> > and less likely to cause problems in the future. However I'm trying to
> > figure out the best way to do that.
> >
> > What I _want_ to do is basically create N sysfs groups, where each
> > group points to the same array of attributes. Then in the show/store
> > methods, look up which group I'm in and use that as an index. But the
> > show/store functions only pass the attributes themselves, and there
> > seems to be no way for me to get the parent node. So my next plan is
> > to create a wrapper around struct device_attribute where I can store
> > my index, create a template of attributes, and then create N copies of
> > this template. The show/store method is then a single method, which
> > uses container_of on the attribute to get the index, offset, and size
> > of the descriptor to change. This seems less than ideal to me, as it's
> > never fun to feel like you're wasting memory, even though it's
> > probably on the order of a kilobyte or two.
> >
> > Stanislav, you've got the unit descriptors off in the scsi_device,
> > which would make a lot of sense for me too, except that I need to
> > configure luns that may not exist yet. Can you expand on your
> > enable_lun idea?
> > -Evan
>
> It's a writeable sysfs entry that receive an integer value (as an index
> of a lun that should be enable). The store function does some sanity
> checks, reads the configuration descriptor, update the specified
> lun enable parameter and sends it. After restart the lun will be available
> and ready for further configuration.
>
> Stanislav
>
>

Thanks Bart for the advice. I took that and ran with it a little in
the next series, which I've just sent out.
Stanislav, thanks for elaborating. For the next spin of this series I
went with keeping the config descriptor separate, but if everyone
prefers putting the config descriptor behind the device/unit
descriptors, I will keep this solution in mind.
-Evan
