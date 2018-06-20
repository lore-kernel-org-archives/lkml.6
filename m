Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9F2C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF3020875
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5dsWk5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF3020875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754567AbeFTQUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:20:48 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44487 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754548AbeFTQUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:20:46 -0400
Received: by mail-lf0-f67.google.com with SMTP id p23-v6so167290lfh.11;
        Wed, 20 Jun 2018 09:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ju8PtELIqgoIk5huwRdbUX6rV3vDV4Dz/UoQntvf9c8=;
        b=q5dsWk5dgtfguqFttd2byr8U11GQ/6HcWlm/TvRuuzKtWWZGJs2SnJx0H2rN1CRjXY
         7nIRI1zdOj2z95SLvXZ2hapT/PGAWcPVB9OhaZyW/oRWQpbhKuzj6tzJ4PRnM8dPP3Gj
         qk+zAy9SDKeflUYnqLmkmwYMdLth3BqhrrCxKLVrstqvlnjsAAWfY6YyO1RCfiCSOVvr
         kTzuhGodYtQTdBxw+A95etUufsmf06q0igQ4QzcDk1ROJUHCbs5dEyI5eVRaAhQzXo6N
         +pegl4xVKv8mIgbEgxCpb2/dMveVJUC2vctIuORDZmX1WQMXETga//Mv3V7ZW+qIA1pj
         OhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ju8PtELIqgoIk5huwRdbUX6rV3vDV4Dz/UoQntvf9c8=;
        b=GqJ6/Qfv8NLYCpvrc3svrm76t5qVKmiJDVUzOujOWFmug8KrK/bei9fYoTalWC3Fq+
         /AiQCbNgcIjYZeAQwD/dw1rrywMxoe9b/XV0TtQ9AyZdepe0PTNTHt1Aul7m67rIDGou
         sVVuWhidzD/ZekaxjACX8DjAsQkAjvbL2B6+irn4p9zP9zr7S/+on1kPvT0h5DjSYUKD
         UzNCXJJFt6/mIkvpA/CWSx7efSqOCUcJd9ALsJlFAzMj2BcyvFUGzbDSvMva890TgW1O
         fVR28Yfxwa1bijpqOBJMzlzpzFILJ/oQXA9uOlCY520uqb9UCaqPMuKBq5TnlYt2j4NV
         rSzg==
X-Gm-Message-State: APt69E2oO+JUy8vMS2QNAKAoSbcTh0mNL6WZQhjWzkpysit9jkCEW32/
        AarIXm1IFV1T/dN9uIdhHwLq6VzHb3uPNnQezIk=
X-Google-Smtp-Source: ADUXVKJQI3sGRDTyYmEOC+5GNT3d/mztj5vJp/YqfsF5qe/Rdp5NwdZEV4Kj29lkVBhD47RkVGJrSOPNSo1Rzl0NIxc=
X-Received: by 2002:a2e:40d9:: with SMTP id r86-v6mr14558154lje.19.1529511645328;
 Wed, 20 Jun 2018 09:20:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 09:20:44
 -0700 (PDT)
In-Reply-To: <5ffd5433-6bb3-71a8-2b33-ceef50ddf6d7@suse.de>
References: <20180620095228.3686471-1-arnd@arndb.de> <5ffd5433-6bb3-71a8-2b33-ceef50ddf6d7@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Jun 2018 18:20:44 +0200
X-Google-Sender-Auth: u1FaefQbaqocJKOQY1QjnJ93wKI
Message-ID: <CAK8P3a1S4mRH5jkpv3ecKhEkHUH5799uEF6eq_wBx7Z07NqVWA@mail.gmail.com>
Subject: Re: [PATCH] bcache: stop using the deprecated get_seconds()
To:     Coly Li <colyli@suse.de>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Michael Lyle <mlyle@lyle.org>,
        Tang Junhui <tang.junhui@zte.com.cn>,
        Hannes Reinecke <hare@suse.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-bcache@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 5:51 PM, Coly Li <colyli@suse.de> wrote:
> On 2018/6/20 5:51 PM, Arnd Bergmann wrote:
>> bcache uses get_seconds() to read the current system time and store it in
>> the superblock as well as in uuid_entry structures that are user visible.
>>
>> This changes over from the deprecated function to
>> ktime_get_real_seconds(), which returns a 64-bit timestamp as it
>> should. Unfortunately, the two structures are still limited to 32 bits,
>> so this won't fix any real problems. Let's at least document that
>> properly, in case we get an updated format in the future it can be
>> fixed. Until then, we still have some time, and checking the tools
>> at https://github.com/koverstreet/bcache-tools reveals no access to
>> any of them.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Hi Arnd,
>
> Firstly thanks to your patch, especially the detailed information in
> patch log, it helps me to understand the problem more easier.
>
> From the information, it seems the problem is current 32bit time stamp
> will be overflow in 2106. So it will be 88 years later, which I have to
> say I don't care.
>
> Also for get_seconds() which works well for current code as many other
> places call it, I would like to keep it.

I'm currently in the process of removing all instances of get_seconds()
with patches like this. In many cases, we actually want to use
ktime_get_seconds() to return a monotonic time that is immune
to concurrent setttimeofday() calls, in others the code needs to be
changed to avoid the y2038 overflow. For bcache, we don't
really need either of them, but I'd still want to move over everything
to ktime_get_* based interfaces.

Should I clarify that motivation in the changelog text further?

I can also do a simple replacement of get_seconds() with
ktime_get_real_seconds() throughout bcache instead of
adding the intermediate helper function.

      Arnd
