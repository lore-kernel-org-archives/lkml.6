Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12A0C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB158222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfBLS5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:57:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729371AbfBLS53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:57:29 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7DE17369CA;
        Tue, 12 Feb 2019 18:57:29 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 919C3194A0;
        Tue, 12 Feb 2019 18:57:25 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 295CE220992; Tue, 12 Feb 2019 13:57:25 -0500 (EST)
Date:   Tue, 12 Feb 2019 13:57:25 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: Re: [PATCH 00/52] [RFC] virtio-fs: shared file system for virtual
 machines
Message-ID: <20190212185725.GD6273@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
 <871s4dc85b.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871s4dc85b.fsf@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 12 Feb 2019 18:57:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 09:26:48PM +0530, Aneesh Kumar K.V wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:
> 
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
> > causing some workloads and test suites to fail.
> 
> Can you elaborate on this? Is this with 9p2000.L ? We did quiet a lot of
> work to make sure posix test suite pass on 9p file system. Also 
> was the mount option with cache=loose?

Hi Aneesh,

Yes this is with 9p2000.L and cache=loose. I used following mount option.

mount -t 9p -o trans=virtio hostShared /mnt/virtio-9p/ -oversion=9p2000.L,posixacl,cache=loose

We noticed primarily two issues.

- Ran pjdfstests and a lot of them are failing. I think even kata
  container folks also experienced pjdfstests failures. I have never
  looked into details of why it is failing.

- We thought mmap(MAP_SHARED) will not work with virtio-9p when two
  clients are running in two different VMs and mapped same file with
  MAP_SHARED.

Having said that, biggest concern with virtio-9p seems to be performance.
We are looking for ways to improve performance with virtio-fs. Hoping
DAX can provide faster data access and fuse protocol itself seems to
be faster (in primilinary testing results).

Thanks
Vivek
