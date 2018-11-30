Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E6FC04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E525F20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SSdCsuiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E525F20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeK3NCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 08:02:33 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44352 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeK3NCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 08:02:33 -0500
Received: by mail-qk1-f193.google.com with SMTP id n12so2312206qkh.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 17:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xW9rmFiKf3WY/YyCuyTfToXUagNK8rDkMueS0ALg+1Q=;
        b=SSdCsuiwg7Ui8uCNQUqifgVnyytUa3W4JdghR5l0M1/SLPlcGY+Ipl/VIMJD8jCRJN
         6qAWBrjQRdcRuzgKR2R48fo1pkraVEG36RAzvlmi3A+wJNSXWkLfTHFso69+ZbpD6aOE
         vSfk+5kQGEN4hBT42XA+onouppIanURs/Pw5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xW9rmFiKf3WY/YyCuyTfToXUagNK8rDkMueS0ALg+1Q=;
        b=Iyk6ftI19BSYD9cKeaNihtjklorydwo4kpKh14hDI7TefnxkCvkQPAf2/VtJNxJSNd
         bdu8Y94UgtfHw8s1C7SO2JtO1ZifzGPQyZI8x44xuttwuweBH1Ds5v6esR+AGMcSLWs3
         ErTRJOa5G+EmvGrNAXIpRtIOqmZfZmprXWyCs8mj+RotU2Ge0/qM3nsR75CXRZb6v7Cn
         DxM5pZW1WYwp7fL7iORYgntW5DsEXCU8g6ws+nM/NvubOs+StK4UmZRT+4z9wjshfsU7
         cWlVyBZf0yutqSqgQ7NznDep+ic13Dp4RKel4vb2Cs3i+5dwMh5WrAHjVTUVdMoNhv3H
         +56Q==
X-Gm-Message-State: AA+aEWZsvHn21yEAs8GXVX6kOwoIy83MyeBLgPHQFkeIAH7AuWXXzWa1
        xAZQYaLJ8PrZLeHAKMjrjLiM7rZTdavJUL2wGAtgSQ==
X-Google-Smtp-Source: AFSGD/VeFKQUmo9Yw5tVzRQwTTioksUufrFvMfCrh6ITYZlyyEfC0s77mihAfVVpFT+rmzED14tazg7MudGzbAHYdZA=
X-Received: by 2002:a37:3388:: with SMTP id z130mr3447838qkz.51.1543542897172;
 Thu, 29 Nov 2018 17:54:57 -0800 (PST)
MIME-Version: 1.0
References: <1543535954-28073-1-git-send-email-jalee@purestorage.com> <cc7cbad6-0e7d-8328-c602-61d659c3a7de@grimberg.me>
In-Reply-To: <cc7cbad6-0e7d-8328-c602-61d659c3a7de@grimberg.me>
From:   Jaesoo Lee <jalee@purestorage.com>
Date:   Thu, 29 Nov 2018 17:54:45 -0800
Message-ID: <CAJX3CtiBs6YOjkP5xGb5yPShvOdmhuD7kx-kBAVL7+YsyEGMyw@mail.gmail.com>
Subject: Re: [PATCH] nvme-rdma: complete requests from ->timeout
To:     sagi@grimberg.me
Cc:     keith.busch@intel.com, axboe@fb.com, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prabhath Sajeepa <psajeepa@purestorage.com>,
        Roland Dreier <roland@purestorage.com>,
        Ashish Karkare <ashishk@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not the queue, but the RDMA connections.

Let me describe the scenario.

1. connected nvme-rdma target with 500 namespaces
: this will make the nvme_remove_namespaces() took a long time to
complete and open the window vulnerable to this bug
2. host will take below code path for nvme_delete_ctrl_work and send
normal shutdown in nvme_shutdown_ctrl()
- nvme_stop_ctrl
  - nvme_stop_keep_alive --> stopped keep alive
- nvme_remove_namespaces --> took too long time, over 10~15s
- nvme_rdma_shutdown_ctrl
  - nvme_rdma_teardown_io_queues
  - nvme_shutdown_ctrl
    - nvmf_reg_write32
      -__nvme_submit_sync_cmd --> nvme_delete_ctrl_work blocked here
  - nvme_rdma_teardown_admin_queue
- nvme_uninit_ctrl
- nvme_put_ctrl
3. the rdma connection is disconnected by the nvme-rdma target
: in our case, this is triggered by the target side timeout mechanism
: I did not try, but I think this could happen if we lost the RoCE link, too.
4. the shutdown notification command timed out and the work stuck
while leaving the controller in NVME_CTRL_DELETING state

Thanks,

Jaesoo Lee.


On Thu, Nov 29, 2018 at 5:30 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > This does not hold at least for NVMe RDMA host driver. An example scenario
> > is when the RDMA connection is gone while the controller is being deleted.
> > In this case, the nvmf_reg_write32() for sending shutdown admin command by
> > the delete_work could be hung forever if the command is not completed by
> > the timeout handler.
>
> If the queue is gone, this means that the queue has already flushed and
> any commands that were inflight has completed with a flush error
> completion...
>
> Can you describe the scenario that caused this hang? When has the
> queue became "gone" and when did the shutdown command execute?
