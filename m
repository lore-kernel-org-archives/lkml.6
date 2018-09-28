Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F8BC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F21206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bL5Wx30M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F21206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeI2FgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:36:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36984 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeI2FgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:36:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id v9-v6so7311264ljk.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 16:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4U7qXeMnCTJ8U6WDyWaq2/3eUrFOrRe91R90RiauHuw=;
        b=bL5Wx30MErTLw+ELnhmXqlVsuC8XkjqI/FqWOYo89jvoz1kD9xRqesvDxG8t5gXITP
         zhVJjUtOMRHHrXoj7lN8UvhiZOwgNUV6fQdQh815e9N73KIZ1UoTDEsN+Mte94zNsCkZ
         EegwIv9om72cOx4k9dmBdIFvjO3kFFwwUjZ4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4U7qXeMnCTJ8U6WDyWaq2/3eUrFOrRe91R90RiauHuw=;
        b=qpLMPJ7qSYv7yLt23Vj0nFamRQ89TBXFO1U2YC5XF+fclUYu6RC0KIuBCHlTX8W4zK
         lxzZpUs5rQZI9iiuZRqkKpk/UjmHA8bJpiCxBfq7cr7hQWJ2HZAMqXRdWdQD+BSVRGN7
         q+lQYoIglJyjK1SrSuq0Pb5V+c5M46cyS0S84aFDHPwq5yQDxFlOlDZM33xIWMtuktSX
         s1yXu2TqgPghNmpcUMPQyeMR1Yw4iYRBDAC/aFVyvCbrVcOcNpUmhqKeg+efud+o791l
         jdgnzC1vNbWKmY9+GgG5LVqCEQZ+1ncEJ2iaz2OnseCnu/zNRUdDC5r7530QYfUIGjCX
         8Jww==
X-Gm-Message-State: ABuFfoiaT+WFz2dhwOOX/J48PMno2Rawgx35n1S7g8cW+I2nYd/s6NFY
        XVUMvwagWY018t5LjO+DZYOndbFiwyY=
X-Google-Smtp-Source: ACcGV62lmV6e7IsWViaTYCuPfTkSV3EweZC2SC6/UmXvgez0oURwwuwrrdPjRQ+nIsSxohcaKuGa6g==
X-Received: by 2002:a2e:7017:: with SMTP id l23-v6mr384198ljc.160.1538176207362;
        Fri, 28 Sep 2018 16:10:07 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id b62-v6sm1251837ljf.7.2018.09.28.16.10.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 16:10:06 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id u21-v6so245893lja.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 16:10:05 -0700 (PDT)
X-Received: by 2002:a2e:7c18:: with SMTP id x24-v6mr418811ljc.174.1538176204601;
 Fri, 28 Sep 2018 16:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180928230203.905-1-evgreen@chromium.org> <20180928230203.905-3-evgreen@chromium.org>
 <20180928230416.GA30772@infradead.org>
In-Reply-To: <20180928230416.GA30772@infradead.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 28 Sep 2018 16:09:28 -0700
X-Gmail-Original-Message-ID: <CAE=gft4iB_iHfZ10vtty1aC6BAevT_zGLd0Yh3P8=Cpg4pymew@mail.gmail.com>
Message-ID: <CAE=gft4iB_iHfZ10vtty1aC6BAevT_zGLd0Yh3P8=Cpg4pymew@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] scsi: ufs: Execute START_STOP_UNIT during init
To:     hch@infradead.org
Cc:     Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        adrian.hunter@intel.com, stanislav.nijnikov@wdc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 4:04 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Sep 28, 2018 at 04:02:03PM -0700, Evan Green wrote:
> > For UFS devices that are provisioned to have an initial power mode
> > (bInitPowerMode) of "sleep", Linux will currently fail to enumerate
> > the device. This is because the UFS specification says that the
> > device must get a START_STOP_UNIT SCSI command to wake the unit
> > up before other common initialization features like the device
> > descriptor will be available to be read.
>
> Yikes, this is just completely broken in terms of scsi compliance.
>
> I think we should simply not support such devices.

Really? It's part of the UFS spec. The document I have specifies that
I shouldn't reproduce without permission, but it's in JESD220A section
7.2.4 UFS-Sleep Power Mode.
-Evan
