Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879F5C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A662087F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfA1KEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:04:51 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:28677 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfA1KEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 05:04:49 -0500
X-IronPort-AV: E=Sophos;i="5.56,533,1539648000"; 
   d="scan'208";a="76590264"
Subject: Re: [PATCH 2/2] efi/cper: Avoid possible OOB when checking generic
 data block
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-efi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Huang Ying <ying.huang@intel.com>
References: <20190122160912.27312-1-ross.lagerwall@citrix.com>
 <20190122160912.27312-3-ross.lagerwall@citrix.com>
 <20190123115402.GB3227@zn.tnic>
From:   Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <d0a78e2a-7114-de25-4515-01844087ddbb@citrix.com>
Date:   Mon, 28 Jan 2019 10:04:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190123115402.GB3227@zn.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/19 11:54 AM, Borislav Petkov wrote:
> On Tue, Jan 22, 2019 at 04:09:12PM +0000, Ross Lagerwall wrote:
>> When checking a generic status block, we iterate over all the generic
>> data blocks. The loop condition only checks that the start of the
>> generic data block is valid (within estatus->data_length) but not the
>> whole block. Because the size of data blocks (excluding error data) may
>> vary depending on the revision and the revision is contained within the
>> data block, ensure that enough of the current data block is valid before
>> dereferencing any members otherwise an OOB access may occur if
snip
>> -		data_len -= acpi_hest_get_record_size(gdata);
>> +		record_len = acpi_hest_get_record_size(gdata);
> 
> record_size so that it matches the function name it is used to compute
> this.
> 
> Btw, trying to grok this code is making my head spin.
> 
>> +		if (record_len > data_len)
>> +			return -EINVAL;
> 
> <---- newline here.
> 
> Btw, those checks in the loop you can abstract away into a separate
> function so that you end up with something more readable like:
> 
>          apei_estatus_for_each_section(estatus, gdata) {
>                  record_size = check_hest_record_size(gdata, data_len);
>                  if (!record_size)
>                          return -EINVAL;
> 
>                  data_len -= record_size;
>          }
> 
> for example.
> 

There are only two if statements in the loop body -- I don't think it is 
necessary to abstract this into a separate function (which still 
requires having one if statement in the loop body).

I've made the other changes you suggested and sent a V2.

Thanks,
-- 
Ross Lagerwall
