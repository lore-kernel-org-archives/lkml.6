Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751407AbeBUDXI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 22:23:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751312AbeBUDXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 22:23:06 -0500
Date: Tue, 20 Feb 2018 21:23:01 -0600
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        "Manoj N . Kumar" <manoj@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] scsi: cxlflash: Select SCSI_SCAN_ASYNC
References: <20180219071037.27938-1-vaibhav@linux.vnet.ibm.com>
 <87sh9wrqd8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sh9wrqd8.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18022103-0008-0000-0000-000002D8A4F6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008567; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00992764; UDB=6.00504390; IPR=6.00772110;
 MB=3.00019663; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-21 03:23:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022103-0009-0000-0000-000038555FF2
Message-Id: <20180221032301.GA58304@p8tul1-build.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-20_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802210040
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 07:56:35PM +1100, Michael Ellerman wrote:
> Vaibhav Jain <vaibhav@linux.vnet.ibm.com> writes:
> 
> > The cxlflash driver uses "Asynchronous SCSI scanning" enabled by
> > CONFIG_SCSI_SCAN_ASYNC. Without this enabled the modprobe of cxlflash
> > module gets hung with following backtrace:
> >
> > Call Trace:
> >  __switch_to+0x2cc/0x470
> >  __schedule+0x288/0xab0
> >  schedule+0x40/0xc0
> >  schedule_timeout+0x254/0x4f0
> >  wait_for_common+0xdc/0x260
> >  flush_work+0x140/0x2a0
> >  work_on_cpu+0x88/0xb0
> >  pci_device_probe+0x1d0/0x220
> >  driver_probe_device+0x408/0x5b0
> >  __driver_attach+0x16c/0x1a0
> >  bus_for_each_dev+0xb8/0x110
> >  driver_attach+0x3c/0x60
> >  bus_add_driver+0x1d8/0x370
> >  driver_register+0x9c/0x180
> >  __pci_register_driver+0x74/0xa0
> >  init_cxlflash+0x158/0x1cc
> >  do_one_initcall+0x68/0x1e0
> >  do_init_module+0x90/0x254
> >  load_module+0x2f8c/0x3720
> >  SyS_finit_module+0xcc/0x140
> >  system_call+0x58/0x6c
> 
> Why does it "hang"? That's kind of bizarre, I would expect either a
> build or runtime failure if a feature the driver requires is missing.
> 

It hangs due to a bug in the driver. I briefly looked at it several
months back before getting distracted with other items. IIRC there
was an issue with the state machine.

> > diff --git a/drivers/scsi/cxlflash/Kconfig b/drivers/scsi/cxlflash/Kconfig
> > index a011c5dbf214..f054c1b0fff3 100644
> > --- a/drivers/scsi/cxlflash/Kconfig
> > +++ b/drivers/scsi/cxlflash/Kconfig
> > @@ -6,6 +6,7 @@ config CXLFLASH
> >  	tristate "Support for IBM CAPI Flash"
> >  	depends on PCI && SCSI && CXL && EEH
> >  	select IRQ_POLL
> > +	select SCSI_SCAN_ASYNC
> 
> It's user configurable, so it's rude to select it. It can also be
> disabled on the kernel command line, so this seems like a fragile
> solution.
>
I think Vaibhav's intention here was to avoid the hang while the bug
is still present - I believe he has encountered it several times recently.

The proper solution would be to fix the bug.
