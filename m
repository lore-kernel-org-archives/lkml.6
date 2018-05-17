Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752191AbeEQTsp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 15:48:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50288 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752130AbeEQTsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 15:48:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CDD60605A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pprakash@codeaurora.org
Subject: Re: [PATCH v4 3/3] mailbox: ACPI: erroneous error message when
 parsing the ACPI, PCCT
To: "Rafael J. Wysocki" <rafael@kernel.org>, Al Stone <ahs3@redhat.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
References: <20180501003907.4322-1-ahs3@redhat.com>
 <20180501003907.4322-4-ahs3@redhat.com>
 <17197481-bd76-f2ec-9d6e-4cd0d94b9265@codeaurora.org>
 <bb9eefb1-a22b-9fc1-4a51-d067bdbe3f99@redhat.com>
 <CAJZ5v0itXwbatAwaXTumW17nxLVEKWTWhh1wqOiUqFmBSdjzzA@mail.gmail.com>
 <b3a31c5a-7090-ff15-c90d-dfeab221471f@redhat.com>
 <CAJZ5v0i7fR+rAk4eRm0jV8Ot93juq8NZarsoJRX+7RV6-yELKw@mail.gmail.com>
From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Message-ID: <85c95aad-fefb-50f4-8a06-eec25415db2a@codeaurora.org>
Date: Thu, 17 May 2018 13:48:39 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0i7fR+rAk4eRm0jV8Ot93juq8NZarsoJRX+7RV6-yELKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/17/2018 4:24 AM, Rafael J. Wysocki wrote:
> On Thu, May 17, 2018 at 12:01 AM, Al Stone <ahs3@redhat.com> wrote:
>> There have been multiple reports of the following error message:
>>
>> [    0.068293] Error parsing PCC subspaces from PCCT
>>
>> This error message is not correct.  In multiple cases examined, the PCCT
>> (Platform Communications Channel Table) concerned is actually properly
>> constructed; the problem is that acpi_pcc_probe() which reads the PCCT
>> is making the assumption that the only valid PCCT is one that contains
>> subtables of one of two types: ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE or
>> ACPI_PCCT_TYPE_HW_REDUCED_TYPE2.  The number of subtables of these
>> types are counted and as long as there is at least one of the desired
>> types, the acpi_pcc_probe() succeeds.  When no subtables of these types
>> are found, regardless of whether or not any other subtable types are
>> present, the error mentioned above is reported.
>>
>> In the cases reported to me personally, the PCCT contains exactly one
>> subtable of type ACPI_PCCT_TYPE_GENERIC_SUBSPACE.  The function
>> acpi_pcc_probe() does not count it as a valid subtable, so believes
>> there to be no valid subtables, and hence outputs the error message.
>>
>> An example of the PCCT being reported as erroneous yet perfectly fine
>> is the following:
>>
>>                     Signature : "PCCT"
>>                  Table Length : 0000006E
>>                      Revision : 05
>>                      Checksum : A9
>>                        Oem ID : "XXXXXX"
>>                  Oem Table ID : "XXXXX   "
>>                  Oem Revision : 00002280
>>               Asl Compiler ID : "XXXX"
>>         Asl Compiler Revision : 00000002
>>
>>         Flags (decoded below) : 00000001
>>                      Platform : 1
>>                      Reserved : 0000000000000000
>>
>>                 Subtable Type : 00 [Generic Communications Subspace]
>>                        Length : 3E
>>
>>                      Reserved : 000000000000
>>                  Base Address : 00000000DCE43018
>>                Address Length : 0000000000001000
>>
>>             Doorbell Register : [Generic Address Structure]
>>                      Space ID : 01 [SystemIO]
>>                     Bit Width : 08
>>                    Bit Offset : 00
>>          Encoded Access Width : 01 [Byte Access:8]
>>                       Address : 0000000000001842
>>
>>                 Preserve Mask : 00000000000000FD
>>                    Write Mask : 0000000000000002
>>               Command Latency : 00001388
>>           Maximum Access Rate : 00000000
>>       Minimum Turnaround Time : 0000
>>
>> To fix this, we count up all of the possible subtable types for the
>> PCCT, and only report an error when there are none (which could mean
>> either no subtables, or no valid subtables), or there are too many.
>> We also change the logic so that if there is a valid subtable, we
>> do try to initialize it per the PCCT subtable contents.  This is a
>> change in functionality; previously, the probe would have returned
>> right after the error message and would not have tried to use any
>> other subtable definition.
>>
>> Tested on my personal laptop which showed the error previously; the
>> error message no longer appears and the laptop appears to operate
>> normally.
> I'd like to know the Prashanth's opinion here.

Looks good.

Reviewed-by: Prashanth Prakash <pprakash@codeaurora.org>

--
Thanks,
Prashanth
