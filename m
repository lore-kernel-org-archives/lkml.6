Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967421AbeCAKGu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:06:50 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35054 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967178AbeCAKGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:06:43 -0500
Subject: Re: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and
 ioq0
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: keith.busch@intel.com, axboe@fb.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180228164726.GB16536@lst.de>
 <ddfc2ab4-1a51-c488-25e8-bc434edf8aba@grimberg.me>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <66e4ad3e-4019-13ec-94c0-e168cc1d95b4@oracle.com>
Date: Thu, 1 Mar 2018 18:05:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ddfc2ab4-1a51-c488-25e8-bc434edf8aba@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8818 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803010131
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi sagi

Thanks for your kindly response.

On 03/01/2018 05:28 PM, Sagi Grimberg wrote:
> 
>> Note that we originally allocates irqs this way, and Keith changed
>> it a while ago for good reasons.  So I'd really like to see good
>> reasons for moving away from this, and some heuristics to figure
>> out which way to use.  E.g. if the device supports more irqs than
>> I/O queues your scheme might always be fine.
> 
> I still don't understand what this buys us in practice. Seems redundant
> to allocate another vector without any (even marginal) difference.
> 

When the adminq is free, ioq0 irq completion path has to invoke nvme_irq twice, one for itself,
one for adminq completion irq action.
We are trying to save every cpu cycle across the nvme host path, why we waste nvme_irq cycles here.
If we have enough vectors, we could allocate another irq vector for adminq to avoid this.

Sincerely
Jianchao 
