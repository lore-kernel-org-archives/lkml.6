Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4991CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1B6206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WHMWYofX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1B6206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387564AbeKFQUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 11:20:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52744 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387421AbeKFQUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 11:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IZwOvmjjUlEO3jNq8d0zAYL8Ydod4au5p5x+p1pS3pU=; b=WHMWYofXrxWGe/PelLdeCUpXU
        zDihoruFtC1fQzr+Cmgi6xWD3G+dRecbMJL5g1sTF5JNNROg0dSvQet4Zp276UDFEhUTkCLlAcTgT
        BT1yBRzKOiyNc/Hsc50l1XEmiZqCHyoPSGBNyu5iAHsdoe+TIwLsH73BE+efxsYLZHALVKLM33tGl
        36BAbWiomQgBi+sFvscd6yjpvF2TUhW0QRaPUWrX6XT+/u4IWiJG9WZfXKZf54+TXieOPcRV8sWOZ
        C5QiDNahSFeV8wxOZQxkP+Hsz5pYKSL8iwAMHoYrklKc+yAsrVPRx0fkn9ETkzNjJrAEKi6A8lFrb
        HYmAK6xaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJvI9-0004nh-QB; Tue, 06 Nov 2018 06:56:49 +0000
Date:   Mon, 5 Nov 2018 22:56:49 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Vincent Chen <vincentc@andestech.com>, aou@eecs.berkeley.edu,
        arnd@arndb.de, alankao@andestech.com, greentime@andestech.com,
        palmer@sifive.com, linux-kernel@vger.kernel.org,
        zong@andestech.com, linux-riscv@lists.infradead.org,
        deanbo422@gmail.com
Subject: Re: [RFC 0/2] RISC-V: A proposal to add vendor-specific code
Message-ID: <20181106065649.GA13526@infradead.org>
References: <1540982130-28248-1-git-send-email-vincentc@andestech.com>
 <cac10a0961274e3ac4674e945f9d9e90@mailhost.ics.forth.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cac10a0961274e3ac4674e945f9d9e90@mailhost.ics.forth.gr>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 09:39:29PM +0200, Nick Kossifidis wrote:
> a) By directly modifying your custom CSRs, it means that we will need
> compiler support in order to compile a kernel with your code in it. This
> will break CI systems and will introduce various issues on testing and
> reviewing your code. In general if we need custom toolchains to compile
> the kernel, that may be unavailable (vendors will not always open source
> their compiler support), we won't be able to maintain a decent level of
> code quality in the tree. How can the maintainer push your code on the
> repository if he/she can't even perform a basic compilation test ?

And that (besides avoiding the wild growth of extensions) is the major
reason why accepting vendor specific CSRs or instructions is a no-go.
