Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044B0C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0C72172F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PzxdnLCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0C72172F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390075AbeHGUbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:31:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41171 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388625AbeHGUbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:31:33 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17-v6so14172237ljy.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 11:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6y/g7K56ZtE6xODYHPLdVO+33a+g5svNcluGHgiNqtw=;
        b=PzxdnLCFabQ84unNGU+awF+9xqTRa6egF/DxG4Cb9NOHzMzw1OM1U5yAeZUbIZkdgB
         ixkcUobHicnQCAjM0GisVfuPMBVrF4b8pXIp82Jfg+52vFha5seXpt/EYQpI5vVmE6gv
         nsENSxPGBlpgAIbo/8bJ6Zx+rywiGLVOW0eps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6y/g7K56ZtE6xODYHPLdVO+33a+g5svNcluGHgiNqtw=;
        b=Ikm5elzANQk30kAnHumkHPJgin/84N+kIohPdt3MvjRKR6PWCglcuyivttNIhhv4Hd
         WHNIROdhM3Qp0gb8fVUcONhcf7jC41xg/Fi3YCk9tRnwkf9MwL8qOL7K3ohUS2Dup77n
         f0buxFeRhL3kOOtuAeyW+drL9NH+p5dtAcxn072hXHBz3oZzyTp5pvLYaCP6p9yDL4LT
         5/e3AnQ1YtkQu3xYuok/6I+DUIVR6vIBv0fNYJCMMuvbN1NJeZzdVMXQjrSkc9MJVihm
         ctrNScXCmRMa8HUoYoRvPDrlxpsqKTcqjqvEDGsV4niYqNfM97aOMB7ofvnU1l7t0X9A
         8yfw==
X-Gm-Message-State: AOUpUlEwPMwSJrgzuehLgyaLjXjNrDGjtgwdY1qIxyfnhHHrdhERzmW+
        VRj/huUKi1iXP61UM1SWpQtKrDhVWIg=
X-Google-Smtp-Source: AAOMgpeyIrECEufOBKWBDdkxY5YNx6aHzzfKnODWtU4YGuG+8HxGBbiRN6zIbSBKQfg1yCdnT1BnAA==
X-Received: by 2002:a2e:4055:: with SMTP id n82-v6mr14735374lja.99.1533665756730;
        Tue, 07 Aug 2018 11:15:56 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id h90-v6sm352546lji.66.2018.08.07.11.15.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 11:15:55 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id j19-v6so14177048ljc.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 11:15:54 -0700 (PDT)
X-Received: by 2002:a2e:9941:: with SMTP id r1-v6mr15725049ljj.53.1533665754504;
 Tue, 07 Aug 2018 11:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180725201452.81235-1-evgreen@chromium.org> <MWHPR04MB11374B145CB323EC8C3339DB9A200@MWHPR04MB1137.namprd04.prod.outlook.com>
In-Reply-To: <MWHPR04MB11374B145CB323EC8C3339DB9A200@MWHPR04MB1137.namprd04.prod.outlook.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 7 Aug 2018 11:15:18 -0700
X-Gmail-Original-Message-ID: <CAE=gft71pqduuEE+dtWX0oFv3pcodD6ddenyuLX4JPo=0Ht6kg@mail.gmail.com>
Message-ID: <CAE=gft71pqduuEE+dtWX0oFv3pcodD6ddenyuLX4JPo=0Ht6kg@mail.gmail.com>
Subject: Re: [PATCH v3] scsi: ufs: Make sysfs attributes writable
To:     Stanislav.Nijnikov@wdc.com
Cc:     Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Bart.VanAssche@wdc.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanislav. Thanks for the review.

On Mon, Aug 6, 2018 at 2:28 AM Stanislav Nijnikov
<Stanislav.Nijnikov@wdc.com> wrote:
>
> Hi Evan,
>
> > -----Original Message-----
> > From: Evan Green <evgreen@chromium.org>
> > Sent: Wednesday, July 25, 2018 11:15 PM
> > To: Vinayak Holikatti <vinholikatti@gmail.com>; James E.J. Bottomley <jejb@linux.vnet.ibm.com>; Martin K. Petersen
> > <martin.petersen@oracle.com>; Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>; Adrian Hunter <adrian.hunter@intel.com>; linux-
> > kernel@vger.kernel.org; linux-scsi@vger.kernel.org; Bart Van Assche <Bart.VanAssche@wdc.com>
> > Cc: Evan Green <evgreen@chromium.org>
> > Subject: [PATCH v3] scsi: ufs: Make sysfs attributes writable
> >
> > This change makes the UFS controller's sysfs attributes writable, which
> > will enable users to modify attributes. This can be useful during factory
> > provisioning for setting up critical attributes like the reference clock
> > frequency.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > ---
> > Configfs was determined to be the preferred mechanism for writing the
> > config descriptor, but attributes also need to be written during setup,
> > and are already present in sysfs. Making these attributes writable is
> > also helpful for debugging and experimentation.
> >
> > Changes since v2:
> >       - Removed the configuration descriptor changes from the series,
> > since configfs was the preferred way to write to that, leaving only
> > this change.
> >
> > Changes since v1:
> >       - Reworked the interface to show each unit of the config
> > descriptor as a separate directory, rather than the previous method I
> > had of a file for selecting the unit, and then a common set of files
> > that interacted with whichever unit was selected. I did some kobject
> > magic to accomplish this. I noticed from Greg KH's reply to Sayali's
> > patches [1] that configfs might be the preferred method. Let me know
> > if I should abandon this series in favor of Sayali's, with the
> > possible exception of "Make sysfs attributes writable".
> >       - Squashed documentation changes into their respective code
> > changes.
> >       - I decided to keep the config descriptor attributes as their
> > own files, rather than hiding writes behind device descriptor and unit
> > descriptor, as I think that's more future proof and true to the UFS spec.
> >
> > [1] https://lkml.org/lkml/2018/6/8/210
> >
> >  Documentation/ABI/testing/sysfs-driver-ufs | 17 +--------
> >  drivers/scsi/ufs/ufs-sysfs.c               | 58 ++++++++++++++++++++----------
> >  2 files changed, 40 insertions(+), 35 deletions(-)
> >
...
> > diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
> > index 8d9332bb7d0c..5e286b9d1aea 100644
> > --- a/drivers/scsi/ufs/ufs-sysfs.c
> > +++ b/drivers/scsi/ufs/ufs-sysfs.c
> > @@ -655,7 +655,7 @@ static const struct attribute_group ufs_sysfs_flags_group = {
> >       .attrs = ufs_sysfs_device_flags,
> >  };
> >
> > -#define UFS_ATTRIBUTE(_name, _uname)                                 \
> > +#define UFS_ATTRIBUTE_SHOW(_name, _uname)                            \
> >  static ssize_t _name##_show(struct device *dev,                              \
> >       struct device_attribute *attr, char *buf)                       \
> >  {                                                                    \
> > @@ -665,25 +665,45 @@ static ssize_t _name##_show(struct device *dev,                         \
> >               QUERY_ATTR_IDN##_uname, 0, 0, &value))                  \
> >               return -EINVAL;                                         \
> >       return sprintf(buf, "0x%08X\n", value);                         \
> > -}                                                                    \
> > -static DEVICE_ATTR_RO(_name)
> > +}
> >
> > -UFS_ATTRIBUTE(boot_lun_enabled, _BOOT_LU_EN);
> > -UFS_ATTRIBUTE(current_power_mode, _POWER_MODE);
> > -UFS_ATTRIBUTE(active_icc_level, _ACTIVE_ICC_LVL);
> > -UFS_ATTRIBUTE(ooo_data_enabled, _OOO_DATA_EN);
> > -UFS_ATTRIBUTE(bkops_status, _BKOPS_STATUS);
> > -UFS_ATTRIBUTE(purge_status, _PURGE_STATUS);
> > -UFS_ATTRIBUTE(max_data_in_size, _MAX_DATA_IN);
> > -UFS_ATTRIBUTE(max_data_out_size, _MAX_DATA_OUT);
> > -UFS_ATTRIBUTE(reference_clock_frequency, _REF_CLK_FREQ);
> > -UFS_ATTRIBUTE(configuration_descriptor_lock, _CONF_DESC_LOCK);
> > -UFS_ATTRIBUTE(max_number_of_rtt, _MAX_NUM_OF_RTT);
> > -UFS_ATTRIBUTE(exception_event_control, _EE_CONTROL);
> > -UFS_ATTRIBUTE(exception_event_status, _EE_STATUS);
> > -UFS_ATTRIBUTE(ffu_status, _FFU_STATUS);
> > -UFS_ATTRIBUTE(psa_state, _PSA_STATE);
> > -UFS_ATTRIBUTE(psa_data_size, _PSA_DATA_SIZE);
> > +#define UFS_ATTRIBUTE_RO(_name, _uname)                                      \
> > +UFS_ATTRIBUTE_SHOW(_name, _uname)                                    \
> > +DEVICE_ATTR_RO(_name)
> It should be static here.

Will fix.

>
> > +
> > +#define UFS_ATTRIBUTE_RW(_name, _uname)                                      \
> > +UFS_ATTRIBUTE_SHOW(_name, _uname)                                    \
> > +static ssize_t _name##_store(struct device *dev,                     \
> > +             struct device_attribute *attr, const char *buf,         \
> > +             size_t count)                                           \
> > +{                                                                    \
> > +     struct ufs_hba *hba = dev_get_drvdata(dev);                     \
> > +     u32 value;                                                      \
> > +     if (kstrtou32(buf, 0, &value))                                  \
> > +             return -EINVAL;                                         \
> > +     if (ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,        \
> > +             QUERY_ATTR_IDN##_uname, 0, 0, &value))                  \
> > +             return -EINVAL;                                         \
> > +     return count;                                                   \
> > +}                                                                    \
> > +static DEVICE_ATTR_RW(_name)
> > +
> > +UFS_ATTRIBUTE_RW(boot_lun_enabled, _BOOT_LU_EN);
> > +UFS_ATTRIBUTE_RO(current_power_mode, _POWER_MODE);
> > +UFS_ATTRIBUTE_RW(active_icc_level, _ACTIVE_ICC_LVL);
> > +UFS_ATTRIBUTE_RW(ooo_data_enabled, _OOO_DATA_EN);
> I would prefer to leave "write once" attributes as read-only.

Oh, but I want those write once attributes, I plan to use them during
provisioning. Are you worried about accidental writes? My mind jumps
to some sort of unlock mechanism where you write a magic string into
an additional sysfs file to unlock the write-once attributes. But the
last time I proposed a sysfs file that affected the behavior of other
sysfs files, I got the proverbial raspberry. Any thoughts?

>
> > +UFS_ATTRIBUTE_RO(bkops_status, _BKOPS_STATUS);
> > +UFS_ATTRIBUTE_RO(purge_status, _PURGE_STATUS);
> > +UFS_ATTRIBUTE_RW(max_data_in_size, _MAX_DATA_IN);
> > +UFS_ATTRIBUTE_RW(max_data_out_size, _MAX_DATA_OUT);
> > +UFS_ATTRIBUTE_RW(reference_clock_frequency, _REF_CLK_FREQ);
> > +UFS_ATTRIBUTE_RW(configuration_descriptor_lock, _CONF_DESC_LOCK);
> Same here, "write once" attribute.
>
> > +UFS_ATTRIBUTE_RW(max_number_of_rtt, _MAX_NUM_OF_RTT);
> > +UFS_ATTRIBUTE_RW(exception_event_control, _EE_CONTROL);
> > +UFS_ATTRIBUTE_RW(exception_event_status, _EE_STATUS);
> This one is read only attribute.

Will fix.

>
> > +UFS_ATTRIBUTE_RO(ffu_status, _FFU_STATUS);
> > +UFS_ATTRIBUTE_RO(psa_state, _PSA_STATE);
> > +UFS_ATTRIBUTE_RO(psa_data_size, _PSA_DATA_SIZE);
> >
> >  static struct attribute *ufs_sysfs_attributes[] = {
> >       &dev_attr_boot_lun_enabled.attr,
> > --
> > 2.16.4
>
> I would add some write option to some flags as well. For example, enabling/
> disabling the background operations could be very useful.

I agree. Okay if I do that as a follow-on patch?

>
> Regards
> Stanislav
