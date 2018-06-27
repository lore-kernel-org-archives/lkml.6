Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F7EC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28B723F36
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28B723F36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lucaceresoli.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934039AbeF0JJn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:09:43 -0400
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:50555 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbeF0JJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:09:40 -0400
Received: from [109.168.11.45] (port=55870 helo=[192.168.101.172])
        by srv-hp10.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1fY5Zi-00490X-OY; Wed, 27 Jun 2018 10:13:15 +0200
Subject: Re: [PATCH v4 6/8] media: imx274: add helper function to fill a reg_8
 table chunk
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     linux-media@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
References: <1528716939-17015-1-git-send-email-luca@lucaceresoli.net>
 <1528716939-17015-7-git-send-email-luca@lucaceresoli.net>
 <20180626122053.gd5jmt2wr35s5oh2@valkosipuli.retiisi.org.uk>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <fb7bb663-0708-8271-8f4a-fff906c7babc@lucaceresoli.net>
Date:   Wed, 27 Jun 2018 10:13:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626122053.gd5jmt2wr35s5oh2@valkosipuli.retiisi.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv-hp10.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: srv-hp10.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: srv-hp10.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On 26/06/2018 14:20, Sakari Ailus wrote:
> Hi Luca,
> 
> On Mon, Jun 11, 2018 at 01:35:37PM +0200, Luca Ceresoli wrote:
>> Tables of struct reg_8 are used to simplify multi-byte register
>> assignment. However filling these snippets with values computed at
>> runtime is currently implemented by very similar functions doing the
>> needed shift & mask manipulation.
>>
>> Replace all those functions with a unique helper function to fill
>> reg_8 tables in a simple and clean way.
> 
> What's the purpose of writing these registers as multiple I²C writes, when
> this can be done as a single write (i.e. the address followed by two or
> three octets of data)?

Good point. The for loops applying the register values (the lines just
after those changed by my patch) defuse the regmap bulk write capability.

I guess this could be improved not filling any table, but directly
calling regmap_bulk_write(), passing the u16 or u32 register value with
proper endianness. No tables, less code. This would replace the present
patch with a shorter and more effective one. Is it what you was suggesting?

I'll try that.
-- 
Luca
