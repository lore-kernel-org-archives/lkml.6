Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754727AbeCGSbf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:31:35 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49176 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754039AbeCGSbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:31:34 -0500
Subject: Re: [PATCH v1] xen: acpi: upload _PSD info for offline CPUs too
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        Juergen Gross <jgross@suse.com>
References: <20180306201209.21890-1-joao.m.martins@oracle.com>
 <a62621c6-ca44-fae4-7661-b7fe5380bbc0@oracle.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <c57f56a9-4914-bef1-1379-cc0b8f038146@oracle.com>
Date: Wed, 7 Mar 2018 18:26:24 +0000
MIME-Version: 1.0
In-Reply-To: <a62621c6-ca44-fae4-7661-b7fe5380bbc0@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8825 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803070210
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2018 05:51 PM, Boris Ostrovsky wrote:
> On 03/06/2018 03:12 PM, Joao Martins wrote:
>> All uploaded PM data from offline CPUs takes the info from vCPU 0 and
> 
> "offline" may not be the right term here. Maybe "non-dom0"?
> 
Yeah, probably clearer to use that.

>> changing only the acpi_id. For processors which P-state coordination type
>> is HW_ALL (0xFD) it is OK to upload bogus P-state dependency information
>> (_PSD), because Xen will ignore cpufreq domains existence.
>>
>> Albeit for hardware exposing Px coordination types as SW_ANY or SW_ALL,
>> this will have some unintended side effects. Effectively, it will look at
>> the P-state domain existence and *if it already exists* it will skip the
>> acpi-cpufreq initialization and thus inherit the policy from the first CPU
>> in the cpufreq domain. This will finally lead to the original cpu not
>> changing target freq to P0 other than the first in the domain. Which will
>> make turbo boost not getting enabled (e.g. for 'performance' governor) for
>> all cpus.
>>
>> This patch fixes that, by also evaluating _PSD when enumerating all ACPI
>> procesors (online and offline) and always uploading the correct P-State
>> dependency up to Xen.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>> xen_processor_get_psd() is taken from acpi_processor_get_psd()
>> (drivers/acpi/processor_perflib.c) simply because only Xen Dom0 needs
>> to handle vcpus != pcpus. If preferred I could try exporting that API
>> instead and use it here.
> 
> I think this would be a preferable approach.
> 
OK, I'll respin with exporting this from drivers/acpi. FWIW I copied solely for
backportability purposes provided that hardware with SW_ANY or SW_ALL and
current stable kernels is a little broken.

	Joao
