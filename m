Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE7EC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EDB20C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="l+RbgSAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3EDB20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeIMQkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:40:55 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:6505 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeIMQkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536838311; x=1568374311;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=gaegV/Zb1viALxTO4IgyiMViiH3bLmaRMQ1XQ5T/BD8=;
  b=l+RbgSArL8wdl86cZAha3GBIS/ZV22yKTas8/+DNV1vnyk4iAAn04XSj
   rehmUO0Z6+bK5xWpu2V7WLPU8IhA8WnmK06miY1nLaQM1ossweAxdPkgd
   IMDrHkSt5mXQssupeUgRaMuRHK8GtPLgqEjzh+q3po+H30Bq5lg9ncqyL
   4=;
X-IronPort-AV: E=Sophos;i="5.53,368,1531785600"; 
   d="scan'208";a="738489039"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Sep 2018 11:31:48 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w8DBVcV5090977
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Thu, 13 Sep 2018 11:31:45 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w8DBVa9w013817;
        Thu, 13 Sep 2018 13:31:37 +0200
Subject: Re: [RFC 00/60] Coscheduling for Linux
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180912002449.GA21797@breakout>
 <c41f4e4f-30a1-5a3c-dec6-dc8f1d181c94@amazon.de>
 <20180912231535.GA1546@breakout>
From:   "=?UTF-8?Q?Jan_H._Sch=c3=b6nherr?=" <jschoenh@amazon.de>
Openpgp: preference=signencrypt
Message-ID: <5490845c-3f71-8487-8580-87b18a639ecd@amazon.de>
Date:   Thu, 13 Sep 2018 13:31:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912231535.GA1546@breakout>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/2018 01:15 AM, Nishanth Aravamudan wrote:
> [...] if I just try to set machine's
> cpu.scheduled to 1, with no other changes (not even changing any child
> cgroup's cpu.scheduled yet), I get the following trace:
> 
> [16052.164259] ------------[ cut here ]------------
> [16052.168973] rq->clock_update_flags < RQCF_ACT_SKIP
> [16052.168991] WARNING: CPU: 59 PID: 59533 at kernel/sched/sched.h:1303 assert_clock_updated.isra.82.part.83+0x15/0x18
[snip]

This goes away with the change below (which fixes patch 58/60).

Thanks,
Jan

diff --git a/kernel/sched/cosched.c b/kernel/sched/cosched.c
index a1f0d3a7b02a..a98ea11ba172 100644
--- a/kernel/sched/cosched.c
+++ b/kernel/sched/cosched.c
@@ -588,6 +588,7 @@ static void sdrq_update_root(struct sdrq *sdrq)

        /* Get proper locks */
        rq_lock_irqsave(rq, &rf);
+       update_rq_clock(rq);

        sdrq->is_root = is_root;
        if (is_root)
