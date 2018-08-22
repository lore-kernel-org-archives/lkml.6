Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD46C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402A72148E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402A72148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbeHVNj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:39:57 -0400
Received: from 15.mo6.mail-out.ovh.net ([188.165.39.161]:54546 "EHLO
        15.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbeHVNj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:39:57 -0400
Received: from player771.ha.ovh.net (unknown [10.109.160.12])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id A1E78175E32
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 12:15:40 +0200 (CEST)
Received: from bahia.lan (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player771.ha.ovh.net (Postfix) with ESMTPSA id 10CA88400AA;
        Wed, 22 Aug 2018 12:15:24 +0200 (CEST)
Date:   Wed, 22 Aug 2018 12:15:23 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Ming Lei <tom.leiming@gmail.com>, Ming Lei <ming.lei@redhat.com>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        qemu-discuss@nongnu.org, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: Slow boot in QEMU with virtio-scsi disks
Message-ID: <20180822121523.4494871d@bahia.lan>
In-Reply-To: <98344e68266e447826f133ad14d0c83d@natalenko.name>
References: <f40092b20856d07bd7f870abf5ea939e@natalenko.name>
        <CACVXFVO1pN=CZvNY8Q4wBrAoA=3w8Ew38aGqpOSHJ1uYAM-sxw@mail.gmail.com>
        <98344e68266e447826f133ad14d0c83d@natalenko.name>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4020588570882513327
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtjedrfedugddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2018 19:39:56 +0200
Oleksandr Natalenko <oleksandr@natalenko.name> wrote:

> Hi.
> 
> On 11.08.2018 14:23, Ming Lei wrote:
> > Please test for-4.19/block:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-4.19/block
> > 
> > This slow boot issue should have been fixed by the following commits:
> > 
> > 1311326cf475 blk-mq: avoid to synchronize rcu inside 
> > blk_cleanup_queue()
> > 97889f9ac24f blk-mq: remove synchronize_rcu() from 
> > blk_mq_del_queue_tag_set()
> > 5815839b3ca1 blk-mq: introduce new lock for protecting 
> > hctx->dispatch_wait
> > 2278d69f030f blk-mq: don't pass **hctx to blk_mq_mark_tag_wait()
> > 8ab6bb9ee8d0 blk-mq: cleanup blk_mq_get_driver_tag()  
> 
> Indeed, I can confirm that these commits fix the issue.
> 
> Thanks a lot.
> 

So do I.

Thanks Ming Lei for the fix !

Cheers,

--
Greg
