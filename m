Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeEaVUz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 17:20:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51000 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeEaVUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 17:20:49 -0400
Date: Thu, 31 May 2018 22:20:48 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 31/32] [RFC] fs: Add a move_mount() system call [ver #8]
Message-ID: <20180531212048.GJ30522@ZenIV.linux.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
 <152720692470.9073.11301353609129445901.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152720692470.9073.11301353609129445901.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 01:08:44AM +0100, David Howells wrote:
> [!] NOTE: This patch doesn't quite work to move an O_CLONE_MOUNT-produced
>     vfsmount as move_mount() checks that the source vfsmount mnt_ns matches
>     the calling process's mnt_ns - but the vfsmount's mnt_ns isn't set
>     until one attempts to actually mount it into the namespace.

*shrug*

Turn those checks into
	error = -EINVAL;
	/* mountpoint should be ours */
	if (!check_mnt(p))
		goto out1;
	/* and the thing moved should be either ours or completely unattached */
	if (old->mnt_ns && !check_mnt(old))
		goto out1;
