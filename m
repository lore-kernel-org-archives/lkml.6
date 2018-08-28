Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E8DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6119C2087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y0fmdz40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6119C2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeH1Xt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:49:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46170 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbeH1Xt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TGxruCtIGC7lNOti6xCrQl6albp2BM4KRA2nlWn4cuA=; b=Y0fmdz40wlGoaj5wv/OlOcYXDW
        UlsoEtH4HClkcpUfi1SbIPKBuTEvAtFcVSUJ55eG5MsAg7KCFUY0Xp5WOv4vW9ETm2HJ2vESTYduP
        BMG5OyuitQKVbA5Q8g4duuU3nZDrS8G3Px8ZO6H5EhVO7K19a337tERgnAtvGn7vk25TZQIjrkNRA
        Ww9xH157OZBuq84dxKFhE28B5upULHNVYuXx4CtMgWHKrw7glxloltaBUyJO8WHal+2fROgSXH343
        1cQm81o4o3hr0vgy82l2ZHGMI+ijsKJN1jNycbfZRvhY4ZW7Sk42vSlQ0vZyOSzJ0MyX0so98vaXs
        XVVN/3hQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuk5h-0004jG-Ss; Tue, 28 Aug 2018 19:55:54 +0000
Subject: Re: [PATCH v3] modules_install: make missing $DEPMOD a warning
 instead of an error
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jessica Yu <jeyu@kernel.org>,
        Chih-Wei Huang <cwhuang@linux.org.tw>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
References: <4449cd91-fae5-caf1-a917-82e0c5f0aba8@infradead.org>
 <CAK7LNASyhKFp+AWQr-RWTRbMu78=G7Uj=350xrjq_Lht8MVYzQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c9066b61-6666-5adc-1f34-f8cea91864c5@infradead.org>
Date:   Tue, 28 Aug 2018 12:55:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNASyhKFp+AWQr-RWTRbMu78=G7Uj=350xrjq_Lht8MVYzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/23/2018 09:20 PM, Masahiro Yamada wrote:
> Hi Randy,
> 
> 
> 2018-08-24 3:13 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> When $DEPMOD is not found, only print a warning instead of exiting
>> with an error message and error status.
> 
> 
> Could you add the motivation of this change
> (as Nikolaus reported) ?
> 
> Without the reason recorded in git-log,
> somebody may wonder why this commit is useful.
> 

Added for v4.

> 
>> Warning: 'make modules_install' requires /sbin/depmod. Please install it.
>> This is probably in the kmod package.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Fixes: 934193a654c1 ("kbuild: verify that $DEPMOD is installed")
>> Cc: stable@vger.kernel.org
>> Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
>> Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
>> Cc: Michal Marek <michal.lkml@markovi.net>
>> Cc: Jessica Yu <jeyu@kernel.org>
>> Cc: Chih-Wei Huang <cwhuang@linux.org.tw>
>> Cc: H. Nikolaus Schaller <hns@goldelico.com>
> 
> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> 
> 

Added for v4.

> 
> 
>> ---
>> v2: add missing "exit 0" and update the commit message (no Error).
>> v3: add Fixes: and Cc: stable
>>
>>  scripts/depmod.sh |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> --- lnx-418.orig/scripts/depmod.sh
>> +++ lnx-418/scripts/depmod.sh
>> @@ -15,9 +15,9 @@ if ! test -r System.map ; then
>>  fi
>>
>>  if [ -z $(command -v $DEPMOD) ]; then
>> -       echo "'make modules_install' requires $DEPMOD. Please install it." >&2
>> +       echo "Warning: 'make modules_install' requires $DEPMOD. Please install it." >&2
>>         echo "This is probably in the kmod package." >&2
>> -       exit 1
>> +       exit 0
>>  fi
>>
>>  # older versions of depmod require the version string to start with three
> 
> 
> 
> BTW, if System.map is missing, depmod is silently skipped.
> 
> 
> I think if System.map is missing, a user is doing something wrong,
> but you could do like this:
> 
> $ make mrproper
>    [snip]
> $ make defconfig
>    [snip]
> $ make modules
>    [snip]
> $ make modules_install
>   INSTALL drivers/thermal/x86_pkg_temp_thermal.ko
>   INSTALL fs/efivarfs/efivarfs.ko
>   INSTALL net/ipv4/netfilter/ipt_MASQUERADE.ko
>   INSTALL net/ipv4/netfilter/iptable_nat.ko
>   INSTALL net/ipv4/netfilter/nf_log_arp.ko
>   INSTALL net/ipv4/netfilter/nf_log_ipv4.ko
>   INSTALL net/ipv4/netfilter/nf_nat_ipv4.ko
>   INSTALL net/ipv6/netfilter/nf_log_ipv6.ko
>   INSTALL net/netfilter/nf_log_common.ko
>   INSTALL net/netfilter/nf_nat.ko
>   INSTALL net/netfilter/nf_nat_ftp.ko
>   INSTALL net/netfilter/nf_nat_irc.ko
>   INSTALL net/netfilter/nf_nat_sip.ko
>   INSTALL net/netfilter/xt_LOG.ko
>   INSTALL net/netfilter/xt_addrtype.ko
>   INSTALL net/netfilter/xt_mark.ko
>   INSTALL net/netfilter/xt_nat.ko
>   DEPMOD  4.18.0+
> 
> 
> The log looks like all the process went well,
> but depmod is actually skipped because System.map is
> generated by "make vmlinux"
> 
> 
> What do you think we should do about this case?
> 
> Skip depmod silently?
> Make it fail?
> Print noisy warning like missing depmod case?

Since this shouldn't be happening, I prefer the noisy warning message
like the missing depmod case.

Do you want a separate patch for that?

thanks,
-- 
~Randy
