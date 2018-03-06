Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754245AbeCFXZR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 18:25:17 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:43471 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754035AbeCFXZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 18:25:15 -0500
X-Google-Smtp-Source: AG47ELvDFffm11crcIhivWkZCfnAkzRKsMfLW7xb4my8ebFP1YKS7LTa+CJj/fesZfuJLdAyEzAGr0rfVgvIIH74eKo=
MIME-Version: 1.0
In-Reply-To: <20180228211514.GC13394@ziepe.ca>
References: <20180220205638.1959033-1-arnd@arndb.de> <20180228211514.GC13394@ziepe.ca>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Mar 2018 00:25:14 +0100
X-Google-Sender-Auth: dT84GYcBkhEz9wMAzkxeFsf1nd4
Message-ID: <CAK8P3a2dsQ7QAb64DCp9Fc2xXjEyHNjBFdRc=y6FanQKsXhADg@mail.gmail.com>
Subject: Re: [PATCH 1/2] infiniband: qplib_fp: fix pointer cast
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Eddie Wai <eddie.wai@broadcom.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 10:15 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Tue, Feb 20, 2018 at 09:56:26PM +0100, Arnd Bergmann wrote:
>> Building for a 32-bit target results in a couple of warnings from casting between
>> a 32-bit pointer and a 64-bit integer:
>>
>> drivers/infiniband/hw/bnxt_re/qplib_fp.c: In function 'bnxt_qplib_service_nq':
>> drivers/infiniband/hw/bnxt_re/qplib_fp.c:333:23: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>>     bnxt_qplib_arm_srq((struct bnxt_qplib_srq *)q_handle,
>>                        ^
>> drivers/infiniband/hw/bnxt_re/qplib_fp.c:336:12: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>>             (struct bnxt_qplib_srq *)q_handle,
>>             ^
>> In file included from include/linux/byteorder/little_endian.h:5,
>>                  from arch/arm/include/uapi/asm/byteorder.h:22,
>>                  from include/asm-generic/bitops/le.h:6,
>>                  from arch/arm/include/asm/bitops.h:342,
>>                  from include/linux/bitops.h:38,
>>                  from include/linux/kernel.h:11,
>>                  from include/linux/interrupt.h:6,
>>                  from drivers/infiniband/hw/bnxt_re/qplib_fp.c:39:
>> drivers/infiniband/hw/bnxt_re/qplib_fp.c: In function 'bnxt_qplib_create_srq':
>> include/uapi/linux/byteorder/little_endian.h:31:43: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>>  #define __cpu_to_le64(x) ((__force __le64)(__u64)(x))
>>                                            ^
>> include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__cpu_to_le64'
>>  #define cpu_to_le64 __cpu_to_le64
>>                      ^~~~~~~~~~~~~
>> drivers/infiniband/hw/bnxt_re/qplib_fp.c:569:19: note: in expansion of macro 'cpu_to_le64'
>>   req.srq_handle = cpu_to_le64(srq);
>>
>> Using a uintptr_t as an intermediate works on all architectures.
>>
>> Fixes: 37cb11acf1f7 ("RDMA/bnxt_re: Add SRQ support for Broadcom adapters")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>  drivers/infiniband/hw/bnxt_re/qplib_fp.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> I applied the series to for-next, thanks

Hi Jason,

kernelci still reports the warning for v4.16-rc, any chance you can also send it
as a bugfix for the current release?

      Arnd
