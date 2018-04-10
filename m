Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754063AbeDJNrq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:47:46 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:55952 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752925AbeDJNrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:47:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 1E16D336424
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Tue, 10 Apr 2018 15:47:41 +0200
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
In-Reply-To: <3d7b5a707e216e19eb3defe0586bfbc8@natalenko.name>
References: <10360653.ov98egbaqx@natalenko.name>
 <CAGXu5jL8oLV2xvjBVYv_SNXr74LdgpXEmU7K+cLYpD7jh2chgw@mail.gmail.com>
 <CAGXu5j+mVc6O_=GOF3YQmS4QZxeFgVPQtMxNH8sjBAhpJLjm9w@mail.gmail.com>
 <2679696.GDoj5zcZOu@natalenko.name>
 <CAGXu5jLG9ia+zBNcPt+q+BpJayoUuYwXitOgeHmh=7sPp-s87A@mail.gmail.com>
 <51a7e805058ef7f35b226cbbf0ccc4ff@natalenko.name>
 <CAGXu5jKRrdYjuyLSvc4k4mqttkM7zw-96poQ1GYqRRgPqZFOYQ@mail.gmail.com>
 <3d7b5a707e216e19eb3defe0586bfbc8@natalenko.name>
Message-ID: <d31189fc94392eb733c1e310ac1ec498@natalenko.name>
User-Agent: Roundcube Webmail/1.3.5
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1523368061;
        h=from:sender:reply-to:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:resent-to:resent-cc:resent-from:resent-sender:resent-message-id:in-reply-to:references:list-id:list-owner:list-unsubscribe:list-subscribe:list-post;
        bh=73NV0GmZi5lL/C+hsbc0GKlTvL4+hvWs5RMAMJ6xSG4=;
        b=yCtnSm1Yiv8jmXC2K3aVZjxxtN+5/tyb+mpdhMWrgltVxqX+TGdXkSDowDIH7E8QzFtHqh
        IUBwE+7Q0fMQE3e051tpDdx+aJbVzcFi918tCHIYp/Ft4lzJcg+ntqJU18fSH2mB+7Gyw7
        o4U1Y6ROxZneYV8ExI+0+W6v37at0lk=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1523368061; a=rsa-sha256;
        cv=none;
        b=wocxcmgBQOJqMGHgcedyUTsBcJjkvwYl9McMZtPgRW9Eg6LiVgI9l1sKlLsvOOWqP4p4toKl2S0E3It4rgQEm+FvskgW8ZVTwmsn/PJbMSuaSdCu25dBNzD8HSeQbjHljgkFtClqNasGZ8Dq/KFcGsNp+vWlYdcspcSZDhSC/e0=
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name
        smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

10.04.2018 08:35, Oleksandr Natalenko wrote:
>> - does it reproduce _without_ hardened usercopy? (I would assume yes,
>> but you'd just not get any warning until the hangs started.) If it
>> does reproduce without hardened usercopy, then a new bisect run could
>> narrow the search even more.
> 
> Looks like it cannot be disabled via kernel cmdline, so I have to
> re-compile the kernel, right? I can certainly do that anyway.

Okay, I've recompiled the kernel without hardened usercopy:

[root@archlinux ~]# zgrep USERCOPY /proc/config.gz
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set

and I cannot reproduce the issue anymore. I/O doesn't hang regardless of 
how long I hammer it.

Eeeh? Maybe, this is a matter of some cleanup code path once the 
warn/bug condition is hit with hardening enabled? I'm just guessing here 
again.

Will work towards checking Linus' master branch now…

Regards,
   Oleksandr
