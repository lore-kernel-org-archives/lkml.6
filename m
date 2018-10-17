Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16FBECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CCB2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CCB2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeJQXei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:34:38 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:35502 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeJQXeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:34:37 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gCntt-0000bf-2d; Wed, 17 Oct 2018 09:38:21 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gCnts-00030R-HY; Wed, 17 Oct 2018 09:38:20 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     David Howells <dhowells@redhat.com>
Cc:     Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        Al Viro <viro@ZenIV.linux.org.uk>, linux-api@vger.kernel.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
References: <87woqgiqta.fsf@xmission.com>
        <19866.1539782101@warthog.procyon.org.uk>
        <68a2107f-bf70-055b-86cf-1ba2ba9422bf@gmail.com>
        <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
        <153754766004.17872.9829232103614083565.stgit@warthog.procyon.org.uk>
        <9b8bf436-65de-13b9-0002-0479d11c18ca@gmail.com>
        <20181013061141.GR32577@ZenIV.linux.org.uk>
        <28710.1539782412@warthog.procyon.org.uk>
        <f6f2553e-f64d-9c26-4290-baf43e5f533b@gmail.com>
        <13800.1539789863@warthog.procyon.org.uk>
Date:   Wed, 17 Oct 2018 10:38:04 -0500
In-Reply-To: <13800.1539789863@warthog.procyon.org.uk> (David Howells's
        message of "Wed, 17 Oct 2018 16:24:23 +0100")
Message-ID: <87murcinxf.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gCnts-00030R-HY;;;mid=<87murcinxf.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+BsNEAfi8xRgbj6O2Fenp4z0bOenntuZA=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 31/34] vfs: syscall: Add fspick() to select a superblock for reconfiguration [ver #12]
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>> Davids check will work for bind mounts as well.  It just won't work it
>> just won't work for files or subdirectories of some mountpoint.
>
> Bind mounts have to be done with open_tree() and move_mount().  You can't now
> do fsmount() on something fspick()'d.

But a bind mount will have mnt_root set to the the dentry that was
bound.

Therefore fspick as you are proposing modifying will work for the root
of bind mounts, as well as the root of regular mounts.  My apologies for
not being clear.

Eric

