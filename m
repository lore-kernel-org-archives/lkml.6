Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EACC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94EDA2082B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WQtwSILV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94EDA2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbeJ2VOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:14:19 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8530 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbeJ2VOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:14:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bd6fc400000>; Mon, 29 Oct 2018 05:25:36 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 29 Oct 2018 05:25:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 29 Oct 2018 05:25:49 -0700
Received: from [10.21.24.173] (10.21.24.173) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 29 Oct
 2018 12:25:46 +0000
Subject: Re: [PATCH 4/9] mailbox: tegra-hsp: Add support for shared mailboxes
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        Mika Liljeberg <mliljeberg@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
 <20181026111638.10759-5-thierry.reding@gmail.com>
 <bfc78c91-73f1-4f64-9196-5268a73b5c42@nvidia.com>
 <20181029103937.GB26393@ulmo>
From:   Pekka Pessi <ppessi@nvidia.com>
Message-ID: <9dfa7669-9401-a55c-8959-8d31cf193ca7@nvidia.com>
Date:   Mon, 29 Oct 2018 14:25:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181029103937.GB26393@ulmo>
X-Originating-IP: [10.21.24.173]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To HQMAIL101.nvidia.com
 (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1540815936; bh=B4b5vAzZBRl598we+bKNPK+6/frZo71lZe41UOQE9eM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=WQtwSILVCTUVL6IwrcReEjDCpWGHFRLu1YOaz1jr1dx5wvxQw5s78TEI0e2R70w6I
         q8qnCwqlPSapcz6/AfuzK6qjn5mHxlqYIErbxXuhpKahofE4bpVDpuvUUuljlNIq/S
         WAziHDGkbFxgYDAuXenYf2N5bvxHgBE2P5z+YpGdCyHFn9ofrgYoi1z0KBSKkT5iYL
         sjp4tYfC7qhWaf5RvJoP53q6dDJk6NFVSL/Z3yag4Wd9NHEMGsgSAhbYKXBopZWUTL
         9zXFDq0xrk1Nri/qsJq9V1TTqnxAlkXU6AKPwj81vkUTaFndKFLlrD5fbBpu/sMSae
         hn7kRyPeAJYmQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

 From the 0/9:
> Are you aware of any others that we need to take into account?
We would like to use upstream driver for RCE (and probably AON and SCE)=20
mailbox handling, too. Eventually.
> This is a bit
> of a problem because the mailbox driver doesn't really know anything
> about the direction when it starts up, so how would it make the decision
> about how to program the registers?
I'm afraid that information must be stored in the device tree.
> What's somewhat surprising is that you're saying that both FULL and
> EMPTY interrupts should be handled by the same shared interrupt. That's
> the opposite of what the recommended programming sequence is that the
> TRM specifies.
Which TRM you mean? Something here?

https://p4viewer.nvidia.com/get///hw/ar/doc/Tech_Pubs/Xavier/TRM/

I browsed through he Xavier_TRM_DP09253001v1.pdf HSP section and I could=20
not find any recommendations? But see below.
> Why is it better to handle both FULL and EMPTY interrupts
> with the same shared interrupt?
Only top0 has 8 interrupts, rest of the HSP blocks have only 4 (or 5 in=20
case of top1) interrupts per HSP available through LIC. Hogging two of=20
them means that only two VMs can access a HSP.
> Would it be safe to clear all of the IE registers to 0 on driver probe?
Nope, the driver should clear only the IE register for the shared=20
interrupt that the driver uses. Other IEs are used by other entities.
> If they are indeed separate
> for each processor, it should be fairly easy to keep track of the
> mailboxes used by the kernel and process only those.
Yes, that is what we should do. Again the directionality should be=20
specified in DT.
> I'm not entirely clear on what the advantages are of using the per-
> mailbox registers, or how they are supposed to be used. The existing
> documentation doesn't really explain how these are supposed to be used
> either, so I was mostly just going by trial and error.
On virtualized configs, multiple VMs can use same HSP block but each VM=20
must use its own interrupt. Because all the IE registers are on the same=20
64 KB page, the writes to the page are trapped by hypervisor, which=20
means that enabling or disabling an interrupt via the shared IE register=20
is pretty heavy operation. The per-mailbox IE registers are on a page=20
accessed freely by the IE, no need to trap.

If a VM uses only one empty mailbox interrupt, using a dedicated=20
"shared" interrupt and disabling that in GIC could be a lighter=20
operation, we used to do that in Parker.

--Pekka

On 10/29/2018 12:39 PM, Thierry Reding wrote:
> On Mon, Oct 29, 2018 at 12:04:22PM +0200, Pekka Pessi wrote:
>> Hi Thierry,
>>
>> There is typically one entity (aux cpu or a VM running on CCPLEX) owning=
 the
>> "empty" or producer side of mailbox (iow, waking up on empty) and anothe=
r
>> entity owning the "full" or consumer side of mailbox (waking up on full)=
. An
>> entity should not muck with the interrupts used by the opposite side.
> Okay, that explains some of my observations. I was initially trying to
> program interrupt enables for both FULL and EMPTY interrupts for all
> mailboxes, but then I'd usually get timeouts because the consumer wasn't
> responding (i.e. the SPE wasn't getting FULL interrupts for the CCPLEX's
> TX mailbox).
>
> If I understand correctly, you're saying that the CPU should only be
> using the EMPTY interrupts for it's TX mailbox (while leaving the FULL
> interrupts completely untouched) and only the FULL interrupt for it's
> RX mailbox (while leaving the EMPTY interrupts untouched). This is a bit
> of a problem because the mailbox driver doesn't really know anything
> about the direction when it starts up, so how would it make the decision
> about how to program the registers?
>
>> One entity typically owns one shared interrupt only.=C2=A0 For the
>> BPMP/SCE/RCE/SPE HSP blocks the shared interrupt 0 is owned by the auxil=
iary
>> processor itself, the shared interrupts 1..4 are connected to LIC and ar=
e
>> available to other entities. The convention is to go through the interru=
pts
>> 0..4 and then using the first available shared interrupt for both full a=
nd
>> empty.
> That partially matches another of my observations. It seems like we
> can't use the shared interrupt 0 at all on at least the AON HSP. That's
> fine because that HSP instance contains the TX mailbox for TCU and by
> the current convention in the HSP driver, shared interrupt 0 would be
> aggregating the FULL interrupts, which according to the above we don't
> need for TX mailboxes.
>
> What's somewhat surprising is that you're saying that both FULL and
> EMPTY interrupts should be handled by the same shared interrupt. That's
> the opposite of what the recommended programming sequence is that the
> TRM specifies. Why is it better to handle both FULL and EMPTY interrupts
> with the same shared interrupt?
>
>> The interrupt functions should use a mask for mailboxes owned by kernel =
(in
>> essence what the IE register should be for the HSP shared interrupt owne=
d by
>> the kernel) and serve only those mailboxes owned by kernel. Note that th=
ere
>> is no reset for HSP in Xavier, and the IE register contents may be stale=
.
> Would it be safe to clear all of the IE registers to 0 on driver probe?
> I seem to remember trying to do that and getting similar behaviour to
> what I describe above, namely that interrupts on the SPE weren't working
> anymore. I concluded that the IE register must be shared between the
> various processors, even though that's somewhat suprising given that
> there is no way to synchronize accesses to those registers, so their
> programming would be somewhat up to chance.
>
> Do you know any more about these registers? If they are indeed separate
> for each processor, it should be fairly easy to keep track of the
> mailboxes used by the kernel and process only those. Again I don't know
> how exactly to distinguish between TX and RX mailboxes because they all
> start out the same and only their use defines which direction they go.
> Currently this works because we program them as consumers by default.
> That means we enable the FULL interrupts but keep EMPTY interrupts
> disabled until a message in transmitted on the mailbox, at which point
> we enable the EMPTY interrupt. I suppose at that point we should also
> disable the FULL interrupt, given the above discussion.
>
>> And lastly, if we want to support only Xavier and later, perhaps we shou=
ld
>> be more clear in the bindings? There are no mailbox-specific interrupt
>> enable registers available on Parker and your design relies on them.
> That was certainly not the intention. I thought I had seen the per-
> mailbox interrupt enable registers also in Tegra186 documentation, but
> after double-checking they're indeed not there. I don't think the driver
> currently "relies" on them because it uses them in addition to the
> HSP_IE registers. I suppose that accessing them might cause aborts on
> Tegra186 if they don't exist, though.
>
> I'm not entirely clear on what the advantages are of using the per-
> mailbox registers, or how they are supposed to be used. The existing
> documentation doesn't really explain how these are supposed to be used
> either, so I was mostly just going by trial and error.
>
> Do you know anything more on how to use these registers? I can easily
> make them Tegra194 specific in the code, but if they're aren't any clear
> advantages, it might just be easier to stick with HSP_IE programming
> only.
>
> Thierry

