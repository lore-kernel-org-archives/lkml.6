Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbeDDVM2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 17:12:28 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38597 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbeDDVMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 17:12:25 -0400
X-Google-Smtp-Source: AIpwx4/fVnyN5UQ/XV7YD2C9Z4iWF5bXRrdF3g33Ie6OBLolg5lMGMt/IUcqwcGDpQxYeVaATfLJLw==
Reply-To: ahs3@redhat.com
Subject: Re: [PATCH 3/3] mailbox: ACPI: erroneous error message when parsing
 the ACPI PCCT
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
References: <20180404004211.6141-4-ahs3@redhat.com>
 <201804050450.ecZCFiQT%fengguang.wu@intel.com>
From: Al Stone <ahs3@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <24e06eb5-d23a-5619-b4ed-bc012b9bfbf8@redhat.com>
Date: Wed, 4 Apr 2018 15:12:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <201804050450.ecZCFiQT%fengguang.wu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2018 02:39 PM, kbuild test robot wrote:
> Hi Al,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on pm/linux-next]
> [also build test WARNING on v4.16 next-20180404]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Al-Stone/ACPI-improve-function-documentation-for-acpi_parse_entries_array/20180404-151910
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> 
> smatch warnings:
> drivers/mailbox/pcc.c:392 count_pcc_subspaces() warn: always true condition '(pcct_ss->header.type >= 0) => (0-255 >= 0)'
> 
> vim +392 drivers/mailbox/pcc.c
> 
>    374	
>    375	/*+
>    376	 *
>    377	 * count_pcc_subspaces -- Count the PCC subspaces that are not used in
>    378	 *		reduced hardware systems.
>    379	 * @header: Pointer to the ACPI subtable header under the PCCT.
>    380	 * @end: End of subtable entry.
>    381	 *
>    382	 * Return: 0 for Success, else errno.
>    383	 *
>    384	 * This gets called for each entry in the PCC table.
>    385	 */
>    386	static int count_pcc_subspaces(struct acpi_subtable_header *header,
>    387			const unsigned long end)
>    388	{
>    389		struct acpi_pcct_subspace *pcct_ss =
>    390					(struct acpi_pcct_subspace *) header;
>    391	
>  > 392		if ((pcct_ss->header.type >= ACPI_PCCT_TYPE_GENERIC_SUBSPACE) &&
>    393		    (pcct_ss->header.type <= ACPI_PCCT_TYPE_RESERVED) &&
>    394		    (pcct_ss->header.type != ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE) &&
>    395		    (pcct_ss->header.type !=
>    396					ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2)) {

Aha.  Yup, can be rewritten as:

	if ((pcct_ss->header.type <= ACPI_PCCT_TYPE_RESERVED) &&
	    (pcct_ss->header.type != ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE) &&
	    (pcct_ss->header.type !=
				ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2)) {

I will let this patch sit for a little while to see if there are any further
comments before sending out a v2.

>    397			pr_warn("PCCT count: useful subtype = %d\n",
>    398				pcct_ss->header.type);
>    399			return 0;
>    400		}
>    401		pr_warn("PCCT count: unwanted subtype = %d\n", pcct_ss->header.type);
>    402		return -EINVAL;
>    403	}
>    404	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
