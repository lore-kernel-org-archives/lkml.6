Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D3E13C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD3C2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IENFuMRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD3C2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933660AbeFLTnY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:43:24 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37117 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933541AbeFLTnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:43:21 -0400
Received: by mail-oi0-f65.google.com with SMTP id l22-v6so153989oib.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 12:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a5W+Q0aSzo/KH6n2EqczPMszwIJemm80ZHIAcTiIois=;
        b=IENFuMRP7/kb1G52C/01UODwJOAIfxRtVABudFZXKSp4Rsn5zb/KLrNf6o1i8D5tKR
         /EkL+BuF5SswEFoqlnLZQWcGszUl/O0g/+lklzJ/E/kmj0XJGxb7EWgpLzuoL2NcA+Df
         XdGrmTtL63D0WzoH9kObzHZfNbmqat7gh9thk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a5W+Q0aSzo/KH6n2EqczPMszwIJemm80ZHIAcTiIois=;
        b=LousFzv11N3uNkw838AjNIvm+N5XsZJ4sTGll54i3wLB2DqoLA5u5tZJz13EY1yqs8
         hvcYNM+tDU7cYwlYpsijK9G2M4eHOvikM8jnYNyva6Rc029EWCwz7L6p9qK98wHcqk6M
         8CfmPBZQtsYa9ri8olY2s7cv0FTNEzeGTaincBYvVpRzyieGu6cVh6mJCRi/wWB3oCrC
         Rzq7gLjlN4MIuG6AuKqtc6v+bgG07rfUa0XR1WNQoxCYMDeROoJdDSnpuh2n/Ccx0dZT
         /RnfO1gP/2BqL+SY7jjBynTCd+xvc21MKKhukFj1lTi0Bf+RR1MSJx596JEuDxVnnWqp
         h0wQ==
X-Gm-Message-State: APt69E05LYU2HpIEO2bs3axL+IIL4DA+iMue/xgeM5WGEr3R6WImQF+c
        RY1/vxZxelggj/+EMZMrP5Ndz33CqTg=
X-Google-Smtp-Source: ADUXVKLxDZJFKdAOJ1tECwZ0a/SkQKpgQW0R/h2H3JlG5LBfSSeRzU3qWfS7/8qgVu0dnp+3Gpsm1g==
X-Received: by 2002:aca:3544:: with SMTP id c65-v6mr2641024oia.326.1528832600820;
        Tue, 12 Jun 2018 12:43:20 -0700 (PDT)
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id j196-v6sm627413oib.14.2018.06.12.12.43.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 12:43:19 -0700 (PDT)
Received: by mail-oi0-f43.google.com with SMTP id k190-v6so139840oib.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 12:43:19 -0700 (PDT)
X-Received: by 2002:aca:61c5:: with SMTP id v188-v6mr2953452oib.28.1528832598624;
 Tue, 12 Jun 2018 12:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180529181740.195362-1-evgreen@chromium.org> <MWHPR04MB11372C75BFC9416BAF5E81A19A630@MWHPR04MB1137.namprd04.prod.outlook.com>
 <CAE=gft4LoNiRtxgTA_ZPghZGEVOzu_GAwMgqhs-8NCYVgj_AVw@mail.gmail.com>
 <MWHPR04MB11370AED823FB608218CB9AD9A600@MWHPR04MB1137.namprd04.prod.outlook.com>
 <CAE=gft5Vk3neDkyvmVf4CkBQQPVK=wXp=5jJ8n0uaosEwWUOAg@mail.gmail.com>
 <b844b80f-9f6f-10f7-6dfd-f92d905738e3@intel.com> <MWHPR04MB1137E9FA44BAC5EBE097589C9A790@MWHPR04MB1137.namprd04.prod.outlook.com>
In-Reply-To: <MWHPR04MB1137E9FA44BAC5EBE097589C9A790@MWHPR04MB1137.namprd04.prod.outlook.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 12 Jun 2018 12:42:42 -0700
X-Gmail-Original-Message-ID: <CAE=gft4LRtYJH1DStr6F6iK7q+TMA3RDPhft=A_AFyKpFmyS5w@mail.gmail.com>
Message-ID: <CAE=gft4LRtYJH1DStr6F6iK7q+TMA3RDPhft=A_AFyKpFmyS5w@mail.gmail.com>
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

On Sun, Jun 10, 2018 at 2:31 AM Stanislav Nijnikov
<Stanislav.Nijnikov@wdc.com> wrote:
>
> Hi Adrian,
>
> > -----Original Message-----
> > From: Adrian Hunter <adrian.hunter@intel.com>
> > Sent: Friday, June 8, 2018 3:31 PM
> > To: Evan Green <evgreen@chromium.org>; Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
> > Cc: Vinayak Holikatti <vinholikatti@gmail.com>; jejb@linux.vnet.ibm.com; martin.petersen@oracle.com; linux-
> > kernel@vger.kernel.org; linux-scsi@vger.kernel.org; Gwendal Grignou <gwendal@chromium.org>; Alex Lemberg
> > <Alex.Lemberg@wdc.com>; Avri Altman <Avri.Altman@wdc.com>
> > Subject: Re: [PATCH 0/7] Enable UFS provisioning via Linux
> >
> > On 04/06/18 17:59, Evan Green wrote:
> > > On Sun, Jun 3, 2018 at 3:21 AM Stanislav Nijnikov
> > > <Stanislav.Nijnikov@wdc.com> wrote:
> > >>
> > >>
> > >>
> > >>> -----Original Message-----
> > >>> From: linux-scsi-owner@vger.kernel.org <linux-scsi-owner@vger.kernel.org> On Behalf Of Evan Green
> > >>> Sent: Friday, June 1, 2018 5:44 PM
> > >>> To: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
> > >>> Cc: Vinayak Holikatti <vinholikatti@gmail.com>; jejb@linux.vnet.ibm.com; martin.petersen@oracle.com; linux-
> > >>> kernel@vger.kernel.org; linux-scsi@vger.kernel.org; Gwendal Grignou <gwendal@chromium.org>; Alex Lemberg
> > >>> <Alex.Lemberg@wdc.com>; Avri Altman <Avri.Altman@wdc.com>
> > >>> Subject: Re: [PATCH 0/7] Enable UFS provisioning via Linux
> > >>>
> > >>> Hi Stanislav. Thanks for taking a look. Responses below.
> > >>>
> > >>> On Thu, May 31, 2018 at 3:04 AM Stanislav Nijnikov
> > >>> <Stanislav.Nijnikov@wdc.com> wrote:
> > >>>>
> > >>>> Hi Evan,
> > >>>> I have some generic notes:
> > >>>> - Why to create new sysfs entries for the configuration descriptor fields if they are just duplication of fields in the device and unit
> > >>> descriptors? And the sysfs representation of the device and unit descriptors is existing already.
> > >>>
> > >>> Well, UFS describes them as different descriptors. I worry that if I
> > >>> add a bunch of clever logic to hide the config descriptor behind other
> > >>> descriptors, there might be trouble later if 1) there is a quirky
> > >>> device that doesn't reflect the values between descriptors quite the
> > >>> same way or at the same time, or 2) if a later UFS spec adds more
> > >>> configuration descriptor fields that don't exactly reflect into other
> > >>> non-config descriptors, the cleverness will look awkward.
> > >>
> > >> No additional logic will be required to attach write functionality to the
> > >> existing entries instead of new defined ones. It will reduce the patch
> > >> size significantly. And there will be no need for the unit selector
> > >> mechanism which I'm not sure will be accepted by the SCSI community.
> > >>
> > >
> > > So this would be modifying the existing sysfs entries so that reads
> > > still come from the device and unit descriptors, but writes go to
> > > equivalent fields in the config descriptor? I can explore that
> > > approach. Alternatively, if the unit selector mechanism is not
> > > desired, I could dynamically create sysfs directories for each unit in
> > > the config descriptor, but still bring out the config descriptor
> > > values as separate entries. (I still worry a bit about smashing the
> > > descriptors together as the UFS spec called them out as different).
> >
> > If you use the unit attributes, how do you configure units that do not yet
> > exist?
>
> For example by adding the enable_lun writeable sysfs entry. I think both ways are
> viable and there are several pitfalls in each of them. Now it's up to Evan to decide
> how to implement this.
>
> >
> > Perhaps it is better to represent the configuration descriptors exactly as
> > they are defined in the specification.  Probably not worth exposing them at
> > all if the configuration is locked (attribute bConfigDescrLock == 1).
> >
> > Note also that the 2.1 spec. defines  bConfDescContinue which allows updates
> > to be grouped and committed together.
>
> The only question is how many devices are ready to get dozens of configuration
> descriptors related to first eight LUNs instead just one when this lock is enabled.
>
> Regards
> Stanislav

Actually I could use some advice on this. It seems like folks are
opposed to the idea of having a cfg_unit file, whose value determines
which index to talk to in the unit_* files. (I personally liked that
approach, as it was simple, has precedence, and fit the requirements,
but oh well). My instinct favors Adrian's approach of keeping the
configuration descriptor separate, rather than hiding it behind the
device and unit descriptors, as I think it's more true to the UFS spec
and less likely to cause problems in the future. However I'm trying to
figure out the best way to do that.

What I _want_ to do is basically create N sysfs groups, where each
group points to the same array of attributes. Then in the show/store
methods, look up which group I'm in and use that as an index. But the
show/store functions only pass the attributes themselves, and there
seems to be no way for me to get the parent node. So my next plan is
to create a wrapper around struct device_attribute where I can store
my index, create a template of attributes, and then create N copies of
this template. The show/store method is then a single method, which
uses container_of on the attribute to get the index, offset, and size
of the descriptor to change. This seems less than ideal to me, as it's
never fun to feel like you're wasting memory, even though it's
probably on the order of a kilobyte or two.

Stanislav, you've got the unit descriptors off in the scsi_device,
which would make a lot of sense for me too, except that I need to
configure luns that may not exist yet. Can you expand on your
enable_lun idea?
-Evan
