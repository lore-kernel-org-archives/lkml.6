Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbeBIBnP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 20:43:15 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52050 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbeBIBnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 20:43:13 -0500
Subject: Re: [PATCH 2/6] nvme-pci: fix the freeze and quiesce for shutdown and
 reset case
To: Keith Busch <keith.busch@intel.com>
Cc: axboe@fb.com, sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, hch@lst.de
References: <20180202182413.GH24417@localhost.localdomain>
 <d93d115b-bdb1-24c0-71be-72f1b7563e5a@oracle.com>
 <20180205151314.GP24417@localhost.localdomain>
 <d218f5f5-45f7-6036-00a5-48769101080f@oracle.com>
 <20180206151335.GE31110@localhost.localdomain>
 <e1994613-3cb6-f82b-3296-0f4afdb16314@oracle.com>
 <c5ae0bc0-260e-3a72-5c47-304c0b5034a6@oracle.com>
 <20180207161345.GB1337@localhost.localdomain>
 <1826ebc1-d419-23da-12d4-dd7b1b3fe598@oracle.com>
 <958cae59-1a01-d60f-822b-cf81cfa31b8f@oracle.com>
 <20180208151508.GA4797@localhost.localdomain>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <bdbda3ee-dec3-a2d9-df3c-391cd46973e4@oracle.com>
Date: Fri, 9 Feb 2018 09:41:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180208151508.GA4797@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8799 signatures=668665
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802090018
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith

Thanks for your precious time and kindly response.

On 02/08/2018 11:15 PM, Keith Busch wrote:
> On Thu, Feb 08, 2018 at 10:17:00PM +0800, jianchao.wang wrote:
>> There is a dangerous scenario which caused by nvme_wait_freeze in nvme_reset_work.
>> please consider it.
>>
>> nvme_reset_work
>>   -> nvme_start_queues
>>   -> nvme_wait_freeze
>>
>> if the controller no response, we have to rely on the timeout path.
>> there are issues below:
>> nvme_dev_disable need to be invoked.
>> nvme_dev_disable will quiesce queues, cancel and requeue and outstanding requests.
>> nvme_reset_work will hang at nvme_wait_freeze
> 
> We used to not requeue timed out commands, so that wasn't a problem
> before. Oh well, I'll take a look.
> 
Yes, we indeed don't requeue the timed out commands, but nvme_dev_disable will requeue the other
outstanding requests and quiesce the request queues, this will block the nvme_reset_work->nvme_wati_freeze
to move forward.

As I shared in last email, can we use(or abuse?) blk_set_preempt_only to gate the new bios on generic_make_request ?
Freezing queues is good, but wait_freeze in reset_work is a devil.

Many thanks
Jianchao
