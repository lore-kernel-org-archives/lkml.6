Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48596C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E319E24914
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M9KEqXNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E319E24914
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754567AbeFVVeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:34:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55974 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754134AbeFVVeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nYoyN7z+/+WJooMrgbxAKjwS+KtK+SiQ3FsbsSCRLpI=; b=M9KEqXNV3Wl5ibaA5Q/mo79C2D
        WY1vZH9OpKJCdJhNRUi1nMu+AdV8X1NJB9Ti0i6p87BDEWW8/iRE7pNQXNQB/IY+LkaXgjglU0WAJ
        Vq76hXGgrJ/bmaTf8nPkaYlWIqNN8bsWOwEjXJ+pH3EVR6wpytkFIF2dDQHP3lCPh5+g56BZYQrcx
        g7+SM2ujtsCIi4q35i+EQ6SAfQF15QMgSadqVmnHEB0ednqqeXcKAIDTZEZ1DHv+ktDXiKr6H6xOU
        ISfU7XJO42ZCgc+YCKrsuBWtSu32XMzd/Nv+LR8845aKMFRaJolejD3+rcN2qZedJFItsJXjNDmPw
        lSDmszwQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWTga-0003ea-Bm; Fri, 22 Jun 2018 21:33:40 +0000
Subject: Re: [PATCH v4 2/3] PCI: Allow specifying devices using a base bus and
 path of devfns
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20180622194315.10475-1-logang@deltatee.com>
 <20180622194315.10475-3-logang@deltatee.com>
 <c1278ab2-63a8-19b6-9c8d-fed0b4f94c11@infradead.org>
 <7e5b459d-f083-286c-bd6c-87cf62cc7541@deltatee.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f4bbe0f2-1087-c626-7776-a4fb6b5457c8@infradead.org>
Date:   Fri, 22 Jun 2018 14:33:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <7e5b459d-f083-286c-bd6c-87cf62cc7541@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22/2018 01:50 PM, Logan Gunthorpe wrote:
> 
> 
> On 22/06/18 02:01 PM, Randy Dunlap wrote:
>>> Thus, we add an option to specify devices in the following format:
>>>
>>> [<domain>:]<bus>:<slot>.<func>[/<slot>.<func>]*
>>
>> Please explain the trailing '*'.  I looked thru the code and it doesn't
>> seem to look for it or care.
> 
> This was Willy's suggestion and I liked it. It's similar to regular
> expression syntax: the '*' indicating you may have any number of the
> expression repeated in the square brackets.

Oh, OK.  I can do that syntax, I just didn't know that this was
using that notation.

Hopefully admins can read it that way.

-- 
~Randy
