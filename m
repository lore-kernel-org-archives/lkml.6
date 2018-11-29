Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219B3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7EFB20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mu9s6Rn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7EFB20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbeK3Dgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:36:47 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42925 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729301AbeK3Dgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:36:47 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so1150944pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 08:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=i9zEtRZrUBmOi22elrrpy5vfHxPIYh33i2RGot57Q2o=;
        b=Mu9s6Rn0mug2OUZtL2bFeZt9/4q+Ob6aJEA1SeXvFOfSOxV6OUssvwIOR+0W9COFG1
         KExw8jRMDes0RTxsjkddiUx3pqJ1kHPVRfbePpGWoQ6BxoXNx3NoZXxAJEjQDebhyPEg
         CXm2JvP+rH/4z31wVNeEXMr6m3ulpjNsFnDwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=i9zEtRZrUBmOi22elrrpy5vfHxPIYh33i2RGot57Q2o=;
        b=Vica6QEtZgXSfgKfcwIO7+tPAPXEQbKjH/xj/thvB6p4H8jYtX/kpATJX5GshNtBHY
         T50HnjmJqO1C+uEXPhqBbgLXKWcc0DAyZ6WKqmug3/75p5xscXr2yGLT84VGcpAzQMv4
         CZ9aBm8dTEf0coj/AqetWwSuzc3JLm1X3zR1okuWrMULVOB3HdRmytpUGVcsh7p5WUZ6
         Hejl7EUWUoMZKda/6tbdXJ5O56suAk87FXregBe+0xOSEyixg7e/ga9zX2miSkyhuZm2
         hHbhybiK+WidwdbCYNSVKhXWuhu0PuhnyetO9AYlIdJlSK/HOUMTABhJil0D2XTW9X5T
         NVkQ==
X-Gm-Message-State: AA+aEWZNyCSKdaMjPKQw4lU9IYS6QVcYSIfdBBGVQY2NNa6sIUtDs7Sb
        5r+s5Uf5teyt1EUb8knAzBUMIw==
X-Google-Smtp-Source: AFSGD/XQi8lrl8fcI6jUYU43MzzemxCQw0r+NUZFfTuXBDep2eXQj6qn0PUVxncnVbppWoACFCoKFQ==
X-Received: by 2002:a63:b649:: with SMTP id v9mr1803978pgt.436.1543509051442;
        Thu, 29 Nov 2018 08:30:51 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id b185sm8701357pga.85.2018.11.29.08.30.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 08:30:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <agross@codeaurora.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181129082540.4ceafca6@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181116101059.18ad3fc9@canb.auug.org.au>
 <20181129082540.4ceafca6@canb.auug.org.au>
Message-ID: <154350904879.88331.1156146258217230705@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: linux-next: build warning after merge of the qcom tree
Date:   Thu, 29 Nov 2018 08:30:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Rothwell (2018-11-28 13:25:40)
> Hi all,
> =

> On Fri, 16 Nov 2018 10:10:59 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > Hi all,
> > =

> > After merging the qcom tree, today's linux-next build (arm
> > multi_v7_defconfig) produced this warning:
> > =

> > drivers/gpu/drm/msm/adreno/a6xx_gmu.c: In function 'a6xx_gmu_rpmh_arc_v=
otes_init.constprop':
> > drivers/gpu/drm/msm/adreno/a6xx_gmu.c:943:12: warning: 'pri_count' is u=
sed uninitialized in this function [-Wuninitialized]
> >   pri_count >>=3D 1;
> >             ^~~
> > drivers/gpu/drm/msm/adreno/a6xx_gmu.c:948:12: warning: 'sec_count' may =
be used uninitialized in this function [-Wmaybe-uninitialized]
> >   sec_count >>=3D 1;
> >             ^~~
> > =

> > Introduced by commit
> > =

> >   ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux=
_data()")
> > =

> > # CONFIG_QCOM_COMMAND_DB is not set
> =

> I am still getting these warnings.
> =


Andy's email isn't at codeaurora.org anymore. Not sure if that matters
but he may be missing this.

Either way, thanks for the report. Fix coming shortly.


