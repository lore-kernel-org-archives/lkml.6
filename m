Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A6AC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365B120657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d0/wpFci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365B120657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeJaAXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:23:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbeJaAXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oulFfH9JYVCCDp8mixdnJfogwwFY+N/JvVZ5AUVW1Cs=; b=d0/wpFciFWl09/DEtystyKyfZ
        Ayf549jf7VMrRZVYfWJx5MBeivHLVTe08BdBuTXu+xE0C4OFakZm3V88PbSGYrOg7orsvl3/YkrLI
        5RoRKQrbVidA6JSw44P7MRdDzW20hJItCajSNaT+muQxSHrHkQ0Le44cxrP/W6/aaIL4zpOoW1YDu
        pztgkEZXx5Od8vWVKJbZK1I0ay9kq9u2V9B4yWNVJ1TF0p1LReeg/hVlZOcJ31Cq/jfiUha7tfHsY
        +Sn+z714xYPPiUvWJ5thKByh0wCUq5nnEp0lMtjqkjhkhJ9WWyvjmgjbk2RuYVDQnr84syN1XJHie
        0Paq/9f7Q==;
Received: from [24.132.217.100] (helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHPTo-0007D0-0a; Tue, 30 Oct 2018 08:35:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B36DC202A40A3; Tue, 30 Oct 2018 09:32:10 +0100 (CET)
Date:   Tue, 30 Oct 2018 09:32:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     Linux-Kernel <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        luto@kernel.org, konrad.wilk@oracle.com, dwmw@amazon.co.uk,
        tglx@linutronix.de, Srinivas REDDY Eeda <srinivas.eeda@oracle.com>,
        bp@suse.de, daniel@iogearbox.net, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, hpa@zytor.com
Subject: Re: [PATCH 1/3] retpolines: Only enable retpoline when compiler
 support it
Message-ID: <20181030083210.GA1459@hirez.programming.kicks-ass.net>
References: <e63900bc-d7af-4a57-aa96-f6cc84b89e09@default>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e63900bc-d7af-4a57-aa96-f6cc84b89e09@default>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 11:55:04PM -0700, Zhenzhong Duan wrote:
> Since retpoline capable compilers are widely available, make
> CONFIG_RETPOLINE hard depend on it.
> 
> Change KBUILD to use CONFIG_RETPOLINE_SUPPORT to avoid conflict with
> CONFIG_RETPOLINE which is used by kernel.
> 
> With all that stuff, the check of RETPOLINE is changed to
> CONFIG_RETPOLINE.

So what happens when we select CONFIG_RETPOLINE but do not have
RETPOLINE_SUPPORT ? From a quick reading we'll silently build a
!retpoline kernel. I would expect a build failure.
