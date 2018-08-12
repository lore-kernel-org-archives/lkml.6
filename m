Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C29C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 10:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48A2219CC
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 10:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48A2219CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeHLNdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 09:33:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727767AbeHLNdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 09:33:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2EE6D4059FE1;
        Sun, 12 Aug 2018 10:56:05 +0000 (UTC)
Received: from [10.72.12.110] (ovpn-12-110.pek2.redhat.com [10.72.12.110])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D713C2156712;
        Sun, 12 Aug 2018 10:56:01 +0000 (UTC)
Subject: Re: Problems with uio_pci_generic in v4.18-rc8
To:     "Harris, James R" <james.r.harris@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Walker, Benjamin" <benjamin.walker@intel.com>,
        "Wodkowski, PawelX" <pawelx.wodkowski@intel.com>
References: <21BF98B1-0EA5-46BC-BC68-196190880087@intel.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <7ac09d84-31bf-4d25-dba7-0a61effa2b04@redhat.com>
Date:   Sun, 12 Aug 2018 18:55:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <21BF98B1-0EA5-46BC-BC68-196190880087@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sun, 12 Aug 2018 10:56:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sun, 12 Aug 2018 10:56:05 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'xiubli@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harris,

Since the lock protection in uio irq handler is useless currently as 
discussed in the mail list, so I will revert this commit with small 
changes and now the testing based LIO/TCMU has been finished.

Thanks,
BRs


On 2018/8/11 5:12, Harris, James R wrote:
> Hi,
>   
> Using Linux kernel v4.18-rc8, I am unable to bind a PCI device to uio_pci_generic.  This works fine with v4.18-rc4.  dmesg shows:
>   
> [  336.221585] genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 33
> [  336.221681] uio_pci_generic: probe of 0000:04:00.0 failed with error -22
>   
> This problem has been reproduced on multiple systems.
>   
> This seems to be related to commit 9421e45f5 (“uio: use request_threaded_irq instead”) which was merged in -rc5.  Reverting this commit fixes the issue (I also reverted 543af5861f and 57c5f4df0a which also touch uio.c - just to be safe).
>   
> This seems like a serious regression to uio_pci_generic, but any tips or pointers would be appreciated.
>   
> Thanks,
>   
> Jim Harris
>

