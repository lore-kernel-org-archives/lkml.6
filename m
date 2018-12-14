Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACA1C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD81A2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="CaWViC+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD81A2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbeLNMAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:00:31 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:24848 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeLNMAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:00:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1544788829;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=xBTeoa4ZN9PkmfHkyE6pTdQ3wVl6WnvOhCxnUoeERI0=;
        b=CaWViC+b85hiIa+rQcIMWi1EkBMqCpIAiSwc/yRNI1ssoVDuySR+f9FhhJl7M0gcYV
        5Sx7jraogEVaWwo1+hZKbrLolJznDECz8RmGl8C21PIFxz8x5dtGftwNglWdXS/WZjc4
        83AeAOzjMNtAcRiLw56odn4lUlGCBFxi0oiomPH4SoT3sEnvrrfug30pwm2h28WWQVlW
        AT7RFAWPVK6tyXlSw+eXoAEs4QsZDHzNUumVTqkb2ENnq3/V0Qe5xu/J2UXw4n4HuJMU
        xyZE7n6tShK42qGf1sPfJZ72bThmKuX/wJj1lmK69dDwgi0xfUzctg8RtI2EtedJv97S
        gsUw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkGiwyXDxjMeBKNVg1uDFdnFXWLiw=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:95fc:25d2:69b8:b3cf]
        by smtp.strato.de (RZmta 44.8 AUTH)
        with ESMTPSA id e03c1euBEC0R7e2
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 14 Dec 2018 13:00:27 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
References: <1ecb7692-f3fb-a246-91f9-2db1b9496305@xenosoft.de>
 <6c997c03-e072-97a9-8ae0-38a4363df919@xenosoft.de>
 <4cfb3f26-74e1-db01-b014-759f188bb5a6@xenosoft.de>
 <82879d3f-83de-6438-c1d6-49c571dcb671@xenosoft.de>
 <20181212141556.GA4801@lst.de>
 <2242B4B2-6311-492E-BFF9-6740E36EC6D4@xenosoft.de>
 <84558d7f-5a7f-5219-0c3a-045e6b4c494f@xenosoft.de>
 <20181213091021.GA2106@lst.de>
 <835bd119-081e-a5ea-1899-189d439c83d6@xenosoft.de>
 <76bc684a-b4d2-1d26-f18d-f5c9ba65978c@xenosoft.de>
 <20181213112511.GA4574@lst.de>
 <e109de27-f4af-147d-dc0e-067c8bafb29b@xenosoft.de>
 <ad5a5a8a-d232-d523-a6f7-e9377fc3857b@xenosoft.de>
 <e60d6ca3-860c-f01d-8860-c5e022ec7179@xenosoft.de>
Message-ID: <008c981e-bdd2-21a7-f5f7-c57e4850ae9a@xenosoft.de>
Date:   Fri, 14 Dec 2018 13:00:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <e60d6ca3-860c-f01d-8860-c5e022ec7179@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 December 2018 at 3:15PM, Christoph Hellwig wrote:
 > Thanks for bisecting.  I've spent some time going over the conversion
 > but can't really pinpoint it.  I have three little patches that switch
 > parts of the code to the generic version.  This is on top of the
 > last good commmit (977706f9755d2d697aa6f45b4f9f0e07516efeda).
 >
 > Can you check with whіch one things stop working?

Hello Christoph,

Great news! All your patches work!

I tested all your patches (including the patch '0004-alloc-free.patch' 
today) and the PASEMI onboard ethernet works and the P5020 board boots 
without any problems. Thank you for your work!
I have a few days off. That means, I will work less and only for the 
A-EON first level Linux support. I can test again on Thursday next week.

Have a nice weekend!

Cheers,
Christian
