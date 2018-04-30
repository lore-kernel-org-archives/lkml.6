Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755575AbeD3X2W (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 19:28:22 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34068 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752614AbeD3X2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 19:28:20 -0400
X-Google-Smtp-Source: AB8JxZoDup1hvv5sv/Rf3tbH+9/DdHICYxGF5epOtDcW25ZvjUwafjI/DR15HAyJtcvI6Fj9Ys/cdQ==
Reply-To: ahs3@redhat.com
Subject: Re: [PATCH v2 2/3] ACPI: ensure acpi_parse_entries_array() does not
 access non-existent table data
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
References: <20180424193505.6934-1-ahs3@redhat.com>
 <20180424193505.6934-3-ahs3@redhat.com>
 <CAJZ5v0h77XTGeJ3oDzxjW2_Otm5bZtu51fudCJ277yd_CXWTuQ@mail.gmail.com>
From: Al Stone <ahs3@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e644ffce-cbbc-dcf3-33a9-a06fe2477a18@redhat.com>
Date: Mon, 30 Apr 2018 17:28:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0h77XTGeJ3oDzxjW2_Otm5bZtu51fudCJ277yd_CXWTuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27/2018 05:05 AM, Rafael J. Wysocki wrote:
> On Tue, Apr 24, 2018 at 9:35 PM, Al Stone <ahs3@redhat.com> wrote:
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
>> index 21535762b890..c7b028f231a6 100644
>> --- a/drivers/acpi/tables.c
>> +++ b/drivers/acpi/tables.c
>> @@ -271,8 +271,7 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>>         entry = (struct acpi_subtable_header *)
>>             ((unsigned long)table_header + table_size);
>>
>> -       while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
>> -              table_end) {
>> +       while (((unsigned long)entry + entry->length) <= table_end) {
> 
> The inner parens are not needed.

Pure paranoia on my part.  Will fix.

>>                 if (max_entries && count >= max_entries)
>>                         break;
>>
>> --


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
