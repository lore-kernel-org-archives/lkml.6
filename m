Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD52C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565CE20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GLlOXV3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565CE20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbeIKX2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:28:35 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45957 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeIKX2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:28:35 -0400
Received: by mail-yb1-f194.google.com with SMTP id h22-v6so9696850ybg.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 11:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jwfWkWmpfW9WAkv75dkfHVh5Hv1PHIDlWrSKJ83saZY=;
        b=GLlOXV3vG6Ki0iIazzD06RynJeGpbmK6iscrH/sOSUYbculupiq5w53QdEVA0M0ddd
         hxRrCZtS9/F4aEUeIa6EVpYfoNN9DM+adKgxUd9R+oiO8qcSd089FZueywqRbXrdLQt8
         lEFZ8Rzd+/Hh9wyo9witZvCk+20ZTJnHe6uMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jwfWkWmpfW9WAkv75dkfHVh5Hv1PHIDlWrSKJ83saZY=;
        b=LXjo4NZ0hr+4U8XVEZWz/DX+jVGDedNhnruiqtdsDVPNL3GDy3EO6CgrHXtwgk6EF4
         Ciq2HOjSn5RPcMubvPDOHVcfHFoRUkgHAdKyEkeX5a0mcdo/R+A2PqTLBb/LdiYZspQP
         ob854y4FkUsMnVSIaedFa6YvC4qjMQRX6AIOoCEeTWi07EnomV7Sdgh/tyH7vfDsagL8
         IZt1JMVXP5hQQK81U+0/HSQsAPPuaDuaC+uZg8LH7E7IYxjIEuYdTmoRwCDiu1DotZ/Z
         y1NLVBWPAE53x9AwB0tsh2qlqFi6rA1kKH8WeUiFuUFQmYStc+84a82daz/3SuvkepJh
         bV+A==
X-Gm-Message-State: APzg51A1JN+KjKa2CoALKYAOwV2dXQrQETNtkoTDWNI0VBAaX7+2XDGo
        pbMembyeZwT9eqZer0cAUSh/EpKaYjw=
X-Google-Smtp-Source: ANB0VdbImf6KoGpPjtQvKTtvAIfYAqWFFIfbTkGpBgLLXYjDyTEfdR2FYWk8bHnAKOmQbiDTLsGTYA==
X-Received: by 2002:a25:2542:: with SMTP id l63-v6mr9782999ybl.126.1536690481645;
        Tue, 11 Sep 2018 11:28:01 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id j6-v6sm6830166ywe.107.2018.09.11.11.28.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 11:28:00 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id l16-v6so9704219ybk.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 11:28:00 -0700 (PDT)
X-Received: by 2002:a25:19c3:: with SMTP id 186-v6mr13195705ybz.410.1536690479668;
 Tue, 11 Sep 2018 11:27:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 11:27:58
 -0700 (PDT)
In-Reply-To: <CAGXu5j+R_VLzKxwtqu7yR=vwRBSZNhcjjMtz8OgWRh48Gwisww@mail.gmail.com>
References: <20180911180542.7778-1-labbott@redhat.com> <CAGXu5j+R_VLzKxwtqu7yR=vwRBSZNhcjjMtz8OgWRh48Gwisww@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 11 Sep 2018 11:27:58 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+hL2RhKgF5nyncc6uettPOyD=Je6zOf6NxvFO+pR4dsg@mail.gmail.com>
Message-ID: <CAGXu5j+hL2RhKgF5nyncc6uettPOyD=Je6zOf6NxvFO+pR4dsg@mail.gmail.com>
Subject: Re: [PATCHv2] scsi: ibmvscsis: Fix a stringop-overflow warning
To:     Laura Abbott <labbott@redhat.com>
Cc:     "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Michael Cyr <mikecyr@linux.vnet.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        target-devel <target-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Prarit Bhargava <prarit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 11:24 AM, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Sep 11, 2018 at 11:05 AM, Laura Abbott <labbott@redhat.com> wrote:
>>
>> There's currently a warning about string overflow with strncat:
>>
>> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function 'ibmvscsis_probe':
>> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3479:2: error: 'strncat' specified
>> bound 64 equals destination size [-Werror=stringop-overflow=]
>>   strncat(vscsi->eye, vdev->name, MAX_EYE);
>>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Switch to a single snprintf instead of a strcpy + strcat to handle this
>> cleanly.
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> -Kees
>
>> ---
>> v2: Swtich to using snprintf per suggestion of Kees
>> ---
>>  drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
>> index fac377320158..9305440a00a1 100644
>> --- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
>> +++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
>> @@ -3474,8 +3474,7 @@ static int ibmvscsis_probe(struct vio_dev *vdev,
>>                 vscsi->dds.window[LOCAL].liobn,
>>                 vscsi->dds.window[REMOTE].liobn);
>>
>> -       strcpy(vscsi->eye, "VSCSI ");
>> -       strncat(vscsi->eye, vdev->name, MAX_EYE);
>> +       snprintf(vscsi->eye, sizeof(vscsi->eye), "VSCSI%s", vdev->name);

Eek. No, I take it back: Nick Desaulniers has better eyes than me and
pointed out that there should be a space after VSCSI.

-Kees

>>
>>         vscsi->dds.unit_id = vdev->unit_address;
>>         strncpy(vscsi->dds.partition_name, partition_name,
>> --
>> 2.17.1
>>
>
>
>
> --
> Kees Cook
> Pixel Security



-- 
Kees Cook
Pixel Security
