Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbeCVURA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:17:00 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:36619 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbeCVUQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:16:57 -0400
X-Google-Smtp-Source: AG47ELu8J1K9sCb4TQ+Cnb6YOf51fMlF5zetqSVQjvOCCbK02Pq+USVaFOuxeRQCwpk7qRs2xcLgNA==
Date: Thu, 22 Mar 2018 14:16:49 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Casey Leedom <leedom@chelsio.com>
Cc: SWise OGC <swise@opengridcomputing.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        "'kbuild test robot'" <lkp@intel.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "timur@codeaurora.org" <timur@codeaurora.org>,
        "sulrich@codeaurora.org" <sulrich@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Steve Wise <swise@chelsio.com>, "'Doug Ledford'" <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Werner <werner@chelsio.com>
Subject: Re: [PATCH v4 4/6] infiniband: cxgb4: Eliminate duplicate barriers
 on weakly-ordered archs
Message-ID: <20180322201649.GC9469@ziepe.ca>
References: <1521514068-8856-5-git-send-email-okaya@codeaurora.org>
 <201803221430.P43GJl9U%fengguang.wu@intel.com>
 <3664b253c730dbf83f4528acaedb3a88@codeaurora.org>
 <3e9c006e4541acbce11743dbda553e84@codeaurora.org>
 <03d201d3c1eb$b71fb460$255f1d20$@opengridcomputing.com>
 <83484a3f-d3f7-d763-e4f8-e4fec3bb8cc2@codeaurora.org>
 <52cbc9d7-5a6b-5c8b-b930-058f5be62079@opengridcomputing.com>
 <BY2PR1201MB098352CB012D8AE8084882F3C8A90@BY2PR1201MB0983.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY2PR1201MB098352CB012D8AE8084882F3C8A90@BY2PR1201MB0983.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 07:44:51PM +0000, Casey Leedom wrote:
> | From: Steve Wise <swise@opengridcomputing.com>
> | Sent: Thursday, March 22, 2018 9:28 AM
> |
> | | From: Sinan Kaya <okaya@codeaurora.org>
> | | Date: Thursday, March 22, 2018 7:52 AM
> | |
> | | Isn't this a PowerPC problem? Why penalize other architectures?
> | 
> | I worry it breaks PPC.
>
> And all other architectures.  Aparraently there isn't a formal API
> description for writel_relaxed() and Co., nor __raw_writel(), etc.

We have this:

Documentation/memory-barriers.txt lines 2600-2677/3136 85%

 (*) readX_relaxed(), writeX_relaxed()

     These are similar to readX() and writeX(), but provide weaker memory
     ordering guarantees.  Specifically, they do not guarantee ordering with
     respect to normal memory accesses (e.g. DMA buffers) nor do they guarantee
     ordering with respect to LOCK or UNLOCK operations.  If the latter is
     required, an mmiowb() barrier can be used.  Note that relaxed accesses to
     the same peripheral are guaranteed to be ordered with respect to each
     other.

Which basically says they are the same as writel() except they are not
required to be contained by a spinlock, which is the expensive thing
ARM and PPC are doing with the barriers in writel()

Jason
