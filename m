Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9122CC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2078A20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="fFCKowTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2078A20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754680AbeFTTCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:02:34 -0400
Received: from services.gouders.net ([141.101.32.176]:58482 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754521AbeFTTCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:02:32 -0400
Received: from localhost (ipservice-047-071-023-039.pools.arcor-ip.net [47.71.23.39])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w5KItYaA026752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 20:55:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1529520935; bh=laQy0EWe+Xb6yOgVdpuGfwQvMc8HH3cwsSww1/lBZL4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date;
        b=fFCKowToRT2sGi21MauVVF0mrT6wmgclIoXFBX7yS5A07R3Hg5md7SjlMw8VY72Vd
         ZuIL4Yt4ohs9kf1MmX54wV0I7Sx9t8wkkwYS9DbxBAhXsFIMOvgLehVaFCuhvLlfA5
         wlGJZH/6FOuPMCO2E2+jp1yW3V50fChfDWI5em5E=
From:   Dirk Gouders <dirk@gouders.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC v8 1/1] mconf: global i-search in menu prompts
In-Reply-To: <f02cc7c6-d92e-24f3-b0ad-df9e6bf7630a@infradead.org> (Randy
        Dunlap's message of "Wed, 20 Jun 2018 11:21:28 -0700")
References: <20180620084217.8597-1-dirk@gouders.net>
        <20180620084217.8597-2-dirk@gouders.net>
        <f02cc7c6-d92e-24f3-b0ad-df9e6bf7630a@infradead.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Date:   Wed, 20 Jun 2018 20:55:31 +0200
Message-ID: <ghpo0l2spo.fsf@lena.gouders.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Hi,
>
> On 06/20/2018 01:42 AM, Dirk Gouders wrote:
>> 
>> Operation
>> ---------
>> The TAB key is reserved to toggle the focus between menu and bottons.
>> Focus is on the buttons if one of the buttens (the active one) is
>> hightlighted, otherwise it is on the menu.
>> 
>> When the focus is on the buttons, mconf operates as before with the
>> exception of the TAB key.
>> 
>> When the focus is on the menu, mconf operates in i-search mode and the
>> following input has special meaning:
>> 
>> * <\> (backslash) can be used to search for other occurences of an
>>   already entered string.  On empty search strings, nothing happens.
>> 
>> * Any other printable character than backslash and '\n' is appended to
>>   the current search string and a match is searched for.  If a match
>>   is found, it is immediately navigated to.
>
> About that paragraph above:  I tried to search for "fs-cache", as in:
>
> config FSCACHE_DEBUG
> 	bool "Debug FS-Cache"
>
> but i-search does not allow me to enter a '-' character.  Seems odd to me.

Hi Randy,

thanks for all your testing.

'-' and '+' previously had the same meaning as <KEY_UP>, <KEY_DOWN>,
respectively.  If you are on the top menu item and press '-' there is
nothing to scroll up so it appears as if the pressed key wasn't
processed.

I-search should add those characters to the pattern but I broke that two
or three versions before when I fixed another issue.

I will add this to my list of test cases so this won't happen again.

Dirk


> Still doing other testing...
>
>
>> * BACKSPACE is used to remove the last character of the search string.
>> 
>> * DEL clears the search string.
>> 
>> * ENTER can be used to enter a submenu.
>> 
>> * ESC ESC exits the current isearch and clears the search string.
>> 
>> * Horizontal arrow keys still cycle between the buttons but also
>>   switch focus to the buttons.
>> 
>> * Vertical arroy keys navigate the menu items.
>> 
>> At any time, at most one i-search is active and the navigation path to
>> the current menu is displayed in the subtitle, the second line in the
>> menu window.
>> 
>> Navigation example:
>> 
>> To navigate to options concerning NFS file systems, simply type 'n',
>> 'f' and 's'.
>> 
>> Hint: use the 'z' key with focus on buttons to search for invisible
>>       prompts.
