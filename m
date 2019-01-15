Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BFCC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C28C20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388713AbfAOTK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:10:59 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43470 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729921AbfAOTK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:10:58 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gjU6w-0003UL-2a; Tue, 15 Jan 2019 20:10:54 +0100
Date:   Tue, 15 Jan 2019 20:10:53 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Huacai Chen <chenhc@lemote.com>
cc:     linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, stable@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Michael Hernandez <michael.hernandez@cavium.com>
Subject: Re: [PATCH] genirq/affinity: Assign default affinity to pre/post
 vectors
In-Reply-To: <1546225404-6775-1-git-send-email-chenhc@lemote.com>
Message-ID: <alpine.DEB.2.21.1901151959060.1655@nanos.tec.linutronix.de>
References: <1546225404-6775-1-git-send-email-chenhc@lemote.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Dec 2018, Huacai Chen wrote:

> Generally, irq_create_affinity_masks() assign default affinity to pre/
> post vectors correctly. However, it ignore the case that there are only
> pre/post vectors (when nvecs == affd->pre_vectors + affd->post_vectors)
> and return NULL. This case usually happens when nvecs = 1 (e.g. in nvme
> driver when MSI-X is unavailable and fallback to MSI) and will trigger
> the warning in pci_irq_get_affinity(). This patch fix the corner case.

Errm. This is just wrong. When this function returns NULL, then it has
failed and the caller or any subsequent code is not supposed to use the
result.

The function can return NULL for other reasons, e.g. when the memory
allocation failed. How are you going to duct tape that one?

Thanks,

	tglx
