Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752158AbeDDUkG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 16:40:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:2673 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751754AbeDDUkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 16:40:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,408,1517904000";
   d="scan'208";a="39434344"
Date: Thu, 5 Apr 2018 04:39:52 +0800
From: kbuild test robot <lkp@intel.com>
To: Al Stone <ahs3@redhat.com>
Cc: kbuild-all@01.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Stone <ahs3@redhat.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/3] mailbox: ACPI: erroneous error message when parsing
 the ACPI PCCT
Message-ID: <201804050450.ecZCFiQT%fengguang.wu@intel.com>
References: <20180404004211.6141-4-ahs3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404004211.6141-4-ahs3@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pm/linux-next]
[also build test WARNING on v4.16 next-20180404]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Al-Stone/ACPI-improve-function-documentation-for-acpi_parse_entries_array/20180404-151910
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next

smatch warnings:
drivers/mailbox/pcc.c:392 count_pcc_subspaces() warn: always true condition '(pcct_ss->header.type >= 0) => (0-255 >= 0)'

vim +392 drivers/mailbox/pcc.c

   374	
   375	/*+
   376	 *
   377	 * count_pcc_subspaces -- Count the PCC subspaces that are not used in
   378	 *		reduced hardware systems.
   379	 * @header: Pointer to the ACPI subtable header under the PCCT.
   380	 * @end: End of subtable entry.
   381	 *
   382	 * Return: 0 for Success, else errno.
   383	 *
   384	 * This gets called for each entry in the PCC table.
   385	 */
   386	static int count_pcc_subspaces(struct acpi_subtable_header *header,
   387			const unsigned long end)
   388	{
   389		struct acpi_pcct_subspace *pcct_ss =
   390					(struct acpi_pcct_subspace *) header;
   391	
 > 392		if ((pcct_ss->header.type >= ACPI_PCCT_TYPE_GENERIC_SUBSPACE) &&
   393		    (pcct_ss->header.type <= ACPI_PCCT_TYPE_RESERVED) &&
   394		    (pcct_ss->header.type != ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE) &&
   395		    (pcct_ss->header.type !=
   396					ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2)) {
   397			pr_warn("PCCT count: useful subtype = %d\n",
   398				pcct_ss->header.type);
   399			return 0;
   400		}
   401		pr_warn("PCCT count: unwanted subtype = %d\n", pcct_ss->header.type);
   402		return -EINVAL;
   403	}
   404	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
