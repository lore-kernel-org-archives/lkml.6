Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeBZErW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 23:47:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751947AbeBZErU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 23:47:20 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, mpe@ellerman.id.au,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle/powernv : Restore different PSSCR for idle and hotplug
In-Reply-To: <1519053500-31860-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1519053500-31860-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Date: Mon, 26 Feb 2018 15:47:12 +1100
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18022604-0008-0000-0000-000002DB4C1A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008598; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995190; UDB=6.00505831; IPR=6.00774523;
 MB=3.00019739; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 04:47:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022604-0009-0000-0000-00003862FE37
Message-Id: <87vaekmk6n.fsf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260063
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> writes:
> commit 1e1601b38e6e ("powerpc/powernv/idle: Restore SPRs for deep idle
> states via stop API.") uses stop-api provided by the firmware to restore
> PSSCR. PSSCR restore is required for handling special wakeup. When special
> wakeup is completed, the core enters stop state based on restored PSSCR.
>
> Currently PSSCR is restored to deepest available stop state, causing
> a idle cpu to enter deeper stop state on a special wakeup, which causes
> the cpu to hang on wakeup.
>
> A "sensors" command which reads temperature (through DTS sensors) on idle
> cpu can trigger special wakeup.
>
> Failed Scenario :
> Request restore of PSSCR with RL = 11
> cpu enters idle state (stop5)
>   user triggers "sensors" command
>    Assert special wakeup on cpu
>      Restores PSSCR with RL = 11  <---- Done by firmware
>       Read DTS sensor
>    Deassert special wakeup
>   cpu enters idle state (stop11) <-- Instead of stop5
>
> Cpu hang is caused because cpu ended up in a deeper state than it requested
>
> This patch fixes instability caused by special wakeup when stop11 is
> enabled. Requests restore of PSSCR to deepest stop state used by cpuidle.
> Only when offlining cpu, request restore of PSSCR to deepest stop state.
> On onlining cpu, request restore of PSSCR to deepest stop state used by
> cpuidle.
>
> Fixes : 1e1601b38e6e ("powerpc/powernv/idle: Restore SPRs for deep idle
> states via stop API.")

This should CC stable ?

We'll need this to enable stop11 in firmware and not break things, right?

-- 
Stewart Smith
OPAL Architect, IBM.
