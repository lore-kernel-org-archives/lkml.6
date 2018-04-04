Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeDDUte (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 16:49:34 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:14274 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbeDDUtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 16:49:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name D08BD3329AE
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Wed, 04 Apr 2018 22:49:30 +0200
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Kees Cook <keescook@chromium.org>
Cc: David Windsor <dave@nullcore.net>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: usercopy whitelist woe in scsi_sense_cache
In-Reply-To: <CAGXu5jLwyot++C2EXs+032Lz5WdG65GsEJ-Q55rfhSbkG1Nh+A@mail.gmail.com>
References: <10360653.ov98egbaqx@natalenko.name>
 <CAGXu5jLwyot++C2EXs+032Lz5WdG65GsEJ-Q55rfhSbkG1Nh+A@mail.gmail.com>
Message-ID: <3265889.eu5sbW8aRz@natalenko.name>
User-Agent: Roundcube Webmail/1.3.5
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1522874971;
        h=from:sender:reply-to:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:resent-to:resent-cc:resent-from:resent-sender:resent-message-id:in-reply-to:references:list-id:list-owner:list-unsubscribe:list-subscribe:list-post;
        bh=+1FYR7/Cwoue5Ud+Sw/QtnzY6mSsv6qKvr587Jvz4qI=;
        b=JqpF3KTa2WLLElR1NsUcRyyNBWr6o0mtItpNVU8Age+l920imJV5lOjNzkcb/QMAGvw6ta
        +s1hlWeb5Qb36vyfZlLtalPup9CMKiFRl03VSZJa25Hw9Yav3UTTp+eD6uWonHA1TcTuGI
        1IfCBW/FYL//+L+poNv0c8eyJ73DpTs=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1522874971; a=rsa-sha256;
        cv=none;
        b=wFCbBgqmwDolBNDqYCWGnuaz2En+OH4SymOdwAQ+2CuyqSSQbnMHjrbNnPfgp0gslDKzXphFhXsu5Uh5ZeCAgp6fnWcHkqHGmHd0BB4NMugC7UoscJ4qKjVdXOnvpnHQfl7LAQZBVBrvOzaX94w81PztqmSeJZbFCBXndf874jQ=
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name
        smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On středa 4. dubna 2018 22:21:53 CEST Kees Cook wrote:
> ...
> That means scsi_sense_cache should be 96 bytes in size? But a 22 byte
> read starting at offset 94 happened? That seems like a 20 byte read
> beyond the end of the SLUB object? Though if it were reading past the
> actual end of the object, I'd expect the hardened usercopy BUG (rather
> than the WARN) to kick in. Ah, it looks like
> /sys/kernel/slab/scsi_sense_cache/slab_size shows this to be 128 bytes
> of actual allocation, so the 20 bytes doesn't strictly overlap another
> object (hence no BUG):
> ...

Actually, I can trigger a BUG too:

[  129.259213] usercopy: Kernel memory exposure attempt detected from 
SLUB
object 'scsi_sense_cache' (offset 119, size 22)!
[  129.265167] ------------[ cut here ]------------
[  129.267579] kernel BUG at mm/usercopy.c:100!

And also offset can be different, as you may see:

[   55.993224] Bad or missing usercopy whitelist? Kernel memory exposure
attempt detected from SLUB object 'scsi_sense_cache' (offset 76, size 
22)!
[   55.998678] WARNING: CPU: 0 PID: 1305 at mm/usercopy.c:81 
usercopy_warn
+0x7e/0xa0

It looks like only the size stays the same.

> Can you send me your .config? What SCSI drivers are you using in the
> VM and on the real server?

This is an Arch kernel with a config available here [1].

For both server and VM "lspci -vv" shows "ahci" in use. Is this what you 
are
asking for?

> Are you able to see what ioctl()s smartctl is issuing? I'll try to
> reproduce this on my end...

As per [2], strace shows "SG_IO" requests. Is this detailed enough?

Thanks for looking into it.

Regards,
   Oleksandr

[1] https://git.archlinux.org/svntogit/packages.git/plain/trunk/config?
h=packages/linux&id=d7625be23f83416491d202d5cea96e5a871fb216
[2] https://gist.github.com/6f58f8891468aeba1ab2cc9f45668735
