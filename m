Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FA3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3A8204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Kqy1QRcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfANSBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:01:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35036 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbfANSBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:01:50 -0500
Received: from zn.tnic (p200300EC2BC4CA000555087DEC7D7788.dip0.t-ipconnect.de [IPv6:2003:ec:2bc4:ca00:555:87d:ec7d:7788])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2316D1EC0AEA;
        Mon, 14 Jan 2019 19:01:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547488908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=G9b4au4VAWxHUcbA2ouvVkbeuEWRynZFBPq/8nrSnBk=;
        b=Kqy1QRcgeCOUyoUDfDsW7Q8yUvpoF6VhQtcyJouPIOcrFaGzRFDl2QiocaEegFn9BDYNS2
        3QK1bpZXJQhNjTZqY76Txcwohx1+T7S8RzT14b5NCiwjx8bH0js+hrFbeNFBBt52fFUPaM
        tfo2nzIbUy5brsfcSUpGVgsenS25UbM=
Date:   Mon, 14 Jan 2019 19:01:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc:     Lianbo Jiang <lijiang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "anderson@redhat.com" <anderson@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
Message-ID: <20190114180142.GO2773@zn.tnic>
References: <20190110121944.6050-1-lijiang@redhat.com>
 <20190110121944.6050-2-lijiang@redhat.com>
 <20190111123300.GE4729@zn.tnic>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035661E8@BPXM09GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC035661E8@BPXM09GP.gisp.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 05:48:48PM +0000, Kazuhito Hagio wrote:
> As for makedumpfile, it will be not impossible to remove the
> init_uts_ns.name.relase (OSRELEASE), but some fixes are needed.
> Because historically OSRELEASE has been a kind of a mandatory entry
> in vmcoreinfo from the beginning of vmcoreinfo, so makedumpfile uses
> its existence to check whether a vmcoreinfo is sane.

Well, init_uts_ns is exported in vmcoreinfo anyway - makedumpfile
can simply test init_uts_ns.name.release just as well. And the
"historically" argument doesn't matter because vmcoreinfo is not an ABI.

So makedumpfile needs to be changed to check that new export.

> Also, I think crash also will need to be fixed if it is removed.

Yes, I'm expecting user tools to be fixed and then exports removed.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
