Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45011C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A5D208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A5D208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbeGaLvc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:51:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727409AbeGaLvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:51:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD7E97C6A9;
        Tue, 31 Jul 2018 10:11:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64048111AF3D;
        Tue, 31 Jul 2018 10:11:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180731094021.GC9836@amd>
References: <20180731094021.GC9836@amd> <25489.1532953411@warthog.procyon.org.uk> <20180730143104.GB24051@amd> <20180730180842.GA5544@bombadil.infradead.org> <CA+55aFwY1nQ0LG8CeC8chugWO40kOGKpovBOadpGOOMBinNhbg@mail.gmail.com> <20180730183847.GB5544@bombadil.infradead.org> <CA+55aFzpisX0+T_ipwUdOCXY+tkhe2Ao3KDZxx+UPpguVmirnQ@mail.gmail.com> <20180730194938.GA12962@bombadil.infradead.org> <20180730210209.GY21725@thunk.org> <20180730235849.GA19692@bombadil.infradead.org> <20180731005802.GB21725@thunk.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     dhowells@redhat.com, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 36/38] vfs: Add a sample program for the new mount API [ver #10]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18973.1533031913.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 31 Jul 2018 11:11:53 +0100
Message-ID: <18974.1533031913@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 31 Jul 2018 10:11:55 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 31 Jul 2018 10:11:55 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:

> Proposal is "message %s foo %s\0param 1\0param2\0", only strings
> allowed.

I think that's too strict and you will need to allow integer values, IP
addresses and possibly other things also.  It could certainly have a limited
set (e.g. no kernel pointers).

You also haven't proposed what you think the internal interface should look
like.

> That's simple enough, yet allows translations.

Yes and no.  From the point of view of translating it, yes, it's easier, but
from the point of view of actually writing these things in the kernel, it's
not.

So, currently, I have, say:

	cg_invalf(fc, "option or name mismatch, new: 0x%x \"%s\", old: 0x%x \"%s\"", ...);

Now I can split that to separate out the option change error from the option
change error:

	cg_invalf(fc, "Name mismatch, new: \"%s\", old: \"%s\"", ...);
	cg_invalf(fc, "Option mismatch, new: 0x%x, old: 0x%x", ...);

but we still need to communicate to the logging function how many arguments
we're actually passing.  Now, I wouldn't consider this a fast-path, so
actually counting the arguments encoded in the format string is probably fine
- otherwise we have to actually pass the number of arguments in, e.g.:

	cg_invalf(fc, "Option mismatch, new: 0x%x, old: 0x%x", 2, ...);

and then the kernel has to render the whole lot into 

Another example, in ext4 we have:

	printk(KERN_NOTICE "EXT4-fs (%s): last error at time %u: %.*s:%d",

so we could do something like:

	infof(fc, "EXT4-fs (%s): last error at time %u: %.*s:%d", ...);

on mount.  But the use of "%.*s" is a pain for your interface.  We can't pass
qualifiers like "*" to userspace, so either the caller would have to copy the
string first or the logging routines would have to edit the format string.
Though I suppose we could leave the editing to userspace.

David
