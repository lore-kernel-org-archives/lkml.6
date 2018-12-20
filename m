Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A73C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843CA218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlLkoIpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389031AbeLTSdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:33:24 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45032 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730330AbeLTSdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:33:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so2779173wrt.11;
        Thu, 20 Dec 2018 10:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o6tqrjgBU9IJYqPB2xGPdPY4NzsjF6WvKmBIE5jwGFk=;
        b=hlLkoIpHdoqC6XkNcT5+HI4kBO1aG/PQFXdzTyMwuQ4LlyU4c0Qlx2MUD4pOWdD0tq
         hTHygerrLtvwOn+gBByW5uua44N9509wef9JpqE5diDP+bipjN6tVw3OXdov1izjLYaq
         x8345WIyShoGd8BaQDkcEv5MlYGeFavHFU7agjie1b8ox2gWhro+BHkgp1U6CAPOljB9
         s2LgBkNShrvkdxkaiiFzT8FGOATkaHRR5B9NmXU+EGuyoDZsgsnlrX0chbNE83RXhCk4
         +Q9OIZxNgYyr7nHJY8/Ee8e770U2m4Og3lXMys/b/Arhvl7b6iqzEr5ygHfFCh5Uc3Uh
         8PPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o6tqrjgBU9IJYqPB2xGPdPY4NzsjF6WvKmBIE5jwGFk=;
        b=RPpM6ttr9yUu5ZdB3sZoEUEZZnUSlwILWL/uqsu4Mrm0nMrKyFoFAmxY2BXvL9eUsU
         nSVHXHzFJfqGAmqXRFgB4P3hKKtH79gfXap6TaH5PbQ8UljeIFQfDuxFebDA/7G6501D
         JH/UlGTgFjwgqG6OiGYyUjnp8OMFV1a9O2pfN8hyMQgZLMMjjvKSLdUEgVHWzuKTlb3q
         j659RkmnnMyksNg/ohO5Njvh7Suwn+0DVhBE1iIdp9rlZM9gwYtY6oTdOjTJSlbNl27L
         GnXDtyiUAu0Di3A9vOT/KW9+hyAMMdQGAr+VMT1n+Tg/ius4WypflTlnKv4qPD2lPxEe
         g0XA==
X-Gm-Message-State: AA+aEWZSomPkpiCdDYE9NbIY5kRZCF+SHsEsL57q7y4i3Jy/BRtKVYKM
        zFxipwmUFDCp3jexH0KkvtDIzDN/
X-Google-Smtp-Source: AFSGD/UTTh3GLH0KdDvbhGevkMH2u1yJVUykFklLVKGGPu6iybhIEyZea11yfG0DKCprMOgEW9iC7A==
X-Received: by 2002:adf:9f10:: with SMTP id l16mr24334166wrf.206.1545330798954;
        Thu, 20 Dec 2018 10:33:18 -0800 (PST)
Received: from [192.168.1.34] (57.red-95-122-219.staticip.rima-tde.net. [95.122.219.57])
        by smtp.gmail.com with ESMTPSA id n82sm10287138wma.42.2018.12.20.10.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 10:33:18 -0800 (PST)
Subject: Re: [PATCH] quota: Lock s_umount in exclusive mode for
 Q_XQUOTA{ON,OFF} quotactls.
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
References: <1ad62e88-7784-6de8-c03d-01295375e315@gmail.com>
 <20181214095613.GD8896@quack2.suse.cz>
 <20181220082021.GA27845@quack2.suse.cz>
From:   Javier Barrio <javier.barrio.mart@gmail.com>
Message-ID: <ca7483c8-986c-95c1-7224-9e299083b8f8@gmail.com>
Date:   Thu, 20 Dec 2018 19:33:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220082021.GA27845@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/18 9:20, Jan Kara wrote:
> On Fri 14-12-18 10:56:13, Jan Kara wrote:
>> On Thu 13-12-18 01:06:29, Javier Barrio wrote:
>>> Commit 1fa5efe3622db58cb8c7b9a50665e9eb9a6c7e97 (ext4: Use generic
>>> helpers for quotaon and quotaoff) made possible to call
>>> quotactl(Q_XQUOTAON/OFF) on ext4 filesystems with sysfile quota support.
>>> This leads to calling dquot_enable/disable without s_umount held in excl.
>>> mode, because quotactl_cmd_onoff checks only for Q_QUOTAON/OFF.
>>>
>>> The following WARN_ON_ONCE triggers (in this case for dquot_enable, ext4,
>>> latest Linus' tree):
>>>
>>> [  155.036847] WARNING: CPU: 0 PID: 2343 at fs/quota/dquot.c:2469 dquot_enable+0x34/0xb9
>>
>> ...
>>
>>> This patch locks the superblock ->s_umount sem. in exclusive mode for all Q_XQUOTAON/OFF
>>> quotactls too in addition to Q_QUOTAON/OFF.
>>
>> Thanks for the patch! It looks good to me but let me run it past XFS
>> people. Looking at XFS code they definitely do not *need* s_umount in
>> exclusive mode for Q_XQUOTAON/OFF (they have their private mutex for
>> the exclusion). Shared mode they currently get is enough for them. But
>> exclusive mode is fine for them as well AFAICT and it would be easier if
>> all quota backends had the same locking rules wrt VFS locks. XFS guys, any
>> objections to switching Q_XQUOTAON/OFF handlers from having s_umount locked
>> for read to having it locked exclusive?
> 
> Since there were no objections and the patch passed quota xfstests for XFS,
> I've added it to my tree and will push it to Linus in the coming merge
> window.
> 
> 								Honza
> 

Thank you!


	Javier
