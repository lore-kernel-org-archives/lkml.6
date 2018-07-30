Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB9513F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220F620892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220F620892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeG3MXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:23:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726562AbeG3MXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:23:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 625597DAC6;
        Mon, 30 Jul 2018 10:49:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EEB7112D17A;
        Mon, 30 Jul 2018 10:49:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <b4be11f6-8235-1ee1-9a01-c09eb9b88404@I-love.SAKURA.ne.jp>
References: <b4be11f6-8235-1ee1-9a01-c09eb9b88404@I-love.SAKURA.ne.jp> <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk> <153271277078.9458.16912166489973051987.stgit@warthog.procyon.org.uk>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        tomoyo-dev-en@lists.sourceforge.jp,
        linux-security-module@vger.kernel.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, miklos@szeredi.hu,
        kent.overstreet@gmail.com
Subject: Re: [PATCH 13/38] tomoyo: Implement security hooks for the new mount API [ver #10]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10223.1532947756.1@warthog.procyon.org.uk>
Date:   Mon, 30 Jul 2018 11:49:16 +0100
Message-ID: <10224.1532947756@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 30 Jul 2018 10:49:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 30 Jul 2018 10:49:18 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> Would you provide examples of each possible combination as a C program?
> For example, if one mount point from multiple sources with different
> options are possible, please describe such pattern using syscall so that
> LSM modules can run it to see whether they are working as expected. 

One example could be overlayfs.  So you might do, say:

	ufd = open("/overlay", O_PATH);
	fsfd = fsopen("overlay", 0);
	fsconfig(fsfd, fsconfig_set_path, "lowerdir", "/src", AT_FDCWD);
	fsconfig(fsfd, fsconfig_set_path, "upperdir", "upper", ufd);
	fsconfig(fsfd, fsconfig_set_path, "workdir", "scratch", ufd);
	mfd = fsmount(fsfd, 0, 0);
	move_mount(fsfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);

which would allow you to specify the "sources" using dirfds.

Another possibility is could be ext4 with separate journal:

	fsfd = fsopen("ext4", 0);
	fsconfig(fsfd, fsconfig_set_path, "source", "/dev/sda1", AT_FDCWD);
	fsconfig(fsfd, fsconfig_set_path, "journal_path", "/dev/sda2", AT_FDCWD);
	mfd = fsmount(fsfd, 0, 0);
	move_mount(fsfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);

And then there's bcachefs which suggests on the webpage:

	mount -t bcachefs /dev/sda1:/dev/sdb1 /mnt

but you could then do:

	fsfd = fsopen("bcachefs", 0);
	fsconfig(fsfd, fsconfig_set_path, "source", "/dev/sda1", AT_FDCWD);
	fsconfig(fsfd, fsconfig_set_path, "source", "/dev/sdb2", AT_FDCWD);
	mfd = fsmount(fsfd, 0, 0);
	move_mount(fsfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);

One thing I'm not certain of is whether I should allow multiple values to the
same key name, or whether I should require that each key be labelled
differently, possibly something like:

	fsconfig(fsfd, fsconfig_set_path, "source", "/dev/sda1", AT_FDCWD);
	fsconfig(fsfd, fsconfig_set_path, "source.1", "/dev/sdb2", AT_FDCWD);

David
