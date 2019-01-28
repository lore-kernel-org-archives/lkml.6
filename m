Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90424C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A81B20881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfA1PKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:10:04 -0500
Received: from route-level1.fsdata.se ([89.221.252.216]:59591 "EHLO
        route-level1.fsdata.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfA1PKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:10:04 -0500
Received: from DAG01.HMC.local (192.168.46.11) by EDGE01LEVEL1.hmc.local
 (192.168.46.33) with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 28 Jan
 2019 16:09:25 +0100
Received: from localhost (94.234.46.36) by DAG01.HMC.local (192.168.46.11)
 with Microsoft SMTP Server (TLS) id 15.0.1263.5; Mon, 28 Jan 2019 16:09:21
 +0100
Date:   Mon, 28 Jan 2019 16:09:14 +0100
From:   Mattias Jacobsson <2pi@mok.nu>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <michal.lkml@markovi.net>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <2pi@mok.nu>
Subject: Re: [PATCH v2 2/3] platform/x86: wmi: add WMI support to
 MODULE_DEVICE_TABLE()
Message-ID: <20190128150909.4r3tje5l34u5t2xs@mok.nu>
References: <cover.1548610407.git.2pi@mok.nu>
 <680df320c7263bdd35f87794ae12fb9a9ef3b71c.1548610407.git.2pi@mok.nu>
 <CAHp75VfE0g9OVeOzJ5fBj4MGL4nv=a4S-n1fD9kfP1AaniAOGw@mail.gmail.com>
 <20190128140911.xsltdctpk3bya7ya@mok.nu>
 <20190128142701.xj4vwiind4ddbcj6@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190128142701.xj4vwiind4ddbcj6@pali>
X-Originating-IP: [94.234.46.36]
X-ClientProxiedBy: PROXY04.HMC.local (192.168.46.54) To DAG01.HMC.local
 (192.168.46.11)
Received-SPF: Neutral (EDGE01LEVEL1.hmc.local: 192.168.46.11 is neither
 permitted nor denied by domain of 2pi@mok.nu)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-28, Pali Rohár wrote:
> On Monday 28 January 2019 15:09:11 Mattias Jacobsson wrote:
> > Hi,
> > 
> > On 2019-01-27, Andy Shevchenko wrote:
> > > On Sun, Jan 27, 2019 at 9:04 PM Mattias Jacobsson <2pi@mok.nu> wrote:
> > > >
> > > > The kernel provides the macro MODULE_DEVICE_TABLE() where driver authors
> > > > can specify their device type and their array of device_ids and thereby
> > > > trigger the generation of the appropriate MODULE_ALIAS() output. This is
> > > > opposed to having to specify one MODULE_ALIAS() for each device. The WMI
> > > > device type is currently not supported.
> > > >
> > > > While using MODULE_DEVICE_TABLE() does increase the complexity as well
> > > > as spreading out the implementation across the kernel, it does come with
> > > > some benefits too;
> > > > * It makes different drivers look more similar; if you can specify the
> > > >   array of device_ids any device type specific input to MODULE_ALIAS()
> > > >   will automatically be generated for you.
> > > > * It helps each driver avoid keeping multiple versions of the same
> > > >   information in sync. That is, both the array of device_ids and the
> > > >   potential multitude of MODULE_ALIAS()'s.
> > > >
> > > > Add WMI support to MODULE_DEVICE_TABLE() by adding info about struct
> > > > wmi_device_id in devicetable-offsets.c and add a WMI entry point in
> > > > file2alias.c.
> > > >
> > > > The type argument for MODULE_DEVICE_TABLE(type, name) is wmi.
> > > 
> > > > +/* Looks like: wmi:guid */
> > > > +static int do_wmi_entry(const char *filename, void *symval, char *alias)
> > > > +{
> > > > +       DEF_FIELD_ADDR(symval, wmi_device_id, guid_string);
> > > > +       if (strlen(*guid_string) != WMI_GUID_STRING_LEN) {
> > > > +               warn("Invalid WMI device id 'wmi:%s' in '%s'\n",
> > > > +                               *guid_string, filename);
> > > > +               return 0;
> > > > +       }
> > > 
> > > > +       if (snprintf(alias, 500, WMI_MODULE_PREFIX "%s", *guid_string) < 0) {
> > > 
> > > What the point to use snprintf here with arbitrary buffer size if we
> > > exactly know 2 facts:
> > > 1. UUID string is  36 characters
> > > 2. buffer is long enough
> > > 
> > > ?
> > 
> > As long as no one changes the code, not much.
> 
> At least instead of hardcoded number 500, you should use pass size of alias:

Just a note; 500 comes from a few lines below in the do_table()
function. It is the actual size of alias we get in do_wmi_entry().

> 
>   static int do_wmi_entry(const char *filename, void *symval, char *alias, size_t alias_size)
> 
>   if (snprintf(alias, alias_size, WMI_MODULE_PREFIX "%s", *guid_string) < 0) {

That is a good idea, but requires changing all other entry points.
I was thinking of defining a DO_ENTRY_ALIAS_SIZE macro to replace
all/any 500 in file2alias.c. However that is a separate patch.

> 
> Or pass buffer of constant size and then you do not need to use snprintf:
> 
>   #define ALIAS_SIZE (sizeof(WMI_MODULE_PREFIX)+WMI_GUID_STRING_LEN)

I could use ALIAS_SIZE and add that to snprintf() instead of 500.
While I guess it is unlikely that alias ever will be changed to be too
short for us, using ALIAS_SIZE doesn't "guarantee" that we are within
the bounds of alias if anything changes.

> 
>   static int do_wmi_entry(const char *filename, void *symval, char alias[ALIAS_SIZE])
> 
> This should not break even when code around changes.
> 
> > > 
> > > > +               warn("Could not generate all MODULE_ALIAS's in '%s'\n",
> > > > +                               filename);
> > > > +               return 0;
> > > > +       }
> > > > +       return 1;
> > > > +}
> > > 
> > > -- 
> > > With Best Regards,
> > > Andy Shevchenko
> > 
> > Thanks,
> > Mattias
> 
> -- 
> Pali Rohár
> pali.rohar@gmail.com

Thanks,
Mattias
