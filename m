Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7611C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB45214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB45214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbeIRUUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:20:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:24746 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726737AbeIRUUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:20:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 07:47:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,390,1531810800"; 
   d="scan'208";a="89823059"
Received: from xuting-mobl.ccr.corp.intel.com (HELO [192.168.4.139]) ([10.255.29.10])
  by fmsmga004.fm.intel.com with ESMTP; 18 Sep 2018 07:47:10 -0700
Subject: Re: [LKP] [ipc] 61224adcd2: general_protection_fault:#[##]
To:     David Howells <dhowells@redhat.com>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>
References: <9df6256f-dcf3-ee6f-dd9d-b7efe2f539e6@intel.com>
 <1dac87f5-fa47-eaf2-ef34-945365e0b2c3@intel.com>
 <7c403b7d-0f60-68ea-d058-cb56d3fece75@intel.com>
 <20180913010517.GB7632@shao2-debian>
 <23069.1536838121@warthog.procyon.org.uk>
 <7969.1537252241@warthog.procyon.org.uk>
 <9189.1537255398@warthog.procyon.org.uk>
 <9499.1537266023@warthog.procyon.org.uk>
From:   Li Zhijian <zhijianx.li@intel.com>
Message-ID: <3905bb1b-c691-0c8b-490f-599e7a0d561b@intel.com>
Date:   Tue, 18 Sep 2018 22:47:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <9499.1537266023@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/18/2018 6:20 PM, David Howells wrote:
> Li Zhijian <zhijianx.li@intel.com> wrote:
>
>> this is not expected.
>> could you list/home/dhowells/.lkp/cache
> final_initrd  initrd-concatenated  lkp/  lkp-x86_64-ad88cb1a437a_.cgz  osimage/
>
> Note that ~/.lkp is a symlink to somewhere that I don't mind clobbering.
>
> Does this assume that I'm running on some particular OS other than Fedora?

sorry, i cannot reproduce your issue on debian and ubuntu

1. please type following command to verify the lkp-src
$ gzip -dc /home/dhowells/.lkp/cache/lkp-x86_64-ad88cb1a437a_.cgz | cpio -t

it should have something like
lizhijian@ivb44:~$ gzip -dc .lkp/cache/lkp-x86_64-ebf5822e1818_.cgz | cpio -t | head
lkp
lkp/lkp
lkp/lkp/src
lkp/lkp/src/COPYING
lkp/lkp/src/Gemfile
lkp/lkp/src/Makefile
lkp/lkp/src/README.md
lkp/lkp/src/Rakefile
lkp/lkp/src/_config.yml
lkp/lkp/src/allot

2. remove this file and try again with following changes
lizhijian@ivb44:/lkp-qemu/lkp-tests$ git diff
diff --git a/pack/lkp-src b/pack/lkp-src
index 793084cb..ca8717e9 100755
--- a/pack/lkp-src
+++ b/pack/lkp-src
@@ -1,5 +1,5 @@
  #!/bin/bash
-
+set -x
  LKP_SRC=${LKP_SRC:-/lkp/$USER/src}
  export ARCH=${arch:-x86_64}
  LKP_USER=${LKP_USER:-$USER}



Thanks
  

>
> David
