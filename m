Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CB5C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0046E206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbfAIPZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:25:08 -0500
Received: from zg8tmtu5ljg5lje1ms4xmtka.icoremail.net ([159.89.151.119]:39657
        "HELO zg8tmtu5ljg5lje1ms4xmtka.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1730871AbfAIPZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:25:08 -0500
X-Greylist: delayed 22632 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jan 2019 10:25:07 EST
Received: from MI20170214RZUL (unknown [114.255.247.135])
        by email2 (Coremail) with SMTP id AgBjCgDX3zc8EjZcB5YRCg--.43451S3;
        Wed, 09 Jan 2019 23:24:47 +0800 (CST)
From:   "Peng Wang" <rocking@whu.edu.cn>
To:     "'Matthew Wilcox'" <willy@infradead.org>
Cc:     <cl@linux.com>, <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20190109090628.1695-1-rocking@whu.edu.cn> <20190109121352.GI6310@bombadil.infradead.org>
In-Reply-To: <20190109121352.GI6310@bombadil.infradead.org>
Subject: RE: [PATCH] mm/slub.c: re-randomize random_seq if necessary
Date:   Wed, 9 Jan 2019 23:24:44 +0800
Message-ID: <000501d4a82f$74821b40$5d8651c0$@whu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHS10gH9bp1oZXRh7a3ROcd3vd+NwIerMmLpZmMotA=
Content-Language: zh-cn
X-CM-TRANSID: AgBjCgDX3zc8EjZcB5YRCg--.43451S3
X-Coremail-Antispam: 1UD129KBjvdXoWrurW5tr4rCr4fCw15Zw43KFg_yoWDGrg_Za
        4IvFyDAa15Wr4DWa45Ca15ZryxKr9ruF18t34kGr12qryvqrZrA3W5W34xu3WIvFn8GrW3
        Ar4kJa1xAasakjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2xYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_XrWl42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4znQUUUUU
X-CM-SenderInfo: qsqrijaqrviiqqxyq4lkxovvfxof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wednesday, January 9, 2019 8:14 PM, Matthew Wilcox wrote:
> On Wed, Jan 09, 2019 at 05:06:27PM +0800, Peng Wang wrote:
> > calculate_sizes() could be called in several places
> > like (red_zone/poison/order/store_user)_store() while
> > random_seq remains unchanged.
> >
> > If random_seq is not NULL in calculate_sizes(), re-randomize it.
> 
> Why do we want to re-randomise the slab at these points?

At these points, s->size might change,
but random_seq still use the old size and not updated.

When doing shuffle_freelist() in allocat_slab(),
old next object offset would be used. 

    idx = s->random_seq[*pos];

One possible case:

s->size gets smaller, then number of objects in a slab gets bigger.
The size of s->random_seq array should be bigger but not updated.
In next_freelist_entry(), *pos might exceed the s->random_seq.

When we get zero value from s->random_seq[*pos] twice after exceeding,
BUG_ON(object == fp) would be triggered in set_freepointer().


