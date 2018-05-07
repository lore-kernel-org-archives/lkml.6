Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752784AbeEGTan (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 15:30:43 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:45467 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbeEGTal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 15:30:41 -0400
X-Google-Smtp-Source: AB8JxZpP1Lw40OvSOrsrKYxNUlZchCjDaaixgts7klhjwr4msMAv/D6i3/QZ+oF0tRtoQXXq2o4fO4PTzVVPLNK/J0U=
MIME-Version: 1.0
In-Reply-To: <20180507191857.GA15604@bombadil.infradead.org>
References: <1525704627-30114-1-git-send-email-yehs1@lenovo.com>
 <20180507184622.GB12361@bombadil.infradead.org> <CAPcyv4hBJN3npXwg3Ur32JSWtKvBUZh7F8W+Exx3BB-uKWwPag@mail.gmail.com>
 <20180507191857.GA15604@bombadil.infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 7 May 2018 12:30:40 -0700
Message-ID: <CAPcyv4g_Pua2+3FsEuCyLndX__Tbvk03J0WSc37u+kWvxthQ2Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/6] use mm to manage NVDIMM (pmem) zone
To: Matthew Wilcox <willy@infradead.org>
Cc: Huaisheng Ye <yehs1@lenovo.com>, Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, chengnt@lenovo.com,
        pasha.tatashin@oracle.com, Sasha Levin <alexander.levin@verizon.com>,
        Linux MM <linux-mm@kvack.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, colyli@suse.de,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 7, 2018 at 12:18 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Mon, May 07, 2018 at 11:57:10AM -0700, Dan Williams wrote:
>> I think adding yet one more mm-zone is the wrong direction. Instead,
>> what we have been considering is a mechanism to allow a device-dax
>> instance to be given back to the kernel as a distinct numa node
>> managed by the VM. It seems it times to dust off those patches.
>
> I was wondering how "safe" we think that ability is.  NV-DIMM pages
> (obviously) differ from normal pages by their non-volatility.  Do we
> want their contents from the previous boot to be observable?  If not,
> then we need the BIOS to clear them at boot-up, which means we would
> want no kernel changes at all; rather the BIOS should just describe
> those pages as if they were DRAM (after zeroing them).

Certainly the BIOS could do it, but the impetus for having a kernel
mechanism to do the same is for supporting the configuration
flexibility afforded by namespaces, or otherwise having the capability
when the BIOS does not offer it. However, you are right that there are
extra security implications when System-RAM is persisted, perhaps
requiring the capacity to be explicitly locked / unlocked could
address that concern?
