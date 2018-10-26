Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6922AECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6622082D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a4ZTkaJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6622082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeJZSIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:08:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55292 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeJZSIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iRzSzFfMpJPH5fWYU91iQwZk+vLFmG/YAbr0c3Dc980=; b=a4ZTkaJYY6UngxYjKqMogy9/S
        HIV/j3fehVFN6rAVhiujGZkzp7FVtpWwQa/6V/wTf9Oj+g65tNwNRUAnxtj7UkdB1RsSgUdS+pP1s
        4PTZnD5nTxEr10qCXeDLv8CvEh6SDL8jb64POwb3yZ3nnHHrhXBkI0VCLsGpoOE+Mpkx1qV9QA8oE
        ngvSehZv6QSQtOfvoMJLE9GSwKYehbMsAt/ib9PW8+Msxe4ar+dgjrDDpxFb7OBYqZlMhGVW99Ftx
        OlQ6y8agO7uMwCRSKeFF9Bp7xGMi7pvsiAiru+/FAmHgApv3XEnDngoFlXab7EI8ChMvpLCexzBgf
        UIIT92xUg==;
Received: from [167.98.65.38] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFyTP-0000hB-69; Fri, 26 Oct 2018 09:32:07 +0000
Received: by worktop (Postfix, from userid 1000)
        id 39F196E07BE; Fri, 26 Oct 2018 11:32:05 +0200 (CEST)
Date:   Fri, 26 Oct 2018 11:32:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, igor.stoppa@huawei.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Pekka Enberg <penberg@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Lihao Liang <lianglihao@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/17] prmem: linked list: disable layout randomization
Message-ID: <20181026093205.GD3159@worktop.c.hoisthospitality.com>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-14-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023213504.28905-14-igor.stoppa@huawei.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 12:35:00AM +0300, Igor Stoppa wrote:
> Some of the data structures used in list management are composed by two
> pointers. Since the kernel is now configured by default to randomize the
> layout of data structures soleley composed by pointers, this might
> prevent correct type punning between these structures and their write
> rare counterpart.

'might' doesn't really work for me. Either it does or it does not.
