Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D427C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 10:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8F9208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 10:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="KyhZpm5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8F9208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbeLHK3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 05:29:11 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:12799 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeLHK3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 05:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1544264948;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=KTXuyewgr8kDWrlNEr8gOP2nYPtR6uHStBvCXYAIu+c=;
        b=KyhZpm5rAaFh3gEDAH9ig/Areud021YokwZKj5Wxwn4Z3BjNtlAyOB+d+OQpl3u+/a
        NYnnBxm9Ujcfm2fSyTKiW6omBGtF0NgVD/GEvzcN0UeSKdI5P08IpA8rzdBL4SJ7RQtT
        IqocrF4GTlKATnLnPH5yCwsf9VWyKWw5DHou/AXTT/wyaU7CUn3PzN9RrKf3phXZguUB
        mGbt25TRXymudekXyGYTDsHyc/rlPWue5mSZHwcNlBKRY4cErkB/iI5zyuJ+SJ1Dx05R
        RTId+4+UjUDHr7Z5ZSOU/if/gj+ZnGVVfrMMR8ZX6aoB7QxjQXKi0zgYY58Ws9FVBU2R
        QaeA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7Cldhk6vuOP1NBxRkB4aV+VIXkb+"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:b8f0:8684:6e60:563]
        by smtp.strato.de (RZmta 44.6 AUTH)
        with ESMTPSA id 404b20uB8AT6wYj
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 8 Dec 2018 11:29:06 +0100 (CET)
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
 <5a2ea855-b4b0-e48a-5c3e-c859a8451ca2@xenosoft.de>
 <7B6DDB28-8BF6-4589-84ED-F1D4D13BFED6@xenosoft.de>
Message-ID: <8a2c4581-0c85-8065-f37e-984755eb31ab@xenosoft.de>
Date:   Sat, 8 Dec 2018 11:29:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <7B6DDB28-8BF6-4589-84ED-F1D4D13BFED6@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next step: 7ebc44c535f6bd726d553756d38b137acc718443 (powerpc/dma: remove 
max_direct_dma_addr)

git checkout 7ebc44c535f6bd726d553756d38b137acc718443

OK, the PASEMI onboard ethernet works and the P5020 board boots.

-- Christian


On 07 December 2018 at 7:33PM, Christian Zigotzky wrote:
> Next step: 13c1fdec5682b6e13257277fa16aa31f342d167d (powerpc/dma: move pci_dma_dev_setup_swiotlb to fsl_pci.c)
>
> git checkout 13c1fdec5682b6e13257277fa16aa31f342d167d
>
> Result: The PASEMI onboard ethernet works and the P5020 board boots.
>
> — Christian


