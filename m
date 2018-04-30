Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755580AbeD3XjM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 19:39:12 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45630 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753683AbeD3XjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 19:39:08 -0400
X-Google-Smtp-Source: AB8JxZoJtHhB8mdg9KCY8pUdf53NCwCP8s6GMwjybg2uKlP9rPjslXCBjfeqUavwMAF0F65o7DHpmw==
Reply-To: ahs3@redhat.com
Subject: Re: [PATCH v2 3/3] mailbox: ACPI: erroneous error message when
 parsing the ACPI PCCT
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
References: <20180424193505.6934-1-ahs3@redhat.com>
 <20180424193505.6934-4-ahs3@redhat.com>
 <CAJZ5v0iqy6KuKFK+P-s945X6BjEkEom_xQqZc1PLNJ5_zcv9Lg@mail.gmail.com>
From: Al Stone <ahs3@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ee151f81-b32a-5315-107a-c211aa63abfb@redhat.com>
Date: Mon, 30 Apr 2018 17:39:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iqy6KuKFK+P-s945X6BjEkEom_xQqZc1PLNJ5_zcv9Lg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27/2018 05:16 AM, Rafael J. Wysocki wrote:
> On Tue, Apr 24, 2018 at 9:35 PM, Al Stone <ahs3@redhat.com> wrote:
>> There have been multiple reports of the following error message:
>>
>> [    0.068293] Error parsing PCC subspaces from PCCT
>>
> 
> [cut]
> 
>>
>> Tested on my personal laptop which showed the error previously; the
>> error message no longer appears and the laptop appears to operate
>> normally.
>>
>> Signed-off-by: Al Stone <ahs3@redhat.com>
>> Cc: Jassi Brar <jassisinghbrar@gmail.com>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Len Brown <lenb@kernel.org>
>> ---
>>  drivers/mailbox/pcc.c | 99 +++++++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 73 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>> index 3ef7f036ceea..cc77a2f1694f 100644
>> --- a/drivers/mailbox/pcc.c
>> +++ b/drivers/mailbox/pcc.c
>> @@ -372,6 +372,35 @@ static const struct mbox_chan_ops pcc_chan_ops = {
>>         .send_data = pcc_send_data,
>>  };
>>
>> +/*
>> + *
>> + * count_pcc_subspaces -- Count the PCC subspaces that are not used in
>> + *             reduced hardware systems.
> 
> One line here, please.

Ack.

>> + * @header: Pointer to the ACPI subtable header under the PCCT.
>> + * @end: End of subtable entry.
>> + *
>> + * Return: 0 for Success, else errno.
> 
> The only errno returned appears to be -EINVAL, so maybe say when that
> is returned and then "or 0 otherwise".

Okay.

>> + *
>> + * This gets called for each entry in the PCC table.
>> + */
>> +static int count_pcc_subspaces(struct acpi_subtable_header *header,
>> +               const unsigned long end)
>> +{
>> +       struct acpi_pcct_subspace *pcct_ss =
>> +                               (struct acpi_pcct_subspace *) header;
> 
> This can be one line (ignore warnings from checkpatch about that).

Okay.  That's always a bit of a judgment call with checkpatch.

>> +
>> +       if ((pcct_ss->header.type <= ACPI_PCCT_TYPE_RESERVED) &&
>> +           (pcct_ss->header.type != ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE) &&
>> +           (pcct_ss->header.type !=
>> +                               ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2)) {
> 
> This can be one line too.

Okay.

>> +               pr_warn("PCCT count: useful subtype = %d\n",
>> +                       pcct_ss->header.type);
> 
> Why pr_warn()?
> 
>> +               return 0;
>> +       }
>> +       pr_warn("PCCT count: unwanted subtype = %d\n", pcct_ss->header.type);
>> +       return -EINVAL;
>> +}
>> +

Oh, bugger.  I inadvertently left some debug noise in here.  Both of the above
pr_warn() calls should go away since they don't actually provide any value.

>>  /**
>>   * parse_pcc_subspace - Parse the PCC table and verify PCC subspace
>>   *             entries. There should be one entry per PCC client.
>> @@ -395,10 +424,14 @@ static int parse_pcc_subspace(struct acpi_subtable_header *header,
>>                     && (pcct_ss->header.type !=
>>                                 ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2)) {
>>                         pr_err("Incorrect PCC Subspace type detected\n");
>> +                       pr_warn("PCCT parse: unwanted subtype = %d\n",
>> +                               pcct_ss->header.type);
> 
> Maybe merge the two messages?

Yup, or remove the pr_warn(); that's really just extra debug info I had put in
to check results.

> 
>>                         return -EINVAL;
>>                 }
>>         }
>>
>> +       pcct_ss = (struct acpi_pcct_hw_reduced *) header;
>> +       pr_warn("PCCT parse: useful subtype = %d\n", pcct_ss->header.type);

...and same here -- the pr_warn() is extraneous, really.

>>         return 0;
>>  }
>>
>> @@ -449,8 +482,8 @@ static int __init acpi_pcc_probe(void)
>>         struct acpi_table_header *pcct_tbl;
>>         struct acpi_subtable_header *pcct_entry;
>>         struct acpi_table_pcct *acpi_pcct_tbl;
>> +       struct acpi_subtable_proc proc[ACPI_PCCT_TYPE_RESERVED];
>>         int count, i, rc;
>> -       int sum = 0;
>>         acpi_status status = AE_OK;
>>
>>         /* Search for PCCT */
>> @@ -459,43 +492,50 @@ static int __init acpi_pcc_probe(void)
>>         if (ACPI_FAILURE(status) || !pcct_tbl)
>>                 return -ENODEV;
>>
>> -       count = acpi_table_parse_entries(ACPI_SIG_PCCT,
>> -                       sizeof(struct acpi_table_pcct),
>> -                       ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE,
>> -                       parse_pcc_subspace, MAX_PCC_SUBSPACES);
>> -       sum += (count > 0) ? count : 0;
>> -
>> -       count = acpi_table_parse_entries(ACPI_SIG_PCCT,
>> -                       sizeof(struct acpi_table_pcct),
>> -                       ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2,
>> -                       parse_pcc_subspace, MAX_PCC_SUBSPACES);
>> -       sum += (count > 0) ? count : 0;
>> +       /* Set up the subtable handlers */
>> +       for (i = ACPI_PCCT_TYPE_GENERIC_SUBSPACE;
>> +            i < ACPI_PCCT_TYPE_RESERVED;
> 
> I would append the line below to this one.

Okay.

>> +            i++) {
>> +               proc[i].id = i;
>> +               if (i == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE ||
>> +                   i == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2)
>> +                       proc[i].handler = parse_pcc_subspace;
>> +               else
>> +                       proc[i].handler = count_pcc_subspaces;
>> +               proc[i].count = 0;
> 
> Why don't you move the count initialization above the if ()?

Sure.

>> +       }
>>
>> -       if (sum == 0 || sum >= MAX_PCC_SUBSPACES) {
>> -               pr_err("Error parsing PCC subspaces from PCCT\n");
>> +       count = acpi_table_parse_entries_array(ACPI_SIG_PCCT,
>> +                       sizeof(struct acpi_table_pcct), proc,
>> +                       ACPI_PCCT_TYPE_RESERVED, MAX_PCC_SUBSPACES);
>> +       if (count == 0) {
>> +               pr_warn("PCCT provided but has no subspaces defined\n");
>> +               return -EINVAL;
>> +       } else if (count > MAX_PCC_SUBSPACES) {
>> +               pr_warn("Too many PCC subspaces defined in PCCT\n");
> 
> Do we need such detailed information to be printed here?  If you said
> something like "Invalid PCCT format", you could merge the two if ()
> branches.

Yeah, let me re-do these and simplify them.

>>                 return -EINVAL;
>>         }
>>
>>         pcc_mbox_channels = kzalloc(sizeof(struct mbox_chan) *
>> -                       sum, GFP_KERNEL);
>> +                       count, GFP_KERNEL);
> 
> One line, please.

Okay.

>>         if (!pcc_mbox_channels) {
>>                 pr_err("Could not allocate space for PCC mbox channels\n");
>>                 return -ENOMEM;
>>         }
>>
>> -       pcc_doorbell_vaddr = kcalloc(sum, sizeof(void *), GFP_KERNEL);
>> +       pcc_doorbell_vaddr = kcalloc(count, sizeof(void *), GFP_KERNEL);
>>         if (!pcc_doorbell_vaddr) {
>>                 rc = -ENOMEM;
>>                 goto err_free_mbox;
>>         }
>>
>> -       pcc_doorbell_ack_vaddr = kcalloc(sum, sizeof(void *), GFP_KERNEL);
>> +       pcc_doorbell_ack_vaddr = kcalloc(count, sizeof(void *), GFP_KERNEL);
>>         if (!pcc_doorbell_ack_vaddr) {
>>                 rc = -ENOMEM;
>>                 goto err_free_db_vaddr;
>>         }
>>
>> -       pcc_doorbell_irq = kcalloc(sum, sizeof(int), GFP_KERNEL);
>> +       pcc_doorbell_irq = kcalloc(count, sizeof(int), GFP_KERNEL);
>>         if (!pcc_doorbell_irq) {
>>                 rc = -ENOMEM;
>>                 goto err_free_db_ack_vaddr;
>> @@ -509,18 +549,25 @@ static int __init acpi_pcc_probe(void)
>>         if (acpi_pcct_tbl->flags & ACPI_PCCT_DOORBELL)
>>                 pcc_mbox_ctrl.txdone_irq = true;
>>
>> -       for (i = 0; i < sum; i++) {
>> +       for (i = 0; i < count; i++) {
>>                 struct acpi_generic_address *db_reg;
>> -               struct acpi_pcct_hw_reduced *pcct_ss;
>> +               struct acpi_pcct_subspace *pcct_ss;
>>                 pcc_mbox_channels[i].con_priv = pcct_entry;
>>
>> -               pcct_ss = (struct acpi_pcct_hw_reduced *) pcct_entry;
>> +               if (pcct_entry->type == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE ||
>> +                   pcct_entry->type ==
>> +                               ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
> 
> Again, please merge the two lines above.

Okay.

>> +                       struct acpi_pcct_hw_reduced *pcct_hrss;
>> +
>> +                       pcct_hrss = (struct acpi_pcct_hw_reduced *) pcct_entry;
>>
>> -               if (pcc_mbox_ctrl.txdone_irq) {
>> -                       rc = pcc_parse_subspace_irq(i, pcct_ss);
>> -                       if (rc < 0)
>> -                               goto err;
>> +                       if (pcc_mbox_ctrl.txdone_irq) {
>> +                               rc = pcc_parse_subspace_irq(i, pcct_hrss);
>> +                               if (rc < 0)
>> +                                       goto err;
>> +                       }
>>                 }
>> +               pcct_ss = (struct acpi_pcct_subspace *) pcct_entry;
>>
>>                 /* If doorbell is in system memory cache the virt address */
>>                 db_reg = &pcct_ss->doorbell_register;
>> @@ -531,7 +578,7 @@ static int __init acpi_pcc_probe(void)
>>                         ((unsigned long) pcct_entry + pcct_entry->length);
>>         }
>>
>> -       pcc_mbox_ctrl.num_chans = sum;
>> +       pcc_mbox_ctrl.num_chans = count;
>>
>>         pr_info("Detected %d PCC Subspaces\n", pcc_mbox_ctrl.num_chans);
>>
>> --

Thanks for the review, Rafael.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
