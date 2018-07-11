Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B5BC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB8720BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SsL26y7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB8720BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732416AbeGKIsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:48:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeGKIsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lIe/DLWc/iKEgC2Wmet738q1s4rkKcXLtns8ACW0XY0=; b=SsL26y7+9lThMOkozGZ+4XLOd
        T8Li2QTbhe18etiwfUqrfDK7WavNXeKjtywm5AIMaVlRKNRPSOIWPuN+wUxk6YQJeeorTWsjzyQ2t
        LTtv0Cwl63VanN2/tr3HwnW9DIsJ8SNhL1Cbmk2h7+ImhdiDmyYP+fl+Cvwc2P0j7rK7RD3ZE+E0/
        Na9AIhkxx+oswqZwscpuSE58KaGhTm505N/fJoJpZgDDeXR+7SXXMMY5buq1B6GVHOKdAoicINsvW
        pCYjVQMhteRLu1S8MAlsUuLa6vaDZ1lBYorjMVsrABhWNtiA3ykG/Ff5n5jrDTFFj8Gg8MvIEjbKn
        kWnvGjxPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdAkS-0007xB-IG; Wed, 11 Jul 2018 08:45:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7BA5A20291063; Wed, 11 Jul 2018 10:45:18 +0200 (CEST)
Date:   Wed, 11 Jul 2018 10:45:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [RFC PATCH v2 10/27] x86/mm: Introduce _PAGE_DIRTY_SW
Message-ID: <20180711084518.GQ2476@hirez.programming.kicks-ass.net>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-11-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710222639.8241-11-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 03:26:22PM -0700, Yu-cheng Yu wrote:
> +	pte = pte_clear_flags(pte, _PAGE_DIRTY_SW);
>  	return pte_set_flags(pte, _PAGE_DIRTY_HW | _PAGE_SOFT_DIRTY);

Having both _PAGE_DIRTY_SW and _PAGE_SOFT_DIRTY is really confusing.

I'm not sure I have an anwser for this, but urggh.
