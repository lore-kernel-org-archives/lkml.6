Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03BFECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545742087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="qR7o+KdW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545742087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbeIXVqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:46:17 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:25388 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeIXVqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1537803810; x=1569339810;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=IV+eJF4LmiGfMZrl4ks2U/5ZPnMV0iNQwuCp7M9L8X8=;
  b=qR7o+KdWqfMr9zrMJZ6w5Cyvw8f18M5f51GAHh1dpEGO/6V+w3G/g0RI
   ZSu3OmAqkGHlp7fsMWi0V/8H0zt5eCst+iyMi5aqkuhUnLP+Ew7KIOvWt
   Alkq4SMsuEd/n2NbETfUnaaBNsTCzu3CtvMYwTVriUi1uZ2NoTPS523cT
   I=;
X-IronPort-AV: E=Sophos;i="5.54,298,1534809600"; 
   d="scan'208";a="632348462"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 Sep 2018 15:43:28 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w8OFhPwT031645
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 24 Sep 2018 15:43:27 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w8OFhPK9020699;
        Mon, 24 Sep 2018 17:43:25 +0200
Subject: Re: [RFC 00/60] Coscheduling for Linux
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <3336974a-38f7-41dd-25a7-df05e077444f@oracle.com>
 <90282ce3-dd14-73dc-fb9f-e78bb4042221@amazon.de>
 <a68891ae-468b-da35-61ee-a3136c6e64c1@oracle.com>
From:   "=?UTF-8?Q?Jan_H._Sch=c3=b6nherr?=" <jschoenh@amazon.de>
Openpgp: preference=signencrypt
Message-ID: <b95ff65d-04fe-642f-4878-a31db8875b0d@amazon.de>
Date:   Mon, 24 Sep 2018 17:43:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a68891ae-468b-da35-61ee-a3136c6e64c1@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/19/2018 11:53 PM, Subhra Mazumdar wrote:
> Can we have a more generic interface, like specifying a set of task ids
> to be co-scheduled with a particular level rather than tying this with
> cgroups? KVMs may not always run with cgroups and there might be other 
> use cases where we might want co-scheduling that doesn't relate to
> cgroups.

Currently: no.

At this point the implementation is tightly coupled to the cpu cgroup
controller. This *might* change, if the task group optimizations mentioned
in other parts of this e-mail thread are done, as I think, that it would
decouple the various mechanisms.

That said, what if you were able to disable the "group-based fairness"
aspect of the cpu cgroup controller? Then you would be able to control
just the coscheduling aspects on their own. Would that satisfy the use
case you have in mind?

Regards
Jan
