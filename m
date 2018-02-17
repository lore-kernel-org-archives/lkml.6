Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751127AbeBQKED (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 05:04:03 -0500
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:46279 "EHLO
        rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbeBQKEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 05:04:01 -0500
X-IronPort-AV: E=Sophos;i="5.46,524,1511827200";
   d="scan'208";a="360122971"
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>, Victor Kamensky <kamensky@cisco.com>,
        hpa@zytor.com
From: Taras Kondratiuk <takondra@cisco.com>
In-Reply-To: <A5A0727C-B932-49F6-A7D7-AA7CAECECF96@zytor.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James McMechan <james.w.mcmechan@gmail.com>, initramfs@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, xe-linux-external@cisco.com
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
 <1518813234-5874-2-git-send-email-takondra@cisco.com>
 <d69f329c-8365-bb0e-69ee-774cbea141b2@zytor.com>
 <72480de8-e6d6-5125-e647-08815eb9f6a7@landley.net>
 <alpine.LRH.2.00.1802161336350.22409@sjc-ads-6991.cisco.com>
 <A5A0727C-B932-49F6-A7D7-AA7CAECECF96@zytor.com>
Message-ID: <151886184029.6069.5504703113024901667@takondra-t460s>
User-Agent: alot/0.6
Subject: Re: [PATCH v3 01/15] Documentation: add newcx initramfs format description
Date: Sat, 17 Feb 2018 02:04:00 -0800
X-Auto-Response-Suppress: DR, OOF, AutoReply
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1HA48Ng019156

Quoting hpa@zytor.com (2018-02-16 16:00:36)
> On February 16, 2018 1:47:35 PM PST, Victor Kamensky <kamensky@cisco.com> wrote:
> >
> >
> >On Fri, 16 Feb 2018, Rob Landley wrote:
> >
> >>
> >> On 02/16/2018 02:59 PM, H. Peter Anvin wrote:
> >>> On 02/16/18 12:33, Taras Kondratiuk wrote:
> >>>> Many of the Linux security/integrity features are dependent on file
> >>>> metadata, stored as extended attributes (xattrs), for making
> >decisions.
> >>>> These features need to be initialized during initcall and enabled
> >as
> >>>> early as possible for complete security coverage.
> >>>>
> >>>> Initramfs (tmpfs) supports xattrs, but newc CPIO archive format
> >does not
> >>>> support including them into the archive.
> >>>>
> >>>> This patch describes "extended" newc format (newcx) that is based
> >on
> >>>> newc and has following changes:
> >>>> - extended attributes support
> >>>> - increased size of filesize to support files >4GB
> >>>> - increased mtime field size to have 64 bits of seconds and added a
> >>>>   field for nanoseconds
> >>>> - removed unused checksum field
> >>>>
> >>>
> >>> If you are going to implement a new, non-backwards-compatible
> >format,
> >>> you shouldn't replicate the mistakes of the current format. 
> >Specifically:
> >>
> >> So rather than make minimal changes to the existing format and
> >continue to
> >> support the existing format (sharing as much code as possible), you
> >recommend
> >> gratuitous aesthetic changes?
> >>
> >>> 1. The use of ASCII-encoded fixed-length numbers is an idiotic
> >legacy
> >>> from an era before there were any portable way of dealing with
> >numbers
> >>> with prespecified endianness.
> >>
> >> It lets encoders and decoders easily share code with the existing
> >cpio format,
> >> which we still intend to be able to read and write.
> >>
> >>> If you are going to use ASCII, make them
> >>> delimited so that they don't have fixed limits, or just use binary.
> >>
> >> When it's gzipped this accomplishes what? (Other than being
> >gratuitously
> >> different from the previous iteration?)
> >>
> >>> The cpio header isn't fixed size, so that argument goes away, in
> >fact
> >>> the only way to determine the end of the header is to scan forward.
> >>>
> >>> 2. Alignment sensitivity!  Because there is no header length
> >>> information, the above scan tells you where the header ends, but
> >there
> >>> is padding before the data, and the size of that padding is only
> >defined
> >>> by alignment.
> >>
> >> Again, these are minimal changes to the existing cpio format. You're
> >complaining
> >> about _cpio_, and that the new stuff isn't _different_ enough from
> >it.
> >>
> >>> 3. Inband encoding of EOF: if you actually have a filename
> >"TRAILER!!!"
> >>> you have problems.
> >>
> >> Been there, done that:
> >>
> >> http://lkml.iu.edu/hypermail/linux/kernel/1801.3/01791.html
> >>
> >>> But first, before you define a whole new format for which no tools
> >exist
> >>> (you will have to work with the maintainers of the GNU tools to add
> >>> support)
> >>
> >> No, he's been working with the maintainer of toybox to add support
> >(for about a
> >> year now), which gets him the Android command line. And the kernel
> >has its own
> >> built-in tool to generate cpio images anyway.
> >>
> >> Why would anyone care what the GNU project thinks?
> >
> >In our internal use of this patch series we do use gnu cpio
> >to create initramfs.cpio.
> >
> >And reference to gnu cpio patch that supports newcx format is
> >posted in description for this serieis:
> >
> >https://raw.githubusercontent.com/victorkamensky/initramfs-xattrs-poky/rocko/meta/recipes-extended/cpio/cpio-2.12/cpio-xattrs.patch
> >
> >Whether GNU cpio maintainers will accept it is different matter.
> >We will try, but we need to start somewhere and agree on
> >new format first.
> >
> >Thanks,
> >Victor
> >
> >>> you should see how complex it would be to support the POSIX
> >>> tar/pax format,
> >>
> >> That argument was had (at length) when initramfs went in over a
> >decade ago.
> >> There are links in
> >Documentation/filesystems/ramfs-rootfs-initramfs.txt to the
> >> mailing list entries about it.
> >>
> >>> which already has all the features you are seeking, and
> >>> by now is well-supported.
> >>
> >> So... tar wasn't well-supported 15 years ago? (Hasn't the kernel
> >source always
> >> been distributed via tarball back since 0.0.1?)
> >>
> >> You're suggesting having a whole second codepath that shares no code
> >with the
> >> existing cpio extractor. Are you suggesting abandoning support for
> >the existing
> >> initramfs.cpio.gz file format?
> >>
> >> Rob
> >>
> 
> Introducing new, incompatible data formats is an inherently *very* costly operation; unfortunately many engineers don't seem to have a good grip of just *how* expensive it is (see "silly embedded nonsense hacks", "too little, too soon".)
> 
> Cpio itself is a great horror show of just how bad this gets: a bunch of minor tweaks without finding underlying design bugs resulting in a ton of mutually incompatible formats.  "They are almost the same" doesn't help: they are still incompatible.
> 
> Introducing a new incompatible data format without strong justification is engineering malpractice.  Doing it under the non-justification of expedience ("oh, we can share most of the code") is aggravated engineering malpractice.
> 
> It is entirely possible that the modern posix tar/pax format is too complex to be practical in this case – that would be justifying a new format.  But then you are taking the fundamental cost of breakage, and then the new format definitely should not be replicating known defects of another format and without at least some thought about how to avoid it in the future.

I do understand a cost of adding a new format and I'd be very happy not
to do it if there is a better option. I did consider using tar/pax, but
looks like it was already discussed in 2001 between you and Al Viro [1]
and tar was rejected.

My main tar concerns:
- ustar+pax header is *huge*. E.g. directory entry in archive: pax 1536
  bytes vs cpio <200 bytes. Overall compressed initramfs size increase
  is not significant though.
- pax is not a strict format. E.g. xattrs may be stored under different
  names: SHCILY.xattr (GNU tar, star) vs LIBARCHIVE.xattr (libarchive).

I'm not sure which option is better. Adding tar to the kernel or adding
new cpio format into several tools (GNU cpio, libarchive, busybox,
toybox) will result in approximately the same amount of code.

It would be nice to get Al Viro's thoughts on this.

[1] https://web.archive.org/web/20060909041730/http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.2/1638.html
