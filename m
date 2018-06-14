Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AA78BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 00:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6110F208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 00:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6110F208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thebollingers.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935903AbeFNAkr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 20:40:47 -0400
Received: from resqmta-po-09v.sys.comcast.net ([96.114.154.168]:54714 "EHLO
        resqmta-po-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935557AbeFNAkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 20:40:46 -0400
Received: from resomta-po-08v.sys.comcast.net ([96.114.154.232])
        by resqmta-po-09v.sys.comcast.net with ESMTP
        id TG7wfs7JFv8ZOTGJifayGE; Thu, 14 Jun 2018 00:40:46 +0000
Received: from thebollingers.org ([73.223.250.230])
        by resomta-po-08v.sys.comcast.net with ESMTPA
        id TGJffBOr4AsWhTGJhfLcrD; Thu, 14 Jun 2018 00:40:45 +0000
Date:   Wed, 13 Jun 2018 17:40:44 -0700
From:   Don Bollinger <don@thebollingers.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] optoe: driver to read/write SFP/QSFP EEPROMs
Message-ID: <20180614004044.jjz3ws3zyns7x4x6@thebollingers.org>
References: <20180611042515.ml6zbcmz6dlvjmrp@thebollingers.org>
 <CAK8P3a2aPshgrAp6=e62mvEpmmLYCAwRa_HxG_A1YKJ5we5XVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2aPshgrAp6=e62mvEpmmLYCAwRa_HxG_A1YKJ5we5XVQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CMAE-Envelope: MS4wfJnTAVp5GCyK+GXhy2T7ZCDQltP2c87hFRBvVCWgoYxWIp9PqjZZWNupd9vC1wZgPT5yfxJQ9WtFXdh+qyDCuuzK44hp9dseeSHRzqpscrXo3W1mb2DG
 TCIpMj1r2OWBS/EGuBPvWop68OBGEkHQegxJ2xT6g8RcB71AI/sWoK6erhr2prbV5qBdts4zyyVkhGj0AYlNaT8DJm9Wj7tyY96u4Zl0DvXxQR46MHd1P54h
 TH6BvbO3x+BhfR9cjZYsTI4MO1430DDvKSMzbXNmwkY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 03:43:02PM +0200, Arnd Bergmann wrote:
> On Mon, Jun 11, 2018 at 6:25 AM, Don Bollinger <don@thebollingers.org> wrote:
> > optoe is an i2c based driver that supports read/write access to all
> > the pages (tables) of MSA standard SFP and similar devices (conforming
> > to the SFF-8472 spec) and MSA standard QSFP and similar devices
> > (conforming to the SFF-8436 spec).
> >
> >
> > Signed-off-by: Don Bollinger <don@thebollingers.org>
> 
> > +
> > +#undef EEPROM_CLASS
> > +#ifdef CONFIG_EEPROM_CLASS
> > +#define EEPROM_CLASS
> > +#endif
> > +#ifdef CONFIG_EEPROM_CLASS_MODULE
> > +#define EEPROM_CLASS
> > +#endif
> 
> I don't understand this part: I see some older patches introducing an
> EEPROM_CLASS, but nothing ever seems to have made it into the
> mainline kernel.
> 
> If that class isn't there, this code shouldn't be either. You can always
> add it back in case we decide to introduce that class later, but then
> I wouldn't make it a compile-time option but just a hard dependency
> instead.

Thanks for the feedback.

Some background will explain how optoe got here...  My goal is to make
the EEPROM data and controls in {Q}SFP devices more accessible.  (I'm
working for Finisar, an optics vendor.)

The ecosystem where optoe operates includes switch vendors, NOS vendors,
optics vendors and switch ASIC vendors, competing and collaborating to
build a bunch of different complete white box switch solutions.

The NOS (Network Operating System) vendors start with a Linux distro,
then add a bunch of their own patches and 'value add'.  Then they
include platform drivers from the switch vendors.  And they integrate
the chosen switch ASIC SDK.

Here's the key:  I don't have access to all of those pieces.  I can
build an environment to build my driver for many of those systems, but I
can't change other elements of that NOS.

The first NOS I targeted (Cumulus Linux) happens to be the author of the
EEPROM_CLASS patches you cited.  I began with their driver (the best
available), and morphed it into optoe.  To fit their environment, I kept
the EEPROM_CLASS code.  They use their own platform driver (one for each
switch model) to instantiate their predecessor to the optoe driver.  So,
since I don't have access to their platform driver, I kept the data
structure they pass to the probe function, where I get initialization
data.  That is now struct optoe_platform_data.  The *dummy items in that
struct maintain compatibility, while making it clear that they aren't
really needed.

When I targeted the next NOS, it did not have the EEPROM_CLASS code.  I
figured out I could #ifdef that code, enabling me to create a driver that
works in both environments.  

> 
> > +struct optoe_platform_data {
> > +       u32             byte_len;               /* size (sum of all addr) */
> > +       u16             page_size;              /* for writes */
> > +       u8              flags;
> > +       void            *dummy1;                /* backward compatibility */
> > +       void            *dummy2;                /* backward compatibility */
> > +
> > +#ifdef EEPROM_CLASS
> > +       struct eeprom_platform_data *eeprom_data;
> > +#endif
> > +       char port_name[MAX_PORT_NAME_LEN];
> > +};
> 
> What is the backward-compatibility for? Normally we don't do it
> like that, we only keep compatibility with things that have already
> been part of the kernel, especially when you also have an #ifdef
> that makes it incompatible again ;-)

So it is actually compatible with two different kernel compilations.  If
EEPROM_CLASS is configured, optoe supports that model.  If not, optoe
implements a sysfs file to identify which port this device is on.  It
works.

> 
> > +struct optoe_data {
> > +       struct optoe_platform_data chip;
> 
> Maybe merge the two structures into one?

optoe_platform_data is passed in when optoe gets a probe.  It is only
part of the data I need to maintain internally.  I inherited this
pattern from at24.c (the predecessor ^2 to optoe).

> 
>         Arnd
> 

All that said...  I am working with my partners to see if we can remove
both the EEPROM_CLASS code and the compatibility anomalies.  Technically
it would be easy.  Logistically it is probably manageable.  The next
step is mine, I will either remove the offending code or I will lobby to
keep it in there.

Don
