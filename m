Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965243AbeBMPQL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:16:11 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:37971 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965079AbeBMPQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:16:09 -0500
X-Google-Smtp-Source: AH8x225z/yXm5W8e3rJVAme6uT6DOe+uXCuRUU8P8j3qD6LGI5CMS9ctiNwUgpJ48CXxoDnZ4FQwKtUnkYDL3+VmwPM=
MIME-Version: 1.0
In-Reply-To: <20180213162038-mutt-send-email-mst@kernel.org>
References: <20180207013525.1634-1-marcandre.lureau@redhat.com>
 <20180207013525.1634-4-marcandre.lureau@redhat.com> <20180212053104-mutt-send-email-mst@kernel.org>
 <CAMxuvawozzWQ98WkduM=nWQJMMmagSQuHPZMhOYbGZEG5a2aaQ@mail.gmail.com>
 <20180212160849-mutt-send-email-mst@kernel.org> <CAMxuvayUh=N3Lc6+ut8Ct5scVyS5dVRP_qDmpX7pCYf60hnQRA@mail.gmail.com>
 <20180213162038-mutt-send-email-mst@kernel.org>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Tue, 13 Feb 2018 16:16:08 +0100
Message-ID: <CAMxuvaxq9boTcJ2uDOJsYyo3=_WYtn1==kuq3QbPygBfVc+8Zw@mail.gmail.com>
Subject: Re: [PATCH v13 3/4] fw_cfg: write vmcoreinfo details
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergio Lopez Pascual <slp@redhat.com>, Baoquan He <bhe@redhat.com>,
        "Somlo, Gabriel" <somlo@cmu.edu>, xiaolong.ye@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Feb 13, 2018 at 3:27 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Feb 13, 2018 at 03:14:03PM +0100, Marc-Andre Lureau wrote:
>> Hi
>>
>> On Mon, Feb 12, 2018 at 10:00 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Mon, Feb 12, 2018 at 11:04:49AM +0100, Marc-Andre Lureau wrote:
>> >> >> +}
>> >> >> +
>> >> >> +/* qemu fw_cfg device is sync today, but spec says it may become async */
>> >> >> +static void fw_cfg_wait_for_control(struct fw_cfg_dma *d)
>> >> >> +{
>> >> >> +     do {
>> >> >> +             u32 ctrl = be32_to_cpu(READ_ONCE(d->control));
>> >> >> +
>> >> >> +             if ((ctrl & ~FW_CFG_DMA_CTL_ERROR) == 0)
>> >> >> +                     return;
>> >> >> +
>> >> >> +             usleep_range(50, 100);
>> >> >> +     } while (true);
>> >> >
>> >> > And you need an smp rmb here.
>> >
>> > I'd just do rmb() in fact.
>> >
>> >> Could you explain? thanks
>> >
>> > See Documentation/memory-barriers.txt
>> > You know that control is valid, but following read of
>> > the structure could be reordered. So you need that barrier there.
>> > Same for write: wmb.
>>
>> Is this ok?
>> @@ -103,10 +104,14 @@ static ssize_t fw_cfg_dma_transfer(void
>> *address, u32 length, u32 control)
>>         dma = virt_to_phys(d);
>>
>>         iowrite32be((u64)dma >> 32, fw_cfg_reg_dma);
>> +       /* force memory to sync before notifying device via MMIO */
>> +       wmb();
>>         iowrite32be(dma, fw_cfg_reg_dma + 4);
>>
>>         fw_cfg_wait_for_control(d);
>>
>> +       /* do not reorder the read to d->control */
>> +       rmb();
>>         if (be32_to_cpu(READ_ONCE(d->control)) & FW_CFG_DMA_CTL_ERROR) {
>>                 ret = -EIO;
>>         }
>
> I think you need an rmb after the read of d->control.
>


There are two reads of d->control, one in fw_cfg_wait_for_control() to
wait for completion, and the other one here to handle error. Do you
mean that for clarity rmb() should be moved at the end of
fw_cfg_wait_for_control() instead?

thanks
