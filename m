Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1E7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305C426CD2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GQ8dawrk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305C426CD2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbeFZPg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:36:56 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43525 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751144AbeFZPgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1530027415; x=1561563415;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=bUkh17lpERxvU4JnjJvWq4FBD238xDu4V40k4uewZQ0=;
  b=GQ8dawrkXP7zoXg4B+E74yeHu/pOdEM9ugaOmhEVbDwOEI3EPjj0mMt0
   6rr2mIiux0k5dqXSlvThvzoyQWdljGbp4cNZoXB2sITCUpjLDaiGnajvr
   Jhr+QF9A1Bnx5Yy0f9L71NMhOKvD46tIgcYhOqQs7tvI2QIU1ORbrqzEL
   JAJcIHGeWApTyniA7jp9UI9HjTF1k4Ll5FdSW4dMHWW/Lcz1deQeK3TDe
   M8gf2acajk1yZk4KXkmDZyrSckwhhAtX23kiTkfkI6sWX0i8lJV54JyRM
   fbgzLbstjpwtRQbtNcHdxBJ1Wbutk4+u/khfxwi6hbF3cIzPPWayzVDaH
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,274,1526313600"; 
   d="scan'208";a="84513042"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2018 23:36:55 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Jun 2018 08:26:28 -0700
Received: from thinkpad-bart.sdcorp.global.sandisk.com (HELO [10.111.67.248]) ([10.111.67.248])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2018 08:36:54 -0700
Subject: Re: [PATCH] blk-mq: use mutex_trylock to avoid lock inversion
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1529391637-1704-1-git-send-email-jianchao.w.wang@oracle.com>
 <2409013d789ca266879d24c815b76c2193e23fe3.camel@wdc.com>
 <d528a730-8e44-225b-2a35-3544160761dc@oracle.com>
 <2c2003ff1baac05688495677f67239d52f6d9527.camel@wdc.com>
 <2a1dda06-5c7c-b75b-c1ae-75d1a2a49694@oracle.com>
 <a0350d07-3c11-c04c-d9ba-94a5868e7d8f@oracle.com>
From:   Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <1d4d1dc3-7014-4e2a-1ea5-e1446381b404@wdc.com>
Date:   Tue, 26 Jun 2018 08:36:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <a0350d07-3c11-c04c-d9ba-94a5868e7d8f@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/18 20:47, jianchao.wang wrote:
> V2 patch has been posted, would you please take a look at on them ?
> https://marc.info/?l=linux-block&m=152965143412927&w=2

Hello Jianchao,

Patches 1/3 and 2/3 of that series look fine to me but I don't like the 
approach of patch 3/3 so please do not expect a review from me for that 
patch.

Thanks,

Bart.
