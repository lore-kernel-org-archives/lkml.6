Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbeEPPX1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:23:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752454AbeEPPXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:23:25 -0400
Date: Wed, 16 May 2018 08:24:53 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Ehson Hussain <ehson_husain@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RCU CPU stall Warnings with JTAG debugging
Reply-To: paulmck@linux.vnet.ibm.com
References: <BN3PR14MB0803AB92BA71034E5903C027E7920@BN3PR14MB0803.namprd14.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN3PR14MB0803AB92BA71034E5903C027E7920@BN3PR14MB0803.namprd14.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051615-0008-0000-0000-000003087495
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009035; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01033180; UDB=6.00528261; IPR=6.00812311;
 MB=3.00021147; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-16 15:23:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051615-0009-0000-0000-00003945858E
Message-Id: <20180516152453.GC3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805160154
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 01:45:45PM +0000, Ehson Hussain wrote:
> Hello Paul,
> 
> Hope you're doing great. I'm trying JTAG debugging on an aarch64 SoC (Xilinx Zynqmp zcu102 to be precise); when I halt the cores manually, or hit a breakpoint, I get a CPU stall warning on resuming after the RCU grace period expires.
> 
> If I resume quickly enough, I do not get the warning.
> 
> My question is, if all cores are stopped during debugging, how does RCU code detect/self-detect stalls on CPU? I have never observed this behavior in older kernels (3.14 and above), with arm cores e.g. armv7 based Freescale iMx6 boards.

My guess is that the jiffies clock is updated after resume to allow for
the time elapsed during the halt.  So the system resumes, the jiffies
counter gets a huge increment, and RCU complains about the massive
passage of time.

If you are doing JTAG debugging, I recommend shutting off RCU CPU stall
warnings, for example, using the rcupdate.rcu_cpu_stall_suppress kernel
boot parameter.

I suppose you could also tweak the clock code to pretend that no time
passes while halted, but that could be a very tricky task.

							Thanx, Paul
