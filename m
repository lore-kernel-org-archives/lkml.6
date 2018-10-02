Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65342C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8AE2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8AE2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeJCE6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:58:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:37457 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbeJCE6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:58:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2018 15:13:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,333,1534834800"; 
   d="scan'208";a="79352326"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.130]) ([10.24.14.130])
  by orsmga006.jf.intel.com with ESMTP; 02 Oct 2018 15:13:02 -0700
Subject: Re: [RFC PATCH 10/10] arch/x86: Introduce QOS feature for AMD
To:     "Moger, Babu" <Babu.Moger@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "bp@suse.de" <bp@suse.de>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "luto@kernel.org" <luto@kernel.org>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "jannh@google.com" <jannh@google.com>,
        "dima@arista.com" <dima@arista.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180924191841.29111-1-babu.moger@amd.com>
 <20180924191841.29111-11-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <7690b121-dd54-ea58-ec77-2dbb88c25b16@intel.com>
Date:   Tue, 2 Oct 2018 15:13:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924191841.29111-11-babu.moger@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/24/2018 12:19 PM, Moger, Babu wrote:
> +/*
> + * Check whether a cache bit mask is valid. AMD allows
> + * non-contiguous masks.
> + */
> +bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r)
> +{
> +	unsigned long first_bit, zero_bit, val;
> +	unsigned int cbm_len = r->cache.cbm_len;
> +	int ret;
> +
> +	ret = kstrtoul(buf, 16, &val);
> +	if (ret) {
> +		rdt_last_cmd_printf("non-hex character in mask %s\n", buf);
> +		return false;
> +	}
> +
> +	if (val == 0 || val > r->default_ctrl) {
> +		rdt_last_cmd_puts("mask out of range\n");
> +		return false;
> +	}

According to
https://www.amd.com/system/files/TechDocs/56375_Quality_of_Service_Extensions.pdf
"If an L3_MASK_n register is programmed with all 0’s, that COS will be
prevented from allocating any lines in the L3 cache."

The "val == 0" test thus does not seem necessary.

> +
> +	first_bit = find_first_bit(&val, cbm_len);
> +	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
> +
> +
> +	if ((zero_bit - first_bit) < r->cache.min_cbm_bits) {
> +		rdt_last_cmd_printf("Need at least %d bits in mask\n",
> +				    r->cache.min_cbm_bits);
> +		return false;
> +	}

If AMD platforms accept CBM of all zeroes then it seems that the
platforms would not require a minimum number of set bits?

Reinette
