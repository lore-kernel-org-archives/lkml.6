Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbeDPQsJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:48:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753105AbeDPQsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:48:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51D02183D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AIpwx49GSjcJES6cBZpzMLyn1X0yTj/Dtf5zShAr1xLRTk6i8/QEkUizY+hiFpT911+pAbeKXc+2bjtDGmsUo8byIxg=
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iCkc7ZSB7Sjk-O7iBWvvTzhTmdccucC4uN6GEu5Bjotw@mail.gmail.com>
References: <20180409074604.17671-1-oohall@gmail.com> <CAL_Jsq+ho2QhmNmPZMDJcfSxposJd=jYDvjhXH8cMAtVFP7n4A@mail.gmail.com>
 <CAPcyv4iCkc7ZSB7Sjk-O7iBWvvTzhTmdccucC4uN6GEu5Bjotw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 16 Apr 2018 11:47:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLujBZzo5T0118QiX-CvxfetaBcPG9rC_WGCCK8k4Ka7Q@mail.gmail.com>
Message-ID: <CAL_JsqLujBZzo5T0118QiX-CvxfetaBcPG9rC_WGCCK8k4Ka7Q@mail.gmail.com>
Subject: Re: [PATCH] drivers/of: Introduce ARCH_HAS_OWN_OF_NUMA
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Oliver O'Halloran" <oohall@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Device Tree <devicetree@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 9, 2018 at 4:05 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Mon, Apr 9, 2018 at 1:52 PM, Rob Herring <robh@kernel.org> wrote:
>> On Mon, Apr 9, 2018 at 2:46 AM, Oliver O'Halloran <oohall@gmail.com> wrote:
>>> Some OF platforms (pseries and some SPARC systems) has their own
>>> implementations of NUMA affinity detection rather than using the generic
>>> OF_NUMA driver, which mainly exists for arm64. For other platforms one
>>> of two fallbacks provided by the base OF driver are used depending on
>>> CONFIG_NUMA.
>>>
>>> In the CONFIG_NUMA=n case the fallback is an inline function in of.h.
>>> In the =y case the fallback is a real function which is defined as a
>>> weak symbol so that it may be overwritten by the architecture if desired.
>>>
>>> The problem with this arrangement is that the real implementations all
>>> export of_node_to_nid(). Unfortunately it's not possible to export the
>>> fallback since it would clash with the non-weak version. As a result
>>> we get build failures when:
>>>
>>> a) CONFIG_NUMA=y && CONFIG_OF=y, and
>>> b) The platform doesn't implement of_node_to_nid(), and
>>> c) A module uses of_node_to_nid()
>>>
>>> Given b) will be true for most platforms this is fairly easy to hit
>>> and has been observed on ia64 and x86.
>>
>> How specifically do we hit this? The only module I see using
>> of_node_to_nid in mainline is Cell EDAC driver.
>
> The of_pmem driver is using it currently pending for a 4.17 pull
> request. Stephen hit the compile failure in -next.

I took a look at this. The correct fix here is to use dev_to_node() instead:

diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index 85013bad35de..0a701837dfc0 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -67,7 +67,7 @@ static int of_pmem_region_probe(struct platform_device *pdev)
                 */
                memset(&ndr_desc, 0, sizeof(ndr_desc));
                ndr_desc.attr_groups = region_attr_groups;
-               ndr_desc.numa_node = of_node_to_nid(np);
+               ndr_desc.numa_node = dev_to_node(&pdev->dev);
                ndr_desc.res = &pdev->resource[i];
                ndr_desc.of_node = np;
                set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);


And we should remove the exported symbol.

I'll send a proper patch.

Rob
