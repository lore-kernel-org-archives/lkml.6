Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01EDECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EAE20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="Ae+ezBmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56EAE20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeJ0EEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:04:31 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:17962 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeJ0EEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:04:31 -0400
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 56177449CDA;
        Fri, 26 Oct 2018 21:26:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1540581972;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=ZAyHo5CkCzGVHVUmdjgBLIEhsYQEP9qajwxc3yOZDSc=;
        b=Ae+ezBmEoRKhZj4XLOTGF1dWdZiFVEqt1/WqeyMFOu5Jbq5f4LMESUAiCoqR/5Y/W4+vc1
        lzWLfL+iZFjiO0sNEbsfpkITEZM75ozpBDukATWv9uRXS+c7jUKK5V4b63r/E3thixFOWF
        kU23ymxEl/o0ImWBPUHp4EB1434ieWw=
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 56177449CDA
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Oct 2018 21:26:12 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Dave Taht <dave.taht@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: CAKE and r8169 cause panic on upload in v4.19
Message-ID: <61d09f0db41f269cc9ee13dd68a5c285@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.7
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1540581972;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=ZAyHo5CkCzGVHVUmdjgBLIEhsYQEP9qajwxc3yOZDSc=;
        b=NYnpyRLYzRecEw+RTvAUgBTPS+UEh+fUj5a0UROEWO+qoiIbdT8hO2d5g8yGSRPs3kkIaj
        D6FjHzZrFjrGum+VCWZc+jr1pZ6G3HksZMIs88SrT9t+BFpGfu/6qOCcdrfqhgCMMK/lYs
        DiWYrMftrp78jbGHY3WI5knyfr99YgA=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1540581972; a=rsa-sha256;
        cv=none;
        b=fuEuIk6jSFNLAXxWU4FVIUdUHjQ7d6Gt5AgY2mglBiTySr5TeuQOjcaSH5lsfVwDKOTFDOPI4YmMjONPOEx8/GpG8sGONbicijCR+jcvNRwqjDuzfw3jr0g0juXjKUxcwsF90yxr/Q9tLAJ5IFc1D/Iy6sFW4tQyc+B697A90sE=
ARC-Authentication-Results: i=1;
        vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I was excited regarding the fact that v4.19 introduced CAKE, so I've 
deployed it on my home router.

I used this script of mine [1]:

# bufferbloat enp3s0.100 20 20

to do its job on the VLAN interface, where 20/20 ISP link is switched 
from the home switch. Basically, it just follows [2] with simple 
bandwidth restriction and egress mirroring using ifb.

Then I thought it would be nice to run speedtest-cli on one of the 
computer in the home LAN, connected to this router. Download stage went 
fine, but immediately after upload started I've got a panic on the 
router: [3] (sorry, it is a photo, netconsole didn't work because, I 
assume, the panic happened in the networking code). I rebooted the 
router and tried once more, and got the same result, again during upload 
stage. Then I rebooted again, replaced CAKE script with my former HTB 
script, and after running speedtest-cli a couple of times there's no 
panic.

Before running speedtest-cli I was using CAKE for a couple of days 
without generating much traffic just fine. It seems it crashes only if 
lots of traffic is generated with tools like this.

My sysctl: [4] and ethtool -k: [5]

So far, I've found something similar only here: [6] [7]. The common 
thing is r8169 driver in use, so, maybe, it is a driver issue, and CAKE 
is just happy to reveal it.

If it is something known, please point me to a possible fix. If it is 
something new, I'm open to provide more info on your request, try 
patches etc (as usual).

Thanks.

-- 
   Oleksandr Natalenko (post-factum)

[1] https://gist.github.com/4b27c49a7f9b4d775e2e38ba23d3f13c
[2] https://www.bufferbloat.net/projects/codel/wiki/Cake
[3] https://bit.ly/2SlUl7R
[4] https://gist.github.com/pfactum/bdad2594b151578f460857cacd94c689
[5] https://gist.github.com/pfactum/cad2cc5d1512b31fbc76d821b3e63dbf
[6] https://boards.4chan.org/g/thread/68171835#p68188019
[7] https://i.4cdn.org/g/1540307271879.jpg
