Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B13C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD361208EB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="evWn+WKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD361208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbeHCQpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:45:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42954 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeHCQpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yKK1BsZYPKJJ8bsxV0UZP/zXtx25ocecWUvgN/2198s=; b=evWn+WKjzRpRFLJrWT9Qrx7/W
        FSjOEk/Pl7NAmO/RG0KwxutxmM6U/BWaRC3wN9BfMQIrvk4JwigrBsLz6ejpOshsRevnfXKm9kUIt
        k+yKige0HlmKdssf139fxrPSL3CbB/6v08a7PLAPzZTTShb5w6q+5PD3jCbcF1cjkcfsyShtW4QeT
        5szZp+IdjuYYfjBNYvNfFWqipXtxbxBk1hnMXTkU79N/CDQVRe1id9zhvNs7rvZ/qgDjAFvZrkKb9
        bR7JN9hnxuNVUMIr1T7fJ7H27TX7aBWysE4HIwdh3U54zbPVwwlXlglRxHx966Vwrn0d7KSwSO5hi
        dQUgRqd+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flbNU-0006nd-J1; Fri, 03 Aug 2018 14:48:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 367C720267E4F; Fri,  3 Aug 2018 16:48:26 +0200 (CEST)
Date:   Fri, 3 Aug 2018 16:48:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        fenghua.yu@intel.com, Tony Luck <tony.luck@intel.com>,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, mingo@redhat.com,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/7] x86/intel_rdt: Restoration of Cache
 Pseudo-Locked regions
Message-ID: <20180803144826.GL2458@hirez.programming.kicks-ass.net>
References: <cover.1532463771.git.reinette.chatre@intel.com>
 <alpine.DEB.2.21.1808031343020.1745@nanos.tec.linutronix.de>
 <3a33c9e9-4432-dbef-c3b7-a4da1740b0f7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a33c9e9-4432-dbef-c3b7-a4da1740b0f7@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 07:23:27AM -0700, Dave Hansen wrote:
> On 08/03/2018 04:45 AM, Thomas Gleixner wrote:
> >> Within the kernel two locations with direct invocations of the WBINVD
> >> instruction are coverted to native_wbinvd() and compile tested. Neither
> >> location is likely to be used on the platforms supporting Cache Pseudo-Locking.
> > Can we just get rid of WBINVD?
> 
> In general, or just this specific case?

In general I think. There aren't that many users IIRC.
