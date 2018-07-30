Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFC016256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE7420857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rZ+pQ/rH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE7420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeG3S04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:26:56 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:5389 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeG3S04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1532969464; x=1564505464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a6EWL3Gykq4/sL1IRbBsbFmC8npvdWHwA313SgeOfV8=;
  b=rZ+pQ/rHljSg2z9PP2Ng9HWSFP3nqcB0QUHvk1g3WRAuLm7DMxrMriIU
   S9ZExDT1Cyen4t3N5kJsVS5cxk95LsZ8vxDwTaQkIEGfe8Lmw4/FPsc+X
   csKyN6n86ph5d2H1iieflfEH46A37jyoX6TGVyUrQYwqQkmkBEJJjdKp1
   4=;
X-IronPort-AV: E=Sophos;i="5.51,422,1526342400"; 
   d="scan'208";a="747039686"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-7c6d20a4.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jul 2018 16:41:35 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-7c6d20a4.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w6UGf0IR070864
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 30 Jul 2018 16:41:00 GMT
Received: from EX13D05UWB004.ant.amazon.com (10.43.161.208) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 30 Jul 2018 16:41:00 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D05UWB004.ant.amazon.com (10.43.161.208) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 30 Jul 2018 16:41:00 +0000
Received: from localhost (10.55.160.54) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 30 Jul 2018 16:41:00 +0000
Date:   Mon, 30 Jul 2018 09:41:00 -0700
From:   Eduardo Valentin <eduval@amazon.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Eduardo Valentin <eduval@amazon.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
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
        "Kate Stewart" <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH RESEND 1/1] x86: tsc: avoid system instability in
 hibernation
Message-ID: <20180730164100.GD15414@u40b0340c692b58f6553c.ant.amazon.com>
References: <20180726155656.14873-1-eduval@amazon.com>
 <20180730085354.GA2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180730085354.GA2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Peter,

On Mon, Jul 30, 2018 at 10:53:54AM +0200, Peter Zijlstra wrote:
> On Thu, Jul 26, 2018 at 08:56:56AM -0700, Eduardo Valentin wrote:
> > System instability are seen during resume from hibernation when system
> > is under heavy CPU load. This is due to the lack of update of sched
> > clock data
> 
> Which would suggest you're already running with unstable sched clock.
> Otherwise nobody would care about the scd stuff.


Yes.

> 
> What kind of machine are you running? What does:
> 
>   dmesg | grep -i tsc
> 
> say?

Here:
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.004005] tsc: Detected 3000.000 MHz processor
[    0.066796] TSC deadline timer enabled
[    3.904269] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2b3e459bf4c, max_idle_ns: 440795289890 ns

> 
> > The fix for this situation is to mark the sched clock as unstable
> > as early as possible in the resume path, leaving it unstable
> > for the duration of the resume process. This will force the
> > scheduler to attempt to align the sched clock across CPUs using
> > the delta with time of day, updating sched clock data. In a post
> > hibernation event, we can then mark the sched clock as stable
> > again, avoiding unnecessary syncs with time of day on systems
> > in which TSC is reliable.
> 
> None of this makes any sense. Either you were already unstable and it
> should already have worked and them marking it stable is an outright
> bug, or your sched clock was stable but then your initial diagnosis of
> lack of scd updates is complete garbage.
> 

I see, or it is just a workaround for the underling issue. I, for sure, see no
lockups anymore after forcing the scd updates. The other thing which are not
super clear is that this happens during the unfreezing of tasks. If I get a
set of cpu hog tasks while unfreezing, I see the system throwing worqueue lockup
detectors in hibernation restore.

> 

-- 
All the best,
Eduardo Valentin
