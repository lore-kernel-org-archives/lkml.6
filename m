Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C85C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB9D20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iQJqk8I0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB9D20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbeLCIfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:35:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34782 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeLCIfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:35:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Kyx2QCID12UOPm/FFHZm76pDnAa5udfNIhFmf6fCX50=; b=iQJqk8I0H3e+RUZ98xoNzBmsB
        pqoeSsKOU9Dm25Ta+QLNAPjyRHExviYVAdqkCY6tWNfqm3HY1VQUMy1ok2Tm1U3dmry8X68JHgziB
        J3eFCaHwjIqlMZ5jr8cVmF8hkQqzQ1bH1loOyRYjcGl004eMv1v7xhEsJkrSfwFIY4e09kX0nYyOZ
        dhjdZPOl2baFB+t93Pf+NWjj150MdBQgOnKcoDiX+tQWrtPu5utvVcEfpuxDzZ+jEUD5MpGevN/vN
        Ozl8iJBDPtBfKxmX7SEJ0wfjeJwCIzPnq4k83CYeG/01V1dilJx0oi4tVJNm5ujB4TDR0b19bUTUD
        XxUTFk2qg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTjh1-0002I0-8m; Mon, 03 Dec 2018 08:35:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C86BA2029F873; Mon,  3 Dec 2018 09:35:00 +0100 (CET)
Date:   Mon, 3 Dec 2018 09:35:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        mingo@redhat.com, will.deacon@arm.com
Subject: Re: [PATCH] locktorture: Fix assignment of boolean variables
Message-ID: <20181203083500.GH11614@hirez.programming.kicks-ass.net>
References: <20181201083149.36972-1-wen.yang99@zte.com.cn>
 <20181201203700.GW4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181201203700.GW4170@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2018 at 12:37:01PM -0800, Paul E. McKenney wrote:
> On Sat, Dec 01, 2018 at 04:31:49PM +0800, Wen Yang wrote:
> > Fix the following warnings reported by coccinelle:
> > 
> > kernel/locking/locktorture.c:703:6-10: WARNING: Assignment of bool to 0/1
> > kernel/locking/locktorture.c:918:2-20: WARNING: Assignment of bool to 0/1
> > kernel/locking/locktorture.c:949:3-20: WARNING: Assignment of bool to 0/1
> > kernel/locking/locktorture.c:682:2-19: WARNING: Assignment of bool to 0/1
> > kernel/locking/locktorture.c:688:2-19: WARNING: Assignment of bool to 0/1
> > kernel/locking/locktorture.c:648:2-20: WARNING: Assignment of bool to 0/1
> > kernel/locking/locktorture.c:654:2-20: WARNING: Assignment of bool to 0/1
> > 
> > This patch also makes the code more readable.
> > 
> > Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> > CC: Davidlohr Bueso <dave@stgolabs.net>
> > CC: "Paul E. McKenney" <paulmck@linux.ibm.com>
> > CC: Josh Triplett <josh@joshtriplett.org>
> > CC: linux-kernel@vger.kernel.org
> 
> Adding the current maintainers on CC.

So I strongly disagree with this. Anybody that has trouble with 0/1 vs
false/true needs to stay the heck away from C.

I would suggest we delete that stupid coccinelle scripts that generates
these pointless warns.
