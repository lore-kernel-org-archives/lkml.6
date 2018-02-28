Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934128AbeB1UFI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 15:05:08 -0500
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:7317 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933981AbeB1UFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 15:05:05 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2G8AACcCpdahz+a6ERdGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQmgQAoCoNKmBGCAoEWaoY3jR6CAQqFMAIagjxXFQECAQEBAQE?=
 =?us-ascii?q?BAgECEAEBAQoLCQgoL4I4IoJKAQEBAwEjEUUMBAIBCBEEAQEBAgIjAwICAh8lA?=
 =?us-ascii?q?QgIAgQOBQiEfAMNCKwBgieHLA2BMIIWAQEBAQEBAQMBAQEBAQEBAQEfgQ+EFII?=
 =?us-ascii?q?ngz2DLYJqghsEHxAjglOCYgWNcowwMAmNO4MwgW+HUYU+ijSHH4EuNIF1cE+CQ?=
 =?us-ascii?q?4JDEAyBe3eLJYEXAQEB?=
X-IPAS-Result: =?us-ascii?q?A2G8AACcCpdahz+a6ERdGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?mgQAoCoNKmBGCAoEWaoY3jR6CAQqFMAIagjxXFQECAQEBAQEBAgECEAEBAQoLC?=
 =?us-ascii?q?QgoL4I4IoJKAQEBAwEjEUUMBAIBCBEEAQEBAgIjAwICAh8lAQgIAgQOBQiEfAM?=
 =?us-ascii?q?NCKwBgieHLA2BMIIWAQEBAQEBAQMBAQEBAQEBAQEfgQ+EFIIngz2DLYJqghsEH?=
 =?us-ascii?q?xAjglOCYgWNcowwMAmNO4MwgW+HUYU+ijSHH4EuNIF1cE+CQ4JDEAyBe3eLJYE?=
 =?us-ascii?q?XAQEB?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.198
X-IronPort-AV: E=Sophos;i="5.47,406,1515477600";
   d="scan'208";a="1222193538"
X-DLP: DLP_GlobalPCIDSS
To: <andy.shevchenko@gmail.com>
CC: <rjw@rjwysocki.net>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] power/hibernate: Make passing hibernate offsets more
 friendly
Thread-Topic: [RFC] power/hibernate: Make passing hibernate offsets more
 friendly
Thread-Index: AQHTsLvZsEmrPWpV1EW9TBL1ic3Lf6O6giwA//+55sA=
Date: Wed, 28 Feb 2018 20:05:03 +0000
Message-ID: <ad15f3beb9f44c77b79f3038cb75b69c@ausx13mpc124.AMER.DELL.COM>
References: <1519839829-2191-1-git-send-email-mario.limonciello@dell.com>
 <CAHp75VcdsALCUBNoO4BoOj0rHuxurhr6B3GL2i7D79BxRL77kQ@mail.gmail.com>
In-Reply-To: <CAHp75VcdsALCUBNoO4BoOj0rHuxurhr6B3GL2i7D79BxRL77kQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1SK5EUF027759



> -----Original Message-----
> From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
> Sent: Wednesday, February 28, 2018 12:11 PM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: Rafael J . Wysocki <rjw@rjwysocki.net>; ACPI Devel Maling List <linux-
> acpi@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>
> Subject: Re: [RFC] power/hibernate: Make passing hibernate offsets more friendly
> 
> On Wed, Feb 28, 2018 at 7:43 PM, Mario Limonciello
> <mario.limonciello@dell.com> wrote:
> > Currently the only way to specify a hibernate offset for a swap
> > file is on the kernel command line.
> >
> > This makes some changes to improve:
> > 1) Add a new /sys/power/disk_offset that lets userspace specify
> > the offset and disk to use when initiating a hibernate cycle.
> >
> > 2) Adjust /sys/power/resume interpretation to also read in an
> > offset.
> 
> Read is okay per se (not consistent though), showing is not.
> It might break an ABI.

Right this is part of why I was proposing making a new attribute.

The current RFC implementation I sent keeps the read output the
same for /sys/power/resume.

> 
> > Actually klibc's /bin/resume has supported passing a hibernate
> > offset in since 20695264e21dcbde309cd81f73cfe2cea42e779d.
> >
> > The kernel was just lobbing anything after the device specified
> > off the string.  Instead parse that and populate hibernate offset
> > with it.
> 
> > An alternative to introducing a new sysfs parameter may be to document
> > setting these values via /sys/power/resume.  If the wrong signature is found
> > on the swapfile/swap partition by the kernel it does show an error
> > but it updates the values and they'll work when actually invoked later.
> 
> Don't you need to document new node?

Yes, I wanted to get feedback before I reworked documentation and that's
why I implemented both approaches right now.

Maybe both even make sense.
When I resubmit as a patch I'll make sure documentation is updated.

> 
> > +static int parse_device_input(const char *buf, size_t n)
> >  {
> > +       unsigned long long offset;
> >         dev_t res;
> >         int len = n;
> >         char *name;
> > +       char *last;
> >
> >         if (len && buf[len-1] == '\n')
> >                 len--;
> 
> I'm not sure first part even needed, but okay, it's in original code.
> 
> >         name = kstrndup(buf, len, GFP_KERNEL);
> >         if (!name)
> >                 return -ENOMEM;
> 
> Side notes.
> This whole dance b/c of high probability of '\n' at the end which
> breaks _some_ kernel parsers.
> It might make sense to do a wrapper and call the guts of this function
> with or without memory allocation depending on presence of '\n'.
> 

OK.

> > -
> 
> This is not needed to be removed.
> 
> > +       last = strrchr(name, ':');
> 
> > +       printk("%lu %s %s %d", last-name, name, last, len);
> 
> Ouch. I guess it's only for RFC.

Yes I was having problems originally and it was debug, it won't
be there when submitted for application.

> 
> > +       if (last != NULL &&
> 
> > +           (last-name) != len-1 &&
> 
> > +           sscanf(last+1, "%llu", &offset) == 1)
> 
> This is effectively
> 
> if (last && *(last+1)) {
>   int ret = kstrtoull(...&swsusp_resume_block...);
>   if (ret)
>    ...warn?..
> }
> 
> ?

I'll have to look more closely, but if this simplification
works I'll switch over.

> 
> > +                swsusp_resume_block = offset;
> 
> > +       swsusp_resume_device = res;
> > +
> 
> > +       return 1;
> 
> ???
> Why not traditional 0?
> 
> > +}
> 
> > @@ -1125,7 +1161,6 @@ static int __init pm_disk_init(void)
> >
> >  core_initcall(pm_disk_init);
> >
> > -
> 
> This doesn't belong to the change.
> 
> --
> With Best Regards,
> Andy Shevchenko
