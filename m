Return-Path: <ben.hutchings@codethink.co.uk>
X-Google-Smtp-Source: AB8JxZprcVwQE4UuTFNWQeGTYkiHfHc8v2syVd+bg3lr3edFmWm4iVZUlR/4d21WJ6UMPzkEInIP
ARC-Seal: i=1; a=rsa-sha256; t=1526489633; cv=none;
        d=google.com; s=arc-20160816;
        b=Z/VOQvLF4qTPOWuk8LyyEMUx7xkHhgN2f3O2LXd7yku/axZaon/6zMl7uvgs1Das3s
         KnVFDLukl/TeYu1kYbo2oZTBeqvRhVsGoTiyXWIzk6gCfHYDYeJ2/zPAPyKy0a4qWlOq
         NqVy0FTzygWkSRlgN96KxjONOzMBweKYlnyoUjXq3eZMmqYUfCZpywjm5/cixzz6hUQX
         EDfIi8wXYiADufpNaQq7lqa8f+IZ4tvtl89KTQj4iPnIFL2iwbtMtexcghPu3sd0hcEP
         chNNDMSoQ199x+CPR8m2v/R1/hRAiFL+eShhdAKWdv1sSX5ZYilQNeqLh3GGHX7gwU+m
         TMlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=fuBHjrE31bV7Vn6cRqGc2C9XKRiORjh+qToMEBoGmEU=;
        b=MXX8G6up93CHn90jFmn1TnVqGo78nWQNdA4gHLK/QSrtI2LwlEyudvsEvd7YPNJz+1
         13C7tCsvcpunv2iCy1z18OwSb4RRI2bSeNIWXx6s8q30f7sfNLQXkDa5SaM+T0+NHzeH
         SIA9KRvBVevs2mLZEa8UIxLzhvxCwbl6kKUmGsHCnqcHLfNkySSXdoinbBLOYYZpa0Wb
         dt63b0Q+wCBmWB8gJZbhT0b6xIgGGJGNR+1v/SHYs89Y4rg9Bw7gHMpbN8UxuGStL6xI
         B/2xxxyh1p5gfNy/umD06W5kfOwjGpofiolj+05eYfIBc21DhQniQNZrPvmkAGcs3yeL
         A+xg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Message-ID: <1526489629.9159.147.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 23/97] ubi: fastmap: Dont flush fastmap work on
 detach
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Martin Townsend <mtownsend1973@gmail.com>, Richard Weinberger
	 <richard@nod.at>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  LKML <linux-kernel@vger.kernel.org>
Date: Wed, 16 May 2018 17:53:49 +0100
In-Reply-To: <20180422135306.338619311@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
	 <20180422135306.338619311@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598454908575503165?=
X-GMAIL-MSGID: =?utf-8?q?1600640393925538745?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 2018-04-22 at 15:53 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Richard Weinberger <richard@nod.at>
> 
> commit 29b7a6fa1ec07e8480b0d9caf635a4498a438bf4 upstream.
> 
> At this point UBI volumes have already been free()'ed and fastmap can no
> longer access these data structures.

I don't see how this change can fix a use-after-free.  If this function
can be called with *ubi already freed, then the rest of the function
body is also not safe to run.  But I don't think that is the case.

ubi->fm_work doesn't depend on any other structure (except a global
workqueue, which won't go away).

It seems to me that the bug is really a race condition, and removing
the flush_work() makes it harder to hit that condition.  The proper fix
would be to call flush_work() (or cancel_work_sync()) before the UBI
volumes are freed.

Ben.

> Reported-by: Martin Townsend <mtownsend1973@gmail.com>
> Fixes: 74cdaf24004a ("UBI: Fastmap: Fix memory leaks while closing the WL sub-system")
> Cc: stable@vger.kernel.org
> Signed-off-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  drivers/mtd/ubi/fastmap-wl.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- a/drivers/mtd/ubi/fastmap-wl.c
> +++ b/drivers/mtd/ubi/fastmap-wl.c
> @@ -360,7 +360,6 @@ static void ubi_fastmap_close(struct ubi
>  {
>  	int i;
>  
> -	flush_work(&ubi->fm_work);
>  	return_unused_pool_pebs(ubi, &ubi->fm_pool);
>  	return_unused_pool_pebs(ubi, &ubi->fm_wl_pool);
>  
> 
> 
> 
-- 
Ben Hutchings
Software Developer, Codethink Ltd.
