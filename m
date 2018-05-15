Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbeEOIAX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:00:23 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:42853 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752368AbeEOIAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:00:18 -0400
X-Google-Smtp-Source: AB8JxZptUnUTIp0InquUCI90rgP8xl4S7ztZmE3mF7NQHfc/+PyYYvOOyvFMTp71d1pgPetPd1968RQjjpgKpIUKJ8k=
MIME-Version: 1.0
In-Reply-To: <bb9eefb1-a22b-9fc1-4a51-d067bdbe3f99@redhat.com>
References: <20180501003907.4322-1-ahs3@redhat.com> <20180501003907.4322-4-ahs3@redhat.com>
 <17197481-bd76-f2ec-9d6e-4cd0d94b9265@codeaurora.org> <bb9eefb1-a22b-9fc1-4a51-d067bdbe3f99@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 15 May 2018 10:00:17 +0200
X-Google-Sender-Auth: srOnNvhR5561TuRdyWhhyQrYRGE
Message-ID: <CAJZ5v0itXwbatAwaXTumW17nxLVEKWTWhh1wqOiUqFmBSdjzzA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mailbox: ACPI: erroneous error message when
 parsing the ACPI PCCT
To: Al Stone <ahs3@redhat.com>
Cc: "Prakash, Prashanth" <pprakash@codeaurora.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 12:49 AM, Al Stone <ahs3@redhat.com> wrote:
> On 05/14/2018 03:04 PM, Prakash, Prashanth wrote:
>>
>>
>> On 4/30/2018 6:39 PM, Al Stone wrote:
>>> There have been multiple reports of the following error message:
>>>
>>> [    0.068293] Error parsing PCC subspaces from PCCT
>>>
>>> This error message is not correct.  In multiple cases examined, the PCCT
>>> (Platform Communications Channel Table) concerned is actually properly
>>> constructed; the problem is that acpi_pcc_probe() which reads the PCCT
>>> is making the assumption that the only valid PCCT is one that contains
>>> subtables of one of two types: ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE or
>>> ACPI_PCCT_TYPE_HW_REDUCED_TYPE2.  The number of subtables of these
>>> types are counted and as long as there is at least one of the desired
>>> types, the acpi_pcc_probe() succeeds.  When no subtables of these types
>>> are found, regardless of whether or not any other subtable types are
>>> present, the error mentioned above is reported.
>>>
>>> In the cases reported to me personally, the PCCT contains exactly one
>>> subtable of type ACPI_PCCT_TYPE_GENERIC_SUBSPACE.  The function
>>> acpi_pcc_probe() does not count it as a valid subtable, so believes
>>> there to be no valid subtables, and hence outputs the error message.
>>>
>>> An example of the PCCT being reported as erroneous yet perfectly fine
>>> is the following:
>>>
>>>                     Signature : "PCCT"
>>>                  Table Length : 0000006E
>>>                      Revision : 05
>>>                      Checksum : A9
>>>                        Oem ID : "XXXXXX"
>>>                  Oem Table ID : "XXXXX   "
>>>                  Oem Revision : 00002280
>>>               Asl Compiler ID : "XXXX"
>>>         Asl Compiler Revision : 00000002
>>>
>>>         Flags (decoded below) : 00000001
>>>                      Platform : 1
>>>                      Reserved : 0000000000000000
>>>
>>>                 Subtable Type : 00 [Generic Communications Subspace]
>>>                        Length : 3E
>>>
>>>                      Reserved : 000000000000
>>>                  Base Address : 00000000DCE43018
>>>                Address Length : 0000000000001000
>>>
>>>             Doorbell Register : [Generic Address Structure]
>>>                      Space ID : 01 [SystemIO]
>>>                     Bit Width : 08
>>>                    Bit Offset : 00
>>>          Encoded Access Width : 01 [Byte Access:8]
>>>                       Address : 0000000000001842
>>>
>>>                 Preserve Mask : 00000000000000FD
>>>                    Write Mask : 0000000000000002
>>>               Command Latency : 00001388
>>>           Maximum Access Rate : 00000000
>>>       Minimum Turnaround Time : 0000
>>>
>>> To fix this, we count up all of the possible subtable types for the
>>> PCCT, and only report an error when there are none (which could mean
>>> either no subtables, or no valid subtables), or there are too many.
>>> We also change the logic so that if there is a valid subtable, we
>>> do try to initialize it per the PCCT subtable contents.  This is a
>>> change in functionality; previously, the probe would have returned
>>> right after the error message and would not have tried to use any
>>> other subtable definition.
>>>
>>> Tested on my personal laptop which showed the error previously; the
>>> error message no longer appears and the laptop appears to operate
>>> normally.
>>>
>>> Signed-off-by: Al Stone <ahs3@redhat.com>
>>> Cc: Jassi Brar <jassisinghbrar@gmail.com>
>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>> Cc: Len Brown <lenb@kernel.org>
>>> ---
>>>  drivers/mailbox/pcc.c | 96 +++++++++++++++++++++++++++++++++------------------
>>>  1 file changed, 63 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>>> index 3ef7f036ceea..72af37d7e95e 100644
>>> --- a/drivers/mailbox/pcc.c
>>> +++ b/drivers/mailbox/pcc.c
>>> @@ -372,13 +372,37 @@ static const struct mbox_chan_ops pcc_chan_ops = {
>>>      .send_data = pcc_send_data,
>>>  };
>>>
>>> +/*
>>> + *
>>> + * count_pcc_subspaces -- Count PCC subspaces not used in reduced HW systems.
>>> + * @header: Pointer to the ACPI subtable header under the PCCT.
>>> + * @end: End of subtable entry.
>>> + *
>>> + * Return: If we find a PCC subspace entry that is one of the types used
>>> + *  in reduced hardware systems, return -EINVAL.  Otherwise, return 0.
>>> + *
>>> + * This gets called for each subtable in the PCC table.
>>> + */
>>> +static int count_pcc_subspaces(struct acpi_subtable_header *header,
>>> +            const unsigned long end)
>>> +{
>>> +    struct acpi_pcct_subspace *pcct_ss = (struct acpi_pcct_subspace *) header;
>>> +
>>> +    if ((pcct_ss->header.type <= ACPI_PCCT_TYPE_RESERVED) &&
>>> +        (pcct_ss->header.type != ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE) &&
>>> +        (pcct_ss->header.type != ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2))
>>> +            return 0;
>>> +
>>> +    return -EINVAL;
>>> +}
>>> +
>>>  /**
>>> - * parse_pcc_subspace - Parse the PCC table and verify PCC subspace
>>> - *          entries. There should be one entry per PCC client.
>>> + * parse_pcc_subspaces -- Count PCC subspaces used only in reduced HW systems.
>>>   * @header: Pointer to the ACPI subtable header under the PCCT.
>>>   * @end: End of subtable entry.
>>>   *
>>> - * Return: 0 for Success, else errno.
>>> + * Return: If we find a PCC subspace entry that is one of the types used
>>> + *  in reduced hardware systems, return 0.  Otherwise, return -EINVAL.
>>>   *
>>>   * This gets called for each entry in the PCC table.
>>>   */
>>> @@ -393,10 +417,8 @@ static int parse_pcc_subspace(struct acpi_subtable_header *header,
>>>              if ((pcct_ss->header.type !=
>>>                              ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE)
>>>                  && (pcct_ss->header.type !=
>>> -                            ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2)) {
>>> -                    pr_err("Incorrect PCC Subspace type detected\n");
>>> +                            ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2))
>>>                      return -EINVAL;
>>> -            }
>>>      }
>>>
>>>      return 0;
>> Can't we combine  parse_pcc_subspace and count_pcc_subspaces into a
>> single function? parse_pcc_subspace can return 0 for supported subspace
>> types and -EINVAL for others.
>
> I did think about that.  The issue is that we have subspaces that are only
> valid in reduced hardware systems, and subspaces that are not.  It might make
> sense to use different names, as in 'count_reduced_hw_subspaces()' and
> 'count_general_subspaces()' (or something like those) but we do have the two
> separate classes and hardware belonging to each of those classes.
>
> That being said, you raise a good point: this would only be useful if the
> mailbox code needed to know the classes of subspaces were different; I saw
> no such code but I could have missed it.  If you're aware of any such cases,
> let me know.  Otherwise, I'll combine the two counting routines and test it.
>
>> The limitation on number of subspaces(max = 256) applies to all types of PCC
>> subspaces (see Table 14-351 in ACPI 6.2).  The MAX_PCC_SUBSPACES check in
>>  parse_pcc_subspace seems invalid as pcc_mbox_ctrl.num_chans will not be
>> initialized yet at that moment.
>
> Good catch.  Thanks.  That test was there prior to my patches, but I'll pull
> it out.
>
>> Given above, I think it is probably better to update parse_pcc_subspace to
>> only check for a valid PCC subspace type. The check to make sure overall count
>> of subspace is  less than 256 is already present following the call to
>> acpi_table_parse_entries_array().
>>
>> --
>> Thanks,
>> Prashanth
>>
>
> Thanks, Prashanth.
>
> Rafael: do you want me to just re-send this patch or the whole series?  Either
> way works for me; what's easiest for you since the first two have been applied?

Just this patch, please.

I've applied the other two already.

Thanks,
Rafael
