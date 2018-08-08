Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CE4C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4496721ADF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UtE5CDQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4496721ADF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbeHIA6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 20:58:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37542 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730262AbeHIA6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 20:58:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id v9-v6so2972222ljk.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 15:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r3HncyiROr5NZxHnHIdgU1pt9+WDVHKcr6D00d4Tr1w=;
        b=UtE5CDQBTlHBvTX/EHhc7Q4FszoJFLzDuZzGkj/OEgLwhb1P6P/mGr4xEgUuZC9aOo
         X3GkfRKMkaVVP76Kjisyaz6j9HXYufZYW/EvC7FD2Lw2IpLfIH1NzxrxciHjxViYGr4P
         wPJO/1ixmPfLKtMlMiw+urvfTGdMn5s0oXgoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r3HncyiROr5NZxHnHIdgU1pt9+WDVHKcr6D00d4Tr1w=;
        b=qtHQrdbVDrf0+Qnirg8S1QSgs959MJ3Tj51edHPnAjjozGZlOn3yh7ySzygtW6kVg7
         4qOLHUycu2pwCOEGFeqLnHTZ7eVbTTGAmLrZYL5wYHbI3ZHXQlq9OdvfIHM3OEhOFfUt
         sO2nYFKJXf7OrQ+3pKQAKtukWg0sIuagI0DZ46X1bsNZavsNoKjkQYif0ddXbsrs72yC
         6qAhayvSIfB8k04QVFqOET4pmrU+zmzTxB7uRyvnEtV9VqkNbzFxoaAxd4tRe0ql4Eyb
         +ghiOxdgJhTlm25pHPF+l47h9amkmRVnucpyEDMUGNe5PKCXEOd78khb61SxjbIFIMQg
         HFxA==
X-Gm-Message-State: AOUpUlF707vKIbj4GsAdlX5b9d+lcn0G6b6hgOhZERj1VxivTX/94asG
        5Q822LR8DHYEbBMVUFrYkcVGKlsZXls=
X-Google-Smtp-Source: AA+uWPy7Rvdc6twcJhbkt+YRUTBK1DOgKNmYWK5XZ8rhHwqp4qtOHkR2Jq0zILTzQFHcXYO2X9nD+w==
X-Received: by 2002:a2e:144f:: with SMTP id 15-v6mr3419191lju.122.1533767777578;
        Wed, 08 Aug 2018 15:36:17 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id w8-v6sm994154lfe.67.2018.08.08.15.36.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 15:36:15 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id b22-v6so2727345lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 15:36:15 -0700 (PDT)
X-Received: by 2002:a19:10c4:: with SMTP id 65-v6mr3218305lfq.113.1533767775084;
 Wed, 08 Aug 2018 15:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180725201452.81235-1-evgreen@chromium.org> <MWHPR04MB11374B145CB323EC8C3339DB9A200@MWHPR04MB1137.namprd04.prod.outlook.com>
 <CAE=gft71pqduuEE+dtWX0oFv3pcodD6ddenyuLX4JPo=0Ht6kg@mail.gmail.com> <MWHPR04MB11379252EFDE5E6198EA06069A260@MWHPR04MB1137.namprd04.prod.outlook.com>
In-Reply-To: <MWHPR04MB11379252EFDE5E6198EA06069A260@MWHPR04MB1137.namprd04.prod.outlook.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 8 Aug 2018 15:35:38 -0700
X-Gmail-Original-Message-ID: <CAE=gft607Bqr=_C71xcqataq5JMDYY+2Q7hrd+cae4sv_F2PvA@mail.gmail.com>
Message-ID: <CAE=gft607Bqr=_C71xcqataq5JMDYY+2Q7hrd+cae4sv_F2PvA@mail.gmail.com>
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

On Wed, Aug 8, 2018 at 1:47 AM Stanislav Nijnikov
<Stanislav.Nijnikov@wdc.com> wrote:
>
> Hi Evan,
>
> > -----Original Message-----
> > From: Evan Green <evgreen@chromium.org>
> > Sent: Tuesday, August 7, 2018 9:15 PM
> > To: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
> > Cc: Vinayak Holikatti <vinholikatti@gmail.com>; jejb@linux.vnet.ibm.com; martin.petersen@oracle.com; adrian.hunter@intel.com;
> > linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org; Bart Van Assche <Bart.VanAssche@wdc.com>
> > Subject: Re: [PATCH v3] scsi: ufs: Make sysfs attributes writable
> >
> > Hi Stanislav. Thanks for the review.
> >
> > On Mon, Aug 6, 2018 at 2:28 AM Stanislav Nijnikov
> > <Stanislav.Nijnikov@wdc.com> wrote:
> > >
> > > Hi Evan,
> > >
> > > > -----Original Message-----
> > > > From: Evan Green <evgreen@chromium.org>
> > > > Sent: Wednesday, July 25, 2018 11:15 PM
> > > > To: Vinayak Holikatti <vinholikatti@gmail.com>; James E.J. Bottomley <jejb@linux.vnet.ibm.com>; Martin K. Petersen
> > > > <martin.petersen@oracle.com>; Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>; Adrian Hunter <adrian.hunter@intel.com>;
> > linux-
> > > > kernel@vger.kernel.org; linux-scsi@vger.kernel.org; Bart Van Assche <Bart.VanAssche@wdc.com>
> > > > Cc: Evan Green <evgreen@chromium.org>
> > > > Subject: [PATCH v3] scsi: ufs: Make sysfs attributes writable
> > > >
> > > > This change makes the UFS controller's sysfs attributes writable, which
> > > > will enable users to modify attributes. This can be useful during factory
> > > > provisioning for setting up critical attributes like the reference clock
> > > > frequency.
> > > >
> > > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > > > ---
> > > > Configfs was determined to be the preferred mechanism for writing the
> > > > config descriptor, but attributes also need to be written during setup,
> > > > and are already present in sysfs. Making these attributes writable is
> > > > also helpful for debugging and experimentation.
> > > >
> > > > Changes since v2:
> > > >       - Removed the configuration descriptor changes from the series,
> > > > since configfs was the preferred way to write to that, leaving only
> > > > this change.
> > > >
> > > > Changes since v1:
> > > >       - Reworked the interface to show each unit of the config
> > > > descriptor as a separate directory, rather than the previous method I
> > > > had of a file for selecting the unit, and then a common set of files
> > > > that interacted with whichever unit was selected. I did some kobject
> > > > magic to accomplish this. I noticed from Greg KH's reply to Sayali's
> > > > patches [1] that configfs might be the preferred method. Let me know
> > > > if I should abandon this series in favor of Sayali's, with the
> > > > possible exception of "Make sysfs attributes writable".
> > > >       - Squashed documentation changes into their respective code
> > > > changes.
> > > >       - I decided to keep the config descriptor attributes as their
> > > > own files, rather than hiding writes behind device descriptor and unit
> > > > descriptor, as I think that's more future proof and true to the UFS spec.
> > > >
> > > > [1] https://lkml.org/lkml/2018/6/8/210
> > > >
> > > >  Documentation/ABI/testing/sysfs-driver-ufs | 17 +--------
> > > >  drivers/scsi/ufs/ufs-sysfs.c               | 58 ++++++++++++++++++++----------
> > > >  2 files changed, 40 insertions(+), 35 deletions(-)
> > > >
> > ...
> > > > diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
> > > > index 8d9332bb7d0c..5e286b9d1aea 100644
> > > > --- a/drivers/scsi/ufs/ufs-sysfs.c
> > > > +++ b/drivers/scsi/ufs/ufs-sysfs.c
> > > > @@ -655,7 +655,7 @@ static const struct attribute_group ufs_sysfs_flags_group = {
> > > >       .attrs = ufs_sysfs_device_flags,
> > > >  };
> > > >
> > > > -#define UFS_ATTRIBUTE(_name, _uname)                                 \
> > > > +#define UFS_ATTRIBUTE_SHOW(_name, _uname)                            \
> > > >  static ssize_t _name##_show(struct device *dev,                              \
> > > >       struct device_attribute *attr, char *buf)                       \
> > > >  {                                                                    \
> > > > @@ -665,25 +665,45 @@ static ssize_t _name##_show(struct device *dev,                         \
> > > >               QUERY_ATTR_IDN##_uname, 0, 0, &value))                  \
> > > >               return -EINVAL;                                         \
> > > >       return sprintf(buf, "0x%08X\n", value);                         \
> > > > -}                                                                    \
> > > > -static DEVICE_ATTR_RO(_name)
> > > > +}
> > > >
> > > > -UFS_ATTRIBUTE(boot_lun_enabled, _BOOT_LU_EN);
> > > > -UFS_ATTRIBUTE(current_power_mode, _POWER_MODE);
> > > > -UFS_ATTRIBUTE(active_icc_level, _ACTIVE_ICC_LVL);
> > > > -UFS_ATTRIBUTE(ooo_data_enabled, _OOO_DATA_EN);
> > > > -UFS_ATTRIBUTE(bkops_status, _BKOPS_STATUS);
> > > > -UFS_ATTRIBUTE(purge_status, _PURGE_STATUS);
> > > > -UFS_ATTRIBUTE(max_data_in_size, _MAX_DATA_IN);
> > > > -UFS_ATTRIBUTE(max_data_out_size, _MAX_DATA_OUT);
> > > > -UFS_ATTRIBUTE(reference_clock_frequency, _REF_CLK_FREQ);
> > > > -UFS_ATTRIBUTE(configuration_descriptor_lock, _CONF_DESC_LOCK);
> > > > -UFS_ATTRIBUTE(max_number_of_rtt, _MAX_NUM_OF_RTT);
> > > > -UFS_ATTRIBUTE(exception_event_control, _EE_CONTROL);
> > > > -UFS_ATTRIBUTE(exception_event_status, _EE_STATUS);
> > > > -UFS_ATTRIBUTE(ffu_status, _FFU_STATUS);
> > > > -UFS_ATTRIBUTE(psa_state, _PSA_STATE);
> > > > -UFS_ATTRIBUTE(psa_data_size, _PSA_DATA_SIZE);
> > > > +#define UFS_ATTRIBUTE_RO(_name, _uname)                                      \
> > > > +UFS_ATTRIBUTE_SHOW(_name, _uname)                                    \
> > > > +DEVICE_ATTR_RO(_name)
> > > It should be static here.
> >
> > Will fix.
> >
> > >
> > > > +
> > > > +#define UFS_ATTRIBUTE_RW(_name, _uname)                                      \
> > > > +UFS_ATTRIBUTE_SHOW(_name, _uname)                                    \
> > > > +static ssize_t _name##_store(struct device *dev,                     \
> > > > +             struct device_attribute *attr, const char *buf,         \
> > > > +             size_t count)                                           \
> > > > +{                                                                    \
> > > > +     struct ufs_hba *hba = dev_get_drvdata(dev);                     \
> > > > +     u32 value;                                                      \
> > > > +     if (kstrtou32(buf, 0, &value))                                  \
> > > > +             return -EINVAL;                                         \
> > > > +     if (ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,        \
> > > > +             QUERY_ATTR_IDN##_uname, 0, 0, &value))                  \
> > > > +             return -EINVAL;                                         \
> > > > +     return count;                                                   \
> > > > +}                                                                    \
> > > > +static DEVICE_ATTR_RW(_name)
> > > > +
> > > > +UFS_ATTRIBUTE_RW(boot_lun_enabled, _BOOT_LU_EN);
> > > > +UFS_ATTRIBUTE_RO(current_power_mode, _POWER_MODE);
> > > > +UFS_ATTRIBUTE_RW(active_icc_level, _ACTIVE_ICC_LVL);
> > > > +UFS_ATTRIBUTE_RW(ooo_data_enabled, _OOO_DATA_EN);
> > > I would prefer to leave "write once" attributes as read-only.
> >
> > Oh, but I want those write once attributes, I plan to use them during
> > provisioning. Are you worried about accidental writes? My mind jumps
> > to some sort of unlock mechanism where you write a magic string into
> > an additional sysfs file to unlock the write-once attributes. But the
> > last time I proposed a sysfs file that affected the behavior of other
> > sysfs files, I got the proverbial raspberry. Any thoughts?
> >
> Well, I suppose users with root  permissions should know what they are
> doing. At least, add a special comment for these in the ABI file, not
> everyone has access to the UFS spec.

Will do. Spin coming up.
-Evan
