Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbeFDTD7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 15:03:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751053AbeFDTD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:03:57 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAK8P3a0wecxxkjgmW3bv5v8_rJ6H5RZQ0QTvVhR2+cx7sBwxcA@mail.gmail.com>
References: <CAK8P3a0wecxxkjgmW3bv5v8_rJ6H5RZQ0QTvVhR2+cx7sBwxcA@mail.gmail.com> <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk> <152720693123.9073.4511934790831409009.stgit@warthog.procyon.org.uk> <CAK8P3a0rO=F_n0pmsxUghRrF9hC_2+2Bd6RaVwC9H-=Xo6oQWA@mail.gmail.com> <21648.1528124488@warthog.procyon.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-afs@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 32/32] [RFC] fsinfo: Add a system call to allow querying of filesystem information [ver #8]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <471.1528139035.1@warthog.procyon.org.uk>
Date: Mon, 04 Jun 2018 20:03:55 +0100
Message-ID: <472.1528139035@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:

> > I've split the capabilities out into their own thing.  I've attached the
> > revised patch below.
>
> I'm still not completely clear on how variable-length structures are
> supposed to be handled by the fsinfo syscall. It seems like a possible
> source of bugs to return a structure from the kernel that has a different
> size in kernel and user space depending on the fsinfo_cap__nr value at
> compile time. How does one e.g. guarantee there is no out of bounds access
> when you run new user space on an older kernel that has a smaller structure?

There's a buffer size parameter:

	int ret = fsinfo(int dfd,
			 const char *filename,
			 const struct fsinfo_params *params,
			 void *buffer,
			 size_t buf_size);

For a fixed-size buffer request (as opposed to a string), the fsinfo syscall
allocates an internal buffer sized for the size of the buffer that the
internal kernel code is expecting, and *not* what the user asked for:

	/* Allocate an appropriately-sized buffer.  We will truncate the
	 * contents when we write the contents back to userspace.
	 */
	size = fsinfo_buffer_sizes[params.request];
	...
	if (buf_size > 0) {
		params.buf_size = size;
		params.buffer = kzalloc(size, GFP_KERNEL);
		if (!params.buffer)
			return -ENOMEM;
	}

so that the filesystems don't have to concern themselves with anything other
than the kernel's idea of the size.

The fsinfo() syscall truncates the reply buffer to the size the user requested
if the user requested a smaller amount.  Take the fsinfo_supports struct for
example:

	struct fsinfo_supports {
		__u64	supported_stx_attributes;
		__u32	supported_stx_mask;
		__u32	supported_ioc_flags;
	};

Now imagine that in future we want to add another field, say the mask of the
windows file attributes a filesystem supports.  We can extend the struct like
so:

	struct fsinfo_supports_v2 {
		__u64	supported_stx_attributes;
		__u32	supported_stx_mask;
		__u32	supported_ioc_flags;
		__u32	supported_win_file_atts;
		__u32	__reserved[1];
	};

Note that the start of the new struct *must* correspond in layout to the
original struct.  An application that doesn't know about v2 would just ask for
v1:

	struct fsinfo_supports foo;
	fsinfo(.... &foo, sizeof(foo));

and would only ever get those bits - though it would be told that there is
more data available.  An application that does know about v2 might do:

	struct fsinfo_supports_v2 foo2;
	fsinfo(.... &foo2, sizeof(foo2));

If all of v2 was available, all fields will be filled in and the return value
will == sizeof(foo2).  If not all fields are available, the return value will
== sizeof(foo).  If a v3 was added, the return value would == sizeof(v3), and
so on.

I can improve this such that if you asked for a fixed-length option and the
kernel doesn't have enough data to fill the user buffer provided, then it
clears the remainder of the buffer.  That way at least any unsupported fields
will be initialised to 0.


For the capabilities bitmask, it's not really any different conceptually.  If
you want to test capability bit 47, you need to ask for 6 bytes of data.  If
the kernel doesn't support that many bits, it won't necessarily give you that
many bytes.  If it has, say, 13 bytes-worth of caps available, it will only
give you the first 6 bytes-worth if that's all you ask for.  You presumably
weren't interested or didn't know about any more than that.


As for strings, they're completely variable length anyway, so I don't think
there's a problem there.

> In any case, it would be nice to have a trivial way to query which of
> the four timestamp types are supported at all, and returning
> them separately would be one way of doing that.

	fsinfo_cap_has_atime	= 45,	/* fs supports access time */
	fsinfo_cap_has_btime	= 46,	/* fs supports birth/creation time */
	fsinfo_cap_has_ctime	= 47,	/* fs supports change time */
	fsinfo_cap_has_mtime	= 48,	/* fs supports modification time */

David
