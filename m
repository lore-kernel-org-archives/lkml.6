Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9AAC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7841E218B0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eR5gGUCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfAGXtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:49:07 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43759 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfAGXtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:49:06 -0500
Received: by mail-ed1-f65.google.com with SMTP id f9so2500187eds.10;
        Mon, 07 Jan 2019 15:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m66FkWzWK4Ca77T0mttzUwdOm6hMUj5wpz7jHygHJxo=;
        b=eR5gGUCy+edoG5lufynRkfMK1ZnXTroQawfDEOHX720Qp39G6thntFAbwqcwQSlg4H
         4WWwbW4sllzYlwrOIaNUYI5ER9jHca/HEexMa+Y94H9JSi9iKT9LIW8HfdrjtOxC3Ywb
         tOtBKeCrU09xM+wSxmvkPK1SkHN0wXssY8EOxcoLq7xvjEO8xDrcv6FfBfL6NKR7OmLg
         KLJcCFl7dmM00/J/FuhJahrImviagC3c74hurd8mz3nN2nl5+KwYErZqjns366dvtdOI
         oxrB+HkUUPhKhzzGZqx8IkiP8CNJlHYdAGDBrAl7osYwGg7U37MHbCcUwfm0cVYhmo6F
         tcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m66FkWzWK4Ca77T0mttzUwdOm6hMUj5wpz7jHygHJxo=;
        b=HqLJj12GFS55XV4GDo/qUpYCA4P0rLqpBw/FXoyhnM6GSk55kzsLwsGwhwmV2hRgIN
         vRFhWVuNnVGQYBdbsEbFx7B0aFPNTq242FAtcMG7iJxgs/6g1fibhHw9LjA5I7QmP6Ty
         sNbfeCc4Gy16NaqYpgbxayHTQdUykWzdG/GNCqnE+W9WCXlDAdSA1fGNGWnsLR0USGYL
         WerjD516YtHv2GIpT28Bx7o/sjrTmu8RbUmfL908GGHuyezXnIBEuUk//cT58d3X9zA1
         nisAiZKlgOwbu1lhzHFTf9hf9mUtfSdg3l96y0GuANwGHU4Y5GsIIea8D5aigWVO7aBD
         5QnA==
X-Gm-Message-State: AA+aEWbsotfWVRiyPI0+wnAP/FD2Hd3jWJaGbOyB0xYU37qM/KY3CNlE
        uP4kuqFNlFuGGox9dMvRXg==
X-Google-Smtp-Source: AFSGD/VTzSZXm/YVb+GAuWqfE/hv7XupYD0muTh3KDqpqeQxobehQ109nixgXckZyJZh9CkrBVUrFg==
X-Received: by 2002:a50:f5af:: with SMTP id u44mr59193359edm.172.1546904944649;
        Mon, 07 Jan 2019 15:49:04 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id m14sm39056388edc.27.2019.01.07.15.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 15:49:04 -0800 (PST)
Date:   Tue, 8 Jan 2019 02:49:01 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 0/2] /proc/stat: Reduce irqs counting performance overhead
Message-ID: <20190107234901.GA27074@avx2>
References: <1546873978-27797-1-git-send-email-longman@redhat.com>
 <20190107223214.GZ6311@dastard>
 <CAKOZueuHGg=F8se1AQqswZWCEco=ScmudWq5X5s1qS4+LCtgWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKOZueuHGg=F8se1AQqswZWCEco=ScmudWq5X5s1qS4+LCtgWw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 05:41:28PM -0500, Daniel Colascione wrote:
> There should be a general-purpose way for /proc file readers to tell
> the kernel which bits of information interest them on a particular read
> syscall sequence or particular open(2) or something.

This opens a pandora box full of ioctls. /proc supports ioctls on files
which aren't /proc/$PID and /proc/sys/* though.

So people made a mess with allegedly easy text files and now they
continue to make even more mess adding ioctls on top.
