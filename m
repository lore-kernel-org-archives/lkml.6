Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932176AbeCKQKH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 12:10:07 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:39454 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932136AbeCKQKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 12:10:05 -0400
X-Google-Smtp-Source: AG47ELuQtY+EdZbUGJTIPTP/nh0dZ0UytVsSZj2y2Mg9LSBMtaChzE6sRfvmigPtdCAVHcepDSkfxQeGAIOH8l5n+oA=
MIME-Version: 1.0
In-Reply-To: <20180311150151.GB15443@localhost>
References: <1957017.QzKNMJJqD6@bear> <20180306120259.GT15443@localhost>
 <23394379.8nZhno5foU@bear> <20180311150151.GB15443@localhost>
From: Frank Mori Hess <fmh6jj@gmail.com>
Date: Sun, 11 Mar 2018 12:10:03 -0400
Message-ID: <CAJz5OpeF1qGk=wT2aUZZitS3p9VjfiGwccPMA0mmbxYSCXuoxQ@mail.gmail.com>
Subject: Re: [PATCH v3] dmaengine: pl330: flush before wait, and add dev burst support.
To: Vinod Koul <vinod.koul@intel.com>
Cc: fmhess@users.sourceforge.net, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 11:01 AM, Vinod Koul <vinod.koul@intel.com> wrote:
>
> sorry if it wasnt clear earlier, the lines below should come after the ---
> line. git-am skips that part while applying..

ok

>>
>> +     /* do FLUSHP at beginning to clear any stale dma requests before the
>> +      * first WFP.
>> +      */
>
> multiline comments should be:
>
> /*
>  * this is an example of multi-line
>  * comment
>  */
>
> Pls fix at this and other places...

ok

>
>>  static inline int _ldst_memtodev(struct pl330_dmac *pl330,
>>                                unsigned dry_run, u8 buf[],
>> -                              const struct _xfer_spec *pxs, int cyc)
>> +                              const struct _xfer_spec *pxs, int cyc,
>> +                              enum pl330_cond cond)
>>  {
>>       int off = 0;
>> -     enum pl330_cond cond;
>>
>>       if (pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP)
>>               cond = BURST;
>> -     else
>> -             cond = SINGLE;
>>
>> +     /* do FLUSHP at beginning to clear any stale dma requests before the
>> +      * first WFP.
>> +      */
>> +     if (!(pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP))
>> +             off += _emit_FLUSHP(dry_run, &buf[off], pxs->desc->peri);
>>       while (cyc--) {
>>               off += _emit_WFP(dry_run, &buf[off], cond, pxs->desc->peri);
>>               off += _emit_LD(dry_run, &buf[off], ALWAYS);
>> -             off += _emit_STP(dry_run, &buf[off], cond, pxs->desc->peri);
>> -
>> -             if (!(pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP))
>> -                     off += _emit_FLUSHP(dry_run, &buf[off],
>> -                                         pxs->desc->peri);
>> +             if (cond == ALWAYS) {
>> +                     off += _emit_STP(dry_run, &buf[off], SINGLE,
>> +                             pxs->desc->peri);
>> +                     off += _emit_STP(dry_run, &buf[off], BURST,
>> +                             pxs->desc->peri);
>> +             } else {
>> +                     off += _emit_STP(dry_run, &buf[off], cond,
>> +                             pxs->desc->peri);
>> +             }
>
> this looks quite similar to previous routine above, if so can we please make
> it common function and invoke from both of these...

_ldst_memtodev and _ldst_devtomem are similar, but they were even more
similar before my patch.  Do I really have to refactor existing code
to get my patch applied?  I'm not trying to take over maintainership
of the pl330.c driver.

>
>> +static int _dregs(struct pl330_dmac *pl330, unsigned int dry_run, u8 buf[],
>> +             const struct _xfer_spec *pxs, int transfer_length)
>> +{
>> +     int off = 0;
>> +     int dregs_ccr;
>> +
>> +     if (transfer_length == 0)
>> +             return off;
>> +
>> +     switch (pxs->desc->rqtype) {
>> +     case DMA_MEM_TO_DEV:
>> +             off += _ldst_memtodev(pl330, dry_run, &buf[off], pxs,
>> +                     transfer_length, SINGLE);
>> +             break;
>
> empty line after each case pls

ok

>
>> +     case DMA_DEV_TO_MEM:
>> +             off += _ldst_devtomem(pl330, dry_run, &buf[off], pxs,
>> +                     transfer_length, SINGLE);
>> +             break;
>> +     case DMA_MEM_TO_MEM:
>> +             dregs_ccr = pxs->ccr;
>> +             dregs_ccr &= ~((0xf << CC_SRCBRSTLEN_SHFT) |
>> +                     (0xf << CC_DSTBRSTLEN_SHFT));
>> +             dregs_ccr |= (((transfer_length - 1) & 0xf) <<
>> +                     CC_SRCBRSTLEN_SHFT);
>> +             dregs_ccr |= (((transfer_length - 1) & 0xf) <<
>> +                     CC_DSTBRSTLEN_SHFT);
>> +             off += _emit_MOV(dry_run, &buf[off], CCR, dregs_ccr);
>> +             off += _ldst_memtomem(dry_run, &buf[off], pxs, 1);
>> +             break;
>> +     default:
>> +             off += 0x40000000; /* Scare off the Client */
>
> Can you explain this bit, shouldnt this be err?
>

I just copied that behavior from the existing _bursts() function.  I
guess the original author's idea was returning a big offset would
result in a dry run failure due to exceeding the maximum buffer size.
I do agree an error would be better, although it would require
refactoring since the return values from _bursts and _dregs are not
checked for errors, they just blindly add the return value to the
offset.

>> @@ -1303,11 +1362,6 @@ static int _setup_req(struct pl330_dmac *pl330, unsigned dry_run,
>>       /* DMAMOV CCR, ccr */
>>       off += _emit_MOV(dry_run, &buf[off], CCR, pxs->ccr);
>>
>> -     x = &pxs->desc->px;
>> -     /* Error if xfer length is not aligned at burst size */
>> -     if (x->bytes % (BRST_SIZE(pxs->ccr) * BRST_LEN(pxs->ccr)))
>> -             return -EINVAL;
>> -
>>       off += _setup_xfer(pl330, dry_run, &buf[off], pxs);
>>
>>       /* DMASEV peripheral/event */
>> @@ -2115,15 +2169,29 @@ static int pl330_config(struct dma_chan *chan,
>>                       pch->fifo_addr = slave_config->dst_addr;
>>               if (slave_config->dst_addr_width)
>>                       pch->burst_sz = __ffs(slave_config->dst_addr_width);
>> -             if (slave_config->dst_maxburst)
>> -                     pch->burst_len = slave_config->dst_maxburst;
>> +             if (pch->dmac->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP)
>> +                     pch->burst_len = 1;
>
> so in this case we don't honour the requested burst length?
>

I don't have any experience with the PL330_QUIRK_BROKEN_NO_FLUSHP
hardware, or knowledge of how it (mis)behaves.  So I just tried to
maintain the existing behavior as much as possible.  The old code
advertised the max burst length as 1 with PL330_QUIRK_BROKEN_NO_FLUSHP
hardware, and programmed the pl330 to respond only to burst requests
(and of course the old code never did any peripheral bursts longer
than 1).  I actually don't mind changing the behavior of
PL330_QUIRK_BROKEN_NO_FLUSHP but it seems like someone with more
knowledge of that hardware should be involved, like the rock-chips.com
guys who introduced it in commit
271e1b86e69140fe65718ae8a264284c46d3129d ,

>> +             else if (slave_config->dst_maxburst) {
>> +                     if (slave_config->dst_maxburst > PL330_MAX_BURST)
>> +                             pch->burst_len = PL330_MAX_BURST;
>> +                     else
>> +                             pch->burst_len = slave_config->dst_maxburst;
>> +             } else
>> +                     pch->burst_len = 1;
>>       } else if (slave_config->direction == DMA_DEV_TO_MEM) {
>>               if (slave_config->src_addr)
>>                       pch->fifo_addr = slave_config->src_addr;
>>               if (slave_config->src_addr_width)
>>                       pch->burst_sz = __ffs(slave_config->src_addr_width);
>> -             if (slave_config->src_maxburst)
>> -                     pch->burst_len = slave_config->src_maxburst;
>> +             if (pch->dmac->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP)
>> +                     pch->burst_len = 1;
>> +             else if (slave_config->src_maxburst) {
>> +                     if (slave_config->src_maxburst > PL330_MAX_BURST)
>> +                             pch->burst_len = PL330_MAX_BURST;
>> +                     else
>> +                             pch->burst_len = slave_config->src_maxburst;
>> +             } else
>> +                     pch->burst_len = 1;
>
> again this looks duplicate..
> --
> ~Vinod

Ok, I'll make a little helper function.

-- 
Frank
