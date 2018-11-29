Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBDCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB8220863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYbRLwA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB8220863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbeK2MQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:16:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbeK2MQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:16:00 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17F22206B6;
        Thu, 29 Nov 2018 01:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543453946;
        bh=3T6rMB0XvE37yr31GYVP2uvaQsuhFoBEKdGv1wB3dCw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MYbRLwA9BKu7e4ZFaqD/KP1mwbpa92UsoPMxti4Q/T1wdYrzS45QhVwwYyyknqj3T
         5gSSiAdteTH1grLUlcDLd1uPPxs514MynB1hleU0Omj8/tH0Lws2mzrTcvDuJUphK9
         AVKwjeVMXZI4m/zcFozIYHDCYUn6FcocWfIqB+EE=
Message-ID: <1543453945.4149.6.camel@kernel.org>
Subject: Re: [PATCH v7 09/16] tracing: Add hist trigger snapshot() action
 test case
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Wed, 28 Nov 2018 19:12:25 -0600
In-Reply-To: <20181128111558.5869fa4be7104314e833a801@kernel.org>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
         <a40dadf6ffa267a1a573b62bb1c9b4db9d91f744.1542221863.git.tom.zanussi@linux.intel.com>
         <20181126220332.215b461779d1d57f37b46e20@kernel.org>
         <1543359225.4223.5.camel@kernel.org>
         <20181128111558.5869fa4be7104314e833a801@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Wed, 2018-11-28 at 11:15 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Tue, 27 Nov 2018 16:53:45 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > > > +ping $LOCALHOST -c 3
> > > > +nice -n 1 ping $LOCALHOST -c 3
> > > > +
> > > > +echo 0 > /sys/kernel/debug/tracing/events/sched/enable
> > > 
> > > Shouldn't we stop tracing instead of disabling the event?
> > > 
> > 
> > This is just reversing the enable, so should be fine, but I can
> > stop
> > tracing instead if you prefer.
> 
> Oops, maybe we have to check the difference between event enabling
> and
> trace enabling.
> echo 0 > tracing_on will stop writing ring buffer, but event may
> continue
> to be called. Does this mean hist will be updated? (and I guess
> preferrable
> behavior is to stop hist too, isn't it?)
> 

For this test case, we're only enabling the sched events so we have
something in the snapshot buffer to verify that the snapshot worked, so
either should work for this purpose.

The triggers are supposed to work even if nothing is being logged to
the ring buffer, so the hist triggers updating when tracing to the
buffers is disabled is consistent with that...

Tom

> Thank you,
> 
> 
