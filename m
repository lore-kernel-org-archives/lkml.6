Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80416C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5074A2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HYPdpERI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391437AbeLUSZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:25:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35214 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388745AbeLUSZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+3oIgzMYSGpRMTGjMC8G5htx2OQ47BK5Wfpi+mdajPQ=; b=HYPdpERIQ336JfjJC5Z+FaPM1
        vdg/xTlNXbSi4vE7USoDcgPsRi348Z7T6j9E+4vPV+lL05QVF0ObjEzzfHlNpARSsPKe6XKAaf/lR
        Q9kzrkM+XZt+tH2LlsIoIr/2Sfqh3vdrTMI6rMfug+PKNalbIPXz5VIRFm8pbSkjCVw635TFem4oN
        J9BbSShJ3tBRMHPDdSeMEyu8DFEV0fBAf8hNgk0IWL5kutI6LJKsY9u8OgsGmCdPOHIDN7uLnbO5K
        zkJmYbQPur0QZC99nHHZVti/l3HIxC2V1sdj0pm7NcHyc7uNZTkh5Xr9Se45+ulSWRrmqGLrOjXIC
        CiDlwZZuQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gaPU4-0004eG-EX; Fri, 21 Dec 2018 18:25:16 +0000
Date:   Fri, 21 Dec 2018 10:25:16 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] x86_64: memset_user()
Message-ID: <20181221182515.GF10600@bombadil.infradead.org>
References: <20181221181423.20455-1-igor.stoppa@huawei.com>
 <20181221181423.20455-2-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221181423.20455-2-igor.stoppa@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 08:14:12PM +0200, Igor Stoppa wrote:
> +unsigned long __memset_user(void __user *addr, int c, unsigned long size)
> +{
> +	long __d0;
> +	unsigned long  pattern = 0;
> +	int i;
> +
> +	for (i = 0; i < 8; i++)
> +		pattern = (pattern << 8) | (0xFF & c);

That's inefficient.

	pattern = (unsigned char)c;
	pattern |= pattern << 8;
	pattern |= pattern << 16;
	pattern |= pattern << 32;

