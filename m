Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29E3C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 10:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1885E2087E
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 10:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="e/kC6Ke7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbfATK1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 05:27:40 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:33244 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730427AbfATK1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 05:27:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 8BEAEA009B;
        Sun, 20 Jan 2019 11:27:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1547980058; i=@fjfi.cvut.cz;
        bh=05DCmzKy2JWk5/dlJWb1twQpyRlEyUxnlfJhbY0uP8Q=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=e/kC6Ke7R632WRh9IwqmrHV/d6HMBJdX98oFL0o+1ZO5+dvuRG7LTnepVa7WcP2DR
         9O23S2o/QBKUhhtcdubMn5wEpqxFVXngL++YgumN4tKDINxsiR2luHtcCIQEIwUc5w
         5xhJ1bKJlQtmrmDOk/7KhxF4aiKuNT+qPrfLMag0=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id eNln3N2Jq7zl; Sun, 20 Jan 2019 11:27:35 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 424F7A0081;
        Sun, 20 Jan 2019 11:27:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 424F7A0081
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id EEBF16004E; Sun, 20 Jan 2019 11:27:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by linux.fjfi.cvut.cz (Postfix) with ESMTP id DAEB16002A;
        Sun, 20 Jan 2019 11:27:30 +0100 (CET)
Date:   Sun, 20 Jan 2019 11:27:30 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Scott Bauer <sbauer@plzdonthack.me>
cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@infradead.org,
        jonathan.derrick@intel.com
Subject: Re: [PATCH v2 11/16] block: sed-opal: ioctl for writing to shadow
 mbr
In-Reply-To: <20190119171550.GB12171@hacktheplanet>
Message-ID: <alpine.LRH.2.21.1901201045280.4278@linux.fjfi.cvut.cz>
References: <1547760716-7304-12-git-send-email-zub@linux.fjfi.cvut.cz> <20190119171550.GB12171@hacktheplanet>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jan 2019, Scott Bauer wrote:

> On Thu, Jan 17, 2019 at 09:31:51PM +0000, David Kozub wrote:
>
>> +static int write_shadow_mbr(struct opal_dev *dev, void *data)
>> +{
>> +	struct opal_shadow_mbr *shadow = data;
>> +	const u8 __user *src;
>> +	u8 *dst;
>> +	size_t off = 0;
>> +	u64 len;
>> +	int err = 0;
>> +
>> +	/* do the actual transmission(s) */
>> +	src = (u8 *) shadow->data;
>> +	while (off < shadow->size) {
>> +		err = cmd_start(dev, opaluid[OPAL_MBR], opalmethod[OPAL_SET]);
>> +		add_token_u8(&err, dev, OPAL_STARTNAME);
>> +		add_token_u8(&err, dev, OPAL_WHERE);
>> +		add_token_u64(&err, dev, shadow->offset + off);
>> +		add_token_u8(&err, dev, OPAL_ENDNAME);
>> +
>> +		add_token_u8(&err, dev, OPAL_STARTNAME);
>> +		add_token_u8(&err, dev, OPAL_VALUES);
>> +
>> +		/*
>> +		 * The bytestring header is either 1 or 2 bytes, so assume 2.
>> +		 * There also needs to be enough space to accommodate the
>> +		 * trailing OPAL_ENDNAME (1 byte) and tokens added by
>> +		 * cmd_finalize.
>> +		 */
>> +		len = min(remaining_size(dev) - (2+1+CMD_FINALIZE_BYTES_NEEDED),
>> +			  (size_t)(shadow->size - off));
>
> What if remaining_size(dev) <  2 + 1 + CMD_FINALIZE_BYTES_NEEDED? If that's possible we
> get min(UINT_MAX(ish) , some size larger than our remaining buffer) and that's not good.

This is only possible for uselessly small values of IO_BUFFER_LENGTH, 
which is a compile-time value. Originally I thought it's OK as nobody 
would set the value so low. But on a second thought, after reading your 
comment, I think that even if IO_BUFFER_LENGTH was set to such a value, 
the code should fail gracefully.

So I will change it into:

while (off < shadow->size) {
 	/*
 	 * Number of bytes needed in the cmd buffer to terminate the
 	 * write shadow mbr command.
 	 *
 	 * The bytestring header is either 1 or 2 bytes, so assume 2.
 	 * There also needs to be enough space to accommodate the
 	 * trailing OPAL_ENDNAME (1 byte) and tokens added by
 	 * cmd_finalize.
 	 */
 	const size_t write_shadow_mbr_footer_size =
 		2 + 1 + CMD_FINALIZE_BYTES_NEEDED;

 	err = cmd_start(dev, opaluid[OPAL_MBR], opalmethod[OPAL_SET]);
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, OPAL_WHERE);
 	add_token_u64(&err, dev, shadow->offset + off);
 	add_token_u8(&err, dev, OPAL_ENDNAME);

 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, OPAL_VALUES);

 	if (!can_add(&err, dev, write_shadow_mbr_footer_size))
 		break;
 	len = min(remaining_size(dev) - write_shadow_mbr_footer_size,
 		  (size_t)(shadow->size - off));
 	pr_debug("MBR: write bytes %zu+%llu/%llu\n",
 		 off, len, shadow->size);

Please let me know if you would prefer a different solution.

Best regards,
David
