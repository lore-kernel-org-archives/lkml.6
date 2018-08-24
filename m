Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE21C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BEA21712
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="IszcBC2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BEA21712
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=xxxxxx.xxx
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeHXMfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:35:36 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:20172 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbeHXMff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:35:35 -0400
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Aug 2018 08:35:34 EDT
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id B601966A;
        Fri, 24 Aug 2018 10:52:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :references:in-reply-to:message-id:subject:subject:from:from
        :date:date:received:received:received; s=dkim20160331; t=
        1535100724; x=1536915125; bh=r7ylilZKTm4q6szHPfvbVpvuEG6pCOo880U
        vEHkPy1c=; b=IszcBC2f7cE9noE0QQ9/jnaMzOgUIKqWc8n7u0me0Zz+qv2iT4d
        P/575hvDMEFTy39RQ0H+28iGL/zrRkV5U7ve6fptZlgKbp8eIcWfOUFVzIhxVpSc
        utEoB8tVki6pXW9g6Lbqt9YfGb+0SOtbw6z4rYsjhgr9OkvIaAlykxM7vV6jM+g1
        iCbxCKBwTHVo/+ryskXtkDP/FjV9NWKi+8KjM62R5WDXh9cJvM58AF+bNYq3Uh+1
        MgeeeU1LMrSQXNjcHO1ol1f49xeLnsEF5/0ykTcoWZesYGLO9IrFJlaMeAzoowEm
        6paCC6lVP8gvC96s/HEswxP5xAMDMirVm9Of8tNLAzJzWP/e3MofvXFofRnss3g6
        PXIzqGiZddybx9jQuoVQlfN6PoH4/cSJsHpNZYcLJPz6ctWamaBWcHCT3zGz/qLA
        Kxv2PR9PTkactpFtKA79PQNI8oX/VqWGx8gVbUHrsjyEO8aHbMFy0jG6HxJvNmgk
        EJApvUVbXUzt2XmQ4Nfvmc2RcFksBcuI3SekX4C+joG/JrSqaAqd47iJns65x2+b
        gI/OUYuU0d9wCOexDR7JV/R5T7IG0r1wPuh1cwWN76WhkrtfqZ4ysHlrIZUsEnyH
        o3ajTtMxT9UHGKMBvBrHz08ty+JKWY7tIa1OBCdhpd1mcpMMhEfw2hjE=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sjXYBwn21bDC; Fri, 24 Aug 2018 10:52:04 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 9EF49465;
        Fri, 24 Aug 2018 10:52:04 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id A24112462;
        Fri, 24 Aug 2018 10:52:03 +0200 (CEST)
Date:   Fri, 24 Aug 2018 11:52:00 +0300
From:   xxxxxx xxxxxx <xxxxxx@xxxxxx.xxx>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>, stable@vger.kernel.org,
        Christopher Snowhill <kode54@gmail.com>
Subject: Re: [PATCH] x86/speculation/l1tf: fix off-by-one error when warning
 that system has too much RAM
Message-ID: <20180824115200.693ac345@localhost>
In-Reply-To: <20180823154437.GC12066@tassilo.jf.intel.com>
References: <20180823134418.17008-1-vbabka@suse.cz>
        <20180823154437.GC12066@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2018 08:44:37 -0700 Andi Kleen wrote:

> Ah I see it's a client part with very large DIMMs
> and someone being very brave and using that much
> memory without ECC.

It is not about being "brave" but about being
informed. As of 2018 you can probably call "brave"
everyone who uses any modern computer. However this
machine was purchased in 2012. Consider what was known
then and what is known now. The motherboard ASUS
P8Z77-V does not support ECC memory. Still we needed
and paid for 32GB of RAM, not for 31.5.

--
xxxxxx
