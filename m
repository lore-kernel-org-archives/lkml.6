Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44F3C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BA820844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BA820844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbeHBAjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:39:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726688AbeHBAjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:39:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E257D4219DA9;
        Wed,  1 Aug 2018 22:50:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D35C51C640;
        Wed,  1 Aug 2018 22:50:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <83894922-c126-3648-d2f5-191256111718@schaufler-ca.com>
References: <83894922-c126-3648-d2f5-191256111718@schaufler-ca.com> <675e5c24-36ef-4cc5-846c-1414c1195d85@schaufler-ca.com> <153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk> <7561.1533157444@warthog.procyon.org.uk>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        raven@themaw.net, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: LSM hook for mount, superblock and keys watch notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19024.1533163853.1@warthog.procyon.org.uk>
Date:   Wed, 01 Aug 2018 23:50:53 +0100
Message-ID: <19025.1533163853@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 01 Aug 2018 22:50:54 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 01 Aug 2018 22:50:54 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> This looks like it will solve the problem for security modules.
> I still think there should be some sort of default controls.

The control for keyrings is that you have to have View permission on the thing
you want to set a watchpoint on.

For mount topology changes, everyone can see everything in their namespace
anyway just by repeatedly parsing /proc/mounts or similar.  Whether or not
this is a good idea...

Superblocks - some of the things generated here *shouldn't* be hidden - EIO
for example.

> The idea that the default is that anyone can listen for everyone's
> events, and there's no way to control it does not sit well.
> You could implement that as a security module with the one hook
> that does UID based controls, but I don't see a lot of advantages
> to doing it that way. At the least a process should be able to hide
> the events it would generate from everyone.

That's tricky.  Some of the events aren't actually generated directly by a
process stepping on a trigger - EIO for example.  Further, none of the
interfaces available have a "don't notify" button.  Now I can add one to
move_mount() and fsmount(), but not write() (which might cause EDQUOT or
ENOSPC errors that we might want to know about irrespective of what the user
wants).

> Better would be to have a specification (e.g. mod bits, an ACL) for who
> should receive them.

How does one attach this, and to where?  It doesn't belong to the watch queue,
it belongs to the watched object.  It would also need attaching before the
object gets published.

If you're using fsopen(), you could attach it before doing fsmount() to set an
ACL on a superblock, I suppose:

	fd = fsopen("ext4", 0);
	fsconfig(fd, FSCONFIG_SET_NAMESPACE, "user", NULL, userns_fd);
	fsconfig(fd, FSCONFIG_SET_SB_ACL, NULL, "0:pw,1000:w", 0);
	fsconfig(fd, FSCONFIG_SET_PATH, "source", "/dev/sda1", AT_FDCWD);
	fsconfig(fd, FSCONFIG_SET_FLAG, "acl", NULL, 0);
	mfd = fsmount(0, 0);

where 0 and 1000 are uids and [pw] indicate pickability and watchability, with
the former allowing the use of fspick() with it:

	fd = fspick(AT_FDCWD, "/mnt", 0);

or, even:

	fd = fspick(0, "6f9553ab-7329-4998-bd5b-a5b4add9ad79",
		    FSPICK_OPEN_BY_UUID);

I'm not sure how you'd attach an ACL to mount objects, though.  I guess
move_mount() would have to take a 6th parameter that's the ACL.  You wouldn't
necessarily be able to use the same ACL for both mount and superblock because
of namespaces - it should be possible to have a superblock that's in multiple
user namespace (though it currently isn't).

David
