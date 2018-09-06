Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7526EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD4D2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kbCgnzq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD4D2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeIFOuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:50:16 -0400
Received: from m12-13.163.com ([220.181.12.13]:49338 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbeIFOuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=q+E43
        1o3NMLjxkTMQ6dbM95VNMH3rFUn+KLt95/vyag=; b=kbCgnzq88dSWjQRUHuyfM
        FiNXOWAlbOeL6RQK29Xof30tm9gzJqYWcwgBW4Gx9ygKIsWuvGFesD6AeiFwGUUG
        u23gpAAJIxUeysknAoHGlwkqFnQ67p9JxWjHIgW0gCdGDD16AJwUWc+9oncVjsOW
        Mix+LXEfITL+/HdZ6+ZZBg=
Received: from localhost.localdomain (unknown [49.65.59.196])
        by smtp9 (Coremail) with SMTP id DcCowADHSX4a_pBbMYdbIg--.61270S2;
        Thu, 06 Sep 2018 18:14:51 +0800 (CST)
Subject: Re: Affinity managed interrupts vs non-managed interrupts
To:     Thomas Gleixner <tglx@linutronix.de>,
        Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        linux-block <linux-block@vger.kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com>
 <20180829084618.GA24765@ming.t460p>
 <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com>
 <CACVXFVM7nGxpyq0_jfshgBOTx5B+PuCDmN43SfPTCkENJRLpMg@mail.gmail.com>
 <615d78004495aebc53807156d04d988c@mail.gmail.com>
 <alpine.DEB.2.21.1808312207390.1349@nanos.tec.linutronix.de>
 <486f94a563d63c4779498fe8829a546c@mail.gmail.com>
 <alpine.DEB.2.21.1809010020520.1349@nanos.tec.linutronix.de>
 <602cee6381b9f435a938bbaf852d07f9@mail.gmail.com>
 <alpine.DEB.2.21.1809021357000.1349@nanos.tec.linutronix.de>
 <66256272c020be186becdd7a3f049302@mail.gmail.com>
 <alpine.DEB.2.21.1809031719460.1383@nanos.tec.linutronix.de>
 <dd1c5df55aa99cf4a37bcc58e77e840a@mail.gmail.com>
 <f436fa6a-b865-fadb-4f77-44309ff84405@163.com>
 <c0f779f1d5ef131c39f9397f97d453e8@mail.gmail.com>
 <alpine.DEB.2.21.1809051235180.1416@nanos.tec.linutronix.de>
From:   Dou Liyang <dou_liyang@163.com>
Message-ID: <d2a6f7cf-31df-de17-82e3-eccb9cc73ed8@163.com>
Date:   Thu, 6 Sep 2018 18:14:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809051235180.1416@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: DcCowADHSX4a_pBbMYdbIg--.61270S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUDEfOUUUUU
X-Originating-IP: [49.65.59.196]
X-CM-SenderInfo: pgrxszxl1d0wi6rwjhhfrp/1tbiOQ64olXlg2nwawABst
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

At 09/05/2018 06:38 PM, Thomas Gleixner wrote:
> Oh well. This was not intended to magically provide the solution you want
> to have. It merily changed the behaviour of the managed interrupt
> selection, which is a valid thing to do independent of the stuff you want
> to see.
> 

Thank you for clarifying it, I will send the patch independently.

> As I said that needs more thought and I really can't tell when I have a
> time slot to look at that.
> 

In this period, I am willing to be a volunteer to try to do that you
said in the previous reply. May I?


Thanks
	dou

