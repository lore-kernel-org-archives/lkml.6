Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932544AbeCIS4L (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:56:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50325 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932165AbeCIS4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:56:10 -0500
X-Google-Smtp-Source: AG47ELvnaJ3MSwz/fWomUO9mASedGSELBngnC+li5r8I3iISHCwArqds1BEhp73Sm+wzGO2XikVg2/zl3g26IOE9W7c=
MIME-Version: 1.0
In-Reply-To: <20180309143315.354ad0be@endymion>
References: <1519800494-32107-1-git-send-email-alex.hung@canonical.com> <20180309143315.354ad0be@endymion>
From: Alex Hung <alex.hung@canonical.com>
Date: Fri, 9 Mar 2018 10:56:07 -0800
Message-ID: <CAJ=jqubM2P8=pJQ8cofD3C67hiTOEoB4J99suAdS3YY30eZy-g@mail.gmail.com>
Subject: Re: [PATCH][V2] firmware: dmi_scan: add DMI_OEM_STRING support to dmi_matches
To: Jean Delvare <jdelvare@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 9, 2018 at 5:33 AM, Jean Delvare <jdelvare@suse.de> wrote:
> Hi Alex,
>
> On Tue, 27 Feb 2018 22:48:14 -0800, Alex Hung wrote:
>> OEM strings are defined by each OEM and they contain customized and
>> useful OEM information. Supporting it provides more flexible uses of
>> the dmi_matches function.
>>
>> Signed-off-by: Alex Hung <alex.hung@canonical.com>
>> ---
>>  drivers/firmware/dmi_scan.c     | 11 +++++++++--
>>  include/linux/mod_devicetable.h |  1 +
>>  2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
>> index e763e14..c712e66 100644
>> --- a/drivers/firmware/dmi_scan.c
>> +++ b/drivers/firmware/dmi_scan.c
>> @@ -775,7 +775,15 @@ static bool dmi_matches(const struct dmi_system_id *dmi)
>>               int s = dmi->matches[i].slot;
>>               if (s == DMI_NONE)
>>                       break;
>> -             if (dmi_ident[s]) {
>> +             if (s == DMI_OEM_STRING) {
>> +                     /* DMI_OEM_STRING must be exact match */
>> +                     const struct dmi_device *valid;
>> +
>> +                     valid = dmi_find_device(DMI_DEV_TYPE_OEM_STRING,
>> +                                             dmi->matches[i].substr, NULL);
>> +                     if (valid)
>> +                             continue;
>> +             } else if (dmi_ident[s]) {
>>                       if (dmi->matches[i].exact_match) {
>>                               if (!strcmp(dmi_ident[s],
>>                                           dmi->matches[i].substr))
>> @@ -786,7 +794,6 @@ static bool dmi_matches(const struct dmi_system_id *dmi)
>>                                       continue;
>>                       }
>>               }
>> -
>>               /* No match */
>>               return false;
>>       }
>
> Please avoid gratuitous blank line changes.
>
>> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
>> index 48fb2b4..7d361be 100644
>> --- a/include/linux/mod_devicetable.h
>> +++ b/include/linux/mod_devicetable.h
>> @@ -502,6 +502,7 @@ enum dmi_field {
>>       DMI_CHASSIS_SERIAL,
>>       DMI_CHASSIS_ASSET_TAG,
>>       DMI_STRING_MAX,
>> +     DMI_OEM_STRING, /* special case - will not be in dmi_ident */
>>  };
>>
>>  struct dmi_strmatch {
>
> Other than this, I'm happy with this version, so with the blank line
> restored:
>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thank you very much.

>
> However it doesn't make sense to commit this change unless there will
> be at least one user of it. What is the status of the piece of code
> which was supposed to use this new feature?

The original use of DMI on _OSI is no needed anymore - the OEM _OSI
string will always enabled; however, this patch is still needed
because DMI_OEM_STRING are more suitable for many DMI quirks,
especially for Dell systems, and many, if not all, DMI quirks for Dell
systems with DMI_PRODUCT_NAME can be (and should be) replaced by
DMI_OEM_STRING because 1) OEM string contains system id, 2) multiple
product names can be used for the same system id and 3) the number DMI
quirks can be reduced.

For example, the DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 9020M") in
commit 1f59ab2783aed04f131 can be replaced by
DMI_MATCH_EXACT(DMI_OEM_STRING, "1[0669]")

I will start sending DMI quirks with DMI_OEM_STRING myself and perhaps
sending a clean up patch to replace DMI_PRODUCT_NAME by DMI_OEM_STRING
for the Dell systems I have access to. With this patch in place first,
I am able to convince others to use DMI_OEM_STRING because there will
fewer risks to spend time in vain.

Cheers,
Alex Hung

>
> --
> Jean Delvare
> SUSE L3 Support
