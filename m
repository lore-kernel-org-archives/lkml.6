Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7026C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 22:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FF720866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 22:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TpYq5X0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FF720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeIKDrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 23:47:02 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:48848 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeIKDrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 23:47:02 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 076F610C070F;
        Mon, 10 Sep 2018 15:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536619846; bh=MdyufGLD3UJz93s/CtmM1156/lwvgTXNgLUE+DxnQDQ=;
        h=From:To:CC:Subject:Date:References:From;
        b=TpYq5X0aCNan7f/Cqiu2aKlfD1X5fJesPjCJq/7P2Mhd6PcC/TLTkqyyBNdNKYIuS
         IB/JJ0Ks6SPn6NnalskyJ9X3DrWqklCUmd0u22Z7CFGPYXnewfVwFGFgRw5M0mEVls
         qtdVhejy4Z4Gtr7YP/0HokO4UOJocu760nYUB5QBPtUePxHciDxFfXXbQhfPi+e2IX
         UmUVazGg+xo9y+O3U2gmmaF9/RBNO5YZJOXMPWOTsl8gF1j3UXYNAHCbONOpRAhgnG
         TGx0Ffpc66OQ/+DaoVAZ0MLvDmw9MK6G1+L2TABwYRxnGLMkommZ/5lhwSF3MaVMBc
         j+7w9vOY7lX6A==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id BA5D637DF;
        Mon, 10 Sep 2018 15:50:45 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon, 10
 Sep 2018 15:50:45 -0700
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>
Subject: Re: [PATCH v4 6/8] usb: dwc3: check for requests in started list
 for stream capable endpoints
Thread-Topic: [PATCH v4 6/8] usb: dwc3: check for requests in started list
 for stream capable endpoints
Thread-Index: AQHUR4UYRgxFEofqUUKoe+A6FKwC1w==
Date:   Mon, 10 Sep 2018 22:50:44 +0000
Message-ID: <30102591E157244384E984126FC3CB4F544ADF4D@us01wembx1.internal.synopsys.com>
References: <1536418986-16609-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1536418986-16609-7-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <30102591E157244384E984126FC3CB4F544ADE8E@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.20]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=
=0A=
On 9/10/2018 1:13 PM, Thinh Nguyen wrote:=0A=
> Hi Anurag,=0A=
>=0A=
> On 9/8/2018 8:03 AM, Anurag Kumar Vulisha wrote:=0A=
>> For stream capable endpoints, uas layer can queue mulpile requests on=0A=
>> single ep with different stream ids. So, there can be multiple pending=
=0A=
>> requests waiting to be transferred. This patch changes the code to check=
=0A=
>> for any pending requests waiting to be transferred on ep started_list an=
d=0A=
>> calls __dwc3_gadget_kick_transfer() if any.=0A=
> Whenever a function driver queues a request, then=0A=
> __dwc3_gadget_kick_transfer() will be called right? What case exactly is=
=0A=
> this for? Scatter gathering? If so, then we probably need further=0A=
> explanation. (e.g. Why wait to call __dwc3_gadget_kick_transfer() on=0A=
> XferComplete event rather than sending a START_TRANSFER command for=0A=
> every prepared TRB whenever we do __dwc3_gadget_kick_transfer()?).=0A=
=0A=
Please ignore my question.  We only do 1 transfer per stream id at a=0A=
time. That's fine.=0A=
=0A=
Thanks,=0A=
Thinh=0A=
