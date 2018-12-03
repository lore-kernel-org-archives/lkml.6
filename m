Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B58C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D7E20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D7E20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeLCN5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:57:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726146AbeLCN5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:57:50 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB3DsGAA091701
        for <linux-kernel@vger.kernel.org>; Mon, 3 Dec 2018 08:56:42 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p54vy2vva-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 08:56:41 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 3 Dec 2018 13:56:41 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 3 Dec 2018 13:56:38 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB3Dubq719398776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Dec 2018 13:56:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44B1EB2066;
        Mon,  3 Dec 2018 13:56:37 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FCF6B2065;
        Mon,  3 Dec 2018 13:56:36 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.206.214])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  3 Dec 2018 13:56:36 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E178016C5DF5; Mon,  3 Dec 2018 05:56:38 -0800 (PST)
Date:   Mon, 3 Dec 2018 05:56:38 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "He, Bo" <bo.he@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "Zhang, Jun" <jun.zhang@intel.com>,
        "Xiao, Jin" <jin.xiao@intel.com>,
        "Zhang, Yanmin" <yanmin.zhang@intel.com>
Subject: Re: rcu_preempt caused oom
Reply-To: paulmck@linux.ibm.com
References: <CD6925E8781EFD4D8E11882D20FC406D52A11F61@SHSMSX104.ccr.corp.intel.com>
 <20181129130647.GG4170@linux.ibm.com>
 <20181129142712.GA16607@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A1243D@SHSMSX104.ccr.corp.intel.com>
 <20181130144317.GQ4170@linux.ibm.com>
 <20181130101631.618d955f@gandalf.local.home>
 <CD6925E8781EFD4D8E11882D20FC406D52A1263F@SHSMSX104.ccr.corp.intel.com>
 <20181130164920.GR4170@linux.ibm.com>
 <CD6925E8781EFD4D8E11882D20FC406D52A14B74@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CD6925E8781EFD4D8E11882D20FC406D52A14B74@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18120313-0072-0000-0000-000003D326C4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010165; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01126388; UDB=6.00582089; IPR=6.00906523;
 MB=3.00024426; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-03 13:56:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120313-0073-0000-0000-00004A50D774
Message-Id: <20181203135638.GG4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-03_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812030131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 07:44:03AM +0000, He, Bo wrote:
> Thanks, we have run the test for the whole weekend and not reproduce the issue,  so we confirm the CONFIG_RCU_BOOST can fix the issue.

Very good, that is encouraging.  Perhaps I should think about making
CONFIG_RCU_BOOST=y the default for CONFIG_PREEMPT in mainline, at least
for architectures for which rt_mutexes are implemented.

> We have enabled the rcupdate.rcu_cpu_stall_timeout=7 and also set panic on rcu stall and will see if we can see the panic, will keep you posed with the test results.
> echo 1 > /proc/sys/kernel/panic_on_rcu_stall

Looking forward to seeing what is going on!  Of course, to reproduce, you
will need to again build with CONFIG_RCU_BOOST=n.

							Thanx, Paul

> -----Original Message-----
> From: Paul E. McKenney <paulmck@linux.ibm.com> 
> Sent: Saturday, December 1, 2018 12:49 AM
> To: He, Bo <bo.he@intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>; linux-kernel@vger.kernel.org; josh@joshtriplett.org; mathieu.desnoyers@efficios.com; jiangshanlai@gmail.com; Zhang, Jun <jun.zhang@intel.com>; Xiao, Jin <jin.xiao@intel.com>; Zhang, Yanmin <yanmin.zhang@intel.com>
> Subject: Re: rcu_preempt caused oom
> 
> On Fri, Nov 30, 2018 at 03:18:58PM +0000, He, Bo wrote:
> > Here is the kernel cmdline:
> 
> Thank you!
> 
> > Kernel command line: androidboot.acpio_idx=0  
> > androidboot.bootloader=efiwrapper-02_03-userdebug_kernelflinger-06_03-
> > userdebug androidboot.diskbus=00.0 androidboot.verifiedbootstate=green 
> > androidboot.bootreason=power-on androidboot.serialno=R1J56L6006a7bb 
> > g_ffs.iSerialNumber=R1J56L6006a7bb no_timer_check noxsaves 
> > reboot_panic=p,w i915.hpd_sense_invert=0x7 mem=2G nokaslr nopti 
> > ftrace_dump_on_oops trace_buf_size=1024K intel_iommu=off gpt 
> > loglevel=4 androidboot.hardware=gordon_peak 
> > firmware_class.path=/vendor/firmware relative_sleep_states=1 
> > enforcing=0 androidboot.selinux=permissive cpu_init_udelay=10 
> > androidboot.android_dt_dir=/sys/bus/platform/devices/ANDR0001:00/prope
> > rties/android/ pstore.backend=ramoops memmap=0x1400000$0x50000000 
> > ramoops.mem_address=0x50000000 ramoops.mem_size=0x1400000 
> > ramoops.record_size=0x4000 ramoops.console_size=0x1000000 
> > ramoops.ftrace_size=0x10000 ramoops.dump_oops=1 vga=current
> > i915.modeset=1 drm.atomic=1 i915.nuclear_pageflip=1 
> > drm.vblankoffdelay=
> 
> And no sign of any suppression of RCU CPU stall warnings.  Hmmm...
> It does take more than 21 seconds to OOM?  Or do things happen faster than that?  If they do happen faster than that, then on approach would be to add something like this to the kernel command line:
> 
> 	rcupdate.rcu_cpu_stall_timeout=7
> 
> This would set the stall timeout to seven seconds.  Note that timeouts less than three seconds are silently interpreted as three seconds.
> 
> 							Thanx, Paul
> 
> > -----Original Message-----
> > From: Steven Rostedt <rostedt@goodmis.org>
> > Sent: Friday, November 30, 2018 11:17 PM
> > To: Paul E. McKenney <paulmck@linux.ibm.com>
> > Cc: He, Bo <bo.he@intel.com>; linux-kernel@vger.kernel.org; 
> > josh@joshtriplett.org; mathieu.desnoyers@efficios.com; 
> > jiangshanlai@gmail.com; Zhang, Jun <jun.zhang@intel.com>; Xiao, Jin 
> > <jin.xiao@intel.com>; Zhang, Yanmin <yanmin.zhang@intel.com>
> > Subject: Re: rcu_preempt caused oom
> > 
> > On Fri, 30 Nov 2018 06:43:17 -0800
> > "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
> > 
> > > Could you please send me your list of kernel boot parameters?  They 
> > > usually appear near the start of your console output.
> > 
> > Or just: cat /proc/cmdline
> > 
> > -- Steve
> > 
> 

