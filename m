Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D153C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCE420874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d3X5OoOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCE420874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757003AbeFSJq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:46:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35576 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756608AbeFSJq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kUFdeFatOBzU0whz9Rz2myZyeYBBS8+4Kcrij5uWqE0=; b=d3X5OoOMnd6L0HGi3IWSh9HID
        JdjoMb4ZDXYzVCPdDfabKpKeA8a+kSJSxTTMPXyDuWBuizqxW8n4oQ4MgvnMi3tdH4OXSfIliVkxB
        VwMNe3Fgx+1+Lf7zH/EbPXce0GEqx76S2eZW8bwmquUaAnPcxzeeefmiUDlS+oADWD+IEpSNf5hJE
        AfGmPaeQUFveWAxfU8GOdEI4y2QZhfP5dBVqk9tzk+GmJG7lOIUMFapSIzhd+7sDi7OeWDgI+bBFQ
        v4dcJEdVCURVrK8H/nyLRYpFi740NDAYtbMGgYQIZwNQL/aOPi7/Yl3YasYAEAF+aeCvzHV2y4ZzD
        M2L41MGgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVDD2-000724-3M; Tue, 19 Jun 2018 09:45:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB5F520268507; Tue, 19 Jun 2018 11:45:54 +0200 (CEST)
Date:   Tue, 19 Jun 2018 11:45:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v4 0/4] locking,drm: Fix ww mutex naming / algorithm
 inconsistency
Message-ID: <20180619094554.GM2458@hirez.programming.kicks-ass.net>
References: <20180619082445.11062-1-thellstrom@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619082445.11062-1-thellstrom@vmware.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I suspect you want this through the DRM tree? Ingo are you OK with that?
