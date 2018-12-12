Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE2FC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F642084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F642084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbeLLVWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:22:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbeLLVWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:22:41 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B83786674;
        Wed, 12 Dec 2018 21:22:41 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42F59103BAB6;
        Wed, 12 Dec 2018 21:22:39 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id CD4A02208FC; Wed, 12 Dec 2018 16:22:38 -0500 (EST)
Date:   Wed, 12 Dec 2018 16:22:38 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: Re: [PATCH 00/52] [RFC] virtio-fs: shared file system for virtual
 machines
Message-ID: <20181212212238.GA23229@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
 <20181212203049.GH9077@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212203049.GH9077@char.us.oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 12 Dec 2018 21:22:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 03:30:49PM -0500, Konrad Rzeszutek Wilk wrote:
> On Mon, Dec 10, 2018 at 12:12:26PM -0500, Vivek Goyal wrote:
> > Hi,
> > 
> > Here are RFC patches for virtio-fs. Looking for feedback on this approach.
> > 
> > These patches should apply on top of 4.20-rc5. We have also put code for
> > various components here.
> > 
> > https://gitlab.com/virtio-fs
> > 
> > Problem Description
> > ===================
> > We want to be able to take a directory tree on the host and share it with
> > guest[s]. Our goal is to be able to do it in a fast, consistent and secure
> > manner. Our primary use case is kata containers, but it should be usable in
> > other scenarios as well.
> > 
> > Containers may rely on local file system semantics for shared volumes,
> > read-write mounts that multiple containers access simultaneously.  File
> > system changes must be visible to other containers with the same consistency
> > expected of a local file system, including mmap MAP_SHARED.
> > 
> > Existing Solutions
> > ==================
> > We looked at existing solutions and virtio-9p already provides basic shared
> > file system functionality although does not offer local file system semantics,
> > causing some workloads and test suites to fail. In addition, virtio-9p
> > performance has been an issue for Kata Containers and we believe this cannot
> > be alleviated without major changes that do not fit into the 9P protocol.
> > 
> > Design Overview
> > ===============
> > With the goal of designing something with better performance and local file
> > system semantics, a bunch of ideas were proposed.
> > 
> > - Use fuse protocol (instead of 9p) for communication between guest
> >   and host. Guest kernel will be fuse client and a fuse server will
> >   run on host to serve the requests. Benchmark results (see below) are
> >   encouraging and show this approach performs well (2x to 8x improvement
> >   depending on test being run).
> > 
> > - For data access inside guest, mmap portion of file in QEMU address
> >   space and guest accesses this memory using dax. That way guest page
> >   cache is bypassed and there is only one copy of data (on host). This
> >   will also enable mmap(MAP_SHARED) between guests.
> > 
> > - For metadata coherency, there is a shared memory region which contains
> >   version number associated with metadata and any guest changing metadata
> >   updates version number and other guests refresh metadata on next
> >   access. This is still experimental and implementation is not complete.
> 
> What about Windows guests or BSD ones? Is there a plan to make that work with them as well?

Hi Konrad,

I have not thought much about making it work on Windows or BSD yet. 
Does Fuse work with windows. I am assuming it does with BSD. As long as FUSE
works, I am assuming that atleast basic mode can be made to work.

> 
> What about the Virtio spec? Plans to make changes there as well?

There are plans to change that. Stefan posted a proposal here.

https://lists.oasis-open.org/archives/virtio-dev/201812/msg00073.html

Thanks
Vivek
