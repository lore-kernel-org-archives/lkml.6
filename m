Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752911AbeB1QAC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:00:02 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:38360 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932164AbeB1P7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:59:55 -0500
X-Google-Smtp-Source: AG47ELvdaFJdKas3zP80jK5DNuAfZJwguPdzqM6ZtTXqae/0NRYRp5VuyfdiLP5a0a3sO0rcycQz5CrNYB660hBGxW0=
MIME-Version: 1.0
In-Reply-To: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Feb 2018 17:59:54 +0200
Message-ID: <CAHp75Vet0gt0RW4eu+TCE8qBSk2ymMKkG5=SuM9ytzO3-6Y+Mg@mail.gmail.com>
Subject: Re: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and ioq0
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 5:48 PM, Jianchao Wang
<jianchao.w.wang@oracle.com> wrote:
> Currently, adminq and ioq0 share the same irq vector. This is
> unfair for both amdinq and ioq0.
>  - For adminq, its completion irq has to be bound on cpu0. It
>    just has only one hw queue, it is unreasonable to do this.
>  - For ioq0, when the irq fires for io completion, the adminq irq
>    action on this irq vector will introduce an uncached access on
>    adminq cqe at least, even worse when adminq is busy.
>
> To improve this, allocate separate irq vectors for adminq and
> ioq0, and not set irq affinity for adminq one. If just one irq
> vector, setup adminq + 1 ioq and let them share it. In addition
> add new helper interface nvme_ioq_vector to get ioq vector.

> +static inline unsigned int nvme_ioq_vector(struct nvme_dev *dev,
> +               unsigned int qid)
> +{
> +       /*
> +        * If controller has only legacy or single-message MSI, there will
> +        * be only 1 irq vector. At the moment, we setup adminq + 1 ioq
> +        * and let them share irq vector.
> +        */
> +       return (dev->num_vecs == 1) ? 0 : qid;

Redundant parens.

> +}

>
>         for (i = dev->ctrl.queue_count; i <= dev->max_qid; i++) {
> -               /* vector == qid - 1, match nvme_create_queue */

>                 if (nvme_alloc_queue(dev, i, dev->q_depth,
> -                    pci_irq_get_node(to_pci_dev(dev->dev), i - 1))) {
> +                    pci_irq_get_node(to_pci_dev(dev->dev),
> +                                nvme_ioq_vector(dev, i)))) {

Perhaps better to introduce a temporary variable to make it readable?

>                         ret = -ENOMEM;
>                         break;
>                 }

> +       ret = pci_alloc_irq_vectors_affinity(pdev, 1, (nr_io_queues + 1),
> +                       PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
> +       if (ret <= 0)
>                 return -EIO;
> -       dev->max_qid = nr_io_queues;
> -
> +       dev->num_vecs = ret;
> +       dev->max_qid = (ret > 1) ? (ret - 1) : 1;

I don not see how ret can possible be < 1 here.

Thus, the logic looks like this:
if ret >= 2 => return ret - 1; // Possible variants [1..ret - 1]
if ret == 1 => return 1;

So, for ret == 1 or ret == 2 we still use 1.

Is it by design?

Can it be written like

dev->max_qid = max(ret - 1, 1);

-- 
With Best Regards,
Andy Shevchenko
