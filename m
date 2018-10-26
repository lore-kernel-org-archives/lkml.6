Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19DDECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280AF20831
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="JLKCC+Cw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280AF20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbeJ0IXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 04:23:42 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:25184 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbeJ0IXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 04:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540597479; x=1572133479;
  h=from:subject:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=LiKggMdzOSunu1lTEyjRfgEmHseVWdFzmFs4MvhGRgk=;
  b=JLKCC+Cw7KlZ+VfrYfZ/1kN/ffoEhPJYeSvHvTS4sLYo2dO/INrNVlX6
   d59Bvc8uWif9SZURCE+EGt9GXlLnZ28U4Zlg5ejZSPGjKvKxUy3wzYn2p
   Cl2KUizW+PCgj2g8keWEiEgF0tFV2llSj0UNEDBH2lM3hRPrER7ANHaHX
   k=;
X-IronPort-AV: E=Sophos;i="5.54,429,1534809600"; 
   d="scan'208";a="370653521"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Oct 2018 23:44:37 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9QNiXX6019903
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 26 Oct 2018 23:44:35 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w9QNiXo1029653;
        Sat, 27 Oct 2018 01:44:34 +0200
From:   =?UTF-8?Q?Jan_H=2e_Sch=c3=b6nherr?= <jschoenh@amazon.de>
Subject: [RFC 00/60] Coscheduling for Linux
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <b80700f3-feda-ce05-75e2-7ab3566727fb@oracle.com>
Openpgp: preference=signencrypt
Message-ID: <50b88e33-110f-c67a-671a-47c67017a563@amazon.de>
Date:   Sat, 27 Oct 2018 01:44:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b80700f3-feda-ce05-75e2-7ab3566727fb@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2018 02.26, Subhra Mazumdar wrote:
> Hi Jan,

Hi. Sorry for the delay.

> On 9/7/18 2:39 PM, Jan H. Schönherr wrote:
>> The collective context switch from one coscheduled set of tasks to another
>> -- while fast -- is not atomic. If a use-case needs the absolute guarantee
>> that all tasks of the previous set have stopped executing before any task
>> of the next set starts executing, an additional hand-shake/barrier needs to
>> be added.
>>
> Do you know how much is the delay? i.e what is overlap time when a thread
> of new group starts executing on one HT while there is still thread of
> another group running on the other HT?

The delay is roughly equivalent to the IPI latency, if we're just talking
about coscheduling at SMT level: one sibling decides to schedule another
group, sends an IPI to the other sibling(s), and may already start
executing a task of that other group, before the IPI is received on the
other end.

Now, there are some things that may delay processing an IPI, but in those
cases the target CPU isn't executing user code.

I've yet to produce some current numbers for SMT-only coscheduling. An
older ballpark number I have is about 2 microseconds for the collective
context switch of one hierarchy level, but take that with a grain of salt.

Regards
Jan

