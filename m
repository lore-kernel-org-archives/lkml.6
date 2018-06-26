Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7FCC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7602F26A49
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7602F26A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935249AbeFZMLv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:11:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:32910 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934583AbeFZMLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:11:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 05:11:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="52989041"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 26 Jun 2018 05:11:44 -0700
Message-ID: <c4ad247dd1e0b4b13a2ca4e822bc569675556a7d.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/2] eeprom: at24: Add support for address-width
 property
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Chiang, AlanX" <alanx.chiang@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "Yeh, Andy" <andy.yeh@intel.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 26 Jun 2018 15:11:43 +0300
In-Reply-To: <0772C36F3434E145A062D024A4869A09010AA12F@PGSMSX101.gar.corp.intel.com>
References: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com>
         <1529994128-26770-3-git-send-email-alanx.chiang@intel.com>
         <20180626064736.msxcnsi5rsnxp62k@kekkonen.localdomain>
         <0772C36F3434E145A062D024A4869A09010AA12F@PGSMSX101.gar.corp.intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-26 at 15:11 +0800, Chiang, AlanX wrote:

> If it is, I would like to modify it as below:
> 
> case 8:
> 	If (chip->flags & AT24_FLAG_ADDR16) {
> 		chip->flags &= ~AT24_FLAG_ADDR16;
> 		dev_warn(dev, "address-width is 8, clear the ADDR16
> bit\n");
> 	}
> 	break;

No need to put bit clearing inside the loop, something like below would
be slightly better.

if (chip->flags & AT24_FLAG_ADDR16)
	dev_warn(dev, "address-width is 8, clear the ADDR16 bit\n");
chip->flags &= ~AT24_FLAG_ADDR16;

On top of this the message would sound clearer if you put it like

"Override address width to be 8, while default is 16"

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
