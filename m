Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBC2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FCC2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DIi8eeJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FCC2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeIEUqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:46:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48402 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIEUqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lTndneC71QWfc0gZpQj9NFHSswXZ/2J3iy0L2qCEgoI=; b=DIi8eeJdPTOlTG/i7sCquoFGF
        7TyAHouwMXJN2NQDpju6WcdC3GWjgFzpmj/YNqrXvnRuLlevdNPeeqZISsWoOgcTS7qXUwXtamPlv
        toLSENe0pv0RYIYsRTskBXMUPD9tIHWeRalrY9hnm9wzwSQKJDWg+IDv/ykSPvFmLirwOzXq97xug
        6//9LXStWpGa0dlPk4BQ54Fm3c/HRd6KDFwS85/YTfKhWE7bzgNf+NTkIanKRKuX06WrwK5rzUAsK
        EVYN30YvEY93xSWwKfc7yDhBvU7qbu0DIF1uelQCHvbX25Warawgr1Z3/iSPn+3U76/Kgozvorayt
        mmNq1SoTg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxaTF-0004um-UY; Wed, 05 Sep 2018 16:15:58 +0000
Subject: Re: [PATCH] kbuild: modules_install: Warn if System.map file is not
 found
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <b82ada4b-25d1-5612-4405-d6a09eb59433@infradead.org>
 <CAK7LNATshpTJ5sDH7pMzBbhd-zF7Yskv6ptiysn1X+pHB1Z8Dw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3c595996-d6b2-1714-8b3b-3f21ab56263f@infradead.org>
Date:   Wed, 5 Sep 2018 09:15:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNATshpTJ5sDH7pMzBbhd-zF7Yskv6ptiysn1X+pHB1Z8Dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2018 12:17 AM, Masahiro Yamada wrote:
> Hi Randy,
> 
> 2018-09-01 7:33 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> If there is no System.map file for "make modules_install",
>> scripts/depmod.sh will silently exit with success, having done
>> nothing.  Since this is an unexpected situation, change it to
>> report a Warning for the missing file.  The behavior is not
>> changed except for the Warning message.
>>
>> The (previous) silent success and new Warning can be reproduced
>> by:
>> $ make mrproper; make defconfig
>> $ make modules; make modules_install
>>
>> and since System.map is produced by "make vmlinux", the steps
>> above omit producing the System.map file.
>>
>> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>>  scripts/depmod.sh |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> --- lnx-419-rc1.orig/scripts/depmod.sh
>> +++ lnx-419-rc1/scripts/depmod.sh
>> @@ -11,6 +11,7 @@ DEPMOD=$1
>>  KERNELRELEASE=$2
>>
>>  if ! test -r System.map ; then
>> +       echo "Warning: modules_install: missing 'System.map' file"
>>         exit 0
>>  fi
> 
> Thanks for the patch.
> 
> 
> For consistency, I'd like to suggest '>&2' for this warning too.
> 
> 
> Also, could you add a little more info
> about what happened (or what did not happen) then ?
> 
> 
> 
> For example,
> 
> 
> Warning: modules_install: missing 'System.map' file.  Skipping depmod.

Sure, will do.

thanks,
-- 
~Randy
