Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE85C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26501208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="FGvNxe8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26501208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeLGNpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:45:11 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:15681 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeLGNpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1544190308;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=UiKdQhFyjWHE4+ZgL57zQt5agzEVXV1R1L+vfpWOKek=;
        b=FGvNxe8h5ngT4RxATsvDrjDfdmplxnIUNwqrP/02AKwSQoOqenZthknLAL3eyfmB2D
        yenAfZ3QQAUfbPwAsHSet1dcl+pdSE8036ttPzl+OUcIki4W7ltkMuLNsYGY5GNfTELI
        rfQxfYc7qfLbCfv8bKaJDTMENmiPXwO/5Qaww8B7iyQ9o8F896/nOq+YBCSpi5WR4OlZ
        3+dE8UX/kY4iCv8CgwsLhvwHL5oYk1heuqz5VgdgbRxpGW5mBF2wwb9gKD7fFtCHXN11
        8OsvyXb+lwC+FpudEuWFhdCQr1upkQaI42P62NMH1h5U8DS67T/MAg8kw2+GECDPU5cS
        PODA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkMj+ByMwaeBc+kslmr1FsvPSMWMA=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:3119:8549:9ee9:a01b]
        by smtp.strato.de (RZmta 44.6 AUTH)
        with ESMTPSA id 404b20uB7Dj6ssM
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 7 Dec 2018 14:45:06 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
References: <20181129170351.GC27951@lst.de>
 <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de>
 <20181130105346.GB26765@lst.de>
 <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de>
 <20181130131056.GA5211@lst.de>
 <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de>
 <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de>
 <58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de>
 <20181204142426.GA2743@lst.de>
 <ef56d279-f75d-008e-71ba-7068c1b37c48@xenosoft.de>
 <20181205140550.GA27549@lst.de>
 <1948cf84-49ab-543c-472c-d18e27751903@xenosoft.de>
Message-ID: <5a2ea855-b4b0-e48a-5c3e-c859a8451ca2@xenosoft.de>
Date:   Fri, 7 Dec 2018 14:45:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <1948cf84-49ab-543c-472c-d18e27751903@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 December 2018 at 11:55AM, Christian Zigotzky wrote:
> On 05 December 2018 at 3:05PM, Christoph Hellwig wrote:
>>
>> Thanks.  Can you try a few stepping points in the tree?
>>
>> First just with commit 7fd3bb05b73beea1f9840b505aa09beb9c75a8c6
>> (the first one) applied?
>>
>> Second with all commits up to 5da11e49df21f21dac25a2491aa788307bdacb6b
>>
>> And if that still works with commits up to
>> c1bfcad4b0cf38ce5b00f7ad880d3a13484c123a
>>
> Hi Christoph,
>
> I undid the commit 7fd3bb05b73beea1f9840b505aa09beb9c75a8c6 with the 
> following command:
>
> git checkout 7fd3bb05b73beea1f9840b505aa09beb9c75a8c6
>
> Result: PASEMI onboard ethernet works again and the P5020 board boots.
>
> I will test the other commits in the next days.
>
> @All
> It is really important, that you also test Christoph's work on your 
> PASEMI and NXP boards. Could you please help us with solving the issues?
>
> 'git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.5 a'
>
> Thanks,
> Christian
>
>
Today I tested the commit 5da11e49df21f21dac25a2491aa788307bdacb6b.

git checkout 5da11e49df21f21dac25a2491aa788307bdacb6b

The PASEMI onboard ethernet works and the P5020 board boots.

-- Christian

