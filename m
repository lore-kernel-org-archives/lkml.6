Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751746AbeCPN5d (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 09:57:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41344 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbeCPN5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 09:57:30 -0400
Subject: Re: [PATCH v3] xen/acpi: upload _PSD info for non Dom0 CPUs too
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        devel@acpica.org
References: <20180315142205.15839-1-joao.m.martins@oracle.com>
 <bbf536dc-3c3d-8a25-47e8-7fd52850835d@oracle.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <d14d48ab-9ba1-c70c-4d46-cd9c7c862add@oracle.com>
Date: Fri, 16 Mar 2018 13:57:13 +0000
MIME-Version: 1.0
In-Reply-To: <bbf536dc-3c3d-8a25-47e8-7fd52850835d@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8833 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803160153
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/2018 03:45 PM, Boris Ostrovsky wrote:
> On 03/15/2018 10:22 AM, Joao Martins wrote:
>> All uploaded PM data from non-dom0 CPUs takes the info from vCPU 0 and
>> changing only the acpi_id. For processors which P-state coordination type
>> is HW_ALL (0xFD) it is OK to upload bogus P-state dependency information
>> (_PSD), because Xen will ignore any cpufreq domains created for past CPUs.
>>
>> Albeit for platforms which expose coordination types as SW_ANY or SW_ALL,
>> this will have some unintended side effects. Effectively, it will look at
>> the P-state domain existence and *if it already exists* it will skip the
>> acpi-cpufreq initialization and thus inherit the policy from the first CPU
>> in the cpufreq domain. This will finally lead to the original cpu not
>> changing target freq to P0 other than the first in the domain. Which will
>> make turbo boost not getting enabled (e.g. for 'performance' governor) for
>> all cpus.
>>
>> This patch fixes that, by also evaluating _PSD when we enumerate all ACPI
>> processors and thus always uploading the correct info to Xen. We export
>> acpi_processor_get_psd() for that this purpose, but change signature
>> to not assume an existent of acpi_processor given that ACPI isn't creating
>> an acpi_processor for non-dom0 CPUs.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> 
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> 
Thanks!

I suppose what's remaining is review (or ack) from ACPI folks on the interface
changes made to acpi_processor_get_psd().

	Joao
