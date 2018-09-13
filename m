Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A221C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E35204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="SeGyiGCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E35204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbeIMX1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:27:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42833 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbeIMX1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:27:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so3029163pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 11:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yDYpIWL93vJZrcgkcDELYHIQ9E3tcqiIXB6NTHCqFD4=;
        b=SeGyiGCxgenv+yjr9moQIDA/wFF7VCCnUJ+pJjsrXE3HD/IXxldPqmNzM6601X6aEu
         HXBoTw/aCQh+/tLQZ7FZPDLzzs1+z19WC57KBY3Oz8C4V3OUBgju+l1sJxo1xbKx8iCI
         ewQMFRp9RDxJbJmIO2IE3qXbhQYHje9SZNmp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yDYpIWL93vJZrcgkcDELYHIQ9E3tcqiIXB6NTHCqFD4=;
        b=IIh7NAO1gIgxVY1480Wxp9M3UJ4zWpzP1WLn1nzokHLagD+Cb3i4ZahVh1DqCBEY2x
         tE4QWRad2ADhi3RJBawtQTXpocr7d12L1QsgJmNIvrLRJwn6/Au1H+tgCcjdc0ItTQ0M
         s8/e8KtGJX58pxXKwyJ8OrvOmo+MYYIIMUmpdS2bG45FR6tjAh6Uyw2lxu5sV0FFHpuz
         3XkTGhjRgYg+xoNTduP6NV9GRX/m7V2AvOVlZE4QGwTgCKu+zA7vUNGl6u/vemNtgzsY
         KJQWDu6HrgIobs9et4FKgag4sp1Uht20NEm7abrPIVvNqj54j4Znr475wrInJai7Nryy
         C58Q==
X-Gm-Message-State: APzg51BaWuhAGmukEgHUuHky/ghDgDVJmP1jX0gvmTSdnCqqWtvcFPeE
        bdwmdiAmhxFfO2uO22zOysd5LUceQZQ=
X-Google-Smtp-Source: ANB0Vda5hdQj//4+V178H1dqavo6CpmOmPKv+zYYIBAdAkWAak+rPcc/IY/TCjsnXF82KuC5icU1bA==
X-Received: by 2002:a62:8a4f:: with SMTP id y76-v6mr8511415pfd.233.1536862589616;
        Thu, 13 Sep 2018 11:16:29 -0700 (PDT)
Received: from breakout.internal.digitalocean.com (97-120-204-225.ptld.qwest.net. [97.120.204.225])
        by smtp.gmail.com with ESMTPSA id w12-v6sm6543737pfd.110.2018.09.13.11.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 11:16:29 -0700 (PDT)
Received: by breakout.internal.digitalocean.com (Postfix, from userid 1000)
        id EB7918A2A78; Thu, 13 Sep 2018 11:16:27 -0700 (PDT)
Date:   Thu, 13 Sep 2018 11:16:27 -0700
From:   Nishanth Aravamudan <naravamudan@digitalocean.com>
To:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 00/60] Coscheduling for Linux
Message-ID: <20180913181627.GA29148@breakout>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180912002449.GA21797@breakout>
 <c41f4e4f-30a1-5a3c-dec6-dc8f1d181c94@amazon.de>
 <20180912231535.GA1546@breakout>
 <5490845c-3f71-8487-8580-87b18a639ecd@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5490845c-3f71-8487-8580-87b18a639ecd@amazon.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.2018 [13:31:36 +0200], Jan H. Schönherr wrote:
> On 09/13/2018 01:15 AM, Nishanth Aravamudan wrote:
> > [...] if I just try to set machine's
> > cpu.scheduled to 1, with no other changes (not even changing any child
> > cgroup's cpu.scheduled yet), I get the following trace:
> > 
> > [16052.164259] ------------[ cut here ]------------
> > [16052.168973] rq->clock_update_flags < RQCF_ACT_SKIP
> > [16052.168991] WARNING: CPU: 59 PID: 59533 at kernel/sched/sched.h:1303 assert_clock_updated.isra.82.part.83+0x15/0x18
> [snip]
> 
> This goes away with the change below (which fixes patch 58/60).

Yep, I can confirm this one as well, is now fixed.

-Nish
