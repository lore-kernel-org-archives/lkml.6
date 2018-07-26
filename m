Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A8AC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB0D20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="L1W3Xeer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB0D20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbeGZRY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:24:56 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:36487 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730352AbeGZRY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1532621246; x=1564157246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vrF8zKVENsAn2odTVXeWxiUrNrlkwqQBbw799syz/AI=;
  b=L1W3XeerY9M/vQa0bLlQXPSIc9hvDDZ+YmD1FxE7v1q0s9f6+w165ZMF
   9tppsOd/K9vkprgILXiIZErcodtH438faWKw1ozQeYh2YmNIYqXB4T1P0
   Wb5BtcU+l1S1NL1bo2HFDa/3H0H8E9eCf0YfaYVpTNLuRVICYYWrhQhN9
   4=;
X-IronPort-AV: E=Sophos;i="5.51,405,1526342400"; 
   d="scan'208";a="751716123"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-397e131e.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Jul 2018 16:00:50 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-397e131e.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w6QG0MUb031157
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 26 Jul 2018 16:00:22 GMT
Received: from EX13D05UWB001.ant.amazon.com (10.43.161.181) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 26 Jul 2018 16:00:22 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D05UWB001.ant.amazon.com (10.43.161.181) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 26 Jul 2018 16:00:22 +0000
Received: from localhost (10.88.47.215) by mail-relay.amazon.com
 (10.43.62.226) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 26 Jul 2018 16:00:21 +0000
Date:   Thu, 26 Jul 2018 09:00:20 -0700
From:   Eduardo Valentin <eduval@amazon.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Eduardo Valentin <eduval@amazon.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] x86: tsc: avoid system instability in hibernation
Message-ID: <20180726160020.GA7708@u40b0340c692b58f6553c.ant.amazon.com>
References: <20180725181846.1817-1-eduval@amazon.com>
 <1698243.s70xJfMujH@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1698243.s70xJfMujH@aspire.rjw.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Rafael,

On Thu, Jul 26, 2018 at 10:54:06AM +0200, Rafael J. Wysocki wrote:
> Hi Eduardo,
> 
> On Wednesday, July 25, 2018 8:18:46 PM CEST Eduardo Valentin wrote:
> 

> Can you please resend this with a CC to linux-pm?

Sure, resent here:

https://lkml.org/lkml/2018/7/26/607
https://marc.info/?l=linux-pm&m=153262063331515&w=2

I missed it, probably because it did not come from get_maintainers.

> 
> Cheers,
> Rafael
> 
> 

-- 
All the best,
Eduardo Valentin
