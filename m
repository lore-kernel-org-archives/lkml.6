Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE914C28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04CD20868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04CD20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeJLKyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 06:54:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:27723 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbeJLKyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 06:54:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 20:24:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,371,1534834800"; 
   d="scan'208";a="99581467"
Received: from ipu5-build.bj.intel.com (HELO [10.238.232.171]) ([10.238.232.171])
  by orsmga002.jf.intel.com with ESMTP; 11 Oct 2018 20:21:43 -0700
Subject: Re: question about V4L2_MEMORY_USERPTR on 64bit applications
To:     "Zhang, Ning A" <ning.a.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
References: <1539313441.21249.3.camel@intel.com>
From:   Bing Bu Cao <bingbu.cao@linux.intel.com>
Message-ID: <91f5d31a-d60e-c810-6b0c-23edddef6f1c@linux.intel.com>
Date:   Fri, 12 Oct 2018 11:25:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539313441.21249.3.camel@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ning,

unsigned long   userptr; <<<--- this is a 32bit addr.

I think it's wrong here,for LP64 data modelmachine(unix-like systems), the
actual size ofdata type 'unsigned long'is 8(64bits value)whichis equal
to pointer.
 

On 10/12/2018 11:04 AM, Zhang, Ning A wrote:
> Hi,
>
> I have question about V4L2_MEMORY_USERPTR on 64bit applications.
>
> struct v4l2_buffer {
> 	__u32			index;
> 	__u32			type;
> 	__u32			bytesused;
> 	__u32			flags;
> 	__u32			field;
> 	struct timeval		timestamp;
> 	struct v4l2_timecode	timecode;
> 	__u32			sequence;
>
> 	/* memory location */
> 	__u32			memory;
> 	union {
> 		__u32           offset;
> 		unsigned long   userptr;   <<<--- this is a 32bit addr.
> 		struct v4l2_plane *planes;
> 		__s32		fd;
> 	} m;
> 	__u32			length;
> 	__u32			reserved2;
> 	__u32			reserved;
> };
>
> when use a 64bit application, memory from malloc is 64bit address.
> memory from GPU (eg, intel i915) are also 64bit address.
>
> when use these kind of memory as V4L2_MEMORY_USERPTR, address will be
> truncated into 32bit.
>
> this would be error, but actually not. I really don't understand.
>
> BR.
> Ning.

