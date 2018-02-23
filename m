Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751863AbeBWQvO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:51:14 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40044 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeBWQvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:51:12 -0500
X-Google-Smtp-Source: AG47ELsRh+ItNb5M4i2UL0gPSI5YNH7ly6WZ7D7ps1Brl0CKku9soEgAuLCbbXwqLAMTbtOhHp48ytOYBLRm2RYyu0s=
MIME-Version: 1.0
In-Reply-To: <e8e54cb303074abd82048ffa65f26fc9@AcuMS.aculab.com>
References: <20180223153700.2186058-1-arnd@arndb.de> <e8e54cb303074abd82048ffa65f26fc9@AcuMS.aculab.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Feb 2018 18:51:11 +0200
Message-ID: <CAHp75VfNKVjAmgEor2veC6sDnuLacxK1BVgKbqdZ-mxOX=9CSw@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: use memcpy_toio instead of writeq
To: David Laight <David.Laight@aculab.com>
Cc: Arnd Bergmann <arnd@arndb.de>, James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 6:41 PM, David Laight <David.Laight@aculab.com> wrote:
> From: Arnd Bergmann
>> Sent: 23 February 2018 15:37
>>
>> 32-bit architectures generally cannot use writeq(), so we now get a build
>> failure for the lpfc driver:
>>
>> drivers/scsi/lpfc/lpfc_sli.c: In function 'lpfc_sli4_wq_put':
>> drivers/scsi/lpfc/lpfc_sli.c:145:4: error: implicit declaration of function 'writeq'; did you mean
>> 'writeb'? [-Werror=implicit-function-declaration]
>>
>> Another problem here is that writing out actual data (unlike accessing
>> mmio registers) means we must write the data with the same endianess
>> that we have read from memory, but writeq() will perform byte swaps
>> and add barriers inbetween accesses as we do for registers.
>>
>> Using memcpy_toio() should do the right thing here, using register
>> sized stores with correct endianess conversion and barriers (i.e. none),
>> but on some architectures might fall back to byte-size access.
> ...
>
> Have you looked at the performance impact of this on x86?
> Last time I looked memcpy_toio() aliased directly to memcpy().
> memcpy() is run-time patched between several different algorithms.
> On recent Intel cpus memcpy() is implemented as 'rep movsb' relying
> on the hardware to DTRT.
> For uncached accesses (typical for io) the 'RT' has to be byte transfers.
> So instead of the 8 byte transfers (on 64 bit) you get single bytes.
> This won't be what is intended!
> memcpy_toio() should probably use 'rep movsd' for the bulk of the transfer.

Maybe I'm wrong but it uses movsq on 64-bit and movsl on 32-bit.

The side-effect I referred previously is about tails, i.e. unaligned
bytes are transferred in portions
like
  7 on 64-bit will be  4 + 2 + 1,
  5 = 4 + 1
etc

Similar way on 32-bit.

-- 
With Best Regards,
Andy Shevchenko
