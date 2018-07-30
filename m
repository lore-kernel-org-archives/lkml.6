Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE647FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A587A20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k3l2qA0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A587A20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeG3K23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:28:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40544 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeG3K22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xdGnmK8t1YV0QPYIjo0ZqGbctDl195gyFDUuKKzBSiE=; b=k3l2qA0SGymJzCLwS3/427W9+
        Mt1KB9QnpGlV0RXLV3wfPRg4JItAY7UsFUZKBCCIso1z0kHLiVCrK3/URK2zI5sLKj07qovsI1rvJ
        N29mOgq3WdSqLQp5ZjN1J+Vf+zTRquNI/ij5DEGRffFB18eYlebPZfys0kdPdcudAmJho/XMrU9y7
        eay5Zpbgx+hvuQW4uKK1TUNYeiFRE1BGIGmpuRe76UV23cZZHQZyrHLxiNKQi2k18emDYpvy+xJSI
        W+51pgllsmCBD4ref9MXtaLZRKb1u43TougfwTxOihjSR8AnUi25AY0ZeMU5mn+ZRpiPAiMb3o5NP
        M7yKp8A0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk3wE-0005Bk-6e; Mon, 30 Jul 2018 08:53:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0538420268325; Mon, 30 Jul 2018 10:53:55 +0200 (CEST)
Date:   Mon, 30 Jul 2018 10:53:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eduardo Valentin <eduval@amazon.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>,
        Rajvi Jingar <rajvi.jingar@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH RESEND 1/1] x86: tsc: avoid system instability in
 hibernation
Message-ID: <20180730085354.GA2494@hirez.programming.kicks-ass.net>
References: <20180726155656.14873-1-eduval@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726155656.14873-1-eduval@amazon.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 08:56:56AM -0700, Eduardo Valentin wrote:
> System instability are seen during resume from hibernation when system
> is under heavy CPU load. This is due to the lack of update of sched
> clock data

Which would suggest you're already running with unstable sched clock.
Otherwise nobody would care about the scd stuff.

What kind of machine are you running? What does:

  dmesg | grep -i tsc

say?

> The fix for this situation is to mark the sched clock as unstable
> as early as possible in the resume path, leaving it unstable
> for the duration of the resume process. This will force the
> scheduler to attempt to align the sched clock across CPUs using
> the delta with time of day, updating sched clock data. In a post
> hibernation event, we can then mark the sched clock as stable
> again, avoiding unnecessary syncs with time of day on systems
> in which TSC is reliable.

None of this makes any sense. Either you were already unstable and it
should already have worked and them marking it stable is an outright
bug, or your sched clock was stable but then your initial diagnosis of
lack of scd updates is complete garbage.

