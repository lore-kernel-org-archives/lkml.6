Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbeBWRMr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 12:12:47 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:43135 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbeBWRMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 12:12:45 -0500
X-Google-Smtp-Source: AG47ELusqlHL8OOtsOJaVRbmT5AUK3j3wm0AMYUo/cHKTl2ZN7FZH+cfTHtPoRbRnqe+fKEd/Kqcr8qI0Q8+dnp+nx8=
MIME-Version: 1.0
In-Reply-To: <04b6c673208b4680b7d6cf41ccdfd3f0@AcuMS.aculab.com>
References: <20180223153700.2186058-1-arnd@arndb.de> <e8e54cb303074abd82048ffa65f26fc9@AcuMS.aculab.com>
 <CAHp75VfNKVjAmgEor2veC6sDnuLacxK1BVgKbqdZ-mxOX=9CSw@mail.gmail.com> <04b6c673208b4680b7d6cf41ccdfd3f0@AcuMS.aculab.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Feb 2018 19:12:44 +0200
Message-ID: <CAHp75VcGM=2Tg3Qw-ywC=_Sofgg7Wppf=f=Jhs18n4U1tbTTGA@mail.gmail.com>
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

On Fri, Feb 23, 2018 at 7:09 PM, David Laight <David.Laight@aculab.com> wrote:
> From: Andy Shevchenko
>> Sent: 23 February 2018 16:51
>> On Fri, Feb 23, 2018 at 6:41 PM, David Laight <David.Laight@aculab.com> wrote:


>> The side-effect I referred previously is about tails, i.e. unaligned
>> bytes are transferred in portions
>> like
>>   7 on 64-bit will be  4 + 2 + 1,
>>   5 = 4 + 1
>
> on 64bit memcpy() is allowed to do:
>         (long *)(tgt+len)[-1] = (long *)(src+len)[-1];
>         rep_movsq(tgt, src, len >> 3);
> provided the length is at least 8.
>
> The misaligned PCIe transfer generates a single TLP covering 12 bytes with the
> relevant byte enables set for the first and last 32bit words.

But is it guaranteed on any type of bus?
memcpy_toio() is a generic helper, so, first of all we need to be sure
what CPU on its side does, this is I think is pretty straight forward
since it's all written in asm for 64-bit case.
So, what about buses?

-- 
With Best Regards,
Andy Shevchenko
