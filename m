Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42483C65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33E820700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DnMjz38Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33E820700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbeLFPD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:03:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeLFPD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1Ww/RtAgrRIH6lz2Y8vYaAIvbz9EYN+kMxq+fYs0Tlw=; b=DnMjz38YhyM7PLXhdeLObvURP
        JFeTpmgs2ZwbDa7eNFJHD14PdgsM9CV2tPU8RqzROvL9wlqmr6bK3dLhEXfTvlzVFYfQZmrrdpTFW
        LVdAKSFw5vTPAKbxgA5D+uufgT92OWm6YMexiRoiYu5ItAJM838GjbUizzO4t/yDVAo0CKriW9Ms8
        jJ14gvvvDivnMnro4WTt1hAkCOhd2zwjAsElYLNpvACeeO2It+uMNjmTebBYMnW5fIw0rwdiN2Bjg
        3JV45NvYx9xhfc7a8sMs3lcr2Kxo2Fxm+Xl1lBW1YiYCEQ+nvebKobsgJHhXc20IIKAgafwuRXudN
        kiv695RrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUvBV-0000uP-EY; Thu, 06 Dec 2018 15:03:25 +0000
Date:   Thu, 6 Dec 2018 07:03:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH 2/3] kbuild: generate asm-generic wrappers if mandatory
 headers are missing
Message-ID: <20181206150325.GA2726@infradead.org>
References: <1544009286-15705-1-git-send-email-yamada.masahiro@socionext.com>
 <1544009286-15705-2-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544009286-15705-2-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 08:28:05PM +0900, Masahiro Yamada wrote:
> Some time ago, Sam pointed out a certain degree of overwrap between
> generic-y and mandatory-y. (https://lkml.org/lkml/2017/7/10/121)
> 
> I a bit tweaked the meaning of mandatory-y; now it defines the minimum
> set of ASM headers that all architectures must have.
> 
> If arch does not have specific implementation of a mandatory header,
> Kbuild will let it fallback to the asm-generic one by automatically
> generating a wrapper. This will allow to drop lots of redundant
> generic-y defines.
> 
> Previously, "mandatory" was used in the context of UAPI, but I guess
> this can be extended to kernel space ASM headers.

How useful is it to keep the generic-y behavior around at all vs making
everything useful mandatory?
