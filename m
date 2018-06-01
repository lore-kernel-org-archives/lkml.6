Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeFAOoz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:44:55 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40851 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752695AbeFAOov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:44:51 -0400
X-Google-Smtp-Source: ADUXVKLHlbnfVOzNGHk9/7U9q5hU4TpsqNWdjlwQ84NAyw1f2uyuIl7hCHEdfsAitky7y8b80C+p6A==
MIME-Version: 1.0
References: <20180529181740.195362-1-evgreen@chromium.org> <MWHPR04MB11372C75BFC9416BAF5E81A19A630@MWHPR04MB1137.namprd04.prod.outlook.com>
In-Reply-To: <MWHPR04MB11372C75BFC9416BAF5E81A19A630@MWHPR04MB1137.namprd04.prod.outlook.com>
From: Evan Green <evgreen@chromium.org>
Date: Fri, 1 Jun 2018 07:44:08 -0700
X-Gmail-Original-Message-ID: <CAE=gft4LoNiRtxgTA_ZPghZGEVOzu_GAwMgqhs-8NCYVgj_AVw@mail.gmail.com>
Message-ID: <CAE=gft4LoNiRtxgTA_ZPghZGEVOzu_GAwMgqhs-8NCYVgj_AVw@mail.gmail.com>
Subject: Re: [PATCH 0/7] Enable UFS provisioning via Linux
To: Stanislav.Nijnikov@wdc.com
Cc: Vinayak Holikatti <vinholikatti@gmail.com>, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Alex.Lemberg@wdc.com, Avri.Altman@wdc.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanislav. Thanks for taking a look. Responses below.

On Thu, May 31, 2018 at 3:04 AM Stanislav Nijnikov
<Stanislav.Nijnikov@wdc.com> wrote:
>
> Hi Evan,
> I have some generic notes:
> - Why to create new sysfs entries for the configuration descriptor fields if they are just duplication of fields in the device and unit descriptors? And the sysfs representation of the device and unit descriptors is existing already.

Well, UFS describes them as different descriptors. I worry that if I
add a bunch of clever logic to hide the config descriptor behind other
descriptors, there might be trouble later if 1) there is a quirky
device that doesn't reflect the values between descriptors quite the
same way or at the same time, or 2) if a later UFS spec adds more
configuration descriptor fields that don't exactly reflect into other
non-config descriptors, the cleverness will look awkward.

> - It would be nice to have some "packet" mode allowing to gather configuration changes and apply them at once, not one by one.

That's definitely doable. Do you think it's needed? I suppose if there
were a device that truly allowed you to do only a single write to the
config descriptor, then the commit style would be needed. The two
devices I've tested (Toshiba and Samsung) allow multiple writes to the
config descriptor, which makes me lean towards not needing the
batch-and-commit style, since if you get interrupted you can simply
try again. I'm happy to do either, though.

> - Why to put documentation update in the separate patches?
Well, in case some piece of this turned out to be controversial, I
wanted to allow for the option of taking these changes independently,
without the concern of missing the documentation. I'm happy to squash
all the documentation changes into one if that's preferred.

-Evan
