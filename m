Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967805AbeCALgg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 06:36:36 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42693 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967540AbeCALgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 06:36:31 -0500
X-Google-Smtp-Source: AG47ELu2UHLCDNPIBgYP3qJRTOS0xFLd3MmmSj6tt98MP5P+to0YZqLx3w7vOX0/a6SAgVFoN7TSYp6sKls9hKgbfbU=
MIME-Version: 1.0
In-Reply-To: <20180228193142-mutt-send-email-mst@kernel.org>
References: <20180228150615.17317-1-marcandre.lureau@redhat.com>
 <20180228150615.17317-7-marcandre.lureau@redhat.com> <20180228193142-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 1 Mar 2018 12:36:29 +0100
Message-ID: <CAMxuvaxAuB3mtq7--KA+cCrGZ-kJj9+9yrdiToYo9EoH-=AYHw@mail.gmail.com>
Subject: Re: [PATCH v16 06/11] fw_cfg: handle fw_cfg_read_blob() error
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
        Sergio Lopez Pascual <slp@redhat.com>,
        "Somlo, Gabriel" <somlo@cmu.edu>, xiaolong.ye@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Wed, Feb 28, 2018 at 6:32 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> @@ -557,7 +566,10 @@ static int fw_cfg_sysfs_probe(struct platform_device *pdev)
>>               goto err_probe;
>>
>>       /* get revision number, add matching top-level attribute */
>> -     fw_cfg_read_blob(FW_CFG_ID, &rev, 0, sizeof(rev));
>> +     err = fw_cfg_read_blob(FW_CFG_ID, &rev, 0, sizeof(rev));
>> +     if (err < 0)
>> +             goto err_probe;
>> +
>>       fw_cfg_rev = le32_to_cpu(rev);
>>       err = sysfs_create_file(fw_cfg_top_ko, &fw_cfg_rev_attr.attr);
>>       if (err)
>
> So on this one, maybe we should just drop this attribute.
> Does anyone use it?
> Removing it will speed up boot slightly.

We can't skip reading FW_CFG_ID (rev) as we need it to check DMA
support. I don't mind if we remove the sysfs entry, but I doubt it
makes a difference in boot time.

>> --
>> 2.16.1.73.g5832b7e9f2
