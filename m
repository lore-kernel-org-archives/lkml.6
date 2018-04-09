Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754256AbeDIVFY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 17:05:24 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:41723 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754201AbeDIVFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 17:05:21 -0400
X-Google-Smtp-Source: AIpwx4+L8yo/AL5eQq0aoNArHxpyVZbUpXP8Bkw5jggfRxdq5H14HVLcmhqTncUFXEpZnI3l3wfaCKknSvVUCfhNScE=
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+ho2QhmNmPZMDJcfSxposJd=jYDvjhXH8cMAtVFP7n4A@mail.gmail.com>
References: <20180409074604.17671-1-oohall@gmail.com> <CAL_Jsq+ho2QhmNmPZMDJcfSxposJd=jYDvjhXH8cMAtVFP7n4A@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 9 Apr 2018 14:05:20 -0700
Message-ID: <CAPcyv4iCkc7ZSB7Sjk-O7iBWvvTzhTmdccucC4uN6GEu5Bjotw@mail.gmail.com>
Subject: Re: [PATCH] drivers/of: Introduce ARCH_HAS_OWN_OF_NUMA
To: Rob Herring <robh@kernel.org>
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

On Mon, Apr 9, 2018 at 1:52 PM, Rob Herring <robh@kernel.org> wrote:
> On Mon, Apr 9, 2018 at 2:46 AM, Oliver O'Halloran <oohall@gmail.com> wrote:
>> Some OF platforms (pseries and some SPARC systems) has their own
>> implementations of NUMA affinity detection rather than using the generic
>> OF_NUMA driver, which mainly exists for arm64. For other platforms one
>> of two fallbacks provided by the base OF driver are used depending on
>> CONFIG_NUMA.
>>
>> In the CONFIG_NUMA=n case the fallback is an inline function in of.h.
>> In the =y case the fallback is a real function which is defined as a
>> weak symbol so that it may be overwritten by the architecture if desired.
>>
>> The problem with this arrangement is that the real implementations all
>> export of_node_to_nid(). Unfortunately it's not possible to export the
>> fallback since it would clash with the non-weak version. As a result
>> we get build failures when:
>>
>> a) CONFIG_NUMA=y && CONFIG_OF=y, and
>> b) The platform doesn't implement of_node_to_nid(), and
>> c) A module uses of_node_to_nid()
>>
>> Given b) will be true for most platforms this is fairly easy to hit
>> and has been observed on ia64 and x86.
>
> How specifically do we hit this? The only module I see using
> of_node_to_nid in mainline is Cell EDAC driver.

The of_pmem driver is using it currently pending for a 4.17 pull
request. Stephen hit the compile failure in -next.
