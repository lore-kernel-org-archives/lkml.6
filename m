Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39F4C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B952064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="A4SFddLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B952064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbeJAPuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:50:40 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:48589 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbeJAPuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1538385232; x=1569921232;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Xsb66IXfjvstWgU8UpLP0lVkeCd4GB8jEyXXXSj1Uco=;
  b=A4SFddLgHGg/hp7D7ZJfaDRfVtEC0RkpjVyFvQgt6HZvTunxlKdOC1BD
   QdL9FPhsBkE4VSW7GdDeGuHn+1V7vHH3pu8NrXS8e1EiiIUXYnHyhcAjs
   JiCN3kwECns82l3xhcHkktULAi7DBA2vX//mdBDyMK3j0DRvN8ZBAlKp1
   0=;
X-IronPort-AV: E=Sophos;i="5.54,327,1534809600"; 
   d="scan'208";a="365046694"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Oct 2018 09:13:50 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w919Dl7O040816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 1 Oct 2018 09:13:49 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w919DkM7026727;
        Mon, 1 Oct 2018 11:13:46 +0200
Subject: Re: [RFC 61/60] cosched: Accumulated fixes and improvements
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180913191938.30526-1-jschoenh@amazon.de> <20180926172519.GA23535@breakout>
 <20180926210551.GA28790@breakout>
From:   "=?UTF-8?Q?Jan_H._Sch=c3=b6nherr?=" <jschoenh@amazon.de>
Openpgp: preference=signencrypt
Message-ID: <13d56369-bdcc-9633-ecc0-659efadcd2a4@amazon.de>
Date:   Mon, 1 Oct 2018 11:13:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926210551.GA28790@breakout>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26/2018 11:05 PM, Nishanth Aravamudan wrote:
> On 26.09.2018 [10:25:19 -0700], Nishanth Aravamudan wrote:
>>
>> I found another issue today, while attempting to test (with 61/60
>> applied) separate coscheduling cgroups for vcpus and emulator threads
>> [the default configuration with libvirt].
> 
> <snip>
> 
> [  764.132461] BUG: unable to handle kernel NULL pointer dereference at 0000000000000040
> [  764.141001] PGD 0 P4D 0 
> [  764.144020] Oops: 0000 [#1] SMP PTI
> [  764.147988] CPU: 70 PID: 0 Comm: swapper/70 Tainted: G           OE     4.19-0rc3.ag-generic #4+1536951040do~8680a1b
> [  764.159086] Hardware name: Dell Inc. PowerEdge R640/0W23H8, BIOS 1.2.11 10/19/2017
> [  764.166968] RIP: 0010:set_next_entity+0x15/0x1d0

I got it reproduced.

I will send a fix, when I have one.

Regards
Jan
