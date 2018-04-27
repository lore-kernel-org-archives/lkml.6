Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758984AbeD0Rgg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 13:36:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1758943AbeD0Rge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 13:36:34 -0400
Date: Fri, 27 Apr 2018 19:36:19 +0200
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
To: Zi Yan <zi.yan@sent.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <zi.yan@cs.rutgers.edu>, Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Steve Capper <steve.capper@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        Michal Hocko <mhocko@suse.com>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, Balbir Singh <bsingharora@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Janosch Frank <frankja@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org,
        "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [RFC PATCH 0/9] Enable THP migration for all possible
 architectures
In-Reply-To: <20180426142804.180152-1-zi.yan@sent.com>
References: <20180426142804.180152-1-zi.yan@sent.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18042717-0020-0000-0000-00000416CD49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042717-0021-0000-0000-000042ABDB51
Message-Id: <20180427193619.435eb53a@thinkpad>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-27_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804270167
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2018 10:27:55 -0400
Zi Yan <zi.yan@sent.com> wrote:

> From: Zi Yan <zi.yan@cs.rutgers.edu>
> 
> Hi all,
> 
> THP migration is only enabled on x86_64 with a special
> ARCH_ENABLE_THP_MIGRATION macro. This patchset enables THP migration for
> all architectures that uses transparent hugepage, so that special macro can
> be dropped. Instead, THP migration is enabled/disabled via
> /sys/kernel/mm/transparent_hugepage/enable_thp_migration.
> 
> I grepped for TRANSPARENT_HUGEPAGE in arch folder and got 9 architectures that
> are supporting transparent hugepage. I mechanically add __pmd_to_swp_entry() and
> __swp_entry_to_pmd() based on existing __pte_to_swp_entry() and
> __swp_entry_to_pte() for all these architectures, except tile which is going to
> be dropped.

This will not work on s390, the pmd layout is very different from the pte
layout. Using __swp_entry/type/offset() on a pmd will go horribly wrong.
I currently don't see a chance to make this work for us, so please make/keep
this configurable, and do not configure it for s390.

Regards,
Gerald
