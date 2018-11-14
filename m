Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEE1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86BB2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XalUSWO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86BB2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbeKNUVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:21:32 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48506 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732174AbeKNUVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 15:21:32 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAEAI21w098431;
        Wed, 14 Nov 2018 04:18:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542190682;
        bh=vUOWWRUdPOgLydfoDpd64Ej+y+tIu5gUMS5ilrkwaVw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XalUSWO0M6cOakPbhfhwn/Xg7I1GUXOyRU72lQNfuXU79cH+TYAjIBvv6n9ENeLtM
         1U/daJfqu/xrzGvLsAiPiqiC+go5WbdRr0CVf8L1F8ogiGI0X2jnRdxp4anERz+ulW
         ofwSEAaVcpAAJHaXRItPs8/NTsfZc2rdrz+BDht0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAEAI2Mh021520
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Nov 2018 04:18:02 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 14
 Nov 2018 04:18:01 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 14 Nov 2018 04:18:01 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAEAHu9K018732;
        Wed, 14 Nov 2018 04:17:57 -0600
Subject: Re: [PATCH v1 1/5] drivercore: Revert "deferral race condition fix"
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        USB <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        <rogerq@ti.com>, Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>, <grant.likely@arm.com>,
        Andrzej Hajda <a.hajda@samsung.com>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
 <1c2c1031-a6b4-cbce-ceed-c2ce229c204e@ti.com>
 <20181114003345.GV2089@sirena.org.uk>
 <CAHp75Vf7qozL8abZSh1gv_F3iSiZCprEK5_eGW=SRyUpjYrmtA@mail.gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <262d8ef0-ead2-1ec8-d2e1-0c5f6497b1fb@ti.com>
Date:   Wed, 14 Nov 2018 12:19:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf7qozL8abZSh1gv_F3iSiZCprEK5_eGW=SRyUpjYrmtA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy,

On 2018-11-14 10:45, Andy Shevchenko wrote:
> On Wed, Nov 14, 2018 at 2:34 AM Mark Brown <broonie@kernel.org> wrote:
>>
>> On Mon, Nov 12, 2018 at 06:11:26PM +0200, Peter Ujfalusi wrote:
>>
>>> if we revert the commit then the original issue will re-surfaces. afaik
>>> it was not only audio which hit the 'last driver to be probed from the
>>> deferred list would never probe, unless we provoke the kernel to load
>>> additional module, or remove/reload the module' issue.
>>
>> Right, aren't we just going to be swapping one bug for another?
> 
> Have anyone in possession of Davinchi tested most recent kernel with
> this revert?

I don't think it is related to daVinci, in fact we have seen the very
same issue with OMAP4.
Fwiw this was my initial patch
http://lkml.iu.edu/hypermail/linux/kernel/1404.0/01603.html
Grant based his change on this.

Note the part in the commit message:
"The issue has been observed on embedded systems with CONFIG_PREEMPT
enabled, audio support built as modules and using nfsroot for root
filesystem."

as I recall I was only able to reproduce the stall with nfsroot and
buildroot fs. The timings were different compared to MMC rootfs.

Anyways the patch fixes a real race condition which is generic:
We have driverA and driverB as modules. driverB needs driverA to be
registered to a framework (no direct, hard dependency).

1. driverA starts to probe
2. driverB starts to probe
3. driverB can not continue as driverA is not registered itself to the
framework -> driverB will defer
4. driverA registers to the framework
5. driverA probes successfully
6. driver core will prepare the deferred probe list (note: driverB is
still in it's probe, not in the deferred list)
7. driverB returns from it's probe with -EPROBE_DEFER

and here we are, driverB is alone in the deferred list and the list is
not going to be tried as driverA and driverB were the last ones to
probe.

So, driverB is in the deferred list and stays there until other driver
probes successfully as the deferred driver list only tried when a driver
loads successfully (to see if that satisfy any of the deferred driver).

We have evidence that this has happened, it is a generic issue given
that now days we have more frameworks drivers are relying on.

>>> Do I understand correctly that in your case you have two modules
>>> (dwc3-pci and extcon-intel-mrfld) in a deferred probe loop, iow both of
>>> the drivers returns -EPROBE_DEFER and they just spin?
>>
>>> If both is deferring, how this supposed to work?
>>
>> I'm struggling to follow the original explanation too :(
> 
> Sorry, guys, I confused a nit myself. The bug is there, but
> exxplanation is not fully corrent, indeed. I'll come back with more
> details later.
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
