Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045AFECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 06:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BD52084A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 06:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqpYTfs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BD52084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeGUG6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 02:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbeGUG6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 02:58:50 -0400
Received: from [172.20.7.115] (unknown [209.119.211.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CC702084A;
        Sat, 21 Jul 2018 06:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532153241;
        bh=dTDFkzkrG0pF8huYc0BkeN+MXOTTQ0oUcQ0wSpJ20uE=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=uqpYTfs6jry3ORWeWR7h8dL8PWErvxAhPK6UTqW2mMuyA90KbQNCkm8Q3l+jGSqER
         Wg+FrgXAqtkwq0gO+k7Pw/YIXea0v/ZqcTC37fAA9+Ikiey014f/BKdrNQUj96snYG
         +vCcnvf0Mx5mlPSPZ6DBC54EowG4IJwZDhe2LRG0=
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
From:   Sinan Kaya <okaya@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
References: <CAK9iUCM=zWexWow9TwkRfO186Hwr5WyGy0NHZF1vtXn3wbbZGQ@mail.gmail.com>
 <12fc8de5-ff03-cb00-52cb-25a43c71d03a@codeaurora.org>
 <20180708171418.GA11476@wunner.de>
 <CAK9iUCMcic5mzGiT20KNxgwPo6AuajHFsoj7GOjSht5SwrQevg@mail.gmail.com>
 <20180709160008.GA1490@wunner.de>
 <CAK9iUCMMVR114msKiMHu7ik0VK8T5j=LAYAKsEkdnocTqkdMjQ@mail.gmail.com>
 <20180720200123.GS128988@bhelgaas-glaptop.roam.corp.google.com>
 <2febe688-f973-5ff5-f61d-0451ad7d36ae@kernel.org>
Message-ID: <d34eb5da-0ae1-d455-93e2-2432ec7931ea@kernel.org>
Date:   Fri, 20 Jul 2018 23:07:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2febe688-f973-5ff5-f61d-0451ad7d36ae@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/2018 7:58 PM, Sinan Kaya wrote:
> We need to figure out how to gracefully return inside hotplug driver
> if link down happened and there is an error pending.

How about adding the following into the hotplug ISR?

1. check if firmware first is disabled
2. check if there is a fatal error pending in the device_status register
of the PCI Express capability on the root port.
3. bail out from hotplug routine if this is the case.
4. otherwise, existing behavior.
