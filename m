Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06786C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC7320835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC7320835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbeJCTxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:53:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:59959 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbeJCTxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:53:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 06:04:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="78366245"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.212])
  by orsmga008.jf.intel.com with ESMTP; 03 Oct 2018 06:04:00 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [QUEUED v20180920 04/16] stm class: Introduce framing protocol drivers
In-Reply-To: <20180927164617.GB7481@xps15>
References: <20180920124553.56978-1-alexander.shishkin@linux.intel.com> <20180920124553.56978-5-alexander.shishkin@linux.intel.com> <20180927164617.GB7481@xps15>
Date:   Wed, 03 Oct 2018 16:03:59 +0300
Message-ID: <878t3f6v28.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

>> +	err = stm_lookup_protocol(proto, &pdrv, &pdrv_node_type);
>>  	kfree(devname);
>>  
>> -	if (!stm)
>> +	if (err) {
>> +		stm_put_device(stm);
>>  		return ERR_PTR(-ENODEV);
>> +	}
>
> This condition prevent the subsystem from being used until patch 06/16 is added.

Good catch, I completely missed that.

> I would also suggest automatically compiling in the functionality provided by
> p_basic if p_sys-t is not selected.

That's kind of the intention; in Kconfig the PROTO_BASIC should default
to the same thing as CONFIG_STM, so it should be present unless the user
specifically interfered and disabled it.

> That way we preserve the original
> behaviour.  I would also use p_basic if no protocol driver is selected rather
> than leaving it to the insertion order to make things more
> deterministic.

Agreed, more deterministic is good.

Thanks,
--
Alex
