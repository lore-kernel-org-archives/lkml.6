Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752680AbeENVEi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:04:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53774 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752195AbeENVEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:04:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF74860A06
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pprakash@codeaurora.org
Subject: Re: [PATCH v3 3/3] mailbox: ACPI: erroneous error message when
 parsing the ACPI PCCT
To: Al Stone <ahs3@redhat.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
References: <20180501003907.4322-1-ahs3@redhat.com>
 <20180501003907.4322-4-ahs3@redhat.com>
From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Message-ID: <17197481-bd76-f2ec-9d6e-4cd0d94b9265@codeaurora.org>
Date: Mon, 14 May 2018 15:04:30 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501003907.4322-4-ahs3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/30/2018 6:39 PM, Al Stone wrote:
> There have been multiple reports of the following error message:
>
> [    0.068293] Error parsing PCC subspaces from PCCT
>
> This error message is not correct.  In multiple cases examined, the PCCT
> (Platform Communications Channel Table) concerned is actually properly
> constructed; the problem is that acpi_pcc_probe() which reads the PCCT
> is making the assumption that the only valid PCCT is one that contains
> subtables of one of two types: ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE or
> ACPI_PCCT_TYPE_HW_REDUCED_TYPE2.  The number of subtables of these
> types are counted and as long as there is at least one of the desired
> types, the acpi_pcc_probe() succeeds.  When no subtables of these types
> are found, regardless of whether or not any other subtable types are
> present, the error mentioned above is reported.
>
> In the cases reported to me personally, the PCCT contains exactly one
> subtable of type ACPI_PCCT_TYPE_GENERIC_SUBSPACE.  The function
> acpi_pcc_probe() does not count it as a valid subtable, so believes
> there to be no valid subtables, and hence outputs the error message.
>
> An example of the PCCT being reported as erroneous yet perfectly fine
> is the following:
>
>                     Signature : "PCCT"
>                  Table Length : 0000006E
>                      Revision : 05
>                      Checksum : A9
>                        Oem ID : "XXXXXX"
>                  Oem Table ID : "XXXXX   "
>                  Oem Revision : 00002280
>               Asl Compiler ID : "XXXX"
>         Asl Compiler Revision : 00000002
>
>         Flags (decoded below) : 00000001
>                      Platform : 1
>                      Reserved : 0000000000000000
>
>                 Subtable Type : 00 [Generic Communications Subspace]
>                        Length : 3E
>
>                      Reserved : 000000000000
>                  Base Address : 00000000DCE43018
>                Address Length : 0000000000001000
>
>             Doorbell Register : [Generic Address Structure]
>                      Space ID : 01 [SystemIO]
>                     Bit Width : 08
>                    Bit Offset : 00
>          Encoded Access Width : 01 [Byte Access:8]
>                       Address : 0000000000001842
>
>                 Preserve Mask : 00000000000000FD
>                    Write Mask : 0000000000000002
>               Command Latency : 00001388
>           Maximum Access Rate : 00000000
>       Minimum Turnaround Time : 0000
>
> To fix this, we count up all of the possible subtable types for the
> PCCT, and only report an error when there are none (which could mean
> either no subtables, or no valid subtables), or there are too many.
> We also change the logic so that if there is a valid subtable, we
> do try to initialize it per the PCCT subtable contents.  This is a
> change in functionality; previously, the probe would have returned
> right after the error message and would not have tried to use any
> other subtable definition.
>
> Tested on my personal laptop which showed the error previously; the
> error message no longer appears and the laptop appears to operate
> normally.
>
> Signed-off-by: Al Stone <ahs3@redhat.com>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> ---
>  drivers/mailbox/pcc.c | 96 +++++++++++++++++++++++++++++++++------------------
>  1 file changed, 63 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 3ef7f036ceea..72af37d7e95e 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -372,13 +372,37 @@ static const struct mbox_chan_ops pcc_chan_ops = {
>  	.send_data = pcc_send_data,
>  };
>  
> +/*
> + *
> + * count_pcc_subspaces -- Count PCC subspaces not used in reduced HW systems.
> + * @header: Pointer to the ACPI subtable header under the PCCT.
> + * @end: End of subtable entry.
> + *
> + * Return: If we find a PCC subspace entry that is one of the types used
> + *	in reduced hardware systems, return -EINVAL.  Otherwise, return 0.
> + *
> + * This gets called for each subtable in the PCC table.
> + */
> +static int count_pcc_subspaces(struct acpi_subtable_header *header,
> +		const unsigned long end)
> +{
> +	struct acpi_pcct_subspace *pcct_ss = (struct acpi_pcct_subspace *) header;
> +
> +	if ((pcct_ss->header.type <= ACPI_PCCT_TYPE_RESERVED) &&
> +	    (pcct_ss->header.type != ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE) &&
> +	    (pcct_ss->header.type != ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2))
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
>  /**
> - * parse_pcc_subspace - Parse the PCC table and verify PCC subspace
> - *		entries. There should be one entry per PCC client.
> + * parse_pcc_subspaces -- Count PCC subspaces used only in reduced HW systems.
>   * @header: Pointer to the ACPI subtable header under the PCCT.
>   * @end: End of subtable entry.
>   *
> - * Return: 0 for Success, else errno.
> + * Return: If we find a PCC subspace entry that is one of the types used
> + *	in reduced hardware systems, return 0.  Otherwise, return -EINVAL.
>   *
>   * This gets called for each entry in the PCC table.
>   */
> @@ -393,10 +417,8 @@ static int parse_pcc_subspace(struct acpi_subtable_header *header,
>  		if ((pcct_ss->header.type !=
>  				ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE)
>  		    && (pcct_ss->header.type !=
> -				ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2)) {
> -			pr_err("Incorrect PCC Subspace type detected\n");
> +				ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2))
>  			return -EINVAL;
> -		}
>  	}
>  
>  	return 0;
Can't we combine  parse_pcc_subspace and count_pcc_subspaces into a
single function? parse_pcc_subspace can return 0 for supported subspace
types and -EINVAL for others.

The limitation on number of subspaces(max = 256) applies to all types of PCC
subspaces (see Table 14-351 in ACPI 6.2).  The MAX_PCC_SUBSPACES check in
 parse_pcc_subspace seems invalid as pcc_mbox_ctrl.num_chans will not be
initialized yet at that moment.

Given above, I think it is probably better to update parse_pcc_subspace to
only check for a valid PCC subspace type. The check to make sure overall count
of subspace is  less than 256 is already present following the call to
acpi_table_parse_entries_array().

--
Thanks,
Prashanth
