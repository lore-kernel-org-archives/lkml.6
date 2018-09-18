Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FECC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5042146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD5042146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbeIRNZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:25:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:53699 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbeIRNZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:25:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 00:54:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,389,1531810800"; 
   d="scan'208";a="89728301"
Received: from xuting-mobl.ccr.corp.intel.com (HELO [192.168.4.139]) ([10.255.29.10])
  by fmsmga004.fm.intel.com with ESMTP; 18 Sep 2018 00:54:10 -0700
Subject: Re: [LKP] [ipc] 61224adcd2: general_protection_fault:#[##]
To:     David Howells <dhowells@redhat.com>,
        Rong Chen <rong.a.chen@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>
References: <1dac87f5-fa47-eaf2-ef34-945365e0b2c3@intel.com>
 <7c403b7d-0f60-68ea-d058-cb56d3fece75@intel.com>
 <20180913010517.GB7632@shao2-debian>
 <23069.1536838121@warthog.procyon.org.uk>
 <7969.1537252241@warthog.procyon.org.uk>
 <9189.1537255398@warthog.procyon.org.uk>
From:   Li Zhijian <zhijianx.li@intel.com>
Message-ID: <9df6256f-dcf3-ee6f-dd9d-b7efe2f539e6@intel.com>
Date:   Tue, 18 Sep 2018 15:54:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <9189.1537255398@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/18/2018 3:23 PM, David Howells wrote:
> Still not sure what I'm meant to be seeing.  Note that there are a number of
> "Not found" and "No such file or directory" errors appearing.
>
> I've attached the console log for you.
>
> David
> ---
> warthog>sudo bin/lkp qemu -k /data/fs/linux-next/build2/arch/x86/boot/bzImage job-script
> make: Entering directory '/data/lkp-tests/bin/event'
> gcc    -c -o wakeup.o wakeup.c
> gcc  -static -o wakeup wakeup.o
> rm -f wakeup.o
> strip wakeup
> make: Leaving directory '/data/lkp-tests/bin/event'
> cpio: Cannot open/home/dhowells/.lkp/cache/lkp-x86_64.cpio: No such file or directory
> cpio: Cannot open/home/dhowells/.lkp/cache/lkp-x86_64.cpio: No such file or directory
> cpio: Cannot open/home/dhowells/.lkp/cache/lkp-x86_64.cpio: No such file or directory
> gzip:/home/dhowells/.lkp/cache/lkp-x86_64.cpio: No such file or directory
> mv: cannot stat '/home/dhowells/.lkp/cache/lkp-x86_64.cpio.gz': No such file or directory
> mv: cannot stat '/home/dhowells/.lkp/cache/lkp-x86_64.cgz': No such file or directory

this is not expected.
could you list/home/dhowells/.lkp/cache

looks something wrong at below function
lizhijian@haswell-OptiPlex-9020:~/lkp-tests$ vim lkp-exec/qemu +230
230 create_lkp_src_initrd()
231 {
232         if [[ "$kconfig" =~ ^(i386|x86_64)- ]]; then
233                 local arch=${kconfig%%-*}
234         else
235                 local arch=$(arch)
236         fi
237
238         if [ -d $LKP_SRC/.git ]; then
239                 local head_commit=$(cd $LKP_SRC && git rev-list -n1 HEAD)
240                 local diff_id=$(cd $LKP_SRC && git diff | git patch-id | cut -f1 -d' ')
241                 local src_sig=${head_commit:0:12}_${diff_id:0:12}
242         else
243                 local src_sig=$(ls -lR $LKP_SRC|md5sum|cut -c1-12)
244         fi
245         lkp_initrd=$CACHE_DIR/lkp-$arch-$src_sig.cgz
246         [[ -f $lkp_initrd ]] || {
247                 LKP_USER=$user \
248                 $LKP_SRC/sbin/pack -f -a $arch lkp-src
249                 mv $CACHE_DIR/lkp-$arch.cgz $lkp_initrd
250         }
251 }


Thanks

