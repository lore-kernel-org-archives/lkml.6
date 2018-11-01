Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE20ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D4820657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UB2elMFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D4820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeKAKpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 06:45:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35353 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeKAKpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 06:45:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id z16-v6so616826wrv.2;
        Wed, 31 Oct 2018 18:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kShgA5AuiuIWQhRF2nfkT4ZpGAMy93JEA3WdhPoar+U=;
        b=UB2elMFenHbc12JGF/uubD5KUzHbp/vin5/DM/dWeR60KE35QhlhcIDw4+2ykMAomN
         liu909vTjz5gqGUDScImZ7zy6sGyLsTHFA9pW0rrWkO0fwnXA+GWoR2sf+aEIctUECH9
         sBzN7AUG/x+31jNzrgSdQ3vS4AGDd7CxzlOssVm9SjHtAgRKvoeHpKacWL5sVpIlAqaP
         uQVX+uGr7og4aKWDSb9owTeK+sXya9Ibk0lrHCPuidFgqohRdEvOS3ymoioxXvBiXFXm
         3a5+uQ0j+mo8JJFJBWy6+WyfyffEbzKqzgXtxcRcvgtBgxuS7+3fiCIonsYKDsuzbqXf
         7sNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kShgA5AuiuIWQhRF2nfkT4ZpGAMy93JEA3WdhPoar+U=;
        b=CcOC52T7CrBJJ0xqPLwZ+18Nay6ym5MZZhs4MDJNl5aIQQ6EDYls00mqOuHkp0ANCt
         P4NdrFZWHQXTtLiHdmuZ3E4GSzeUVORhISrdwlYHjlmqWHwzaVTs1GFLmUdtSRBCtWDK
         oLJ/e6x5KpSXKPxHkfQCr9dvG+xk74huCOOs/XrutTbfUF4Xh+mowvyY278N/QtGtI0z
         WRzt98RJceIoOWOKl8gEIf5pOC8aTr/PLgdNBnJPi9D4+kYdjoP5JALm/O6A4LbGyA9g
         nqVx6GRiexOCsvTIJ7efQFp3YBZiEjHV9rfsuVNgXww9+JJNThUpvEKP3SKQnd+SaSGQ
         h+HA==
X-Gm-Message-State: AGRZ1gLLUPQJdqx2faLwg1a/8f/X6lqcFMtAcAg9axDGejeemxFsN24p
        QsWUtwVcQQ10cg3A8OXUA2I=
X-Google-Smtp-Source: AJdET5cneP/vrGGENIVQ+fN6QHYT7Qv8xbvrGC0knb5xAYne6/AM0ZZPk/yok5R3HSXkJrZy17HOtw==
X-Received: by 2002:a5d:6389:: with SMTP id p9-v6mr4691785wru.215.1541036669737;
        Wed, 31 Oct 2018 18:44:29 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id x18-v6sm641401wrs.50.2018.10.31.18.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 18:44:29 -0700 (PDT)
Date:   Wed, 31 Oct 2018 18:44:27 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Boaz Harrosh <ooo@electrozaur.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
Message-ID: <20181101014427.GA5060@flashbox>
References: <20180930205448.26205-1-natechancellor@gmail.com>
 <10b12992-3570-4646-374b-82cbd7276839@acm.org>
 <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
 <1538503063.193396.6.camel@acm.org>
 <CAKwvOdmsNEexQL9R8rgcRcXTZButYM6YWwG8bhVWCoJ8bOqCrA@mail.gmail.com>
 <1538521591.193396.8.camel@acm.org>
 <20181025213144.GB24709@flashbox>
 <1c58c82f-5cfa-f483-097a-5b82904e5e9a@electrozaur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c58c82f-5cfa-f483-097a-5b82904e5e9a@electrozaur.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 03:39:54AM +0200, Boaz Harrosh wrote:
> On 26/10/18 00:31, Nathan Chancellor wrote:
> > On Tue, Oct 02, 2018 at 04:06:31PM -0700, Bart Van Assche wrote:
> <>
> > 
> > Hi Bart,
> > 
> > I'm sorry if I didn't follow the conclusion of this conversation properly
> > but this is the below diff you were initially looking for, correct?
> > 
> > If so, Boaz and Nick, do you have any objections if this is v2? I'd like
> > to get this patch accepted so the warning can be fixed for everyone.
> > 
> 
> ACK on both the original and below code they will all work just fine.
> 
> I do like the original "just remove the _weak thingy". But this one
> will work as well.
> 
> The "with extern" version suggested before is more cumbersome because it will
> need an EXPORT_SYMBOL() but will also work.
> 
> The all use of osd_root_object is just. A properly C-types pointer to couple
> of ZEROS. but since the Interface needs a pointer, those zeros need storage
> somewhere. It does not matter where. (The value of the pointer is not used
> only its content)
> 
> Do you need that I send a proper patch? Actually the original first patch
> is the version I like. (And again all 3 approaches will work)
> 
> Thanks
> Boaz
> 

Hi Boaz,

I am fine with the original v1 as long as you and everyone else are.
I don't mind resending or making a v2 if I need to as well. Just would
like everyone to come to an agreement on something!

Thanks for the review and clarity,
Nathan

> > Thanks,
> > Nathan
> > 
> > ================================================================================
> > 
> > diff --git a/drivers/scsi/osd/osd_initiator.c b/drivers/scsi/osd/osd_initiator.c
> > index e19fa883376f..4250f739beb3 100644
> > --- a/drivers/scsi/osd/osd_initiator.c
> > +++ b/drivers/scsi/osd/osd_initiator.c
> > @@ -58,6 +58,8 @@
> > 
> >  enum { OSD_REQ_RETRIES = 1 };
> > 
> > +static const struct osd_obj_id osd_root_object;
> > +
> >  MODULE_AUTHOR("Boaz Harrosh <ooo@electrozaur.com>");
> >  MODULE_DESCRIPTION("open-osd initiator library libosd.ko");
> >  MODULE_LICENSE("GPL");
> > diff --git a/drivers/scsi/osd/osd_uld.c b/drivers/scsi/osd/osd_uld.c
> > index eaf36ccf58db..770c758baaa9 100644
> > --- a/drivers/scsi/osd/osd_uld.c
> > +++ b/drivers/scsi/osd/osd_uld.c
> > @@ -73,6 +73,7 @@
> > 
> >  static const char osd_name[] = "osd";
> >  static const char *osd_version_string = "open-osd 0.2.1";
> > +static const struct osd_obj_id osd_root_object;
> > 
> >  MODULE_AUTHOR("Boaz Harrosh <ooo@electrozaur.com>");
> >  MODULE_DESCRIPTION("open-osd Upper-Layer-Driver osd.ko");
> > diff --git a/include/scsi/osd_types.h b/include/scsi/osd_types.h
> > index 48e8a165e136..eb31357ec8b3 100644
> > --- a/include/scsi/osd_types.h
> > +++ b/include/scsi/osd_types.h
> > @@ -28,8 +28,6 @@ struct osd_obj_id {
> >         osd_id id;
> >  };
> > 
> > -static const struct __weak osd_obj_id osd_root_object = {0, 0};
> > -
> >  struct osd_attr {
> >         u32 attr_page;
> >         u32 attr_id;
> > 
> 
