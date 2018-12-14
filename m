Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66EEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6A9206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFFm8mv2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbeLNStx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:49:53 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38446 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730405AbeLNStw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:49:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so6805775wml.3;
        Fri, 14 Dec 2018 10:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=20AI8Vd+lVCP42bKmvXJ3gL8wdv8rTxtjbblEkhbpk0=;
        b=MFFm8mv2mo/bteYJiFNUPdQSh7+EBrIgLL8nsY8ziFsATqxjdIXd0KBx1Du8vOY5vt
         aZ0M1g+QyH9/Dvc1+WFGUAkgjodrBCoFNpqh6WeGyVps2X1NslFRToxjqUCVwqlrGcoN
         eZqCgKvDhJCoS5YUe/8Y7urxHS2z17VImicjiyNxgGmX5+mMdLBh1iRK/12lZxu8Mbal
         q06WpiU2qvJbpLFoS28Vr2JA0uQ7MNReknchCMrFLioR799ce4n7lUmC5s0/ao7QcdSs
         4jvRyxEtj9+yDu00Z46n7cgd4ELES2HiDIJAoxpCOZHWIZa24o5szkcAqv8gX/tmX5nT
         SNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=20AI8Vd+lVCP42bKmvXJ3gL8wdv8rTxtjbblEkhbpk0=;
        b=RFvD8FIXtUyIy3an1sbZTZCZeBZGIjniInr2upbJxii7EDUlXHFUsHkyEZjOlPMpei
         otMbMxIjyfQNWFOArhXClM9ViIuDXfp1efpDVsvCLXGTd0N23v+0gGfPlVC1McNao+UP
         es6xZkKGBojjB2cjOEKPMrhD6nFhjh8lWjbEn25LUh8/hAcsQ2bUJYK7u34vx8XDSxrE
         pCeNSymoX4CwzNbO8ykxXEYxH4AQFNWXdez73aQwu4vqlYnYLdX7eL/gTuNEFb3VB+lD
         ieRx6cSEG1cvPOkYXS+KEcxl4BjkDHn8Cy5R+HgJ+Zn1pJE6+rSZsQGWkFlxsYyhI8IL
         a8sg==
X-Gm-Message-State: AA+aEWbe6/x+/OgwBGeWDLxbw3oNeeYImxHaVvjHlwngsuW/p5A2Q9DT
        8jfRqb/iQgH1kcmp1/tOygLvd2K+O9o=
X-Google-Smtp-Source: AFSGD/UooTmHuEnZdBtlTThuweaAa+boXzQ8X/vmFRgH0oM940digBq0YjWqagU7/z/Sj8cQ5nEoWg==
X-Received: by 2002:a1c:9ed7:: with SMTP id h206mr3958405wme.28.1544813389551;
        Fri, 14 Dec 2018 10:49:49 -0800 (PST)
Received: from [192.168.1.34] (57.red-95-122-219.staticip.rima-tde.net. [95.122.219.57])
        by smtp.gmail.com with ESMTPSA id c7sm10308745wre.64.2018.12.14.10.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 10:49:48 -0800 (PST)
Subject: Re: [PATCH] quota: Lock s_umount in exclusive mode for
 Q_XQUOTA{ON,OFF} quotactls.
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
References: <1ad62e88-7784-6de8-c03d-01295375e315@gmail.com>
 <20181214095613.GD8896@quack2.suse.cz>
From:   Javier Barrio <javier.barrio.mart@gmail.com>
Message-ID: <8850e693-5f4d-4582-3bcd-f3a2bf3144c8@gmail.com>
Date:   Fri, 14 Dec 2018 19:49:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181214095613.GD8896@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El 14/12/18 a las 10:56, Jan Kara escribió:

Hi,
>> This patch locks the superblock ->s_umount sem. in exclusive mode for all Q_XQUOTAON/OFF
>> quotactls too in addition to Q_QUOTAON/OFF.
> Thanks for the patch! It looks good to me but let me run it past XFS
> people. Looking at XFS code they definitely do not *need* s_umount in
> exclusive mode for Q_XQUOTAON/OFF (they have their private mutex for
> the exclusion). Shared mode they currently get is enough for them. But
> exclusive mode is fine for them as well AFAICT and it would be easier if
> all quota backends had the same locking rules wrt VFS locks. XFS guys, any
> objections to switching Q_XQUOTAON/OFF handlers from having s_umount locked
> for read to having it locked exclusive?
Thanks, great! I agree.

FWIW, XFS as of now *can* be called while holding s_umount exclusive with the
generic quotactl(Q_QUOTAON/OFF) commands, even though that code path is probably
not exercised in practice (from a quick look xfs-tests/xfs_quota etc always
use the Q_X* variants).

> 								Honza
>
>> AFAICT, other than ext4, only xfs and ocfs2 are affected by this change.
>> The VFS will now call in xfs_quota_* functions with s_umount held, which wasn't the case
>> before. This looks good to me but I can not say for sure. Ext4 and ocfs2 where already
>> beeing called with s_umount exclusive via quota_quotaon/off which is basically the same.
>>
>> Signed-off-by: Javier Barrio <javier.barrio.mart@gmail.com>
>> ---
>>
>> [ I'm not familiar with this code, please excuse me if this is not the right fix ]
>>
>>  fs/quota/quota.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/quota/quota.c b/fs/quota/quota.c
>> index f0cbf58ad4da..fd5dd806f1b9 100644
>> --- a/fs/quota/quota.c
>> +++ b/fs/quota/quota.c
>> @@ -791,7 +791,8 @@ static int quotactl_cmd_write(int cmd)
>>  /* Return true if quotactl command is manipulating quota on/off state */
>>  static bool quotactl_cmd_onoff(int cmd)
>>  {
>> -	return (cmd == Q_QUOTAON) || (cmd == Q_QUOTAOFF);
>> +	return (cmd == Q_QUOTAON) || (cmd == Q_QUOTAOFF) ||
>> +		 (cmd == Q_XQUOTAON) || (cmd == Q_XQUOTAOFF);
>>  }
>>  
>>  /*
>> -- 2.17.1
>>
>>

