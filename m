Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752536AbeEUMmN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:42:13 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:33932 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbeEUMmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:42:08 -0400
X-Google-Smtp-Source: AB8JxZoYaGfqW73kGqXilrVybtUVhbNUqnylgRiBTudVvb70JMhXwNg0/C7Hy4DL6kaY1TXTxmntLYTX0/+XJtEVfpU=
MIME-Version: 1.0
In-Reply-To: <20180521104008.z6ei5zjve7u5iwho@lakrids.cambridge.arm.com>
References: <20180425090047.6485-1-ganapatrao.kulkarni@cavium.com>
 <20180425090047.6485-3-ganapatrao.kulkarni@cavium.com> <20180426105938.y6unpt36lisb7kbr@lakrids.cambridge.arm.com>
 <CAKTKpr7Q7T9ZCTBi=LQR=XaAoihbBA3OKCO7yFobzNmR8EfyjQ@mail.gmail.com>
 <CAKTKpr61zBW_D6v_Ck1Lcp0NJ4wPFOpgbiM5aU_EtuiFU-qp4Q@mail.gmail.com>
 <20180521103712.gofbrjdtghfwolmd@lakrids.cambridge.arm.com> <20180521104008.z6ei5zjve7u5iwho@lakrids.cambridge.arm.com>
From: Ganapatrao Kulkarni <gklkml16@gmail.com>
Date: Mon, 21 May 2018 18:12:07 +0530
Message-ID: <CAKTKpr7rBj2Ai5jsPgfH308GYNviQm1GWNnkvOhBD_Zak34+-Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU driver
To: Mark Rutland <mark.rutland@arm.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <Will.Deacon@arm.com>, jnair@caviumnetworks.com,
        Robert Richter <Robert.Richter@cavium.com>, Vadim.Lomovtsev@cavium.com,
        Jan.Glauber@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 4:10 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, May 21, 2018 at 11:37:12AM +0100, Mark Rutland wrote:
>> Hi Ganapat,
>>
>>
>> Sorry for the delay in replying; I was away most of last week.
>>
>> On Tue, May 15, 2018 at 04:03:19PM +0530, Ganapatrao Kulkarni wrote:
>> > On Sat, May 5, 2018 at 12:16 AM, Ganapatrao Kulkarni <gklkml16@gmail.com> wrote:
>> > > On Thu, Apr 26, 2018 at 4:29 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > >> On Wed, Apr 25, 2018 at 02:30:47PM +0530, Ganapatrao Kulkarni wrote:
>>
>> > >>> +static int alloc_counter(struct thunderx2_pmu_uncore_channel *pmu_uncore)
>> > >>> +{
>> > >>> +     int counter;
>> > >>> +
>> > >>> +     raw_spin_lock(&pmu_uncore->lock);
>> > >>> +     counter = find_first_zero_bit(pmu_uncore->counter_mask,
>> > >>> +                             pmu_uncore->uncore_dev->max_counters);
>> > >>> +     if (counter == pmu_uncore->uncore_dev->max_counters) {
>> > >>> +             raw_spin_unlock(&pmu_uncore->lock);
>> > >>> +             return -ENOSPC;
>> > >>> +     }
>> > >>> +     set_bit(counter, pmu_uncore->counter_mask);
>> > >>> +     raw_spin_unlock(&pmu_uncore->lock);
>> > >>> +     return counter;
>> > >>> +}
>> > >>> +
>> > >>> +static void free_counter(struct thunderx2_pmu_uncore_channel *pmu_uncore,
>> > >>> +                                     int counter)
>> > >>> +{
>> > >>> +     raw_spin_lock(&pmu_uncore->lock);
>> > >>> +     clear_bit(counter, pmu_uncore->counter_mask);
>> > >>> +     raw_spin_unlock(&pmu_uncore->lock);
>> > >>> +}
>> > >>
>> > >> I don't believe that locking is required in either of these, as the perf
>> > >> core serializes pmu::add() and pmu::del(), where these get called.
>> >
>> > without this locking, i am seeing "BUG: scheduling while atomic" when
>> > i run perf with more events together than the maximum counters
>> > supported
>>
>> Did you manage to get to the bottom of this?
>>
>> Do you have a backtrace?
>>
>> It looks like in your latest posting you reserve counters through the
>> userspace ABI, which doesn't seem right to me, and I'd like to
>> understand the problem.
>
> Looks like I misunderstood -- those are still allocated kernel-side.
>
> I'll follow that up in the v5 posting.

please review v5.
>
> Thanks,
> Mark.

thanks
Ganapat
