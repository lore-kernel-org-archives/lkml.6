Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4995C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602DD260D6
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602DD260D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964977AbeFYU0F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 16:26:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934583AbeFYU0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 16:26:00 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFEAB260C7;
        Mon, 25 Jun 2018 20:25:58 +0000 (UTC)
Date:   Mon, 25 Jun 2018 16:25:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com, luto@kernel.org
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Message-ID: <20180625162557.7140664c@gandalf.local.home>
In-Reply-To: <20180625163951.GA52646@joelaf.mtv.corp.google.com>
References: <1529484440-20634-2-git-send-email-byungchul.park@lge.com>
        <20180620145814.GQ3593@linux.vnet.ibm.com>
        <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
        <20180620164902.GW3593@linux.vnet.ibm.com>
        <20180622055659.GA255098@joelaf.mtv.corp.google.com>
        <20180622132843.GN3593@linux.vnet.ibm.com>
        <20180622181916.GA13628@joelaf.mtv.corp.google.com>
        <20180622143247.781028b1@gandalf.local.home>
        <20180622200548.GA114655@joelaf.mtv.corp.google.com>
        <20180625082824.GB21377@X58A-UD3R>
        <20180625163951.GA52646@joelaf.mtv.corp.google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018 09:39:51 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:

> For whatever its worth, I made some notes of what I understood from reading
> the code and old posts because I was sure I would otherwise forget
> everything:
> http://www.joelfernandes.org/linuxinternals/2018/06/15/rcu-dynticks.html

Nice write up. I may point some people to this ;-)

Anyway "complications due to nested NMIs (yes NMIs can nest!)"

What arch allows for NMIs to nest. Because we don't let that happen on
x86, and there's code that I know of that is called by NMIs that is not
re-entrant, and can crash if we allow for NMIs to nest. For example
"in_nmi()" will not show that we are in_nmi() if we allow for nesting
of NMIs. It has a single bit that gets incremented when we enter NMI
code, and cleared when we leave it.

-- Steve
