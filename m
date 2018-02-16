Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbeBPWD4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 17:03:56 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45419 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeBPWDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 17:03:51 -0500
Subject: Re: [PATCH v3 01/15] Documentation: add newcx initramfs format
 description
To: Taras Kondratiuk <takondra@cisco.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Rob Landley <rob@landley.net>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, xe-linux-external@cisco.com
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
 <1518813234-5874-2-git-send-email-takondra@cisco.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <d69f329c-8365-bb0e-69ee-774cbea141b2@zytor.com>
Date: Fri, 16 Feb 2018 12:59:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1518813234-5874-2-git-send-email-takondra@cisco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/16/18 12:33, Taras Kondratiuk wrote:
> Many of the Linux security/integrity features are dependent on file
> metadata, stored as extended attributes (xattrs), for making decisions.
> These features need to be initialized during initcall and enabled as
> early as possible for complete security coverage.
> 
> Initramfs (tmpfs) supports xattrs, but newc CPIO archive format does not
> support including them into the archive.
> 
> This patch describes "extended" newc format (newcx) that is based on
> newc and has following changes:
> - extended attributes support
> - increased size of filesize to support files >4GB
> - increased mtime field size to have 64 bits of seconds and added a
>   field for nanoseconds
> - removed unused checksum field
> 

If you are going to implement a new, non-backwards-compatible format,
you shouldn't replicate the mistakes of the current format.  Specifically:

1. The use of ASCII-encoded fixed-length numbers is an idiotic legacy
from an era before there were any portable way of dealing with numbers
with prespecified endianness.  If you are going to use ASCII, make them
delimited so that they don't have fixed limits, or just use binary.

The cpio header isn't fixed size, so that argument goes away, in fact
the only way to determine the end of the header is to scan forward.

2. Alignment sensitivity!  Because there is no header length
information, the above scan tells you where the header ends, but there
is padding before the data, and the size of that padding is only defined
by alignment.

3. Inband encoding of EOF: if you actually have a filename "TRAILER!!!"
you have problems.

But first, before you define a whole new format for which no tools exist
(you will have to work with the maintainers of the GNU tools to add
support) you should see how complex it would be to support the POSIX
tar/pax format, which already has all the features you are seeking, and
by now is well-supported.

	-hpa
