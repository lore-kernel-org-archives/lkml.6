Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247B4C67790
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 00:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D130720671
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 00:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D130720671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxera.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389182AbeG1Bsc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 21:48:32 -0400
Received: from mx2.mpynet.fi ([82.197.21.85]:42295 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388735AbeG1Bsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 21:48:32 -0400
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Jul 2018 21:48:30 EDT
From:   Anton Altaparmakov <anton@tuxera.com>
To:     David Howells <dhowells@redhat.com>
CC:     Jann Horn <jannh@google.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 34/38] vfs: syscall: Add fsinfo() to query filesystem
 information [ver #10]
Thread-Topic: [PATCH 34/38] vfs: syscall: Add fsinfo() to query filesystem
 information [ver #10]
Thread-Index: AQHUJdAyV0CcP4PZfEyj5IwXni6Gg6SjgUUAgAAJmACAAAcLgA==
Date:   Sat, 28 Jul 2018 00:14:14 +0000
Message-ID: <7C807D58-6B8C-400F-AF67-CD2F38BC0AE4@tuxera.com>
References: <CAG48ez0SdSPkimsk-MW7oSQO-Y64X-LD4JXnuPsZXKuz=y1_Kg@mail.gmail.com>
 <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271291017.9458.7827028432894772673.stgit@warthog.procyon.org.uk>
 <21395.1532735340@warthog.procyon.org.uk>
In-Reply-To: <21395.1532735340@warthog.procyon.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-ID: <752FD3C5BE365846B549589674C7578E@tuxera.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Received-SPF: none
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

> On 28 Jul 2018, at 00:49, David Howells <dhowells@redhat.com> wrote:
> Jann Horn <jannh@google.com> wrote:
>>> +static int fsinfo_generic_name_encoding(struct dentry *dentry, char *buf)
>>> +{
>>> +       static const char encoding[] = "utf8";
>>> +
>>> +       if (buf)
>>> +               memcpy(buf, encoding, sizeof(encoding) - 1);
>>> +       return sizeof(encoding) - 1;
>>> +}
>> 
>> Is this meant to be "encoding to be used by userspace" or "encoding of
>> on-disk filenames"?
> 
> The latter.
> 
>> Are there any plans to create filesystems that behave differently?
> 
> isofs, fat, ntfs, cifs for example.
> 
>> If the latter: This is wrong for e.g. a vfat mount that uses a codepage,
>> right?  Should the default in that case not be "I don't know"?
> 
> Quite possibly.  Note that it could also be what you're interpreting it as
> because the codepage got overridden by a mount parameter rather than what's on
> the disk (assuming the medium actually records this).

No, nothing like that is recorded on disk.  That would have been way too helpful!  (-;  The only place Windows records such information is, you may have guessed this: in the registry which of course is local to the computer and unrelated to what removable media is attached...

> One thing I'm confused about is that fat has both a codepage and a charset and
> I'm not sure of the difference.

Oh that is quite simple.  (-:

The codepage is what is used to translate from/to the on-disk DOS 8.3 style names into the kernel's Unicode character representation.  The correct codepage for a particular volume is not stored on disk so it can lead to all sorts of fun if you for example create some names on for example a Japanese Windows on a FAT formatted USB stick and then plug that into a US or European Windows where the default code pages are completely different - all your filenames will appear totally corrupt.  (Note this ONLY affects 8.3 style/DOS/short names or whatever you want to call them.)

The charset on the other hand is what is used to convert strings coming in from/going out to userspace into the kernel's Unicode character representation.

The one nice thing about VFAT (and there aren't many nice things about it!) is that for long names (i.e. not the 8.3 style/DOS/short names), it actually stores on-disk little-endian UTF-16 (since Windows 2000, before that it used little endian UCS-2 - the change was needed to support things like Emojis and some languages that go outside the UCS-2 range of fixed 16-bit unicode).

Hope this clears that up.

Best regards,

	Anton

> David

-- 
Anton Altaparmakov <anton at tuxera.com> (replace at with @)
Lead in File System Development, Tuxera Inc., http://www.tuxera.com/
Linux NTFS maintainer

