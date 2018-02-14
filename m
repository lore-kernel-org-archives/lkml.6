Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032591AbeBNQaj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:30:39 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43738 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032397AbeBNQah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:30:37 -0500
Message-ID: <1518625818.24026.2.camel@oracle.com>
Subject: Re: [RFC PATCH] elf: enforce MAP_FIXED on overlaying elf segments
 (was: Re: ppc elf_map breakage with MAP_FIXED_NOREPLACE)
From: Khalid Aziz <khalid.aziz@oracle.com>
To: Michal Hocko <mhocko@kernel.org>, Kees Cook <keescook@chromium.org>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        mm-commits@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-Next <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 14 Feb 2018 09:30:18 -0700
In-Reply-To: <20180213100440.GM3443@dhcp22.suse.cz>
References: <6db9b33d-fd46-c529-b357-3397926f0733@linux.vnet.ibm.com>
         <20180129132235.GE21609@dhcp22.suse.cz>
         <87k1w081e7.fsf@concordia.ellerman.id.au>
         <20180130094205.GS21609@dhcp22.suse.cz>
         <5eccdc1b-6a10-b48a-c63f-295f69473d97@linux.vnet.ibm.com>
         <20180131131937.GA6740@dhcp22.suse.cz>
         <bfecda5e-ae8b-df91-0add-df6322b42a70@linux.vnet.ibm.com>
         <20180201131007.GJ21609@dhcp22.suse.cz>
         <20180201134026.GK21609@dhcp22.suse.cz>
         <CAGXu5j+fo0Z_ax2O10A-3D3puLhnX+o5M4Lp3TBsnE=NtFCjpw@mail.gmail.com>
         <20180213100440.GM3443@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8804 signatures=668670
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802140195
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1EGUhaM000862

On Tue, 2018-02-13 at 11:04 +0100, Michal Hocko wrote:
> 
> From 97e7355a6dc31a73005fa806566a57eb5c38032b Mon Sep 17 00:00:00
> 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Tue, 13 Feb 2018 10:50:53 +0100
> Subject: [PATCH] elf: enforce MAP_FIXED on overlaying elf segments
> 
> Anshuman has reported that some ELF binaries in his environment fail
> to
> start with
>  [   23.423642] 9148 (sed): Uhuuh, elf segment at 0000000010030000
> requested but the memory is mapped already
>  [   23.423706] requested [10030000, 10040000] mapped [10030000,
> 10040000] 100073 anon
> 
> The reason is that the above binary has overlapping elf segments:
>   LOAD           0x0000000000000000 0x0000000010000000
> 0x0000000010000000
>                  0x0000000000013a8c 0x0000000000013a8c  R E    10000
>   LOAD           0x000000000001fd40 0x000000001002fd40
> 0x000000001002fd40
>                  0x00000000000002c0 0x00000000000005e8  RW     10000
>   LOAD           0x0000000000020328 0x0000000010030328
> 0x0000000010030328
>                  0x0000000000000384 0x00000000000094a0  RW     10000
> 
> That binary has two RW LOAD segments, the first crosses a page border
> into the second
> 
> 0x1002fd40 (LOAD2-vaddr) + 0x5e8 (LOAD2-memlen) == 0x10030328 (LOAD3-
> vaddr)
> 
> Handle this situation by enforcing MAP_FIXED when we establish a
> temporary brk VMA to handle overlapping segments. All other mappings
> will still use MAP_FIXED_NOREPLACE.
> 
> Fixes: fs, elf: drop MAP_FIXED usage from elf_map
> Reported-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
> 

Looks reasonable to me.

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
