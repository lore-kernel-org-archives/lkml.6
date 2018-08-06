Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E06CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A61921A53
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A61921A53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732658AbeHFTjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:39:19 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:35199 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbeHFTjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:39:19 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fmjJg-0008HJ-Rb; Mon, 06 Aug 2018 11:29:12 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fmjJR-0007G2-D4; Mon, 06 Aug 2018 11:29:12 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
        <153313723557.13253.9055982745313603422.stgit@warthog.procyon.org.uk>
Date:   Mon, 06 Aug 2018 12:28:47 -0500
In-Reply-To: <153313723557.13253.9055982745313603422.stgit@warthog.procyon.org.uk>
        (David Howells's message of "Wed, 01 Aug 2018 16:27:15 +0100")
Message-ID: <87in4n9zg0.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fmjJR-0007G2-D4;;;mid=<87in4n9zg0.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/xDsJmKDX5wy9WenLf/iLzUY5/vMEZyBU=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 28/33] vfs: syscall: Add fsconfig() for configuring and managing a context [ver #11]
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:
>
>  (*) FSCONFIG_CMD_CREATE: Trigger superblock creation.
>
>  (*) FSCONFIG_CMD_RECONFIGURE: Trigger superblock reconfiguration.
>

First let me thank you for adding both FSCONFIG_CMD_CREATE and
FSCONFIG_CMD_RECONFIGURE.  Unfortunately the implementation is currently
broken.  So this patch gets my:

This is broken in two specific ways.
1) FSCONFIG_CMD_RECONFIGURE always returns -EOPNOTSUPPORTED.
   So it is useless.

2) FSCONFIG_CMD_CREATE will succeed even if the superblock already
   exists and it can not use all of the superblock parameters.

   This happens because vfs_get_super will only call fill_super
   if the super block is created.  Which is reasonable on the face
   of it.  But it in practice this introduces security problems.

   a) Either through reconfiguring a shared super block you did not
      realize was shared (as we saw with devpts).

   b) Mounting a super block and not honoring it's mount options
      because something has already mounted it.  As we see today
      with proc.  Leaving userspace to think the filesystem will behave
      one way when in fact it behaves another.

I have already explained this several times, and apparently I have been
ignored.  This fundamental usability issue that leads to security
problems.

The only feedback I have had from previous time is that it is ``racy''
to fix the code.  But it is only racy in the way that O_EXCL is racy.
You might have to retry in userspace if the mount you want isn't in the
state you expect.

Until this security issue is fixed this entire patchset has my:
Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

> +/*
> + * Perform an action on a context.
> + */
> +static int vfs_fsconfig_action(struct fs_context *fc, enum fsconfig_command cmd)
> +{
> +	int ret = -EINVAL;
> +
> +	switch (cmd) {
> +	case FSCONFIG_CMD_CREATE:
> +		if (fc->phase != FS_CONTEXT_CREATE_PARAMS)
> +			return -EBUSY;
> +		fc->phase = FS_CONTEXT_CREATING;
> +		ret = vfs_get_tree(fc);
> +		if (ret == 0)
> +			fc->phase = FS_CONTEXT_AWAITING_MOUNT;
> +		else
> +			fc->phase = FS_CONTEXT_FAILED;
> +		return ret;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}

See no support for FSCONFIG_CMD_RECONFIGURE, and no checks to see if
the superblock has already been mounted.

> +	ret = mutex_lock_interruptible(&fc->uapi_mutex);
> +	if (ret == 0) {
> +		switch (cmd) {
> +		case FSCONFIG_CMD_CREATE:
> +		case FSCONFIG_CMD_RECONFIGURE:
> +			ret = vfs_fsconfig_action(fc, cmd);
> +			break;
> +		default:
> +			ret = vfs_fsconfig(fc, &param);
> +			break;
> +		}
> +		mutex_unlock(&fc->uapi_mutex);
> +	}
> +

Eric
