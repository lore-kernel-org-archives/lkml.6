Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB5BC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10820208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10820208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbeJEOeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:34:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:18555 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbeJEOeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:34:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 00:36:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,343,1534834800"; 
   d="scan'208";a="96305553"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.61])
  by fmsmga001.fm.intel.com with ESMTP; 05 Oct 2018 00:36:36 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] sysfs: constify sysfs create/remove files harder
In-Reply-To: <CAJZ5v0iOR=PLHWtuJDVSsjpeTp_BLsheRM_dR_AL00hN-6bUhQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20181004143750.30880-1-jani.nikula@intel.com> <CAJZ5v0iOR=PLHWtuJDVSsjpeTp_BLsheRM_dR_AL00hN-6bUhQ@mail.gmail.com>
Date:   Fri, 05 Oct 2018 10:36:29 +0300
Message-ID: <87lg7cq1z6.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Oct 2018, "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> On Thu, Oct 4, 2018 at 4:38 PM Jani Nikula <jani.nikula@intel.com> wrote:
>>
>> Let the passed in array be const (and thus placed in rodata) instead of
>> a mutable array of const pointers.
>
> I'm not sure if the changes guarantee what you want.  If I'm not
> mistaken, they just mean that the function itself cannot modify either
> the pointer passed to it, or the contents of the array pointed to by
> that pointer.  They don't imply the location of the array itself,
> though.

I mean, this change allows the caller to add the appropriate const
qualifiers to the array definition, allowing the placement in
rodata. Can't do that withouth the extra const in the function.

> As for the changes:
>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks for the review.

BR,
Jani.


>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>> ---
>>  fs/sysfs/file.c       | 4 ++--
>>  include/linux/sysfs.h | 8 ++++----
>>  2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
>> index 0a7252aecfa5..bb71db63c99c 100644
>> --- a/fs/sysfs/file.c
>> +++ b/fs/sysfs/file.c
>> @@ -334,7 +334,7 @@ int sysfs_create_file_ns(struct kobject *kobj, const struct attribute *attr,
>>  }
>>  EXPORT_SYMBOL_GPL(sysfs_create_file_ns);
>>
>> -int sysfs_create_files(struct kobject *kobj, const struct attribute **ptr)
>> +int sysfs_create_files(struct kobject *kobj, const struct attribute * const *ptr)
>>  {
>>         int err = 0;
>>         int i;
>> @@ -493,7 +493,7 @@ bool sysfs_remove_file_self(struct kobject *kobj, const struct attribute *attr)
>>         return ret;
>>  }
>>
>> -void sysfs_remove_files(struct kobject *kobj, const struct attribute **ptr)
>> +void sysfs_remove_files(struct kobject *kobj, const struct attribute * const *ptr)
>>  {
>>         int i;
>>         for (i = 0; ptr[i]; i++)
>> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
>> index 987cefa337de..786816cf4aa5 100644
>> --- a/include/linux/sysfs.h
>> +++ b/include/linux/sysfs.h
>> @@ -234,7 +234,7 @@ int __must_check sysfs_create_file_ns(struct kobject *kobj,
>>                                       const struct attribute *attr,
>>                                       const void *ns);
>>  int __must_check sysfs_create_files(struct kobject *kobj,
>> -                                  const struct attribute **attr);
>> +                                  const struct attribute * const *attr);
>>  int __must_check sysfs_chmod_file(struct kobject *kobj,
>>                                   const struct attribute *attr, umode_t mode);
>>  struct kernfs_node *sysfs_break_active_protection(struct kobject *kobj,
>> @@ -243,7 +243,7 @@ void sysfs_unbreak_active_protection(struct kernfs_node *kn);
>>  void sysfs_remove_file_ns(struct kobject *kobj, const struct attribute *attr,
>>                           const void *ns);
>>  bool sysfs_remove_file_self(struct kobject *kobj, const struct attribute *attr);
>> -void sysfs_remove_files(struct kobject *kobj, const struct attribute **attr);
>> +void sysfs_remove_files(struct kobject *kobj, const struct attribute * const *attr);
>>
>>  int __must_check sysfs_create_bin_file(struct kobject *kobj,
>>                                        const struct bin_attribute *attr);
>> @@ -342,7 +342,7 @@ static inline int sysfs_create_file_ns(struct kobject *kobj,
>>  }
>>
>>  static inline int sysfs_create_files(struct kobject *kobj,
>> -                                   const struct attribute **attr)
>> +                                   const struct attribute * const *attr)
>>  {
>>         return 0;
>>  }
>> @@ -377,7 +377,7 @@ static inline bool sysfs_remove_file_self(struct kobject *kobj,
>>  }
>>
>>  static inline void sysfs_remove_files(struct kobject *kobj,
>> -                                    const struct attribute **attr)
>> +                                    const struct attribute * const *attr)
>>  {
>>  }
>>
>> --
>> 2.11.0
>>

-- 
Jani Nikula, Intel Open Source Graphics Center
