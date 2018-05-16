Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751490AbeEPFFU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 01:05:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750775AbeEPFFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 01:05:18 -0400
Date: Wed, 16 May 2018 10:35:08 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc: Enable ASYM_SMT on interleaved big-core
 systems
Reply-To: ego@linux.vnet.ibm.com
References: <1526037444-22876-1-git-send-email-ego@linux.vnet.ibm.com>
 <1526037444-22876-3-git-send-email-ego@linux.vnet.ibm.com>
 <1526268127.30369.21.camel@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526268127.30369.21.camel@neuling.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18051605-0036-0000-0000-000002F5897E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009032; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032974; UDB=6.00528138; IPR=6.00812105;
 MB=3.00021139; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-16 05:05:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051605-0037-0000-0000-0000445A0276
Message-Id: <20180516050508.GB14826@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805160050
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 01:22:07PM +1000, Michael Neuling wrote:
> On Fri, 2018-05-11 at 16:47 +0530, Gautham R. Shenoy wrote:
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > 
> > Each of the SMT4 cores forming a fused-core are more or less
> > independent units. Thus when multiple tasks are scheduled to run on
> > the fused core, we get the best performance when the tasks are spread
> > across the pair of SMT4 cores.
> > 
> > Since the threads in the pair of SMT4 cores of an interleaved big-core
> > are numbered {0,2,4,6} and {1,3,5,7} respectively, enable ASYM_SMT on
> > such interleaved big-cores that will bias the load-balancing of tasks
> > on smaller numbered threads, which will automatically result in
> > spreading the tasks uniformly across the associated pair of SMT4
> > cores.
> > 
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/smp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> > index 9ca7148..0153f01 100644
> > --- a/arch/powerpc/kernel/smp.c
> > +++ b/arch/powerpc/kernel/smp.c
> > @@ -1082,7 +1082,7 @@ static int powerpc_smt_flags(void)
> >  {
> >  	int flags = SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
> >  
> > -	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
> > +	if (cpu_has_feature(CPU_FTR_ASYM_SMT) || has_interleaved_big_core) {
> 
> Shouldn't we just set CPU_FTR_ASYM_SMT and leave this code
unchanged?

Yes, that would have the same effect. I refrained from doing that
since I thought CPU_FTR_ASYM_SMT has the "lower numbered threads
expedite thread-folding" connotation from the POWER7 generation.

If it is ok to overload CPU_FTR_ASYM_SMT, we can do what you suggest
and have all the changes in setup-common.c

--
Thanks and Regards
gautham.
