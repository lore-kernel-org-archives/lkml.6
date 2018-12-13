Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3E0C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DAA2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DAA2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeLMJcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:32:52 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:48470 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726578AbeLMJcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:32:51 -0500
X-UUID: 926697806b884b48a978688681d5b666-20181213
X-UUID: 926697806b884b48a978688681d5b666-20181213
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1351068479; Thu, 13 Dec 2018 17:32:29 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 13 Dec
 2018 17:32:27 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Dec 2018 17:32:27 +0800
Message-ID: <1544693547.11699.40.camel@mhfsdcap03>
Subject: Re: [PATCH 4/5] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
From:   Qii Wang <qii.wang@mediatek.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <ryder.lee@mediatek.com>
Date:   Thu, 13 Dec 2018 17:32:27 +0800
In-Reply-To: <20181211202931.xav4gzi7rzh2scgx@ninjato>
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
         <1543843974-4054-5-git-send-email-qii.wang@mediatek.com>
         <20181211202931.xav4gzi7rzh2scgx@ninjato>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-11 at 21:29 +0100, Wolfram Sang wrote:
> > +  - ch-offset: base reg offset for multi-user.
> 
> What is "multi-user"? Why can't you add this offset to the reg-property
> directly?
> 

Thanks for your comment.
There are 3 channel in one MT8183 I3C controller, and every channel can
be used as an I2C controller.
Take the following diagram as example:
If use I3C channels as I2C bus,
1. CH-A/B/C offset are different;
2. If use CH-B or CH-A as I2C, they must config registers which's
address are in CH-A.
 ____________________________________
|     ________                       |
|    |        |<--- offset:0x00      |
|    |  CH-A  |                      |
|    |________|                      |
|    |        |<--- offset:0x100     |
|    |  CH-B  |                      |
|    |________|                      |
|    |        |<--- offset:0x200     |
|    |  CH-C  |                      |
|    |________|                      |
|____________________________________|
        one I3C controller               

Because of CH-B/CH-C depend on CH-A's register, it can't add offset to
reg-property directly.

MT8183 doesn't need to support muti-user according to the latest project
information, and I'll remove this feature from patches.

> > +  - mediatek,share-i3c: i3c controller can share i2c function.
> 
> Please explain in more detail? Is this an I3C controller?
> 

Yes, it is a i3c controller, and it is compatible with i2c. I only use
the feature of i2c, so I need a flag to do some extra settings.


