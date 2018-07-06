Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B15C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A208524003
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U2Pd3Ish"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A208524003
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753796AbeGFKDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:03:19 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50048 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753529AbeGFKDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:03:09 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w66A2YKA019219;
        Fri, 6 Jul 2018 05:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530871354;
        bh=r/vbPWs7xiY7YgdwZimIgK/Sqh8JaDNutscMRUsOK7I=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=U2Pd3Ishn6S9Hdwx4XlcMaQyrSGcX7hWS1M8oYcT6bRT03qmyoC1neg4/nUszAjjk
         qnUt5QJ80WMrw26S7G8dh98pAqanuoIcDoQMe7q8VBvpGtiqrs7H4gvYsxXEvH+9Mf
         Iw8CTFXkEC1X02B0I+noh5UiseHjLhLVWkpr8HP4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w66A2YRK015713;
        Fri, 6 Jul 2018 05:02:34 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 6 Jul
 2018 05:02:34 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 6 Jul 2018 05:02:34 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w66A2T4t020834;
        Fri, 6 Jul 2018 05:02:30 -0500
Subject: Re: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer
 ordering in device_kset
To:     Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <4685360.VNmeYLh0dQ@aspire.rjw.lan>
 <CAFgQCTusBM0-E=wAJgRJA7g-RnDi9ts==-M7KezNBwSWnyO=HA@mail.gmail.com>
 <6281446.GoJLz6Hq6C@aspire.rjw.lan>
 <CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com>
 <CAJZ5v0jo5-z0ZYDzdNPpn54+oAxpdG_=EvVDdz-HKxp7psu-EA@mail.gmail.com>
 <20180706083603.GA9063@wunner.de>
CC:     Pingfan Liu <kernelfans@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux PM <linux-pm@vger.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <34c333f2-d90d-0f6b-83c8-b66c63628a1e@ti.com>
Date:   Fri, 6 Jul 2018 15:32:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180706083603.GA9063@wunner.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Grygorii, linux-omap

On Friday 06 July 2018 02:06 PM, Lukas Wunner wrote:
> [cc += Kishon Vijay Abraham]
> 
> On Thu, Jul 05, 2018 at 11:18:28AM +0200, Rafael J. Wysocki wrote:
>> OK, so calling devices_kset_move_last() from really_probe() clearly is
>> a mistake.
>>
>> I'm not really sure what the intention of it was as the changelog of
>> commit 52cdbdd49853d doesn't really explain that (why would it be
>> insufficient without that change?)
> 
> It seems 52cdbdd49853d fixed an issue with boards which have an MMC
> whose reset pin needs to be driven high on shutdown, lest the MMC
> won't be found on the next boot.
> 
> The boards' devicetrees use a kludge wherein the reset pin is modelled
> as a regulator.  The regulator is enabled when the MMC probes and
> disabled on driver unbind and shutdown.  As a result, the pin is driven
> low on shutdown and the MMC is not found on the next boot.
> 
> To fix this, another kludge was invented wherein the GPIO expander
> driving the reset pin unconditionally drives all its pins high on
> shutdown, see pcf857x_shutdown() in drivers/gpio/gpio-pcf857x.c
> (commit adc284755055, "gpio: pcf857x: restore the initial line state
> of all pcf lines").
> 
> For this kludge to work, the GPIO expander's ->shutdown hook needs to
> be executed after the MMC expander's ->shutdown hook.
> 
> Commit 52cdbdd49853d achieved that by reordering devices_kset according
> to the probe order.  Apparently the MMC probes after the GPIO expander,
> possibly because it returns -EPROBE_DEFER if the vmmc regulator isn't
> available yet, see mmc_regulator_get_supply().
> 
> Note, I'm just piecing the information together from git history,
> I'm not responsible for these kludges.  (I'm innocent!)
> 
> @Pingfan Liu, if you just remove the call to devices_kset_move_last()
> from really_probe(), does the issue go away?
> 
> If so, it might be best to remove that call and model the dependency
> with a call to device_link_add() in mmc_regulator_get_supply().

hmm.. had a quick look on this and looks like struct regulator is a regulator
frameworks internal data structure, so its members are not accessible outside.
struct regulator's device pointer is required for device_link_add().

Thanks
Kishon
