Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbeBIBvk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 20:51:40 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57900 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbeBIBvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 20:51:39 -0500
Subject: Re: [PATCH V2 0/6]nvme-pci: fixes on nvme_timeout and
 nvme_dev_disable
To: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1517822415-11710-1-git-send-email-jianchao.w.wang@oracle.com>
 <073ce416-fd26-b41a-187d-1db9210c48b0@grimberg.me>
 <20180208175606.GD5039@localhost.localdomain>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <db5fe34b-3ffb-a658-d4d6-a1c619b2d590@oracle.com>
Date: Fri, 9 Feb 2018 09:50:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180208175606.GD5039@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8799 signatures=668665
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802090019
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith and Sagi

Many thanks for your kindly response.
That's really appreciated.

On 02/09/2018 01:56 AM, Keith Busch wrote:
> On Thu, Feb 08, 2018 at 05:56:49PM +0200, Sagi Grimberg wrote:
>> Given the discussion on this set, you plan to respin again
>> for 4.16?
> 
> With the exception of maybe patch 1, this needs more consideration than
> I'd feel okay with for the 4.16 release.
> 
Currently, one of the block is the nvme_wait_freeze in nvme_reset_work.
This cause some issues when I test this patchset yesterday.
As I posted on the V1 patchset mail thread:

if we set NVME_REQ_CANCELLED and return BLK_EH_HANDLED as the RESETTING case,
nvme_reset_work will hang forever, because no one could complete the entered requests.

if we invoke nvme_reset_ctrl after modify the state machine to be able to change to RESETTING
to RECONNECTING and queue reset_work, we still cannot move things forward, because the reset_work
is being executed.

if we use nvme_wait_freeze_timeout in nvme_reset_work, unfreeze and return if expires. But the 
timeout value is tricky..


And actually, one of the possible solution to fix this cleanly is blk_set_preempt_only.
It is a lightweight way to gate the new bios out of generic_make_request.

Looking forward your advice on this.
And many thanks for your precious time on this.

Sincerely
Thanks
Jianchao
