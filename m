Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13807C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171712087F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="T9s9oG6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171712087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbeLMJrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:47:24 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:21286 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbeLMJrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1544694441;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=OgkIjYTVAghMHYNbTQQs7wlhsYtJAPI86xVTVQ+Yu8w=;
        b=T9s9oG6JjUO6rPO99wNShRgsSoOw8ADJpueSloiAc6Su9MohDwK1FCido8PWeAwB1c
        yIiEoiMsw9dOmMd3gk1ryLh/wWkH68fIxYHqnDDgJzihibyAUmoLcTz9fIY9q7k1L3XW
        +g4L/9GHkKOqLHgI5N6QkX8JQ272kzTqrrCWNl/vmwhPs9vAcYAIsDXmsZ+t3Jm5XMNn
        2I+4iUOcgi/0skD+pWcNEVUzlFt6ogJVmIhLGzAUIU1vMaHYgLTR4iUxQNF9yfIy5Z+r
        z60IyNmGggmMk0C7b/IOJBDcEqNNygZFwS/pcmXfesuWhs5Jj9wbLKWCA698Fw4gjbRo
        mDxw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkH2j1S+d7f+qCRMaRzyLzUgdHjSA=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:8d43:e6ec:d963:b7de]
        by smtp.strato.de (RZmta 44.8 AUTH)
        with ESMTPSA id e03c1euBD9lJ0Qm
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 13 Dec 2018 10:47:19 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
References: <8a2c4581-0c85-8065-f37e-984755eb31ab@xenosoft.de>
 <424bb228-c9e5-6593-1ab7-5950d9b2bd4e@xenosoft.de>
 <c86d76b4-b199-557e-bc64-4235729c1e72@xenosoft.de>
 <1ecb7692-f3fb-a246-91f9-2db1b9496305@xenosoft.de>
 <6c997c03-e072-97a9-8ae0-38a4363df919@xenosoft.de>
 <4cfb3f26-74e1-db01-b014-759f188bb5a6@xenosoft.de>
 <82879d3f-83de-6438-c1d6-49c571dcb671@xenosoft.de>
 <20181212141556.GA4801@lst.de>
 <2242B4B2-6311-492E-BFF9-6740E36EC6D4@xenosoft.de>
 <84558d7f-5a7f-5219-0c3a-045e6b4c494f@xenosoft.de>
 <20181213091021.GA2106@lst.de>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <835bd119-081e-a5ea-1899-189d439c83d6@xenosoft.de>
Date:   Thu, 13 Dec 2018 10:47:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181213091021.GA2106@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 December 2018 at 10:10AM, Christoph Hellwig wrote:
> On Thu, Dec 13, 2018 at 09:41:50AM +0100, Christian Zigotzky wrote:
>> Today I tried the first patch (0001-get_required_mask.patch) with the last
>> good commit (977706f9755d2d697aa6f45b4f9f0e07516efeda). Unfortunately this
>> patch is already included in the last good commit
>> (977706f9755d2d697aa6f45b4f9f0e07516efeda). I will try the next patch.
> Hmm, I don't think this is the case.  This is my local git log output:
>
> commit 83a4b87de6bc6a75b500c9959de88e2157fbcd7c
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Wed Dec 12 15:07:49 2018 +0100
>
>      get_required_mask
>
> commit 977706f9755d2d697aa6f45b4f9f0e07516efeda
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Sat Nov 10 22:34:27 2018 +0100
>
>      powerpc/dma: remove dma_nommu_mmap_coherent
>
> I've also pushed a git branch with these out to:
>
>      git://git.infradead.org/users/hch/misc.git powerpc-dma.5-debug
>
Sorry Christioph. I was wrong. The first patch isn't included in the 
last good commit. I will try it again. I can only test beside my main 
work. That means it takes longer.

-- Christian

