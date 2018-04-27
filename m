Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932811AbeD0LFq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 07:05:46 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:37520 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932700AbeD0LFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 07:05:44 -0400
X-Google-Smtp-Source: AB8JxZqyvmqY8nFovVB/6xZ+/glTvY08wyRRQC6PCo+XNbiqsrAp8onkf8AUUX5hJtCDsHdObGZIs75DAn7/+4ESY/E=
MIME-Version: 1.0
In-Reply-To: <20180424193505.6934-3-ahs3@redhat.com>
References: <20180424193505.6934-1-ahs3@redhat.com> <20180424193505.6934-3-ahs3@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Apr 2018 13:05:43 +0200
X-Google-Sender-Auth: yY_zEUa5fURow4yzVZQs-D8kRqU
Message-ID: <CAJZ5v0h77XTGeJ3oDzxjW2_Otm5bZtu51fudCJ277yd_CXWTuQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ACPI: ensure acpi_parse_entries_array() does not
 access non-existent table data
To: Al Stone <ahs3@redhat.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 9:35 PM, Al Stone <ahs3@redhat.com> wrote:
> For ACPI tables that have subtables, acpi_parse_entries_array() gets used
> to step through each of the subtables in memory.  The primary loop for this
> was checking that the beginning location of the subtable being examined
> plus the length of struct acpi_subtable_header was not beyond the end of
> the complete ACPI table; if it wasn't, the subtable could be examined, but
> if it was the loop would terminate as it should.
>
> In the middle of this subtable loop, a callback is used to examine the
> subtable in detail.
>
> Should the callback function try to examine elements of the subtable that
> are located past the subtable header, and the ACPI table containing this
> subtable has an incorrect length, it is possible to access either invalid
> or protected memory and cause a fault.  And, the length of struct
> acpi_subtable_header will always be smaller than the length of the actual
> subtable.
>
> To fix this, we make the main loop check that the beginning of the
> subtable being examined plus the actual length of the subtable does
> not go past the end of the enclosing ACPI table.  While this cannot
> protect us from malicious callback functions, it can prevent us from
> failing because of some poorly constructed ACPI tables.
>
> Found by inspection.  There is no functional change to existing code
> that is known to work when calling acpi_parse_entries_array().
>
> Signed-off-by: Al Stone <ahs3@redhat.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> ---
>  drivers/acpi/tables.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 21535762b890..c7b028f231a6 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -271,8 +271,7 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>         entry = (struct acpi_subtable_header *)
>             ((unsigned long)table_header + table_size);
>
> -       while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
> -              table_end) {
> +       while (((unsigned long)entry + entry->length) <= table_end) {

The inner parens are not needed.

>                 if (max_entries && count >= max_entries)
>                         break;
>
> --
