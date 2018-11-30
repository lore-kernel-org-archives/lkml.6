Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44E7C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCBE2080A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SjKXTjiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DCBE2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbeK3LsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 06:48:03 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56366 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3LsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 06:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zqOovWbYaRDBEar6hMJb6IV7E7eWHASwQGSeAGXjOtM=; b=SjKXTjiNrMLRn42BAXjvGB1+2S
        9Z6OcFIBSf8LBT2WphXpWSDhzHj1JxDPAXa8GFts6TNDGyIdCnctSX9aQFeZnbRCoSlbzQEPr5D6k
        dq6ov52c+ApS8ZRecg58FAsmFhd+kaUM0vwxIy/xMR654wxX7zU9utVJu+B4tq4WOy2LcIvqkfOha
        YGX8OcKwd18s+V5sDPFA2tpIxvI1PqEWNPMvctk29qrAtpsM+/E5DesWkranS2lKT36VIWNEBeMSf
        vTmwv0E1vjPfG17FjVv0sCJ+feVg9/XN7OQK5Kc03UAFBzYNf1FTRcytwoZKIeISXFBqNqXqVyQRP
        k/WqG+uQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSWqe-00075l-HE; Fri, 30 Nov 2018 00:40:00 +0000
Subject: Re: [RFC v3 17/19] of: unittest: migrate tests to run on KUnit
To:     Rob Herring <robh@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Frank Rowand <frowand.list@gmail.com>, knut.omang@oracle.com
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-18-brendanhiggins@google.com>
 <CAL_Jsq+09Kx7yMBC_Jw45QGmk6U_fp4N6HOZDwYrM4tWw+_dOA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <18814973-8f0a-4647-a097-fcc3dc0b3cd3@infradead.org>
Date:   Thu, 29 Nov 2018 16:39:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+09Kx7yMBC_Jw45QGmk6U_fp4N6HOZDwYrM4tWw+_dOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/18 12:56 PM, Rob Herring wrote:
>> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
>> index ad3fcad4d75b8..f309399deac20 100644
>> --- a/drivers/of/Kconfig
>> +++ b/drivers/of/Kconfig
>> @@ -15,6 +15,7 @@ if OF
>>  config OF_UNITTEST
>>         bool "Device Tree runtime unit tests"
>>         depends on !SPARC
>> +       depends on KUNIT
> Unless KUNIT has depends, better to be a select here.

That's just style or taste.  I would prefer to use depends
instead of select, but that's also just my preference.

-- 
~Randy
