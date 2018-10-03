Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728F7C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C7720684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C7720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeJCTrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:47:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:26078 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbeJCTrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:47:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 05:58:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="78364692"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.212])
  by orsmga008.jf.intel.com with ESMTP; 03 Oct 2018 05:58:44 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [QUEUED v20180920 05/16] stm class: Add a helper for writing data packets
In-Reply-To: <20180927170748.GC7481@xps15>
References: <20180920124553.56978-1-alexander.shishkin@linux.intel.com> <20180920124553.56978-6-alexander.shishkin@linux.intel.com> <20180927170748.GC7481@xps15>
Date:   Wed, 03 Oct 2018 15:58:43 +0300
Message-ID: <87bm8b6vb0.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

>> +static ssize_t notrace stm_write(struct stm_data *data, unsigned int master,
>> +			  unsigned int channel, const char *buf, size_t count)
>> +{
>> +	ssize_t sz;
>> +
>> +	sz = stm_data_write(data, master, channel, true, buf, count);
>> +	if (sz > 0)
>> +		data->packet(data, master, channel, STP_PACKET_FLAG, 0, 0,
>> +			     buf);
>
> The original code the payload of a flag packet was '0' while in this patch
> changes it to be anything.  Some external tooling could be very confused.

I think the original intention was so: the 'size' field of ->packet()
refers to how many bytes from the given 'payload' the callback should
use. IOW, with size 0, buf may point to anything (still a valid pointer
though). But that should have been documented better from the beginning,
so you're completely right. I'll make a note to myself to go over the
API bits and sort out stuff like that.

Thanks,
--
Alex
