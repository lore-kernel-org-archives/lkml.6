Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFA4ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 23:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF6520657
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 23:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SCh5Pbl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF6520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbeGQAYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 20:24:47 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33732 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729466AbeGQAYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 20:24:47 -0400
Received: by mail-lf0-f67.google.com with SMTP id u14-v6so33503346lfu.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 16:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a2UON7qBo8aDWM3FcBSDX2hQ9Fv1C/YYmkr7JNCgFjI=;
        b=SCh5Pbl+Sg9D/soA/kPpdBJZmeWaB1zT4vQuOr8rx9b1KvkfkffLHg3pA4AbH2B9IB
         HRrSL2SRN5mImT/7RuAtBOMW63bz6B+uogzrHAkaG7nA86biSbghaxnnWtuydscHC/WC
         I8CU0aZF+gwp2F599nSg1N+IXhCTB7Y5M/Vdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a2UON7qBo8aDWM3FcBSDX2hQ9Fv1C/YYmkr7JNCgFjI=;
        b=X5TEDOlENhZ0nNvBh0hj5p8keepGb0u4wWpC6iQUuRkhkRFW/oMj/SPy9HpArtKYwK
         drkz27CSm1Jgn+P2Z+pb58Wo5HGzB+P7wSBLd5MfyxaMQZhD8PnjUwKddRyd9N64CGyu
         T0kriocw82bVfYq81AviMi0nWWhq44z57oTpt/vskvRuVIGL0jJaxXwLgyp3tkTvIMJO
         jqJuHgjcZZihSdIin+0W7rX8YzYCgd2pTeUarFPPhSom2jM3r9S9yoLhpIR0EXBohS35
         kA/tuji/G8UTc8I8/lQYtsISSmDr4aLfw0k8uNHYothg3QyxPQpHIVyaPaKc1pfxeGVo
         jS6Q==
X-Gm-Message-State: AOUpUlHzGtOgcW2gV/TO9WsNR3cUPkgqWn0zlTNbef/sJQq1YYayIZWj
        pMxu97mT3wYwZvSMYBCRxF0btZaeMfY=
X-Google-Smtp-Source: AAOMgpdcnj/4erowBRqE9CCmwCgr4W9H80pTljY9/JSQK0oPN41PHSPcxfJ4DuvdMTUjL6syfbsLEQ==
X-Received: by 2002:a19:e4c1:: with SMTP id x62-v6mr12499789lfi.76.1531785301182;
        Mon, 16 Jul 2018 16:55:01 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id r63-v6sm2775287lja.18.2018.07.16.16.55.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 16:55:01 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 203-v6so20413846ljj.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 16:55:01 -0700 (PDT)
X-Received: by 2002:a2e:89c5:: with SMTP id c5-v6mr11495819ljk.19.1531784850349;
 Mon, 16 Jul 2018 16:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <1530858040-13971-1-git-send-email-sayalil@codeaurora.org>
 <1530858040-13971-3-git-send-email-sayalil@codeaurora.org>
 <CAE=gft5U1-Jo-GvTF7sNAV3Q565AmuUrHpmBdxUL+UwkKxesqA@mail.gmail.com> <0dce9e9c-4f93-9857-72ee-f65ff195c41a@codeaurora.org>
In-Reply-To: <0dce9e9c-4f93-9857-72ee-f65ff195c41a@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 16 Jul 2018 16:46:54 -0700
X-Gmail-Original-Message-ID: <CAE=gft6_=SQjgv7_kHXKJKa8_45NKKFwwE7UaXsijPpMd35LOg@mail.gmail.com>
Message-ID: <CAE=gft6_=SQjgv7_kHXKJKa8_45NKKFwwE7UaXsijPpMd35LOg@mail.gmail.com>
Subject: Re: [PATCH V5 2/2] scsi: ufs: Add configfs support for ufs provisioning
To:     sayalil@codeaurora.org, Bart.VanAssche@wdc.com
Cc:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        asutoshd@codeaurora.org, riteshh@codeaurora.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sayali,
On Mon, Jul 16, 2018 at 1:10 AM Sayali Lokhande <sayalil@codeaurora.org> wr=
ote:
>
> Hi Evan,
>
>
> On 7/9/2018 11:18 PM, Evan Green wrote:
> > Hi Sayali,
> > Thanks for the prompt spin.
> >
> > On Thu, Jul 5, 2018 at 11:21 PM Sayali Lokhande <sayalil@codeaurora.org=
> wrote:
> >> This patch adds configfs support to provision ufs device at
> > s/ufs/UFS/
> Will update.
> >> runtime. This feature can be primarily useful in factory or
> >> assembly line as some devices may be required to be configured
> >> multiple times during initial system development phase.
> >> Configuration Descriptors can be written multiple times until
> >> bConfigDescrLock attribute is zero.
> >>
> >> Configuration descriptor buffer consists of Device and Unit
> >> descriptor configurable parameters which are parsed from vendor
> >> specific provisioning file and then passed via configfs node at
> >> runtime to provision ufs device.
> >> CONFIG_CONFIGFS_FS needs to be enabled for using this feature.
> >>
> >> Usage:
> >> 1) To read current configuration descriptor :
> >>     cat /config/ufshcd/ufs_provision
> >> 2) To provision ufs device:
> >>     echo <config_desc_buf> > /config/ufshcd/ufs_provision
> >>
> >> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> >> ---
> >>   Documentation/ABI/testing/configfs-driver-ufs |  18 +++
> >>   drivers/scsi/ufs/Makefile                     |   1 +
> >>   drivers/scsi/ufs/ufs-configfs.c               | 172 ++++++++++++++++=
++++++++++
> >>   drivers/scsi/ufs/ufshcd.c                     |   2 +
> >>   drivers/scsi/ufs/ufshcd.h                     |  19 +++
> >>   5 files changed, 212 insertions(+)
> >>   create mode 100644 Documentation/ABI/testing/configfs-driver-ufs
> >>   create mode 100644 drivers/scsi/ufs/ufs-configfs.c
> >>
> >> diff --git a/Documentation/ABI/testing/configfs-driver-ufs b/Documenta=
tion/ABI/testing/configfs-driver-ufs
> >> new file mode 100644
> >> index 0000000..dd16842
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/configfs-driver-ufs
> >> @@ -0,0 +1,18 @@
> >> +What:          /config/ufshcd/ufs_provision
> >> +Date:          Jun 2018
> >> +KernelVersion: 4.14
> >> +Description:
> >> +               This file shows the current ufs configuration descript=
or set in device.
> >> +               This can be used to provision ufs device if bConfigDes=
crLock is 0.
> >> +               For more details, refer 14.1.6.3 Configuration Descrip=
tor and
> >> +               Table 14-12 =E2=80=94 Unit Descriptor configurable par=
ameters from specs for
> > Can this be a regular dash, rather than some sort of exotic 0xE2 byte.
> >
> >> +               description of each configuration descriptor parameter=
.
> >> +               Configuration descriptor buffer needs to be passed in =
space separated
> >> +               format specificied as below:
> >> +               echo <bLength> <bDescriptorIDN> <bConfDescContinue> <b=
BootEnable>
> >> +               <bDescrAccessEn> <bInitPowerMode> <bHighPriorityLUN>
> >> +               <bSecureRemovalType> <bInitActiveICCLevel> <wPeriodicR=
TCUpdate>
> >> +               <0Bh:0Fh_ReservedAs_0> <bLUEnable> <bBootLunID> <bLUWr=
iteProtect>
> >> +               <bMemoryType> <dNumAllocUnits> <bDataReliability> <bLo=
gicalBlockSize>
> >> +               <bProvisioningType> <wContextCapabilities> <0Dh:0Fh_Re=
servedAs_0>
> > I wonder if at this point we should be using a binary attribute rather
> > than a text one. Since now you're basically just converting text to
> > bytes, it's not very human anymore.
> Use of binary attr was ruled out before. Pasting previous comments from
> Greg :
> "binary attributes are meant for hardware value pass-through" type stuff.
> Unless this is "raw" data straight from the hardware, binary does not wor=
k.

But now that we've removed the software parameters like lun_to_grow,
and all the calculations, this is exactly a hardware value
pass-through, isn't it? I even see you have things like
<0Bh:0Fh_ReservedAs_0> done in order to match the hardware format.

I see Bart has chimed in on the next series with a suggestion to break
out each field into individual files within configfs. Bart, what are
your feelings about converting to a binary attribute? I remember when
I did my sysfs equivalent of this patch, somebody chimed in indicating
a "commit" file might be needed so that the new configuration could be
written in one fell swoop. One advantage of the binary attribute is
that it writes the configuration atomically.
-Evan
