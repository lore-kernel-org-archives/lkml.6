Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA18C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FA220866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403860AbfAPJ0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:26:23 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44440 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbfAPJ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:26:23 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gjhSk-00042m-G9; Wed, 16 Jan 2019 10:26:18 +0100
Date:   Wed, 16 Jan 2019 10:26:17 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     =?GB2312?B?s8K7qrLF?= <chenhc@lemote.com>
cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Michael Hernandez <michael.hernandez@cavium.com>
Subject: Re: [PATCH] genirq/affinity: Assign default affinity to pre/post
 vectors
In-Reply-To: <tencent_7CB943266ADCFDB06DDDE6EF@qq.com>
Message-ID: <alpine.DEB.2.21.1901161016270.1655@nanos.tec.linutronix.de>
References: <1546225404-6775-1-git-send-email-chenhc@lemote.com> <alpine.DEB.2.21.1901151959060.1655@nanos.tec.linutronix.de> <tencent_7CB943266ADCFDB06DDDE6EF@qq.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-392514603-1547630778=:1655"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-392514603-1547630778=:1655
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

Chen,

On Wed, 16 Jan 2019, 陈华才 wrote:

please do not top-post and use line breaks around 78 char.

> I'm not removing all return NULL of irq_create_affinity_masks(), so the ......

Moved content to the place where it belongs so the context is preserved.

> ------------------ Original ------------------
> From:  "Thomas Gleixner"<tglx@linutronix.de>;
> Date:  Wed, Jan 16, 2019 03:10 AM
> To:  "Huacai Chen"<chenhc@lemote.com>;
> Cc:  "linux-kernel"<linux-kernel@vger.kernel.org>; "Fuxin Zhang"<zhangfx@lemote.com>; "wuzhangjin"<wuzhangjin@gmail.com>; "stable"<stable@vger.kernel.org>; "Christoph Hellwig"<hch@lst.de>; "Michael Hernandez"<michael.hernandez@cavium.com>;
> Subject:  Re: [PATCH] genirq/affinity: Assign default affinity to pre/post vectors

And please configure your e-mail client to NOT copy the full headers into
the reply.

> > On Mon, 31 Dec 2018, Huacai Chen wrote:
> > 
> > > Generally, irq_create_affinity_masks() assign default affinity to pre/
> > > post vectors correctly. However, it ignore the case that there are only
> > > pre/post vectors (when nvecs == affd->pre_vectors + affd->post_vectors)
> > > and return NULL. This case usually happens when nvecs = 1 (e.g. in nvme
> > > driver when MSI-X is unavailable and fallback to MSI) and will trigger
> > > the warning in pci_irq_get_affinity(). This patch fix the corner case.
> > 
> > Errm. This is just wrong. When this function returns NULL, then it has
> > failed and the caller or any subsequent code is not supposed to use the
> > result.
> > 
> > The function can return NULL for other reasons, e.g. when the memory
> > allocation failed. How are you going to duct tape that one?
>
> I'm not removing all return NULL of irq_create_affinity_masks(), so the 
> memory allocation failure still return NULL. I just handle the case that
> there are not enough irq vectors. E.g. in nvme driver, the caller may call
> irq_create_affinity_masks() with nvecs=1,pre_vectors=1,post_vectors=0. In
> this case, the only one vector's default affinity assigning is skipped.

I did not say that you removed all NULL returns. I said that this function
can return NULL for other reasons and then the same situation will happen.

If the masks pointer returned is NULL then the calling code or any
subsequent usage needs to handle it properly. Yes, I understand that this
change makes the warning go away for that particular case, but that's not
making it any more correct.

Thanks,

	tglx


--8323329-392514603-1547630778=:1655--
