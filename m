Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A5DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 11:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5C920815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 11:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5C920815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lucaceresoli.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeKRVd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 16:33:57 -0500
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:60687 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbeKRVd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 16:33:57 -0500
Received: from [78.134.45.135] (port=59578 helo=[192.168.77.57])
        by srv-hp10.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1gOL1T-006E1A-Dh; Sun, 18 Nov 2018 12:13:51 +0100
Subject: Re: [PATCH v3] i2c: mux: remove duplicated i2c_algorithm
To:     Luca Ceresoli <lucaceresoli77@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
References: <20181003151928.17713-1-lucaceresoli77@gmail.com>
 <99cfa6a2-9a60-6bdd-2542-9dd78af75758@axentia.se>
 <70c48ade-b2ac-dde8-4b3e-aa4b2f19940a@gmail.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <205e1d73-2318-ecd4-c531-3ff18a0e0005@lucaceresoli.net>
Date:   Sun, 18 Nov 2018 12:13:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <70c48ade-b2ac-dde8-4b3e-aa4b2f19940a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv-hp10.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: srv-hp10.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: srv-hp10.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 10/10/18 17:48, Luca Ceresoli wrote:
> Hi Peter,
> 
> On 08/10/2018 23:43, Peter Rosin wrote:
>> On 2018-10-03 17:19, Luca Ceresoli wrote:
>>> From: Luca Ceresoli <luca@lucaceresoli.net>
>>>
>>> i2c-mux instantiates one i2c_algorithm for each downstream adapter.
>>> However these algorithms are all identical, depending only on the
>>> parent adapter.
>>>
>>> Avoid duplication by hoisting the i2c_algorithm from the adapters to
>>> the i2c_mux_core object, and reuse it in all the adapters.
>>
>> Ouch, while I like the concept of having one i2c_algorithm per mux,
>> this patch is not working. Various i2c-mux drivers set the
>> muxc->mux_locked variable *after* the i2c_mux_alloc call, and this
>> patch breaks such use.

I finally had a look into this issue. Three drivers are setting
mux_locked after i2c_mux_alloc: i2c-mux-gpmux, i2c-mux-gpio and
i2c-mux-pinctrl.

i2c-mux-gpmux is trivial to fix.

The other two are not trivial because:

 1. they compute mux_locked from other variables
 2. those variables are stored in the drivers "private" data
 3. their private data is stored inside struct i2c_mux_core
    (muxc->priv) which exists only after i2c_mux_alloc()

In those cases computing mux_locked before i2c_mux_alloc() involves
quite invasive changes. It took 3 non-trivial commits just for
i2c-mux-gpio, and I still have to look into i2c-mux-pinctrl.

So the question is: do we really want to do this?

Using the private storage provided by i2c_mux_alloc() is a handy
feature, at least for simpler drivers which know in advance the flags
they need to set. OTOH I don't like individual drivers to manipulate
mux_core flags that look very much like internal data. It makes any
change to the i2c mux core harder, since every changed line could have
side effects in some drivers, which is what's happening here.

What's your opinion about this issue?

Thanks,
-- 
Luca
