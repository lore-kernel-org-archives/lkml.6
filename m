Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32026C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 05:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04CC222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 05:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ETWGqc2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbfBMFzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 00:55:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37934 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730072AbfBMFzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 00:55:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sjarOO1fM7fl0IqS8UEWhDa9GK/T3fwQucCxiPQdsug=; b=ETWGqc2Mz6K29m6ztE7p4C7Hx
        v3WtDxQVbKYoFwFAws/oKdUtRcjJc4jq8YAW3NUxtgJ+0vQEJjvjlL7VEumfkgFGckh3Aa3/LNVTd
        pSH0uese0c4ZONMd9KrGCPJkMAAiL63aRdFe21yuUnBsIpz3fkUToc9ulQLXDzKTVaVYC2Si7kyPg
        THehrx0wIAaLOslYqSBXNydOPh9SuxiNSLLmkCfzO2GxKuBjxAXX52ZbcHl0sIzAMpI1BWU9tBJNj
        VNbwDHIIz6+VsVAD5V6LG9swtMhxiuochHT69j8a8JAbmjkXxTak8YEw/D5P89EfDiQi/JsLERPMH
        5mBkY/KlQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtnVm-0002mt-6O; Wed, 13 Feb 2019 05:55:10 +0000
Date:   Tue, 12 Feb 2019 21:55:10 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 6/6] RISC-V: Implement keepinitrd kernel parameter
Message-ID: <20190213055510.GA5725@infradead.org>
References: <20190119132650.9978-1-anup.patel@wdc.com>
 <20190119132650.9978-7-anup.patel@wdc.com>
 <20190212070807.GD26747@infradead.org>
 <CAAhSdy1NED22YyYrAJDqPkDqT1c2ms2QC9OjHP0qLwHT+o2zvg@mail.gmail.com>
 <20190212184505.GA10984@infradead.org>
 <MN2PR04MB60615E8737B56B1B213B5FA58D660@MN2PR04MB6061.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR04MB60615E8737B56B1B213B5FA58D660@MN2PR04MB6061.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 03:43:06AM +0000, Anup Patel wrote:
> Sure, the keepinitrd=0 by default so it will always free-up initrd by default.
> Please look at v3 patchset.
> 
> Of course, we need separate patch to update documentation of keepinitrd.

No, we need to not just blindly copy what arm did for historic reasons
unless we have a very good reason of our own.

In addition to not having a real need for any of this in a new setup,
it also is duplicated by the retain_initrd parameter which is
implemented in generic code - and for that the commit message at least
has a rationale related to kexec:

https://lkml.org/lkml/2006/12/7/15
