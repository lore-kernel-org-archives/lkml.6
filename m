Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164495AbeCBDGm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 22:06:42 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:46134 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163239AbeCBDGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 22:06:41 -0500
Subject: Re: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and
 ioq0
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <CAHp75Vet0gt0RW4eu+TCE8qBSk2ymMKkG5=SuM9ytzO3-6Y+Mg@mail.gmail.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <616adf0c-5023-0e66-cc59-504d52d76e44@oracle.com>
Date: Fri, 2 Mar 2018 11:06:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vet0gt0RW4eu+TCE8qBSk2ymMKkG5=SuM9ytzO3-6Y+Mg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803020031
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy

Thanks for your precious time for this and kindly reminding.

On 02/28/2018 11:59 PM, Andy Shevchenko wrote:
> On Wed, Feb 28, 2018 at 5:48 PM, Jianchao Wang
> <jianchao.w.wang@oracle.com> wrote:
>> Currently, adminq and ioq0 share the same irq vector. This is
>> unfair for both amdinq and ioq0.
>>  - For adminq, its completion irq has to be bound on cpu0. It
>>    just has only one hw queue, it is unreasonable to do this.
>>  - For ioq0, when the irq fires for io completion, the adminq irq
>>    action on this irq vector will introduce an uncached access on
>>    adminq cqe at least, even worse when adminq is busy.
>>
>> To improve this, allocate separate irq vectors for adminq and
>> ioq0, and not set irq affinity for adminq one. If just one irq
>> vector, setup adminq + 1 ioq and let them share it. In addition
>> add new helper interface nvme_ioq_vector to get ioq vector.
> 
>> +static inline unsigned int nvme_ioq_vector(struct nvme_dev *dev,
>> +               unsigned int qid)
>> +{
>> +       /*
>> +        * If controller has only legacy or single-message MSI, there will
>> +        * be only 1 irq vector. At the moment, we setup adminq + 1 ioq
>> +        * and let them share irq vector.
>> +        */
>> +       return (dev->num_vecs == 1) ? 0 : qid;
> 
> Redundant parens.

Yes, but parens make it more clearly

> 
>> +}
> 
>>
>>         for (i = dev->ctrl.queue_count; i <= dev->max_qid; i++) {
>> -               /* vector == qid - 1, match nvme_create_queue */
> 
>>                 if (nvme_alloc_queue(dev, i, dev->q_depth,
>> -                    pci_irq_get_node(to_pci_dev(dev->dev), i - 1))) {
>> +                    pci_irq_get_node(to_pci_dev(dev->dev),
>> +                                nvme_ioq_vector(dev, i)))) {
> 
> Perhaps better to introduce a temporary variable to make it readable?

yes, indeed.

> 
>>                         ret = -ENOMEM;
>>                         break;
>>                 }
> 
>> +       ret = pci_alloc_irq_vectors_affinity(pdev, 1, (nr_io_queues + 1),
>> +                       PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
>> +       if (ret <= 0)
>>                 return -EIO;
>> -       dev->max_qid = nr_io_queues;
>> -
>> +       dev->num_vecs = ret;
>> +       dev->max_qid = (ret > 1) ? (ret - 1) : 1;
> 
> I don not see how ret can possible be < 1 here.
> 
> Thus, the logic looks like this:
> if ret >= 2 => return ret - 1; // Possible variants [1..ret - 1]
> if ret == 1 => return 1;
> 
> So, for ret == 1 or ret == 2 we still use 1.
> 
> Is it by design?
> 
> Can it be written like
> 
> dev->max_qid = max(ret - 1, 1);
> 

Yes, it looks like more clearly.

Thanks
Jianchao
