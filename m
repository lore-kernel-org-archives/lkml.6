Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F817C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160E822407
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FGB5WFAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160E822407
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934111AbeFUVaq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:30:46 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8140 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933835AbeFUVam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1529616643; x=1561152643;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Nb1XFb6TkFOeT0je+OzTptD4wrvNNkf78Hovi2nidbc=;
  b=FGB5WFAWdz1IWZ0FzeRz5bPvD9uXimZZVW8kxTEig2SiFTaKjgAHjnAu
   lpYyXl/DEhjAq8wesiei7QChoyPXDODsxoFCqucVsdLyP59N8Mj4CMj7y
   S+MzhF3UTbj+WdlAgOzbMd+FU2Fe4hKeViNkxLh3gSlzuAGlaHupxrRAR
   ysd0rQIqQgVgoASxJASwF6tIZO+Wvd54lAJD4j+u1ytCu+ca1Ju1LnNHd
   X7YKa2VzgAzJ8gS4U41OkprNguR925jYdwjK+HaRQXAfyj/aMYaHLTNVv
   qFjTGuXj5zUasfY/Ferq2mVLS6kO9xComJyEFi0UtCggMReKIaZqynFYm
   g==;
X-IronPort-AV: E=Sophos;i="5.51,253,1526313600"; 
   d="scan'208";a="83607287"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2018 05:30:42 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 21 Jun 2018 14:20:29 -0700
Received: from thinkpad-bart.sdcorp.global.sandisk.com (HELO [10.111.67.248]) ([10.111.67.248])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Jun 2018 14:30:40 -0700
Subject: Re: [PATCH 0/5]stop normal completion path entering a timeout req
To:     Keith Busch <keith.busch@intel.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
References: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180620181601.GA24145@localhost.localdomain>
 <e87f5946-bb21-942e-2dcc-b24cee1ad23c@oracle.com>
 <20180621081900.GA5183@lst.de>
 <84a5b54c318b130f47775747d37dc139c27ebda7.camel@wdc.com>
 <20180621211529.GA27589@localhost.localdomain>
From:   Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <fb52d9c5-b392-96eb-c6db-99c603be80d1@wdc.com>
Date:   Thu, 21 Jun 2018 14:30:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621211529.GA27589@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21/18 14:12, Keith Busch wrote:
> On Thu, Jun 21, 2018 at 06:21:09PM +0000, Bart Van Assche wrote:
>> That's not how the SCSI core works.
> 
> How does it work? Jianchao is advocating for holes in software
> to ignore reacting to hardware events and force unnecessary error
> escalation. Putting holes in kernel software can't possibly be our
> only recourse.

Why were the patch "blk-mq: Remove generation seqeunce" and related 
patches rushed upstream without having given anyone a chance to review 
these patches? The approach of these patches is inferior to at least one 
alternative that was available. The code that is currently upstream
spreads the request state over multiple (three) variables while an 
alternative approach was presented that stores the request state in a 
single variable. I think the number of fix-up patches that is needed for 
the approach that is currently upstream shows that the upstream approach 
is inferior. I'm referring to "[PATCH v14] blk-mq: Rework blk-mq timeout 
handling again" (https://marc.info/?l=linux-block&m=152703042412228).

Bart.
