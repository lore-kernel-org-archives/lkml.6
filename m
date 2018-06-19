Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9415C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981F1208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PIIIAnGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981F1208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937750AbeFSMQ7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:16:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60114 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756675AbeFSMQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1dzmC3Mzna+twPUv7L4VaBr6JbLEIedbKn+bVpIqn0U=; b=PIIIAnGb4fM7gQXua7Yih5pAU9
        rZFMr4oTXuwa92O4G8F13D/cW5BRCKmdK5BZ2uX65w4CQ8pK4HEJ+dL54Z0lGT5nQvrhoxzuuq6IE
        KiSDZVZSFakVkgF0CJMuSqYWKBnLOYW+/U5heqERz5b/Q3Yfb5jnIa3YqWDSbUhwacHVd34A/k3GI
        ywvjcetHV2+CO5gRn08/niOOK8BJ5zO05GSO/ZJG4yxFsjjjlL5bmdicqqwl2iY+wxpgwEtcml4YM
        7oIMamOolsPJMj9GwdDZCgXQXqQ6NmndVuW6l+Lxy3g9nYUvrK4Qzd+nQcaUDS33MewtC1JfpD82G
        aAw4eYuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVFZ0-0002JY-4J; Tue, 19 Jun 2018 12:16:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E2CFE20268507; Tue, 19 Jun 2018 14:16:43 +0200 (CEST)
Date:   Tue, 19 Jun 2018 14:16:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 04/10] PM / EM: Expose the Energy Model in sysfs
Message-ID: <20180619121643.GR2458@hirez.programming.kicks-ass.net>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-5-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180521142505.6522-5-quentin.perret@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 03:24:59PM +0100, Quentin Perret wrote:
> This exposes the Energy Model (read-only) of all frequency domains in
> sysfs for convenience. To do so, a parent kobject is added to the CPU
> subsystem under the umbrella of which a kobject for each frequency
> domain is attached.
> 
> The resulting hierarchy is as follows for a platform with two frequency
> domains for example:
> 
>    /sys/devices/system/cpu/energy_model
>    ├── fd0
>    │   ├── capacity
>    │   ├── cpus
>    │   ├── frequency
>    │   └── power
>    └── fd4
>        ├── capacity
>        ├── cpus
>        ├── frequency
>        └── power
> 

Given that each FD can have multiple {freq,power} tuples and sysfs has a
one value per file policy, how does this work?
