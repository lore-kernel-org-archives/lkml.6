Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbeEPCtA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 22:49:00 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:45416 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752095AbeEPCs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 22:48:58 -0400
X-Google-Smtp-Source: AB8JxZoTlcItFJavec3VQBcgGc64r3Ktx5SS0fCYpKfdwa5QdFq8k6zJtitd46Hrih0ETqxdH2srDf2iJ2g2YTP4PwM=
MIME-Version: 1.0
In-Reply-To: <HK2PR03MB1684F8D2724BB8AF1FCCF02A92920@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525704627-30114-1-git-send-email-yehs1@lenovo.com>
 <20180507184622.GB12361@bombadil.infradead.org> <CAPcyv4hBJN3npXwg3Ur32JSWtKvBUZh7F8W+Exx3BB-uKWwPag@mail.gmail.com>
 <x49a7tbi8r3.fsf@segfault.boston.devel.redhat.com> <HK2PR03MB1684659175EB0A11E75E9B61929A0@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180508030959.GB16338@bombadil.infradead.org> <HK2PR03MB16841CBB549F40F86BB8D35C92990@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180510162742.GA30442@bombadil.infradead.org> <HK2PR03MB1684B34F9D1DF18A8CDE18F292930@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180515162003.GA26489@bombadil.infradead.org> <HK2PR03MB1684F8D2724BB8AF1FCCF02A92920@HK2PR03MB1684.apcprd03.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 15 May 2018 19:48:57 -0700
Message-ID: <CAPcyv4hFzzF-jZd3-3vLNbB6SHD1Z5+wuRqgiuubnztAEzsSJQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH v1 0/6] use mm to manage NVDIMM (pmem) zone
To: Huaisheng HS1 Ye <yehs1@lenovo.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jeff Moyer <jmoyer@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        NingTing Cheng <chengnt@lenovo.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>,
        Linux MM <linux-mm@kvack.org>, "colyli@suse.de" <colyli@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <alexander.levin@verizon.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, Ocean HY1 He <hehy1@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 7:05 PM, Huaisheng HS1 Ye <yehs1@lenovo.com> wrote:
>> From: Matthew Wilcox [mailto:willy@infradead.org]
>> Sent: Wednesday, May 16, 2018 12:20 AM>
>> > > > > Then there's the problem of reconnecting the page cache (which is
>> > > > > pointed to by ephemeral data structures like inodes and dentries) to
>> > > > > the new inodes.
>> > > > Yes, it is not easy.
>> > >
>> > > Right ... and until we have that ability, there's no point in this patch.
>> > We are focusing to realize this ability.
>>
>> But is it the right approach?  So far we have (I think) two parallel
>> activities.  The first is for local storage, using DAX to store files
>> directly on the pmem.  The second is a physical block cache for network
>> filesystems (both NAS and SAN).  You seem to be wanting to supplant the
>> second effort, but I think it's much harder to reconnect the logical cache
>> (ie the page cache) than it is the physical cache (ie the block cache).
>
> Dear Matthew,
>
> Thanks for correcting my idea with cache line.
> But I have questions about that, assuming NVDIMM works with pmem mode, even we
> used it as physical block cache, like dm-cache, there is potential risk with
> this cache line issue, because NVDIMMs are bytes-address storage, right?

No, there is no risk if the cache is designed properly. The pmem
driver will not report that the I/O is complete until the entire
payload of the data write has made it to persistent memory. The cache
driver will not report that the write succeeded until the pmem driver
completes the I/O. There is no risk to losing power while the pmem
driver is operating because the cache will recover to it's last
acknowledged stable state, i.e. it will roll back / undo the
incomplete write.

> If system crash happens, that means CPU doesn't have opportunity to flush all dirty
> data from cache lines to NVDIMM, during copying data pointed by bio_vec.bv_page to
> NVDIMM.
> I know there is btt which is used to guarantee sector atomic with block mode,
> but for pmem mode that will likely cause mix of new and old data in one page
> of NVDIMM.
> Correct me if anything wrong.

dm-cache is performing similar metadata management as the btt driver
to ensure safe forward progress of the cache state relative to power
loss or system-crash.

> Another question, if we used NVDIMMs as physical block cache for network filesystems,
> Does industry have existing implementation to bypass Page Cache similarly like DAX way,
> that is to say, directly storing data to NVDIMMs from userspace, rather than copying
> data from kernel space memory to NVDIMMs.

Any caching solution with associated metadata requires coordination
with the kernel, so it is not possible for the kernel to stay
completely out of the way. Especially when we're talking about a cache
in front of the network there is not much room for DAX to offer
improved performance because we need the kernel to takeover on all
write-persist operations to update cache metadata.

So, I'm still struggling to see why dm-cache is not a suitable
solution for this case. It seems suitable if it is updated to allow
direct dma-access to the pmem cache pages from the backing device
storage / networking driver.
