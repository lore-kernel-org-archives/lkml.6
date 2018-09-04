Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB4BC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7D02086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7D02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeIDMgE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:36:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:32809 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeIDMgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:36:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 01:12:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,328,1531810800"; 
   d="scan'208";a="88770545"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga002.jf.intel.com with ESMTP; 04 Sep 2018 01:12:03 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 4 Sep 2018 01:12:03 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 4 Sep 2018 01:12:02 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.226]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.143]) with mapi id 14.03.0319.002;
 Tue, 4 Sep 2018 16:12:01 +0800
From:   "Peng, DongX" <dongx.peng@intel.com>
To:     Nikita Leshenko <nikita.leshchenko@oracle.com>,
        "Wu, Fengguang" <fengguang.wu@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Liu, Jingqi" <jingqi.liu@intel.com>,
        "Dong, Eddie" <eddie.dong@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Brendan Gregg <bgregg@netflix.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [RFC][PATCH 3/5] [PATCH 3/5] kvm-ept-idle: HVA indexed EPT read
Thread-Topic: [RFC][PATCH 3/5] [PATCH 3/5] kvm-ept-idle: HVA indexed EPT read
Thread-Index: AQHUQmOmnZsRsVJTp0KJvY5txETrBqTfPtWAgACKFLA=
Date:   Tue, 4 Sep 2018 08:12:00 +0000
Message-ID: <5249147EF0246348BBCB3713DC3757BF8D0D0C@shsmsx102.ccr.corp.intel.com>
References: <20180901112818.126790961@intel.com>
 <20180901124811.591511876@intel.com>
 <37B30FD3-7955-4C0B-AAB5-544359F4D157@oracle.com>
In-Reply-To: <37B30FD3-7955-4C0B-AAB5-544359F4D157@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYmJiODY5MWYtYjYyNC00NzBiLTljOWUtMGE3ODE0OTEzNGZmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZW9YMk4zUHhSU0pUcHdVR0daMkRvcmNSZytOYUh0VWZabW1XODBUUzNrWE93OTllQndaTGdLTDRyUnozNjZSaiJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_get_kvm() kvm_put_kvm()

-----Original Message-----
From: Nikita Leshenko [mailto:nikita.leshchenko@oracle.com] 
Sent: Tuesday, September 4, 2018 3:57 PM
To: Wu, Fengguang <fengguang.wu@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>; Linux Memory Management List <linux-mm@kvack.org>; Peng, DongX <dongx.peng@intel.com>; Liu, Jingqi <jingqi.liu@intel.com>; Dong, Eddie <eddie.dong@intel.com>; Hansen, Dave <dave.hansen@intel.com>; Huang, Ying <ying.huang@intel.com>; Brendan Gregg <bgregg@netflix.com>; kvm@vger.kernel.org; LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 3/5] [PATCH 3/5] kvm-ept-idle: HVA indexed EPT read

On 1 Sep 2018, at 13:28, Fengguang Wu <fengguang.wu@intel.com> wrote:
> +static ssize_t ept_idle_read(struct file *file, char *buf,
> +			     size_t count, loff_t *ppos)
> +{
> +	struct task_struct *task = file->private_data;
> +	struct ept_idle_ctrl *eic;
> +	unsigned long hva_start = *ppos << BITMAP_BYTE2PVA_SHIFT;
> +	unsigned long hva_end = hva_start + (count << BITMAP_BYTE2PVA_SHIFT);
> +	int ret;
> +
> +	if (*ppos % IDLE_BITMAP_CHUNK_SIZE ||
> +	    count % IDLE_BITMAP_CHUNK_SIZE)
> +		return -EINVAL;
> +
> +	eic = kzalloc(sizeof(*eic), GFP_KERNEL);
> +	if (!eic)
> +		return -EBUSY;
> +
> +	eic->buf = buf;
> +	eic->buf_size = count;
> +	eic->kvm = task_kvm(task);
> +	if (!eic->kvm) {
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
I think you need to increment the refcount while using kvm, otherwise kvm can be destroyed from another thread while you're walking it.

-Nikita
> +
> +	ret = ept_idle_walk_hva_range(eic, hva_start, hva_end);
> +	if (ret)
> +		goto out_free;
> +
> +	ret = eic->bytes_copied;
> +	*ppos += ret;
> +out_free:
> +	kfree(eic);
> +
> +	return ret;
> +}
