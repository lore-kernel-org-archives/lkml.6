Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0178C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A31120837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="FeCNOynF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A31120837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754206AbeFUHEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:04:11 -0400
Received: from services.gouders.net ([141.101.32.176]:55745 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754104AbeFUHEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:04:09 -0400
Received: from localhost ([193.175.198.193])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w5L6vKep009097
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 08:57:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1529564242; bh=pd0O7KjufViIkZ6dzFz7LpDrwA7x7lGcgg/R21Gy7hY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date;
        b=FeCNOynFkOyaUoMps5k10yUg01ponW8asm5RVYToSk6glAgi7PkARWoiKxj8EbV8K
         NtjPnIFOZbLKAZ5x+ydZKQreV9oql4UffFFWc/bdOown2V7KY7Gbds5l7B8AV0akaO
         tXr+RSWKZ1pOcXiZK7N4JN0HgT51A9dq/I96DBqI=
From:   Dirk Gouders <dirk@gouders.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC v8 1/1] mconf: global i-search in menu prompts
In-Reply-To: <126839db-5cc1-7dad-5a1f-21899dc6236e@infradead.org> (Randy
        Dunlap's message of "Wed, 20 Jun 2018 13:02:03 -0700")
References: <20180620084217.8597-1-dirk@gouders.net>
        <20180620084217.8597-2-dirk@gouders.net>
        <f02cc7c6-d92e-24f3-b0ad-df9e6bf7630a@infradead.org>
        <ghpo0l2spo.fsf@lena.gouders.net>
        <126839db-5cc1-7dad-5a1f-21899dc6236e@infradead.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Date:   Thu, 21 Jun 2018 08:57:12 +0200
Message-ID: <ghin6clj93.fsf@lena.gouders.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> On 06/20/2018 11:55 AM, Dirk Gouders wrote:
>> Randy Dunlap <rdunlap@infradead.org> writes:
>> 
>>> Hi,
>>>
>>> On 06/20/2018 01:42 AM, Dirk Gouders wrote:
>>>>
>>>> Operation
>>>> ---------
>>>> The TAB key is reserved to toggle the focus between menu and bottons.
>>>> Focus is on the buttons if one of the buttens (the active one) is
>>>> hightlighted, otherwise it is on the menu.
>>>>
>>>> When the focus is on the buttons, mconf operates as before with the
>>>> exception of the TAB key.
>>>>
>>>> When the focus is on the menu, mconf operates in i-search mode and the
>>>> following input has special meaning:
>>>>
>>>> * <\> (backslash) can be used to search for other occurences of an
>>>>   already entered string.  On empty search strings, nothing happens.
>>>>
>>>> * Any other printable character than backslash and '\n' is appended to
>>>>   the current search string and a match is searched for.  If a match
>>>>   is found, it is immediately navigated to.
>>>
>>> About that paragraph above:  I tried to search for "fs-cache", as in:
>>>
>>> config FSCACHE_DEBUG
>>> 	bool "Debug FS-Cache"
>>>
>>> but i-search does not allow me to enter a '-' character.  Seems odd to me.
>> 
>> Hi Randy,
>> 
>> thanks for all your testing.
>> 
>> '-' and '+' previously had the same meaning as <KEY_UP>, <KEY_DOWN>,
>> respectively.  If you are on the top menu item and press '-' there is
>> nothing to scroll up so it appears as if the pressed key wasn't
>> processed.
>> 
>> I-search should add those characters to the pattern but I broke that two
>> or three versions before when I fixed another issue.
>> 
>> I will add this to my list of test cases so this won't happen again.
>> 
>> Dirk
>> 
>> 
>>> Still doing other testing...
>
> I haven't hit any other issues.

Thank you for testing!
The issue concerning '-' and '+' I will fix.

Dirk
