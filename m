Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965680AbeBMUCs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 15:02:48 -0500
Received: from mga09.intel.com ([134.134.136.24]:33089 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965574AbeBMUCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 15:02:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="31143708"
Message-ID: <1518552164.22495.326.camel@linux.intel.com>
Subject: Re: [tip:x86/urgent 14/14]
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1690:22: sparse: incorrect type
 in argument 1 (different base types)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Ingo Molnar <mingo@kernel.org>
Date: Tue, 13 Feb 2018 22:02:44 +0200
In-Reply-To: <201802140355.Dy4ldN8E%fengguang.wu@intel.com>
References: <201802140355.Dy4ldN8E%fengguang.wu@intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-14 at 03:41 +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> x86/urgent
> head:   0fc8483b698620ea3d8cc6635b54eccc613c23a3
> commit: 0fc8483b698620ea3d8cc6635b54eccc613c23a3 [14/14] x86/io:
> Define readq()/writeq() to use 64-bit type
> reproduce:
>         # apt-get install sparse
>         git checkout 0fc8483b698620ea3d8cc6635b54eccc613c23a3
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF=-D__CHECK_ENDIAN__
> 
> sparse warnings: (new ones prefixed by >>)

> > > drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1690:22: sparse:
> > > incorrect type in argument 1 (different base types) @@ expected
> > > unsigned long long val @@ got nsigned long long val @@
> 
>    drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1690:22: expected
> unsigned long long val
>    drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1690:22: got restricted
> __le64 <noident>
>    drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1691:22: sparse:
> incorrect type in argument 1 (different base types) @@ expected
> unsigned long long val @@ got nsigned long long val @@
>    drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1691:22: expected
> unsigned long long val
>    drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1691:22: got restricted
> __le64 <noident>


> > > drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1231:22: sparse:
> > > incorrect type in argument 1 (different base types) @@ expected
> > > unsigned long long val @@ got nsigned long long val @@
> 
>    drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1231:22: expected
> unsigned long long val
>    drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1231:22: got restricted
> __le64 <noident>
>    drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1232:22: sparse:
> incorrect type in argument 1 (different base types) @@ expected
> unsigned long long val @@ got nsigned long long val @@
>    drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1232:22: expected
> unsigned long long val
>    drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1232:22: got restricted
> __le64 <noident>


Shouldn't above be fixed like this:
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c

+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c

@@ -1687,9 +1687,9 @@ static int hns_roce_v1_post_mbox(struct
ins_roce_dev *hr_dev, u64 in_param,
        roce_set_field(val, ROCEE_MB6_ROCEE_MB_TOKEN_M,
                      ROCEE_MB6_ROCEE_MB_TOKEN_S, token);
 
-       __raw_writeq(cpu_to_le64(in_param), hcr + 0);
-       __raw_writeq(cpu_to_le64(out_param), hcr + 2);
-       __raw_writel(cpu_to_le32(in_modifier), hcr + 4);
+       writeq(in_param, hcr + 0);
+       writeq(out_param, hcr + 2);
+       writel(in_modifier, hcr + 4);
        /* Memory barrier */
        wmb();

(Yeah, patch rather mangled, posted to show the idea)

> > > drivers/scsi/mpt3sas/mpt3sas_base.c:2975:16: sparse: incorrect
> > > type in argument 1 (different base types) @@ expected unsigned
> > > long long val @@ got nsigned long long val @@
> 
>    drivers/scsi/mpt3sas/mpt3sas_base.c:2975:16: expected unsigned long
> long val
>    drivers/scsi/mpt3sas/mpt3sas_base.c:2975:16: got restricted __le64
> <noident>
> > > drivers/scsi/mpt3sas/mpt3sas_base.c:2975:16: sparse: incorrect
> > > type in argument 1 (different base types) @@ expected unsigned
> > > long long val @@ got nsigned long long val @@

My Gosh, it seems cpu_to_le64() there is redundant and no one tested the
code on BE architecture

The entire code there can be changed by using io-64-nonatomic helpers.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
