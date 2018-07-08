Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCB8C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 20:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D0A208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 20:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="St6pwEMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D0A208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754373AbeGHUVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 16:21:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33440 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754335AbeGHUVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 16:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RbTNFpF9mLSP7fiyWz1dUqE2ygLku4NuycVQccFniis=; b=St6pwEMhSSmxXUsL+gkAwfJi0
        bVKLDfBPwYBnI+37jSTpkY5/5anaqFSRtYTxjSIz+Eo0yTTMyOLVnI1NRN97AQTgOax/DDIooRB5w
        OnXPRTnYtV61GvtHQ+xLc+SaHvIvBwac/svVaCl2bCoS7mMNLSUsxyCpkyd8liu7+6e9+kErpy/i1
        MlV/DnxxnWRgbhaWLF1g34OTtPMYpiHL+oqacyhLPe7b+gElzhLfKcr1ZG4Fi8hMyOEN+tO2Hhouv
        vo7KYy/5VNcHoyWrGorPbC/qiZrKAnlmg+J2w5gB0Z9PvvoNTR5U5CVIqigRynUzWUfndIlzuY53u
        ZQummrwfg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcGBc-0000Vb-OB; Sun, 08 Jul 2018 20:21:36 +0000
Date:   Sun, 8 Jul 2018 13:21:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sayali Lokhande <sayalil@codeaurora.org>
Cc:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, asutoshd@codeaurora.org,
        evgreen@chromium.org, riteshh@codeaurora.org,
        linux-scsi@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 2/2] scsi: ufs: Add configfs support for ufs
 provisioning
Message-ID: <20180708202136.GA1546@infradead.org>
References: <1530858040-13971-1-git-send-email-sayalil@codeaurora.org>
 <1530858040-13971-3-git-send-email-sayalil@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530858040-13971-3-git-send-email-sayalil@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 11:50:40AM +0530, Sayali Lokhande wrote:
> This patch adds configfs support to provision ufs device at
> runtime. This feature can be primarily useful in factory or
> assembly line as some devices may be required to be configured
> multiple times during initial system development phase.
> Configuration Descriptors can be written multiple times until
> bConfigDescrLock attribute is zero.
> 
> Configuration descriptor buffer consists of Device and Unit
> descriptor configurable parameters which are parsed from vendor
> specific provisioning file and then passed via configfs node at
> runtime to provision ufs device.
> CONFIG_CONFIGFS_FS needs to be enabled for using this feature.

As mentioned before:  this absolutely needs to be a separate
config option so that the code can be compiled out entirely.
