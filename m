Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbeCIUJg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 15:09:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751192AbeCIUJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 15:09:34 -0500
Date: Fri, 9 Mar 2018 12:09:17 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net,
        arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com,
        Ulrich.Weigand@de.ibm.com
Subject: Re: [PATCH] x86, powerpc : pkey-mprotect must allow pkey-0
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1520583161-11741-1-git-send-email-linuxram@us.ibm.com>
 <20180309084332.hk6xt6obghoqokbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309084332.hk6xt6obghoqokbc@gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18030920-0040-0000-0000-0000043CFA2C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030920-0041-0000-0000-000020E01F83
Message-Id: <20180309200917.GT1060@ram.oc3035372033.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803090239
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 09:43:32AM +0100, Ingo Molnar wrote:
> 
> * Ram Pai <linuxram@us.ibm.com> wrote:
> 
> > Once an address range is associated with an allocated pkey, it cannot be
> > reverted back to key-0. There is no valid reason for the above behavior.  On
> > the contrary applications need the ability to do so.
> > 
> > The patch relaxes the restriction.
> > 
> > Tested on powerpc and x86_64.
> > 
> > cc: Dave Hansen <dave.hansen@intel.com>
> > cc: Michael Ellermen <mpe@ellerman.id.au>
> > cc: Ingo Molnar <mingo@kernel.org>
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/include/asm/pkeys.h | 19 ++++++++++++++-----
> >  arch/x86/include/asm/pkeys.h     |  5 +++--
> >  2 files changed, 17 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> > index 0409c80..3e8abe4 100644
> > --- a/arch/powerpc/include/asm/pkeys.h
> > +++ b/arch/powerpc/include/asm/pkeys.h
> > @@ -101,10 +101,18 @@ static inline u16 pte_to_pkey_bits(u64 pteflags)
> >  
> >  static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
> >  {
> > -	/* A reserved key is never considered as 'explicitly allocated' */
> > -	return ((pkey < arch_max_pkey()) &&
> > -		!__mm_pkey_is_reserved(pkey) &&
> > -		__mm_pkey_is_allocated(mm, pkey));
> > +	/* pkey 0 is allocated by default. */
> > +	if (!pkey)
> > +	       return true;
> > +
> > +	if (pkey < 0 || pkey >= arch_max_pkey())
> > +	       return false;
> > +
> > +	/* reserved keys are never allocated. */
> > +	if (__mm_pkey_is_reserved(pkey))
> > +	       return false;
> 
> Please capitalize in comments consistently, i.e.:

ok.

> 
> 	/* Reserved keys are never allocated: */
> 
> > +
> > +	return(__mm_pkey_is_allocated(mm, pkey));
> 
> 'return' is not a function.

right. will fix.

Thanks,
RP
