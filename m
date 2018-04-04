Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeDDVfA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 17:35:00 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:16226 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752051AbeDDVe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 17:34:58 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name E601C3329F0
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Wed, 04 Apr 2018 23:34:56 +0200
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Kees Cook <keescook@chromium.org>
Cc: David Windsor <dave@nullcore.net>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        keescook@google.com
Subject: Re: usercopy whitelist woe in scsi_sense_cache
In-Reply-To: <CAGXu5jL++CEmLzFtGMVMhGWBzHpsRNJPTsEoc7Pw1dP--=azCA@mail.gmail.com>
References: <10360653.ov98egbaqx@natalenko.name>
 <CAGXu5jLwyot++C2EXs+032Lz5WdG65GsEJ-Q55rfhSbkG1Nh+A@mail.gmail.com>
 <3265889.eu5sbW8aRz@natalenko.name>
 <CAGXu5jL++CEmLzFtGMVMhGWBzHpsRNJPTsEoc7Pw1dP--=azCA@mail.gmail.com>
Message-ID: <6a6ba6c98cad6adf5dbd1cc4eaba47fa@natalenko.name>
User-Agent: Roundcube Webmail/1.3.5
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1522877697;
        h=from:sender:reply-to:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:resent-to:resent-cc:resent-from:resent-sender:resent-message-id:in-reply-to:references:list-id:list-owner:list-unsubscribe:list-subscribe:list-post;
        bh=DMBf+qZF/zEemA2ozQRzcn34D0YWcM2yRsIvKSJhBBM=;
        b=IeIS154Cf9M5vc1RTtxBWACigNlBAdByEYlkdOjzh+yYvuVWJZMUkwahzjsl6VlAEZxOl7
        +pTQFHzbXn/dJRBAplLtfn9crJknvzLwYBzFdDFnn4nlycz//llrqMEoRdjDx4lwfvpjQa
        FsrohKx4JFgf/FlK7ooFcrJwT2+fyfc=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1522877697; a=rsa-sha256;
        cv=none;
        b=U+BR+RnvOgFMssH1p3qYKph4h0EI84V/Bs0PSc+ZeMRzSvMhEm2ZGinM4fZzNV1wdr9G/BXBQY5K+kjWuZB2qZxKKDBOlh6t2JvZfSkF4qDoVuOapwA+05vrgStLGmnFlBfH+/JahDfjnpCN3YeZA2VVdDBO1ZwXdgztt2GWqxI=
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name
        smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

04.04.2018 23:25, Kees Cook wrote:
>> Actually, I can trigger a BUG too:
>> 
>> [  129.259213] usercopy: Kernel memory exposure attempt detected from 
>> SLUB
>> object 'scsi_sense_cache' (offset 119, size 22)!
> 
> Wow, yeah, that's totally outside the slub object_size. How did you
> trigger this? Just luck or something specific?

Just luck, I suppose. It usually comes after the first warning if you 
wait long enough (maybe, a couple of extra minutes).

To give you an idea regarding variety of offsets, I've summarised kernel 
log from the server:

$ sudo journalctl -kb | grep "Kernel memory exposure attempt detected" | 
grep -oE 'offset [0-9]+, size [0-9]+' | sort | uniq -c
       9 offset 107, size 22
       6 offset 108, size 22
       8 offset 109, size 22
       7 offset 110, size 22
       5 offset 111, size 22
       5 offset 112, size 22
       2 offset 113, size 22
       2 offset 114, size 22
       1 offset 115, size 22
       1 offset 116, size 22
       1 offset 119, size 22
       1 offset 85, size 22

> I'd really like to understand how the buffer position can be
> changing... I'd expect that to break all kinds of things (i.e.
> free()ing the slab later would break too...)

I haven't checked the code yet, but the first thing that comes to my 
mind is some uninitialised variable. Just guessing here, though.

> Thanks for the report! I hope someone more familiar with sg_io() can
> help explain the changing buffer offset... :P

Hopefully, SCSI people are Cc'ed here properly…

Thanks!

Regards,
   Oleksandr
