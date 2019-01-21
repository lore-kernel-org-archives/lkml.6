Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB9DC31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E4820861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfAUTEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 14:04:48 -0500
Received: from mail.netline.ch ([148.251.143.178]:37801 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfAUTEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 14:04:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 43A562A6055;
        Mon, 21 Jan 2019 20:04:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id dHAATxsRZUT5; Mon, 21 Jan 2019 20:04:43 +0100 (CET)
Received: from thor (39.1.199.178.dynamic.wline.res.cust.swisscom.ch [178.199.1.39])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id 871E62A6054;
        Mon, 21 Jan 2019 20:04:42 +0100 (CET)
Received: from [::1]
        by thor with esmtp (Exim 4.92-RC4)
        (envelope-from <michel@daenzer.net>)
        id 1glesE-0003AO-4C; Mon, 21 Jan 2019 20:04:42 +0100
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        David Zhou <David1.Zhou@amd.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, Junwei Zhang <Jerry.Zhang@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sean Paul <sean@poorly.run>,
        Christian Koenig <christian.koenig@amd.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org>
 <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org>
 <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
 <20190121162238.GA17651@infradead.org>
 <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
 <59ccf85d-b99d-b5c8-ea87-66c2a892e197@daenzer.net>
 <CAKv+Gu8OkbHwY5UBxahpQpM_gKh2331pQ6o-4YyJdLurbFNHvw@mail.gmail.com>
 <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net>
 <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
 <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Openpgp: preference=signencrypt
Autocrypt: addr=michel@daenzer.net; prefer-encrypt=mutual; keydata=
 mQGiBDsehS8RBACbsIQEX31aYSIuEKxEnEX82ezMR8z3LG8ktv1KjyNErUX9Pt7AUC7W3W0b
 LUhu8Le8S2va6hi7GfSAifl0ih3k6Bv1Itzgnd+7ZmSrvCN8yGJaHNQfAevAuEboIb+MaVHo
 9EMJj4ikOcRZCmQWw7evu/D9uQdtkCnRY9iJiAGxbwCguBHtpoGMxDOINCr5UU6qt+m4O+UD
 /355ohBBzzyh49lTj0kTFKr0Ozd20G2FbcqHgfFL1dc1MPyigej2gLga2osu2QY0ObvAGkOu
 WBi3LTY8Zs8uqFGDC4ZAwMPoFy3yzu3ne6T7d/68rJil0QcdQjzzHi6ekqHuhst4a+/+D23h
 Za8MJBEcdOhRhsaDVGAJSFEQB1qLBACOs0xN+XblejO35gsDSVVk8s+FUUw3TSWJBfZa3Imp
 V2U2tBO4qck+wqbHNfdnU/crrsHahjzBjvk8Up7VoY8oT+z03sal2vXEonS279xN2B92Tttr
 AgwosujguFO/7tvzymWC76rDEwue8TsADE11ErjwaBTs8ZXfnN/uAANgPLQjTWljaGVsIERh
 ZW56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD6IXgQTEQIAHgUCQFXxJgIbAwYLCQgHAwIDFQID
 AxYCAQIeAQIXgAAKCRBaga+OatuyAIrPAJ9ykonXI3oQcX83N2qzCEStLNW47gCeLWm/QiPY
 jqtGUnnSbyuTQfIySkK5AQ0EOx6FRRAEAJZkcvklPwJCgNiw37p0GShKmFGGqf/a3xZZEpjI
 qNxzshFRFneZze4f5LhzbX1/vIm5+ZXsEWympJfZzyCmYPw86QcFxyZflkAxHx9LeD+89Elx
 bw6wT0CcLvSv8ROfU1m8YhGbV6g2zWyLD0/naQGVb8e4FhVKGNY2EEbHgFBrAAMGA/0VktFO
 CxFBdzLQ17RCTwCJ3xpyP4qsLJH0yCoA26rH2zE2RzByhrTFTYZzbFEid3ddGiHOBEL+bO+2
 GNtfiYKmbTkj1tMZJ8L6huKONaVrASFzLvZa2dlc2zja9ZSksKmge5BOTKWgbyepEc5qxSju
 YsYrX5xfLgTZC5abhhztpYhGBBgRAgAGBQI7HoVFAAoJEFqBr45q27IAlscAn2Ufk2d6/3p4
 Cuyz/NX7KpL2dQ8WAJ9UD5JEakhfofed8PSqOM7jOO3LCA==
Message-ID: <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
Date:   Mon, 21 Jan 2019 20:04:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-21 7:28 p.m., Ard Biesheuvel wrote:
> On Mon, 21 Jan 2019 at 19:24, Michel Dänzer <michel@daenzer.net> wrote:
>> On 2019-01-21 7:20 p.m., Ard Biesheuvel wrote:
>>> On Mon, 21 Jan 2019 at 19:04, Michel Dänzer <michel@daenzer.net> wrote:
>>>> On 2019-01-21 6:59 p.m., Ard Biesheuvel wrote:
>>>>> On Mon, 21 Jan 2019 at 18:55, Michel Dänzer <michel@daenzer.net> wrote:
>>>>>> On 2019-01-21 5:30 p.m., Ard Biesheuvel wrote:
>>>>>>> On Mon, 21 Jan 2019 at 17:22, Christoph Hellwig <hch@infradead.org> wrote:
>>>>>>>
>>>>>>>> Until that happens we should just change the driver ifdefs to default
>>>>>>>> the hacks to off and only enable them on setups where we 100%
>>>>>>>> positively know that they actually work.  And document that fact
>>>>>>>> in big fat comments.
>>>>>>>
>>>>>>> Well, as I mentioned in my commit log as well, if we default to off
>>>>>>> unless CONFIG_X86, we may break working setups on MIPS and Power where
>>>>>>> the device is in fact non-cache coherent, and relies on this
>>>>>>> 'optimization' to get things working.
>>>>>>
>>>>>> FWIW, the amdgpu driver doesn't rely on non-snooped transfers for
>>>>>> correct basic operation (the scenario Christian brought up is a very
>>>>>> specialized use-case), so that shouldn't be an issue.
>>>>>
>>>>> The point is that this is only true for x86.
>>>>>
>>>>> On other architectures, the use of non-cached mappings on the CPU side
>>>>> means that you /do/ rely on non-snooped transfers, since if those
>>>>> transfers turn out not to snoop inadvertently, the accesses are
>>>>> incoherent with the CPU's view of memory.
>>>>
>>>> The driver generally only uses non-cached mappings if
>>>> drm_arch/device_can_wc_memory returns true.
>>>
>>> Indeed. And so we should take care to only return 'true' from that
>>> function if it is guaranteed that non-cached CPU mappings are coherent
>>> with the mappings used by the GPU, either because that is always the
>>> case (like on x86), or because we know that the platform in question
>>> implements NoSnoop correctly throughout the interconnect.
>>>
>>> What seems to be complicating matters is that in some cases, the
>>> device is non-cache coherent to begin with, so regardless of whether
>>> the NoSnoop attribute is used or not, those accesses will not snoop in
>>> the caches and be coherent with the non-cached mappings used by the
>>> CPU. So if we restrict this optimization [on non-X86] to platforms
>>> that are known to implement NoSnoop correctly, we may break platforms
>>> that are implicitly NoSnoop all the time.
>>
>> Since the driver generally doesn't rely on non-snooped accesses for
>> correctness, that couldn't "break" anything that hasn't always been broken.
> 
> Again, that is only true on x86.
> 
> On other architectures, DMA writes from the device may allocate in the
> caches, and be invisible to the CPU when it uses non-cached mappings.

Let me try one last time:

If drm_arch_can_wc_memory returns false, the driver falls back to the
normal mode of operation, using a cacheable CPU mapping and snooped GPU
transfers, even if userspace asks (as a performance optimization) for a
write-combined CPU mapping and non-snooped GPU transfers via
AMDGPU_GEM_CREATE_CPU_GTT_USWC. This normal mode of operation is also
used for the ring buffers at the heart of the driver's operation. If
there is a platform where this normal mode of operation doesn't work,
the driver could never have worked reliably on that platform, since
before AMDGPU_GEM_CREATE_CPU_GTT_USWC or drm_arch_can_wc_memory even
existed.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
