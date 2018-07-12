Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9EFC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDFA20BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDFA20BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390034AbeGLAw7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 20:52:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732668AbeGLAw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 20:52:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 40B2A81A4EA9;
        Thu, 12 Jul 2018 00:46:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E193111DCFE;
        Thu, 12 Jul 2018 00:46:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CA+55aFzEjPUGZFk7PnM0T6YEn5uRrscgyCHyhc_cYz0m8ejdLA@mail.gmail.com>
References: <CA+55aFzEjPUGZFk7PnM0T6YEn5uRrscgyCHyhc_cYz0m8ejdLA@mail.gmail.com> <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/32] VFS: Introduce filesystem context [ver #9]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29127.1531356361.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Thu, 12 Jul 2018 01:46:01 +0100
Message-ID: <29128.1531356361@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 12 Jul 2018 00:46:03 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 12 Jul 2018 00:46:03 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> All your documentation (both commit logs, man-pages and in-kernel
> actual docs you add) only talk about "what".
> 
> They don't talk about _why_.
> 
> I can imagine why's. But I think that the "why" is actually way mnore
> important than the what. At no point did I see a "this is the current
> interface, and it doesn't work for xyz, so here's the new interface
> that allows us to do stuff".

Firstly, there are a bunch of problems with the current mount(2) syscall:

 (1) It's actually six or seven different interfaces rolled into one and weird
     combinations of flags make it do different things beyond the original
     specification of the syscall.

 (2) It produces a particularly large and diverse set of errors, which have to
     be mapped back to a small error code.  Yes, there's dmesg - if you have
     it configured - but you can't necessarily see that if you're doing a
     mount inside of a container.

 (3) It copies a PAGE_SIZE block of data for each of the type, device name and
     options.

 (4) The size of the buffers is PAGE_SIZE - and this is arch dependent.

 (5) You can't mount into another mount namespace.  I could, for example,
     build a container without having to be in that container's namespace if I
     can do it from outside.

 (6) It's not really geared for the specification of multiple sources, but
     some filesystems really want that - overlayfs, for example.

and some problems in the internal kernel api:

 (1) There's no defined way to supply namespace configuration for the
     superblock - so, for instance, I can't say that I want to create a
     superblock in a particular network namespace (on automount, say).

     NFS hacks around this by creating multiple shadow file_system_types with
     different ->mount() ops.

 (2) When calling mount internally, unless you have NFS-like hacks, you have
     to generate or otherwise provide text config data which then gets parsed,
     when some of the time you could bypass the parsing stage entirely.

 (3) The amount of data in the data buffer is not known, but the data buffer
     might be on a kernel stack somewhere, leading to the possibility of
     tripping the stack underrun guard.

and other issues too:

 (1) Superblock remount in some filesystems applies options on an as-parsed
     basis, so if there's a parse failure, a partial alteration with no
     rollback is effected.

 (2) Under some circumstances, the mount data may get copied multiple times so
     that it can have multiple parsers applied to it or because it has to be
     parsed multiple times - for instance, once to get the preliminary info
     required to access the on-disk superblock and then again to update the
     superblock record in the kernel.

I want to be able to add support for a bunch of things:

 (1) UID, GID and Project ID mapping/translation.  I want to be able to
     install a translation table of some sort on the superblock to translate
     source identifiers (which may be foreign numeric UIDs/GIDs, text names,
     GUIDs) into system identifiers.  This needs to be done before the
     superblock is published[*].

     Note that this may, for example, involve using the context and the
     superblock held therein to issue an RPC to a server to look up
     translations.

     [*] By "published" I mean made available through mount so that other
     	 userspace processes can access it by path.

     Maybe specifying a translation range element with something like:

	write(fd, "t uid <srcuid> <nsuid> <count>");

     The translation information also needs to propagate over an automount in
     some circumstances.

 (2) Namespace configuration.  I want to be able to tell the superblock
     creation process what namespaces should be applied when it created (in
     particular the userns and netns) for containerisation purposes, e.g.:

	write(fd, "n user=<fd> net=<fd>");

 (3) Namespace propagation.  I want to have a properly defined mechanism for
     propagating namespace configuration over automounts within the kernel.
     This will be particularly useful for network filesystems.

 (4) Pre-mount attribute query.  A chunk of the changes is actually the
     fsinfo() syscall to query attributes of the filesystem beyond what's
     available in statx() and statfs().  This will allow a created superblock
     to be queried before it is published.

 (5) Upcall for configuration.  I would like to be able to query configuration
     that's stored in userspace when an automount is made.  For instance, to
     look up network parameters for NFS or to find a cache selector for
     fscache.

     The internal fs_context could be passed to the upcall process or the
     kernel could read a config file directly if named appropriately for the
     superblock, perhaps:

	[/etc/fscontext.d/afs/example.com/cell.cfg]
	realm = EXAMPLE.COM
	translation = uid,3000,4000,100
	fscache = tag=fred

 (6) Event notifications.  I want to be able to install a watch on a
     superblock before it is published to catch things like quota events and
     EIO.

 (7) Large and binary parameters.  There might be at some point a need to pass
     large/binary objects like Microsoft PACs around.  If I understand PACs
     correctly, you can obtain these from the Kerberos server and then pass
     them to the file server when you connect.

     Having it possible to pass large or binary objects as individual writes
     makes parsing these trivial.  OTOH, some or all of this can potentially
     be handled with the use of the keyrings interface - as the afs filesystem
     does for passing kerberos tokens around; it's just that that seems
     overkill for a parameter you may only need once.

> When you have a diffstat like this:
> 
>  171 files changed, 7147 insertions(+), 1805 deletions(-)
> 
> I sure want to see an explanation for *WHY* it adds 5000+ lines of core code.

Note that there's a chunk more core code to be removed too, once all the
filesystems have been converted, including some of the added code.

> Also, I want to hear about sane security models. One of the things
> people really want to do is have users do their own mounts. We've had
> security issues in that area. Why does this improve on it, or make it
> even worse?

At the moment, I think it's fairly neutral in that regard.  Currently, you
have to have CAP_SYS_ADMIN to call fsopen() and again to call fsmount().

To supervise user-triggered mounting, I might need to add something to permit
upcalling for permission or configuration, then this could be in the parent of
a container, say, or something dispatched from systemd in the system root.  It
should be able to restrict the sources and options that a non-privileged or
container-based mount request is given.

An upcall to an arbiter could be passed the fs-context fd as an argument and
could then use fsinfo() to query the context, including the option flags.

It also might be possible to handle this through LSM policy, particularly if I
formalise the specification of *all* sources in the context.  For example, I
could require things like:

	write(fd, "s store /dev/sda1");	// Specify the storage device
	write(fd, "s jnl /dev/sda2");	// Specify a separate journal
	write(fd, "s nfs example.com");	// Specify an NFS server
	write(fd, "s afs example.com");	// Specify an AFS cell

Then the LSMs could be asked to rule on whether the "store" and "jnl" block
devices could be used for those purposes by the caller and "nfs" or "afs"
names could be looked up in the DNS.

David
