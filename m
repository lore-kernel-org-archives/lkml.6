Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C6FC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9AB22486
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TZgjDB3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE9AB22486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933880AbeFUWKX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:10:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35538 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933847AbeFUWKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ca8rzZ+OWS6mKGTyc7UGktFUdHGEU2w5NG/1RrltHO4=; b=TZgjDB3XGLQSOP3JREMXOINbI
        TCeFNakLTedB8RrwI5EDihkhSuwKYrPinYmkGLBTsLrFUhWUGAbXqkzbAYH0wqDvi8OpyHFZadx8I
        rYixvQ2446GN5ldu97xAsxtGeoN/qZENmXQQT20rY4d99FxrEdUcN7rwLExfcsmyJq9FbgLEYppDe
        mqKx9wBqDdH+Zb/Z+Nj1IN3FLyS+ezDfnRhT3W0XphP23n3AhzhZ+oJbz4D/paL3tame7Mm6Kzchs
        zB5fgliH4rjIEnivgeyX4N/OHX4BmzTB+3GjPTYmnLcH1+nKzfB7qgBJLY/dMOoikci1V+Qp3uTko
        z4mA9+1xA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW7mK-00030S-SU; Thu, 21 Jun 2018 22:10:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B9E62029F1D7; Fri, 22 Jun 2018 00:10:06 +0200 (CEST)
Date:   Fri, 22 Jun 2018 00:10:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 00/16] x86/split_lock: Enable #AC exception for split
 locked accesses
Message-ID: <20180621221006.GC2494@hirez.programming.kicks-ass.net>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <20180621193738.GA13636@worktop.programming.kicks-ass.net>
 <20180621201851.GC114883@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1806212223480.1591@nanos.tec.linutronix.de>
 <20180621220003.GD114883@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621220003.GD114883@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 03:00:03PM -0700, Fenghua Yu wrote:
> The control knob for firmware is to choose continuing firmware execution
> by disabling #AC split lock (default) or stopping firmware execution
> by enabling #AC for split lock. Stopping firmware execution may be useful
> in hard real time system to identify any split lock issue on the platform.

Having the option only allows broken firmware to continue to exist.
Limiting people in how they can use their machines.
