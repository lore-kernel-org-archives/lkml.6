Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751711AbeA3Isc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 03:48:32 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43054 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbeA3Isb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 03:48:31 -0500
X-Google-Smtp-Source: AH8x225evsIzkLsVRzxYGyO4JTqZYF48at2GKrOB7yT7Ao5JYEYqelYokb5FC/W7hgqnOFv8xWIlaQ==
Date: Tue, 30 Jan 2018 09:48:27 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Chen Guanqiao <chen.chenchacha@foxmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] fs: fat: add ioctl method in fat filesystem driver
Message-ID: <20180130084827.g6iegq4rsqnji76s@pali>
References: <20180117104355.889-1-chen.chenchacha@foxmail.com>
 <20180117104355.889-4-chen.chenchacha@foxmail.com>
 <CAHp75Vcxz-6vREpMVBUGNR0kyNUYt3xJDaGPaSYnx9sj4cxX3Q@mail.gmail.com>
 <20180129164304.44on6tdlhpzcwarv@pali>
 <5a7011dd.ca40650a.885bf.f16eSMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a7011dd.ca40650a.885bf.f16eSMTPIN_ADDED_BROKEN@mx.google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0U8mau7022954

On Tuesday 30 January 2018 14:33:49 Chen Guanqiao wrote:
> On Mon, 2018-01-29 at 17:43 +0100, Pali Rohár wrote:
> > On Monday 29 January 2018 15:18:42 Andy Shevchenko wrote:
> > > +Cc: Pali, who AFAIRC is interested in FAT labeling mess.
> > 
> > Yes, please CC me for FAT labeling discussing in future.
> > 
> > > On Wed, Jan 17, 2018 at 12:43 PM, ChenGuanqiao
> > > <chen.chenchacha@foxmail.com> wrote:
> > > 
> > > Commit message?
> > > 
> > > > Signed-off-by: ChenGuanqiao <chen.chenchacha@foxmail.com>
> > > >  #include <linux/fsnotify.h>
> > > >  #include <linux/security.h>
> > > >  #include <linux/falloc.h>
> > > > +#include <linux/ctype.h>
> > > 
> > > It would be better to squeeze it to have order (to some extent)
> > > preserved.
> > > 
> > > > +static int fat_check_d_characters(char *label, unsigned long
> > > > len)
> > > > +{
> > > > +       int i;
> > > > +
> > > > +       for (i = 0; i < len; ++i) {
> > > 
> > > Oy vey, unsigned long len vs. int i.
> > > 
> > > > +               switch (label[i]) {
> > > > +               case 'a' ... 'z':
> > > > +                       label[i] = __toupper(label[i]);
> > 
> > Why only lower a..z? á or ó are also valid (according to some OEM
> > codepage) and are lower case.
> > 
> > Also please look at my testing results. Even old DOS versions are
> > able
> > to correctly read lower case label. Therefore I do not see any reason
> > why to have such "force" code in kernel.
> > 
> > https://www.spinics.net/lists/kernel/msg2645732.html
> > 
> > Here I proposed how should be linux tools unified which manipulates
> > with
> > fat label.
> In character detection, I refer to the FAT standard document "Ecma-
> 107".

So please stick with implementation which is already used in kernel
driver or refer to one of two MS documentations for FAT12/16/32. We do
not want to have part of kernel fs driver to be written according one
documentation, other parts according to another documentation and
remaining parts according to guess or something else. We already have
compatibility with MS FAT, so inventing something new does not make
sense. Also in past there was found mistakes in MS documentation (like
incorrect formulas for counting clusters, etc.), so beware of facts that
documentation/specification does not have to be 100% correct.

In above email I did investigation for FAT labels and come to the
conclusion which seems to make sense. So if you disagree with it, please
open discussion what is wrong with proposed solution for unifying
handling label on Linux. Instead of inventing fully new way how to
handle FAT label in Linux. It really does not make any sense to use
fully different way how to handle FAT label which is incompatible with
existing Linux and Windows implementations.

In namei_msdos.c you can find already used functions. Others should be
available in dir.c.

> The document limits the volume label to a range of characters
> called "d-characters". The "d-characters" only includes uppercase
> letter, '-' and numbers.

msdos.ko and vfat.ko already handles also other characters.

> And I have found the volume label can be written as extended ASCII,
> double-byte characters in Windows. such as Chinese characters, Arabic
> characters, and others are not all characters that control characters
> and punctuation mark in ASCII. This is obviously no correct if we copy
> the implementation of windows completely, let the maximum length of
> volume label is variable?

Label is stored in two locations: boot sector and as entry in root
directory structure. For directory entry there are strict rules which
msdos.ko/vfat.ko uses and which are verified by years of usage. Maximum
length is fixed to 11 bytes due to length of directory entry. Also note
that label cannot be stored as LFN entry.

-- 
Pali Rohár
pali.rohar@gmail.com
