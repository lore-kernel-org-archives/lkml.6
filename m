Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CB0QUnoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C090B607B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeFFMjE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:39:04 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39263 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeFFMjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:39:02 -0400
X-Google-Smtp-Source: ADUXVKIMVvITCbouIet9ihJ55HxXGtO+D3Djilpp00sTpJ5IV3cCLn9gNMczSTUtxWZ+5WtqEyOkJw==
Subject: Re: [PATCH v2 8/9] xen/gntdev: Implement dma-buf import functionality
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180601114132.22596-1-andr2000@gmail.com>
 <20180601114132.22596-9-andr2000@gmail.com>
 <7ef4f26e-4225-ea7e-8183-9a6c3fe69345@oracle.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <8676e1d7-3179-5fc0-08fb-02373df4101b@gmail.com>
Date: Wed, 6 Jun 2018 15:38:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <7ef4f26e-4225-ea7e-8183-9a6c3fe69345@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2018 01:28 AM, Boris Ostrovsky wrote:
> On 06/01/2018 07:41 AM, Oleksandr Andrushchenko wrote:
>>   /* ------------------------------------------------------------------ */
>>   
>> +static int
>> +dmabuf_imp_grant_foreign_access(struct page **pages, u32 *refs,
>> +				int count, int domid)
>> +{
>> +	grant_ref_t priv_gref_head;
>> +	int i, ret;
>> +
>> +	ret = gnttab_alloc_grant_references(count, &priv_gref_head);
>> +	if (ret < 0) {
>> +		pr_err("Cannot allocate grant references, ret %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	for (i = 0; i < count; i++) {
>> +		int cur_ref;
>> +
>> +		cur_ref = gnttab_claim_grant_reference(&priv_gref_head);
>> +		if (cur_ref < 0) {
>> +			ret = cur_ref;
>> +			pr_err("Cannot claim grant reference, ret %d\n", ret);
>> +			goto out;
>> +		}
>> +
>> +		gnttab_grant_foreign_access_ref(cur_ref, domid,
>> +						xen_page_to_gfn(pages[i]), 0);
>> +		refs[i] = cur_ref;
>> +	}
>> +
>> +	ret = 0;
> return 0?
My bad, thank you
>> +
>> +out:
>> +	gnttab_free_grant_references(priv_gref_head);
>> +	return ret;
>> +}
>> +
