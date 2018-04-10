Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeDJGfi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 02:35:38 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:35580 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbeDJGfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 02:35:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 118CE336167
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Apr 2018 08:35:25 +0200
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Kees Cook <keescook@chromium.org>
Cc: David Windsor <dave@nullcore.net>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, keescook@google.com
Subject: Re: usercopy whitelist woe in scsi_sense_cache
In-Reply-To: <CAGXu5jKRrdYjuyLSvc4k4mqttkM7zw-96poQ1GYqRRgPqZFOYQ@mail.gmail.com>
References: <10360653.ov98egbaqx@natalenko.name>
 <CAGXu5jL8oLV2xvjBVYv_SNXr74LdgpXEmU7K+cLYpD7jh2chgw@mail.gmail.com>
 <CAGXu5j+mVc6O_=GOF3YQmS4QZxeFgVPQtMxNH8sjBAhpJLjm9w@mail.gmail.com>
 <2679696.GDoj5zcZOu@natalenko.name>
 <CAGXu5jLG9ia+zBNcPt+q+BpJayoUuYwXitOgeHmh=7sPp-s87A@mail.gmail.com>
 <51a7e805058ef7f35b226cbbf0ccc4ff@natalenko.name>
 <CAGXu5jKRrdYjuyLSvc4k4mqttkM7zw-96poQ1GYqRRgPqZFOYQ@mail.gmail.com>
Message-ID: <3d7b5a707e216e19eb3defe0586bfbc8@natalenko.name>
User-Agent: Roundcube Webmail/1.3.5
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1523342126;
        h=from:sender:reply-to:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:resent-to:resent-cc:resent-from:resent-sender:resent-message-id:in-reply-to:references:list-id:list-owner:list-unsubscribe:list-subscribe:list-post;
        bh=RkJjMDwYHIdCt6X1X7NLIRrL/T9GOFVLFdqq1ZYYwUs=;
        b=JIg6Hw08IP/mikcAUZrDrNv1nQesWqPmWjLqgEQi4Q8RXW++rJjSal2Y4k0KSCnNaK2TqP
        6Y5VmWkknRNOqgY/tEscgQJWLSC1caCWYnRHYr1fvGfEKDAleUzD2GLxrQhPyqzXLfdjeh
        SJ7uTXKi0/M4V1fuHnkG4SYtFDfYKbQ=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1523342126; a=rsa-sha256;
        cv=none;
        b=kP7eTXhLwpoR6LbW2oi/qVIpQh8pJX9NDrERqynKM7CSd3QWlO5J5CkV5IZGlahl4PaFNtPb8oMknDnvt/6uKWyCQttEEjYRVZ/qdzmVSm7v5i6RRQgPmWT8SZONkFX9378U24qa3GkDrA4eSmlvIPnqowFmsFmBzSa4XnriNJQ=
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name
        smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

09.04.2018 22:30, Kees Cook wrote:
>> echo 1 | tee /sys/block/sd*/queue/nr_requests
> 
> I can't get this below "4".

Oops, yeah. It cannot be less than BLKDEV_MIN_RQ (which is 4), so it is 
enforced explicitly in queue_requests_store(). It is the same for me.

>> echo 1 | tee /sys/block/sd*/device/queue_depth
> 
> I've got this now too.
> Ah! dm-crypt too. I'll see if I can get that added easily to my tests.
> And XFS! You love your corner cases. ;)

Yeah, so far this wonderful configuration has allowed me to uncover a 
bunch of bugs, and see, we are not done yet ;).

> Two other questions, since you can reproduce this easily:
> - does it reproduce _without_ hardened usercopy? (I would assume yes,
> but you'd just not get any warning until the hangs started.) If it
> does reproduce without hardened usercopy, then a new bisect run could
> narrow the search even more.

Looks like it cannot be disabled via kernel cmdline, so I have to 
re-compile the kernel, right? I can certainly do that anyway.

> - does it reproduce with Linus's current tree?

Will try this too.

> What would imply missing locking, yes? Yikes. But I'd expect
> use-after-free or something, or bad data, not having the pointer slip
> forward?

I still think this has something to do with blk-mq re-queuing capability 
and how BFQ implements it, because there are no sings of issue popping 
up with Kyber so far.

> Quick update: I added dm-crypt (with XFS on top) and it hung my system
> almost immediately. I got no warnings at all, though.

Did your system hang on smartctl hammering too? Have you got some stack 
traces to compare with mine ones?

Regards,
   Oleksandr
