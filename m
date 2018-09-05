Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4919C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 04:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B80620652
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 04:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B80620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeIEIfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 04:35:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42243 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbeIEIfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 04:35:03 -0400
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w8546CiW3934371
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 4 Sep 2018 21:06:12 -0700
Subject: Re: [PATCH 1/3] x86/boot: Add bit fields into xloadflags for 5-level
 kernel checking
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Baoquan He <bhe@redhat.com>, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180829141624.13985-2-bhe@redhat.com>
 <6ea94875-ae07-6220-eb3e-d3f830cdac03@zytor.com>
 <20180904034414.GI1740@192.168.1.3>
 <4546fc39-4982-4c91-c812-0df1e9bc9e20@zytor.com>
 <20180904052036.GJ1740@192.168.1.3>
 <c4f65956-ad99-84ee-d4bf-044a6f0c5010@zytor.com>
 <20180904084231.ubyjaqp4xhqcnper@kshutemo-mobl1>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <7a1147d7-05af-98fe-3a14-b18ea445c2b5@zytor.com>
Date:   Tue, 4 Sep 2018 21:06:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904084231.ubyjaqp4xhqcnper@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/18 01:42, Kirill A. Shutemov wrote:
> 
> Switching between 4- and 5-level paging modes (in either direction)
> requires paing disabling. It means the code that does the switching has to
> be under 4G otherwise we would lose control.
> 
> We handle the switching correctly in kernel decompression code, but not on
> kexec caller side.
> 
> XLF_5LEVEL indicates that kernel decompression code can deal with
> switching between paging modes and it's safe to jump there in 5-level
> paging mode.
> 
> As an alternative we can change kexec to switch to 4-level paging mode
> before starting the new kernel. Not sure how hard it will be.
> 

Have a flag saying entering in 5-level mode is fine.  However, you really
should support returning to 4-level mode in kexec.  It is *much* easier to do
on the caller side as you have total control of memory allocation there.

	-hpa
