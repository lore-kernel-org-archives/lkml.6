Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6759C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD0D2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD0D2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732233AbeGaOT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:19:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732084AbeGaOT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:19:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0BFE240241C0;
        Tue, 31 Jul 2018 12:39:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 474EE7C5E;
        Tue, 31 Jul 2018 12:39:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180731041642.GH30522@ZenIV.linux.org.uk>
References: <20180731041642.GH30522@ZenIV.linux.org.uk> <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk> <153271291017.9458.7827028432894772673.stgit@warthog.procyon.org.uk>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     dhowells@redhat.com, linux-api@vger.kernel.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 34/38] vfs: syscall: Add fsinfo() to query filesystem information [ver #10]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1599.1533040756.1@warthog.procyon.org.uk>
Date:   Tue, 31 Jul 2018 13:39:16 +0100
Message-ID: <1600.1533040756@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 31 Jul 2018 12:39:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 31 Jul 2018 12:39:18 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ZenIV.linux.org.uk> wrote:

> Umm...  What's so special about cell/volume/domain/realm?

Nothing particularly.  But they're something various network filesystems might
find useful.  cell for AFS, domain for CIFS, realm for things that use
kerberos.

volume_id/uuid/name would be usable by ext4 too, for example.

> And what do we do when a random filesystem gets added - should its
> parameters go into catch-all pile (attr_parameter),

FSINFO_ATTR_PARAMETER is a way to enumerate the configuration parameters
passed to mount, as an alternative to parsing /proc/mounts.  So, for example,
afs has:

	enum afs_param {
		Opt_autocell,
		Opt_dyn,
		Opt_source,
		nr__afs_params
	};

	static const struct fs_parameter_spec afs_param_specs[nr__afs_params] = {
		[Opt_autocell]	= { fs_param_takes_no_value },
		[Opt_dyn]	= { fs_param_takes_no_value },
		[Opt_source]	= { fs_param_is_string },
	};

	static const struct constant_table afs_param_keys[] = {
		{ "autocell",	Opt_autocell },
		{ "dyn",	Opt_dyn },
		{ "source",	Opt_source },
	};

My thought is that calling fsinfo(..., "/some/afs/file", &params, ...) with:

	struct fsinfo_params params = {
		.request = FSINFO_ATTR_PARAMETER,
		.Nth	 = <parameter-number>,
	};

would get you back, for example:

	Nth	Result
	=======	==========================================
	0	"autocell" (or "" if not set)
	1	"dyn" (or "" if not set)
	2	"source=%#grand.central.org:root.cell."
	3+	-ENODATA (ie. there are no more)

where Nth corresponds to the parameter specified by
FSINFO_ATTR_PARAM_DESCRIPTION and Nth.

Now for some filesystems, cgroups-v1 for example, there are parameters beyond
the list (the subsystem name) and these can be listed after the predefined
parameters, eg.:

	Nth	Result
	=======	==========================================
	0	"all" or ""
	1	"clone_children" or ""
	2	"cpuset_v2_mode" or ""
	3	"name" or ""
	4	"none" or ""
	5	"noprefix" or ""
	6	"release_agent" or ""
	7	"xattr" or ""
	8	"<subsys0>" or ""
	9	"<subsys1>" or ""
	10	"<subsys2>" or ""
	...	-ENODATA

> or should they get classes of their own?

Yes.

> For Cthulhu sake, who's going to maintain that enum in face of
> random out-of-tree filesystems, each wanting a class or two its own?

They don't get their own numbers unless they're in-tree.  Full stop.  We have
the same issue with system calls and not-yet-upstream new syscalls.

Note that, as I have the code now, the "type" of return value for each
attribute must also be declared to the fsinfo() core, and the fsinfo core does
the copy to/from userspace.

> We'd tried that with device numbers; ask hpa how well has that
> worked and how much did he love the whole experience...

What would you do instead?  I would prefer to avoid using text strings as keys
because then I need a big lookup table, and possibly this gets devolved to
each filesystem to handle - which ends up even more of a mess because then
there's nothing to hold consistency.

David
