Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA8AC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D37C208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D37C208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbeLLVZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:25:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbeLLVZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:25:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 68C3230BFA3D;
        Wed, 12 Dec 2018 21:25:56 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BEA6D608D9;
        Wed, 12 Dec 2018 21:25:53 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 5A34B2208FC; Wed, 12 Dec 2018 16:25:53 -0500 (EST)
Date:   Wed, 12 Dec 2018 16:25:53 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Piotr Jurkiewicz <piotr.jerzy.jurkiewicz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kvm@vger.kernel.org, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: Re: [PATCH 00/52] [RFC] virtio-fs: shared file system for virtual
 machines
Message-ID: <20181212212553.GB23229@redhat.com>
References: <dc2e6e0f-ab00-a114-0fc1-e787293a73cf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc2e6e0f-ab00-a114-0fc1-e787293a73cf@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 12 Dec 2018 21:25:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 06:07:40PM +0100, Piotr Jurkiewicz wrote:
> Currently, virtio-9p cannot be used with overlayfs in order to obtain
> Docker-like experience (but with separate kernel) because of file attributes
> problems. I wrote an email about that to qemu-devel almost year ago, but it
> received no attention (I attach its contents below.).
> 
> Will virtio-fs avoid these problems? I assume it will be transparent from
> the point of view of file attributes, and not enforce any kind of security
> filtering?

Hi Piotr,

So you want to use virtio-fs as upper/ layer of a overlay filesystem
inside guest? Interesting. I have not tried that.

As of now I think we are not doing any filtering of file attributes
and it might just work. Give it a try. Having said that, I suspect
that security model of virtio-fs most likely will evolve.

Thanks
Vivek
> 
> Piotr Jurkiewicz
> 
> ----
> 
> 1. Upper filesystem must support the creation of trusted.* extended
> attributes.
> 
> 9pfs has support for getting/setting xattrs, but calls operating on
> attributes other than user.* and system.posix_acl_* are dropped.
> 
> 2. Upper filesystem must provide valid d_type in readdir responses.
> 
> This works, but only in case of 'passtrough' and 'none' security models. In
> the case of 'mapped-xattr' and 'mapped-file' models, d_type is being zeroed
> to DT_UNKNOWN during readdir() call.
> 
> All these limitations can be resolved pretty easily, but requires some
> design decisions. I can prepare appropriate patches.
> 
> Ad. 1.
> 
> Why are operations on attributes other than than user.* and
> system.posix_acl_* forbidden? Is this due to security reasons?
> 
> If so, can we map all of them to user.virtfs namespace, similarly as
> system.posix_acl_* are being mapped to user.virtfs.system.posix_acl_* in
> 'mapping' mode already? This way any trusted/security/system attributes will
> be effective only when mounted via virtfs inside VM.
> 
> Ad. 2.
> 
> local_readdir() can fill entry->d_type with the right DT_* value by
> obtaining file type from mapping and translating it with IFTODT() macro.
> This would, however, require reading 'user.virtfs.mode' for each direntry
> during readdir() call, what can affect performance. If so, this behavior
> would probably need to be controlled with some runtime option.
> 
> 'mapped-xattr' and 'mapped-file' models are essential for running qemu with
> overlayfs as non-root, because overlayfs creates device nodes, what is
> possible for unprivileged user only with these models.
