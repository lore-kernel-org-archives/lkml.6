Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C3FC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709CF2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709CF2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbeKETom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:44:42 -0500
Received: from ozlabs.org ([203.11.71.1]:47385 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbeKETom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:44:42 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42pTN23jfvz9sCm;
        Mon,  5 Nov 2018 21:25:38 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     snitzer@redhat.com, axboe@kernel.dk, linuxppc-dev@lists.ozlabs.org,
        satheera@in.ibm.com
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: System not booting since dm changes? (was Linux 4.20-rc1)
In-Reply-To: <CAHk-=whDiwASMgw8Q7TNA2MJhf3s=ouK4+_3ioqmobs-yagnkQ@mail.gmail.com>
References: <CAHk-=whDiwASMgw8Q7TNA2MJhf3s=ouK4+_3ioqmobs-yagnkQ@mail.gmail.com>
Date:   Mon, 05 Nov 2018 21:25:35 +1100
Message-ID: <87tvkvddnk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
...
> Mike Snitzer (1):
>     device mapper updates

Hi Mike,

Replying here because I can't find the device-mapper pull or the patch
in question on LKML. I guess I should be subscribed to dm-devel.

We have a box that doesn't boot any more, bisect points at one of:

  cef6f55a9fb4 Mike Snitzer       dm table: require that request-based DM be layered on blk-mq devices 
  953923c09fe8 Mike Snitzer       dm: rename DM_TYPE_MQ_REQUEST_BASED to DM_TYPE_REQUEST_BASED 
  6a23e05c2fe3 Jens Axboe         dm: remove legacy request-based IO path 


It's a Power8 system running Rawhide, it does have multipath, but I'm
told it was setup by the Fedora installer, ie. nothing fancy.

The symptom is the system can't find its root filesystem and drops into
the initramfs shell. The dmesg includes a bunch of errors like below:

  [   43.263460] localhost multipathd[1344]: sdb: fail to get serial
  [   43.268762] localhost multipathd[1344]: mpatha: failed in domap for addition of new path sdb
  [   43.268762] localhost multipathd[1344]: uevent trigger error
  [   43.282065] localhost kernel: device-mapper: table: table load rejected: not all devices are blk-mq request-stackable
  [   43.282096] localhost kernel: device-mapper: table: unable to determine table type
  [   43.275898] localhost multipathd[1344]: sdd: fail to get serial
  [   43.282597] localhost multipathd[1344]: mpatha: failed in domap for addition of new path sdd
  [   43.282642] localhost multipathd[1344]: uevent trigger error
  [   43.286540] localhost multipathd[1344]: sdc: fail to get serial
  [   43.296366] localhost kernel: device-mapper: table: table load rejected: not all devices are blk-mq request-stackable
  [   43.296392] localhost kernel: device-mapper: table: unable to determine table type
  [   43.292218] localhost multipathd[1344]: mpathb: failed in domap for addition of new path sdc
  [   43.292218] localhost multipathd[1344]: uevent trigger error
  [   43.306193] localhost kernel: device-mapper: table: table load rejected: not all devices are blk-mq request-stackable
  [   43.306212] localhost kernel: device-mapper: table: unable to determine table type
  [  150.523303] localhost dracut-initqueue[1325]: Warning: dracut-initqueue timeout - starting timeout scripts


There's more info here if you want it:
  https://github.com/linuxppc/linux/issues/203


Any ideas what's going wrong here?

cheers
