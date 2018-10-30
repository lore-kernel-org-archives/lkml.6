Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25FCC0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 02:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617AB2082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 02:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617AB2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amzn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbeJ3LpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 07:45:09 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:55058 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeJ3LpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 07:45:08 -0400
X-IronPort-AV: E=Sophos;i="5.54,442,1534809600"; 
   d="scan'208";a="371008309"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Oct 2018 02:53:32 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9U2rQxx087460
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 30 Oct 2018 02:53:30 GMT
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Oct 2018 02:53:29 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13d01UWB003.ant.amazon.com (10.43.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Oct 2018 02:53:28 +0000
Received: from localhost (172.23.204.141) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 30 Oct 2018 02:53:28 +0000
Date:   Tue, 30 Oct 2018 02:53:29 +0000
From:   Balbir Singh <sblbir@amzn.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Balbir Singh <sblbir@amazon.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add cmd_flags to print_req_error
Message-ID: <20181030025329.GA2121@dev-dsk-sblbir-2a-88e651b2.us-west-2.amazon.com>
References: <20181029005732.21040-1-sblbir@amazon.com>
 <543de76a-e43a-9f4d-c781-e3251ea0e749@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <543de76a-e43a-9f4d-c781-e3251ea0e749@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 04:39:05PM -0600, Jens Axboe wrote:
> On 10/28/18 6:57 PM, Balbir Singh wrote:
> > I ran into a bug where after hibernation due to incompatible
> > backends, the block driver returned BLK_STS_NOTSUPP, with the
> > current message it's hard to find out what the command flags
> > were. Adding req->cmd_flags help make the problem easier to
> > diagnose.
> 
> I recently did the same thing to debug something, so I like
> this change. One comment:
> 
> > +	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu flags %llx\n",
> > +				__func__, blk_errors[idx].name,
> > +				req->rq_disk ?  req->rq_disk->disk_name : "?",
> > +				(unsigned long long)blk_rq_pos(req),
> > +				(unsigned long long)req->cmd_flags);
> 
> Why are you casting it to unsigned long long for printing? A simple
> %x should suffice, no cast necessary.
>

Thanks! resent

I was looking at blk_dump_rq_flags() and tried to do something similar.
I agree a %x is sufficient, I was trying to be consistent. We can fix
that path up if needed.
 
> -- 
> Jens Axboe
> 
> 
