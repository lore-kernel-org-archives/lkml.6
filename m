Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752241AbeEOVxp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:53:45 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35679 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751868AbeEOVxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:53:43 -0400
X-Google-Smtp-Source: AB8JxZoqDM8Y1SRhLhm8r8+3LBn+pGFFZWizE7j5i7vvIEnObDgo55WYRiGjc6L8BVS1aJIpFf321Q==
Reply-To: ahs3@redhat.com
Subject: Re: [PATCH v3 2/3] ACPI: ensure acpi_parse_entries_array() does not
 access non-existent table data
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
References: <20180501003907.4322-1-ahs3@redhat.com>
 <20180501003907.4322-3-ahs3@redhat.com>
 <CAJZ5v0j2qnB-CohTzdFzd1mgp0QAphxgTkXa9wVivh02JYnACA@mail.gmail.com>
From: Al Stone <ahs3@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <04afae30-7012-ebb9-cd0e-3ec39bfd955c@redhat.com>
Date: Tue, 15 May 2018 15:53:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0j2qnB-CohTzdFzd1mgp0QAphxgTkXa9wVivh02JYnACA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/2018 11:19 AM, Rafael J. Wysocki wrote:
> On Tue, May 1, 2018 at 2:39 AM, Al Stone <ahs3@redhat.com> wrote:
>> For ACPI tables that have subtables, acpi_parse_entries_array() gets used
>> to step through each of the subtables in memory.  The primary loop for this
>> was checking that the beginning location of the subtable being examined
>> plus the length of struct acpi_subtable_header was not beyond the end of
>> the complete ACPI table; if it wasn't, the subtable could be examined, but
>> if it was the loop would terminate as it should.
>>
>> In the middle of this subtable loop, a callback is used to examine the
>> subtable in detail.
>>
>> Should the callback function try to examine elements of the subtable that
>> are located past the subtable header, and the ACPI table containing this
>> subtable has an incorrect length, it is possible to access either invalid
>> or protected memory and cause a fault.  And, the length of struct
>> acpi_subtable_header will always be smaller than the length of the actual
>> subtable.
>>
>> To fix this, we make the main loop check that the beginning of the
>> subtable being examined plus the actual length of the subtable does
>> not go past the end of the enclosing ACPI table.  While this cannot
>> protect us from malicious callback functions, it can prevent us from
>> failing because of some poorly constructed ACPI tables.
>>
>> Found by inspection.  There is no functional change to existing code
>> that is known to work when calling acpi_parse_entries_array().
>>
>> Signed-off-by: Al Stone <ahs3@redhat.com>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Len Brown <lenb@kernel.org>
>> ---
>>  drivers/acpi/tables.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>> index 4a3410aa6540..82c3e2c52dd9 100644
>> --- a/drivers/acpi/tables.c
>> +++ b/drivers/acpi/tables.c
>> @@ -274,8 +274,7 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>>         entry = (struct acpi_subtable_header *)
>>             ((unsigned long)table_header + table_size);
>>
>> -       while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
>> -              table_end) {
>> +       while ((unsigned long)entry + entry->length <= table_end) {
>>                 if (max_entries && count >= max_entries)
>>                         break;
>>
>> --
> 
> This breaks the CPU enumeration on my Dell XPS13 9360 (possibly among
> other things), so I'm dropping it.  I can send you acpidump output
> from that machine if need be.
> 
> Thanks,
> Rafael
> 

Yes, please.  My fear is that there are a bunch of MADT tables in the real world
that aren't quite right so that while this may be theoretically correct, it may
be wrong as a practical matter.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
