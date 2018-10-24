Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F067ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C5B2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C5B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeJYDxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:53:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbeJYDxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:53:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B8340C059B73;
        Wed, 24 Oct 2018 19:24:34 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E53610694C0;
        Wed, 24 Oct 2018 19:24:30 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w9OJOTxA008839;
        Wed, 24 Oct 2018 15:24:29 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w9OJOT0l008835;
        Wed, 24 Oct 2018 15:24:29 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 24 Oct 2018 15:24:29 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Paul Lawrence <paullawrence@google.com>
cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-doc@vger.kernel.org,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        dm-devel@redhat.com, Shaohua Li <shli@kernel.org>
Subject: Re: [dm-devel] [RFC] dm-bow working prototype
In-Reply-To: <296148c2-f2d9-5818-ea76-d71a0d6f5cd4@google.com>
Message-ID: <alpine.LRH.2.02.1810241514310.4080@file01.intranet.prod.int.rdu2.redhat.com>
References: <20181023212358.60292-1-paullawrence@google.com> <20181023221819.GB17552@agk-dp.fab.redhat.com> <296148c2-f2d9-5818-ea76-d71a0d6f5cd4@google.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 24 Oct 2018 19:24:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 24 Oct 2018, Paul Lawrence wrote:

> Android has had the concept of A/B updates for since Android N, which means
> that if an update is unable to boot for any reason three times, we revert to
> the older system. However, if the failure occurs after the new system has
> started modifying userdata, we will be attempting to start an older system
> with a newer userdata, which is an unsupported state. Thus to make A/B able to
> fully deliver on its promise of safe updates, we need to be able to revert
> userdata in the event of a failure.
> 
> For those cases where the file system on userdata supports
> snapshots/checkpoints, we should clearly use them. However, there are many
> Android devices using filesystems that do not support checkpoints, so we need
> a generic solution. Here we had two options. One was to use overlayfs to
> manage the changes, then on merge have a script that copies the files to the
> underlying fs. This was rejected on the grounds of compatibility concerns and
> managing the merge through reboots, though it is definitely a plausible
> strategy. The second was to work at the block layer.
> 
> At the block layer, dm-snap would have given us a ready-made solution, except
> that there is no sufficiently large spare partition on Android devices. But in
> general there is free space on userdata, just scattered over the device, and
> of course likely to get modified as soon as userdata is written to. We also
> decided that the merge phase was a high risk component of any design. Since
> the normal path is that the update succeeds, we anticipate merges happening
> 99% of the time, and we want to guarantee their success even in the event of
> unexpected failure during the merge. Thus we decided we preferred a strategy
> where the device is in the committed state at all times, and rollback requires
> work, to one where the device remains in the original state but the merge is
> complex.

What about allocating a big file, using the FIEMAP ioctl to find the 
physical locations of the file, creating a dm device with many linear 
targets to map the big file and using it as a snapshot store? I think it 
would be way easier than re-implementing the snapshot functionality in a 
new target.

You can mount the whole filesystem using the "origin" target and you can 
attach a "snapshot" target that uses the mapped big file as its snapshot 
store - all writes will be placed directly to the device and the old data 
will be copied to the snapshot store in the big file.

If you decide that rollback is no longer needed, you just unload the 
snapshot target and delete the big file. If you decide that you want to 
rollback, you can use the snapshot merge functionality (or you can write a 
userspace utility that does offline merge).

Mikulas
