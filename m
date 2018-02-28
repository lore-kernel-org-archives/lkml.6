Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933669AbeB1TTq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:19:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933605AbeB1TTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:19:19 -0500
Date: Thu, 1 Mar 2018 00:49:03 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        npiggin@gmail.com
Subject: Re: [PATCH] cpuidle/powernv : Restore different PSSCR for idle and
 hotplug
References: <1519053500-31860-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <87vaekmk6n.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vaekmk6n.fsf@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170306 (1.8.0)
X-TM-AS-GCONF: 00
x-cbid: 18022819-0040-0000-0000-000004391ED5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022819-0041-0000-0000-000020DC1FFC
Message-Id: <20180228191903.23jmawvfqzbcwi2r@aksadiga.ibm>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280235
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 03:47:12PM +1100, Stewart Smith wrote:
> Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> writes:
> > commit 1e1601b38e6e ("powerpc/powernv/idle: Restore SPRs for deep idle
> > states via stop API.") uses stop-api provided by the firmware to restore
> > PSSCR. PSSCR restore is required for handling special wakeup. When special
> > wakeup is completed, the core enters stop state based on restored PSSCR.
> >
> > Currently PSSCR is restored to deepest available stop state, causing
> > a idle cpu to enter deeper stop state on a special wakeup, which causes
> > the cpu to hang on wakeup.
> >
> > A "sensors" command which reads temperature (through DTS sensors) on idle
> > cpu can trigger special wakeup.
> >
> > Failed Scenario :
> > Request restore of PSSCR with RL = 11
> > cpu enters idle state (stop5)
> >   user triggers "sensors" command
> >    Assert special wakeup on cpu
> >      Restores PSSCR with RL = 11  <---- Done by firmware
> >       Read DTS sensor
> >    Deassert special wakeup
> >   cpu enters idle state (stop11) <-- Instead of stop5
> >
> > Cpu hang is caused because cpu ended up in a deeper state than it requested
> >
> > This patch fixes instability caused by special wakeup when stop11 is
> > enabled. Requests restore of PSSCR to deepest stop state used by cpuidle.
> > Only when offlining cpu, request restore of PSSCR to deepest stop state.
> > On onlining cpu, request restore of PSSCR to deepest stop state used by
> > cpuidle.
> >
> > Fixes : 1e1601b38e6e ("powerpc/powernv/idle: Restore SPRs for deep idle
> > states via stop API.")
> 
> This should CC stable ?
> 
> We'll need this to enable stop11 in firmware and not break things, right?

Yes I will resend and CC it to stable.
> 
> -- 
> Stewart Smith
> OPAL Architect, IBM.
> 
