Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB54FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA4A222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B/AammYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbfBLSpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:45:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbfBLSpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wU07qB9XQlS0d1djNaIi1on+8sJFmtyguN+9hQA20ao=; b=B/AammYDfpPF5UfB+jK408ufC
        KwEHJjkA1tuXXXCP6+xREUOQpdFBMNqA2clb2mk76d+XPRpn9WJLA9+2a3e4w168cagmFyJ7SiRCc
        KBRclTiT5yENHBp3fP9+wJpMgK5vBIYpFpEq3WaHHZKCIDzaWewIMcziPqbDCv3TRHsSgamkikB0h
        DB2tV2fLETqDv5EVkKILMACntcQvSYsySvGXaAxt5I7WNVPKHkmKSL5dzLjIKHOdSOK/Xlu++tAcR
        LUFYN1C5FktDUFwMXI9OdzuznThEq2+U3H/QBS5ycLICEt0fms2pOcMXahNtaFhNOA3q4PBA/t4fs
        kIxpOjhqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtd3J-0004X1-8H; Tue, 12 Feb 2019 18:45:05 +0000
Date:   Tue, 12 Feb 2019 10:45:05 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 6/6] RISC-V: Implement keepinitrd kernel parameter
Message-ID: <20190212184505.GA10984@infradead.org>
References: <20190119132650.9978-1-anup.patel@wdc.com>
 <20190119132650.9978-7-anup.patel@wdc.com>
 <20190212070807.GD26747@infradead.org>
 <CAAhSdy1NED22YyYrAJDqPkDqT1c2ms2QC9OjHP0qLwHT+o2zvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy1NED22YyYrAJDqPkDqT1c2ms2QC9OjHP0qLwHT+o2zvg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 03:53:21PM +0530, Anup Patel wrote:
> If it is initramfs (i.e. CPIO image) then contents of CPIO archive
> are extracted to create a ramfs instance.
> 
> If it is initrd (i.e. some filesystem image) then RAM block device
> is created in-place at initrd location. (Please correct me if I am
> wrong about initrd here).

No.  If it is an initrd image we still copy it into the rootfs first,
and then load it into a ram disk.  Take a look at
init/initramfs.c:populate_rootfs() and
init/do_mounts_initrd.c:initrd_load().

> So in case of initrd we might not want to free-up the RAM but
> we can certainly free-up in case of initramfs.

No, in either case we do not need the original initramfs/initrd
memory.  I suspect arm has this as a workaround for some weird
legacy boot issue, but I can't see any reason why we would not want
to free the memory on riscv.
