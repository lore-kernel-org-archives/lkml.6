Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812DAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F382086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="lffPMhuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F382086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=enneenne.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbeK0Tk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:40:57 -0500
Received: from smtpcmd0756.aruba.it ([62.149.156.56]:55998 "EHLO
        smtpcmd0756.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729443AbeK0Tk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:40:57 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Nov 2018 14:40:56 EST
Received: from [192.168.1.15] ([79.3.83.244])
        by smtpcmd07.ad.aruba.it with bizsmtp
        id 4wce1z01T5GHDdK01wcfkp; Tue, 27 Nov 2018 09:36:40 +0100
Subject: Re: [PATCH -next] pps: using ERR_PTR instead of NULL while
 pps_register_source fails
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net,
        richardcochran@gmail.com, sudipm.mukherjee@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20181126102422.24028-1-yuehaibing@huawei.com>
 <44edc27b-e679-24e8-aef1-fe5b7570f982@enneenne.com>
 <20181127073410.GA13965@kroah.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <53ba0e4e-5848-e6cb-4abf-39db292ba7f3@enneenne.com>
Date:   Tue, 27 Nov 2018 09:36:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181127073410.GA13965@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1543307800; bh=2Ww4w7otSP2eNOBa04gLKF+S28Nruw+OsArTXxoC4wc=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=lffPMhuMQYY5iEGq0bUFRDd9LEL19IAfduy1uhF6Wlu6+5T7cDTpSnltXGBILW2v1
         4GsdoFkzobAyF+SdFt126VeZeKE8Zm6qMjjyZE04EiBPS45056l3NTQjRGnhQFRAaX
         AaiyLsU3X45uE00XnpEOnGM6WpuJfQAo+nYzN6gwOuzq8k1mVpkCCSf8XdFZ7leJrL
         4lBgiaOnBhSbSrN1SmwijZdwW4DeTWnc3WvojDtIlb2aNj1d4BW/+2Ppi9wm/uIGpd
         aMDvGnIdjYc+zsiuCged4Nq7f6b63HfUIH2i8810gwqz3+W9lKYWlM+n/bDlFTm4op
         Hnqf12MT5ZSNQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2018 08:34, Greg KH wrote:
> On Mon, Nov 26, 2018 at 11:43:06AM +0100, Rodolfo Giometti wrote:
>> On 26/11/2018 11:24, YueHaibing wrote:
>>> pps_register_source() has keeps error codes in a local variable,
>>> but it does not make use of the code. This patch let it return
>>> the errcode in case of failure.
>>>
>>> Suggested-by: Richard Cochran <richardcochran@gmail.com>
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>
>> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
> 
> You are the maintainer of this file, shouldn't you be the one sending it
> off to Linus or putting it in your tree somewhere?

This subsystem never had an official tree and in the past I simply acked the 
code and patches was taken by you (or other maintainers) for inclusion... I know 
it's not usual by it worked as is since right now!

However if you prefer having an official tree even for LinuxPPS I can do it and 
then sending my pull requests to Linus! Just let me know what is better for you! :-)

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
