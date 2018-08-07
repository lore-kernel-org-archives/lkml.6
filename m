Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665D7C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A6F2174B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A6F2174B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amzn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbeHGXpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:45:06 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:10763 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbeHGXpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:45:05 -0400
X-IronPort-AV: E=Sophos;i="5.51,456,1526342400"; 
   d="scan'208";a="732535684"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Aug 2018 21:28:42 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w77LSfiB121727
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 7 Aug 2018 21:28:41 GMT
Received: from EX13D13UWB004.ant.amazon.com (10.43.161.218) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 7 Aug 2018 21:28:40 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB004.ant.amazon.com (10.43.161.218) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 7 Aug 2018 21:28:39 +0000
Received: from ued668862963453 (10.61.112.112) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 7 Aug 2018 21:28:39 +0000
Received: by ued668862963453 (sSMTP sendmail emulation); Tue, 07 Aug 2018 14:28:39 -0700
Date:   Tue, 7 Aug 2018 14:28:39 -0700
From:   Matt Wilson <msw@amzn.com>
To:     Anchal Agarwal <anchalag@amazon.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <fllinden@amazon.com>,
        <sblbir@amazon.com>, <msw@amazon.com>
Subject: Re: [PATCH] blk-wbt: Avoid lock contention and thundering herd issue
 in wbt_wait
Message-ID: <20180807212839.GA30244@ued668862963453.ant.amazon.com>
References: <20180731213410.GA35291@kaos-source-ops-60001.pdx1.amazon.com>
 <df2a0476-d9d1-c6c9-6553-f459e890ce8b@kernel.dk>
 <20180801170603.GA32864@kaos-source-ops-60001.pdx1.amazon.com>
 <a9871e54-83bf-7557-2d2f-99e006ceadcf@kernel.dk>
 <9265896d-3f02-ff2f-8e02-3aca775f4087@kernel.dk>
 <20180807201247.GA21108@kaos-source-ops-60001.pdx1.amazon.com>
 <6f24ff4b-9373-2708-8342-96f190f17cbf@kernel.dk>
 <20180807211216.GA14371@kaos-source-ops-60001.pdx1.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180807211216.GA14371@kaos-source-ops-60001.pdx1.amazon.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 09:12:16PM +0000, Anchal Agarwal wrote:
> Hi Jens,
> Thanks for accepting this. There is one small issue, I don't find any emails
> send by me on the lkml mailing list. I am not sure why it didn't land there,
> all I can see is your responses. Do you want one of us to resend the patch
> or will you be able to do it?

Hi Anchal,

Usually this is due to how DMARC is set up for amazon.com. When mail
lists relay your messages without taking ownership of the envelope, it
invalidates the DKIM signatures and the DMARC policy can cause email
to be flagged as forged / spam.

If you configure your mailer and git to use amzn.com instead of
amazon.com it may help, as the DMARC policy for amzn.com is "none"
[1] rather than "quarantine" for amazon.com [2].

--msw

[1] https://mxtoolbox.com/SuperTool.aspx?action=dmarc%3aamzn.com&run=toolpage
[2] https://mxtoolbox.com/SuperTool.aspx?action=dmarc%3aamazon.com&run=toolpage
