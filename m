Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FD1C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842F9222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vAMwh8g/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390925AbfBMOrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:47:48 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42075 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfBMOrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:47:48 -0500
Received: by mail-ed1-f68.google.com with SMTP id r15so2135532eds.9;
        Wed, 13 Feb 2019 06:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7IBNKyjatn8X3VFcQkUE2ehE7yrXUj9SXz162g4Ei+U=;
        b=vAMwh8g/XishWbNX2Y9mkE/7sVAGEtfqyzIQFKBMK0Bhk0uM736PtD49W4PocooglJ
         o9MaxCWqjhZSrFTbV1p4Bhsu/046P4RuLNCJU5qEiBuM0Tgic6Tnm8MZpCe9WJmFJQFh
         6KEM9/Xx/MFYqiQWsr3r7h9iC6t370cWx2/eFq6f9KfILvhsL+plyczp9156E49cKIiz
         hQeQawJSyiWXXVJrWDBNTcyxHdW/7pbYVH6mmE2n63WKaihun9iDaz2wsWh/ic9AII4u
         ySvZjGJSKNjuidlana+jJfXSDX4G4OqcD6u4ftKrJL838nl3eebLwwetdFpwwFw37yMK
         DE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7IBNKyjatn8X3VFcQkUE2ehE7yrXUj9SXz162g4Ei+U=;
        b=AimAjPkvJivVahHCxHtPf9or8ZSL2AGLhzD3LHKqtS70lHQmQqEmXv9ejcWzDYvUac
         SQR7fXS7LFTEaQcy7KRwSoAMrZ2LvFjkuh+fQJfCjs9dm5RGUG0icgpls35nnbIJQS2/
         TDH9Ypb37c2yy4QE06srNWnbrp5Fd1QXP488kJQo/qneSLv1suJ6lQtLVi9AGCj37BLR
         E63GV6ri3Qoex8pXrthCeunYHYcb+8eA21Nr5zJON95CybQj+vSF5zU+qsXkuljX4bAE
         TELY7PHuzhOYGkFgFWVO3WZq+I0cCEq3djFgtCqxj8RR7+uZoIMkhx38A707A2YPhI/S
         3+NQ==
X-Gm-Message-State: AHQUAuZjFN3T5Y0Mrw39SSnmJAgAoXoJWmjaJPcmC4YwRXCPIwp+cbDF
        rDR4Z9qZnSQmQ4WG+8M42NU=
X-Google-Smtp-Source: AHgI3IZkT6XLIglVjZCRbIbQcRlvcUgpyC+OWXz6pyYudHLexD+Eg8WUcrVtccQORUsRNUpdjnt3wA==
X-Received: by 2002:aa7:c6c6:: with SMTP id b6mr709742eds.38.1550069266111;
        Wed, 13 Feb 2019 06:47:46 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id l25sm4649849edr.45.2019.02.13.06.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 06:47:45 -0800 (PST)
Date:   Wed, 13 Feb 2019 14:47:44 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xarray: Document erasing entries during iteration
Message-ID: <20190213144744.ifejzbxrbaltivwc@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190212072958.17373-1-tobin@kernel.org>
 <20190212135129.GL12668@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212135129.GL12668@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 05:51:29AM -0800, Matthew Wilcox wrote:
>On Tue, Feb 12, 2019 at 06:29:58PM +1100, Tobin C. Harding wrote:
>> I had my first go using the XArray today and during that I wondered if
>> it was safe to remove items during iteration.  Conceptually it seems
>> fine and it seemed to work just fine in code - is this something people
>> should not be doing for any reason?  Is this the best way to traverse
>> the tree and get every thing just to erase it?  Are we even supposed to
>> be thinking this is a tree or should we just be thinking it is an array?
>
>You should be thinking it's an array.  I've done everything I can to
>hide the fact that it's implemented as a tree because it's conceptually
>an array.
>
>The xa_for_each() iterator is designed to be extremely robust, at the
>expense of some performance.  The only state it keeps is the @index,
>so you can do anything you like to the XArray during the iteration.
>
>It's definitely worth being clearer in the documentation, for
>the benefit of people who're wondering what the equivalent of
>list_for_each_entry_safe() is.  So I'll apply this patch in a day or
>two unless anybody has further comment on it.
>
>> (As you might have guessed I _still_ don't know exactly how a radix tree
>> works :)
>
>That is _fine_.  As you know I hope to get rid of the radix tree soon ;-)
>

You mean replace radix tree in whole kernel? That would be a big effort.

BTW, have we compared the performance difference?

>> Oh, and FTR the XArray is hot - good effort man.
>> 
>> thanks,
>> Tobin.
>> 
>> 
>>  Documentation/core-api/xarray.rst | 3 ++-
>>  include/linux/xarray.h            | 2 ++
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
>> index 5d54b27c6eba..2578e0bdaa17 100644
>> --- a/Documentation/core-api/xarray.rst
>> +++ b/Documentation/core-api/xarray.rst
>> @@ -97,7 +97,8 @@ You can copy entries out of the XArray into a plain array by calling
>>  :c:func:`xa_extract`.  Or you can iterate over the present entries in
>>  the XArray by calling :c:func:`xa_for_each`.  You may prefer to use
>>  :c:func:`xa_find` or :c:func:`xa_find_after` to move to the next present
>> -entry in the XArray.
>> +entry in the XArray.  It is safe to call :c:func:`xa_release` on entries
>> +as you iterate over the array using :c:func:`xa_for_each`.
>
>that's spelled `xa_erase` ;-)
>
>>  Calling :c:func:`xa_store_range` stores the same entry in a range
>>  of indices.  If you do this, some of the other operations will behave
>> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
>> index 5d9d318bcf7a..1f8974281a0a 100644
>> --- a/include/linux/xarray.h
>> +++ b/include/linux/xarray.h
>> @@ -407,6 +407,8 @@ static inline bool xa_marked(const struct xarray *xa, xa_mark_t mark)
>>   * you should use the xas_for_each() iterator instead.  The xas_for_each()
>>   * iterator will expand into more inline code than xa_for_each().
>>   *
>> + * It is safe to erase entries from the XArray as you iterate over it.
>> + *
>>   * Context: Any context.  Takes and releases the RCU lock.
>>   */
>>  #define xa_for_each(xa, index, entry) \
>> -- 
>> 2.20.1
>> 

-- 
Wei Yang
Help you, Help me
