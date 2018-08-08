Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC7DC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E0021479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E0021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbeHHKz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:55:26 -0400
Received: from nautica.notk.org ([91.121.71.147]:53441 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbeHHKz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:55:26 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id BE51AC009; Wed,  8 Aug 2018 10:36:45 +0200 (CEST)
Date:   Wed, 8 Aug 2018 10:36:30 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     piaojun <piaojun@huawei.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Greg Kurz <groug@kaod.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH] net/9p/trans_virtio.c: decrease the refcount of 9p
 virtio device when removing it
Message-ID: <20180808083630.GB16121@nautica>
References: <5B6AA65E.3030907@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B6AA65E.3030907@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

piaojun wrote on Wed, Aug 08, 2018:
> I found that 9pnet_virtio.ko could not be removed by rmmod command, and I
> could still found it by lsmod. The reason is that we forgot decrease the
> refcount of 9p virtio device by kobject_put. So we should put refcount in
> p9_virtio_remove.


Hmm, I cannot seem to reproduce this. Can you give more details on how
to get into stuck state?
I tried mounting something, accessing the sysfs files, etc to no avail.

lsmod gives a counter to how many references there are to the module,
you can use that to debug a bit.
For example here I get this line just after loading the module:
  9pnet_virtio           32768  0

Then after mounting something there is one reference:
  9pnet_virtio           32768  1

Then unmounting puts that back to 0 and 'modprobe -r' (or rmmod) works.




I dislike saying the next part but I think form also is important,
please bear with me:

 - shorter subject line, please. For example, you can lose 20 characters
by reodering words so there is no need for pronouns
"net/9p/virtio: decrease 9p virtio device refcount on removal"

 - I personally dislike commit messages that are "novelized" (that is,
put yourself as an actor and describe what you were doing)
That seems to be somewhat accepted as looking at the kernel's git log I
see some (few) commits using "I ..." that are not pull request messages
but if possible please avoid this style and try to describe facts, how
things are wrong, what got fixed and if required how.
To give an example again, this says the same thing:
"The 9pnet_virtio module could not be unloaded because we forgot to
decrease the refcount of the 9p virtio device with kobject_put.

Put the reference in 9p_virtio_remove"


Thanks,
-- 
Dominique
