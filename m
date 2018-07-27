Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AFBC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7A020671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7A020671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbeG0HAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 03:00:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52541 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725988AbeG0HAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 03:00:24 -0400
X-UUID: 9ab0907108154677bef8784d0321ec26-20180727
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1757620438; Fri, 27 Jul 2018 13:39:54 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 27 Jul 2018 13:39:52 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 27 Jul 2018 13:39:52 +0800
Message-ID: <1532669992.17602.32.camel@mtksdaap41>
Subject: Re: [PATCH v23 2/4] mailbox: mediatek: Add Mediatek CMDQ driver
From:   CK Hu <ck.hu@mediatek.com>
To:     Houlong Wei <houlong.wei@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        "Sascha Hauer" <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Monica Wang <monica.wang@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>, <ginny.chen@mediatek.com>,
        <enzhu.wang@mediatek.com>
Date:   Fri, 27 Jul 2018 13:39:52 +0800
In-Reply-To: <1532482002-11164-3-git-send-email-houlong.wei@mediatek.com>
References: <1532482002-11164-1-git-send-email-houlong.wei@mediatek.com>
         <1532482002-11164-3-git-send-email-houlong.wei@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jassi:

In this patch, mediatek mailbox controller implement its own data queue
rather than using mailbox framework's queue. I've an idea that could let
mediatek mailbox controller use framework's queue but the framework
should provide abort function. You could take a look on the sample in
[1].

Let me explain why need the abort function. One client of mediatek
mailbox controller is display driver. When a cursor is moving, display
continuously update the register related to the cursor. Display hardware
has a limitation that register should be updated in the vblank period
which is a small interval. In tradition, display hardware would trigger
an interrupt when vblank start, and driver could update register in this
irq handler. But the interrupt handler has the risk that it could be
delayed by some reason so the handler may be postponed out of this
vblank interval. In order to reduce the risk, display driver use GCE
hardware to write register. If a cursor move 3 times before vblank,
display driver would send 3 messages sequentially to mailbox controller.
If the controller use framework's queue, controller just receive the
first message and the others is queued in framework. The first message
could be executed exactly in vblank interval but the other messages are
sent to controller when controller notify framework tx_done in interrupt
handler. The interrupt may be postponed by some reason this is what we
worried. So this patch has to implement its own queue to make sure that
all message execute in vblank interval.

My idea is that display driver send at most one message to mailbox
controller. When it need to send the second message before the first
message is done, it should abort the first message and then send the
second message which should include first message. So how do you think
about abort function? Or you have another suggestion?

[1]
https://github.com/ckhu-mediatek/linux.git-tags/commit/28618df0491f54956a9d5558c3af0df5be208787

Regards,
CK

On Wed, 2018-07-25 at 09:26 +0800, Houlong Wei wrote:
> This patch is first version of Mediatek Command Queue(CMDQ) driver. The
> CMDQ is used to help write registers with critical time limitation,
> such as updating display configuration during the vblank. It controls
> Global Command Engine (GCE) hardware to achieve this requirement.
> Currently, CMDQ only supports display related hardwares, but we expect
> it can be extended to other hardwares for future requirements.
> 
> Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> Signed-off-by: HS Liao <hs.liao@mediatek.com>
> Signed-off-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/mailbox/Kconfig                  |   10 +
>  drivers/mailbox/Makefile                 |    2 +
>  drivers/mailbox/mtk-cmdq-mailbox.c       |  569 ++++++++++++++++++++++++++++++
>  include/linux/mailbox/mtk-cmdq-mailbox.h |   77 ++++
>  4 files changed, 658 insertions(+)
>  create mode 100644 drivers/mailbox/mtk-cmdq-mailbox.c
>  create mode 100644 include/linux/mailbox/mtk-cmdq-mailbox.h
> 
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index e63d29a..2bbabc9 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -189,4 +189,14 @@ config STM32_IPCC
>  	  Mailbox implementation for STMicroelectonics STM32 family chips
>  	  with hardware for Inter-Processor Communication Controller (IPCC)
>  	  between processors. Say Y here if you want to have this support.
> +
> +config MTK_CMDQ_MBOX
> +	tristate "MediaTek CMDQ Mailbox Support"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	select MTK_INFRACFG
> +	help
> +	  Say yes here to add support for the MediaTek Command Queue (CMDQ)
> +	  mailbox driver. The CMDQ is used to help read/write registers with
> +	  critical time limitation, such as updating display configuration
> +	  during the vblank.
>  endif
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index 4d501be..4b00804 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -40,3 +40,5 @@ obj-$(CONFIG_QCOM_APCS_IPC)	+= qcom-apcs-ipc-mailbox.o
>  obj-$(CONFIG_TEGRA_HSP_MBOX)	+= tegra-hsp.o
>  
>  obj-$(CONFIG_STM32_IPCC) 	+= stm32-ipcc.o
> +
> +obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> new file mode 100644
> index 0000000..6f92c5e
> --- /dev/null
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -0,0 +1,569 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2018 MediaTek Inc.
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/mailbox/mtk-cmdq-mailbox.h>
> +#include <linux/of_device.h>
> +
> +#define CMDQ_OP_CODE_MASK		(0xff << CMDQ_OP_CODE_SHIFT)
> +#define CMDQ_IRQ_MASK			0xffff
> +#define CMDQ_NUM_CMD(t)			(t->cmd_buf_size / CMDQ_INST_SIZE)
> +
> +#define CMDQ_CURR_IRQ_STATUS		0x10
> +#define CMDQ_THR_SLOT_CYCLES		0x30
> +#define CMDQ_THR_BASE			0x100
> +#define CMDQ_THR_SIZE			0x80
> +#define CMDQ_THR_WARM_RESET		0x00
> +#define CMDQ_THR_ENABLE_TASK		0x04
> +#define CMDQ_THR_SUSPEND_TASK		0x08
> +#define CMDQ_THR_CURR_STATUS		0x0c
> +#define CMDQ_THR_IRQ_STATUS		0x10
> +#define CMDQ_THR_IRQ_ENABLE		0x14
> +#define CMDQ_THR_CURR_ADDR		0x20
> +#define CMDQ_THR_END_ADDR		0x24
> +#define CMDQ_THR_WAIT_TOKEN		0x30
> +#define CMDQ_THR_PRIORITY		0x40
> +
> +#define CMDQ_THR_ACTIVE_SLOT_CYCLES	0x3200
> +#define CMDQ_THR_ENABLED		0x1
> +#define CMDQ_THR_DISABLED		0x0
> +#define CMDQ_THR_SUSPEND		0x1
> +#define CMDQ_THR_RESUME			0x0
> +#define CMDQ_THR_STATUS_SUSPENDED	BIT(1)
> +#define CMDQ_THR_DO_WARM_RESET		BIT(0)
> +#define CMDQ_THR_IRQ_DONE		0x1
> +#define CMDQ_THR_IRQ_ERROR		0x12
> +#define CMDQ_THR_IRQ_EN			(CMDQ_THR_IRQ_ERROR | CMDQ_THR_IRQ_DONE)
> +#define CMDQ_THR_IS_WAITING		BIT(31)
> +
> +#define CMDQ_JUMP_BY_OFFSET		0x10000000
> +#define CMDQ_JUMP_BY_PA			0x10000001
> +
> +struct cmdq_thread {
> +	struct mbox_chan	*chan;
> +	void __iomem		*base;
> +	struct list_head	task_busy_list;
> +	u32			priority;
> +	bool			atomic_exec;
> +};
> +
> +struct cmdq_task {
> +	struct cmdq		*cmdq;
> +	struct list_head	list_entry;
> +	dma_addr_t		pa_base;
> +	struct cmdq_thread	*thread;
> +	struct cmdq_pkt		*pkt; /* the packet sent from mailbox client */
> +};
> +
> +struct cmdq {
> +	struct mbox_controller	mbox;
> +	void __iomem		*base;
> +	u32			irq;
> +	u32			thread_nr;
> +	struct cmdq_thread	*thread;
> +	struct clk		*clock;
> +	bool			suspended;
> +};
> +
> +static int cmdq_thread_suspend(struct cmdq *cmdq, struct cmdq_thread *thread)
> +{
> +	u32 status;
> +
> +	writel(CMDQ_THR_SUSPEND, thread->base + CMDQ_THR_SUSPEND_TASK);
> +
> +	/* If already disabled, treat as suspended successful. */
> +	if (!(readl(thread->base + CMDQ_THR_ENABLE_TASK) & CMDQ_THR_ENABLED))
> +		return 0;
> +
> +	if (readl_poll_timeout_atomic(thread->base + CMDQ_THR_CURR_STATUS,
> +			status, status & CMDQ_THR_STATUS_SUSPENDED, 0, 10)) {
> +		dev_err(cmdq->mbox.dev, "suspend GCE thread 0x%x failed\n",
> +			(u32)(thread->base - cmdq->base));
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +static void cmdq_thread_resume(struct cmdq_thread *thread)
> +{
> +	writel(CMDQ_THR_RESUME, thread->base + CMDQ_THR_SUSPEND_TASK);
> +}
> +
> +static void cmdq_init(struct cmdq *cmdq)
> +{
> +	WARN_ON(clk_enable(cmdq->clock) < 0);
> +	writel(CMDQ_THR_ACTIVE_SLOT_CYCLES, cmdq->base + CMDQ_THR_SLOT_CYCLES);
> +	clk_disable(cmdq->clock);
> +}
> +
> +static int cmdq_thread_reset(struct cmdq *cmdq, struct cmdq_thread *thread)
> +{
> +	u32 warm_reset;
> +
> +	writel(CMDQ_THR_DO_WARM_RESET, thread->base + CMDQ_THR_WARM_RESET);
> +	if (readl_poll_timeout_atomic(thread->base + CMDQ_THR_WARM_RESET,
> +			warm_reset, !(warm_reset & CMDQ_THR_DO_WARM_RESET),
> +			0, 10)) {
> +		dev_err(cmdq->mbox.dev, "reset GCE thread 0x%x failed\n",
> +			(u32)(thread->base - cmdq->base));
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +static void cmdq_thread_disable(struct cmdq *cmdq, struct cmdq_thread *thread)
> +{
> +	cmdq_thread_reset(cmdq, thread);
> +	writel(CMDQ_THR_DISABLED, thread->base + CMDQ_THR_ENABLE_TASK);
> +}
> +
> +/* notify GCE to re-fetch commands by setting GCE thread PC */
> +static void cmdq_thread_invalidate_fetched_data(struct cmdq_thread *thread)
> +{
> +	writel(readl(thread->base + CMDQ_THR_CURR_ADDR),
> +	       thread->base + CMDQ_THR_CURR_ADDR);
> +}
> +
> +static void cmdq_task_insert_into_thread(struct cmdq_task *task)
> +{
> +	struct device *dev = task->cmdq->mbox.dev;
> +	struct cmdq_thread *thread = task->thread;
> +	struct cmdq_task *prev_task = list_last_entry(
> +			&thread->task_busy_list, typeof(*task), list_entry);
> +	u64 *prev_task_base = prev_task->pkt->va_base;
> +
> +	/* let previous task jump to this task */
> +	dma_sync_single_for_cpu(dev, prev_task->pa_base,
> +				prev_task->pkt->cmd_buf_size, DMA_TO_DEVICE);
> +	prev_task_base[CMDQ_NUM_CMD(prev_task->pkt) - 1] =
> +		(u64)CMDQ_JUMP_BY_PA << 32 | task->pa_base;
> +	dma_sync_single_for_device(dev, prev_task->pa_base,
> +				   prev_task->pkt->cmd_buf_size, DMA_TO_DEVICE);
> +
> +	cmdq_thread_invalidate_fetched_data(thread);
> +}
> +
> +static bool cmdq_command_is_wfe(u64 cmd)
> +{
> +	u64 wfe_option = CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | CMDQ_WFE_WAIT_VALUE;
> +	u64 wfe_op = (u64)(CMDQ_CODE_WFE << CMDQ_OP_CODE_SHIFT) << 32;
> +	u64 wfe_mask = (u64)CMDQ_OP_CODE_MASK << 32 | 0xffffffff;
> +
> +	return ((cmd & wfe_mask) == (wfe_op | wfe_option));
> +}
> +
> +/* we assume tasks in the same display GCE thread are waiting the same event. */
> +static void cmdq_task_remove_wfe(struct cmdq_task *task)
> +{
> +	struct device *dev = task->cmdq->mbox.dev;
> +	u64 *base = task->pkt->va_base;
> +	int i;
> +
> +	dma_sync_single_for_cpu(dev, task->pa_base, task->pkt->cmd_buf_size,
> +				DMA_TO_DEVICE);
> +	for (i = 0; i < CMDQ_NUM_CMD(task->pkt); i++)
> +		if (cmdq_command_is_wfe(base[i]))
> +			base[i] = (u64)CMDQ_JUMP_BY_OFFSET << 32 |
> +				  CMDQ_JUMP_PASS;
> +	dma_sync_single_for_device(dev, task->pa_base, task->pkt->cmd_buf_size,
> +				   DMA_TO_DEVICE);
> +}
> +
> +static bool cmdq_thread_is_in_wfe(struct cmdq_thread *thread)
> +{
> +	return readl(thread->base + CMDQ_THR_WAIT_TOKEN) & CMDQ_THR_IS_WAITING;
> +}
> +
> +static void cmdq_thread_wait_end(struct cmdq_thread *thread,
> +				 unsigned long end_pa)
> +{
> +	struct device *dev = thread->chan->mbox->dev;
> +	unsigned long curr_pa;
> +
> +	if (readl_poll_timeout_atomic(thread->base + CMDQ_THR_CURR_ADDR,
> +			curr_pa, curr_pa == end_pa, 1, 20))
> +		dev_err(dev, "GCE thread cannot run to end.\n");
> +}
> +
> +static void cmdq_task_exec_done(struct cmdq_task *task, enum cmdq_cb_status sta)
> +{
> +	struct cmdq_task_cb *cb = &task->pkt->async_cb;
> +	struct cmdq_cb_data data;
> +
> +	WARN_ON(cb->cb == (cmdq_async_flush_cb)NULL);
> +	data.sta = sta;
> +	data.data = cb->data;
> +	cb->cb(data);
> +
> +	list_del(&task->list_entry);
> +}
> +
> +static void cmdq_task_handle_error(struct cmdq_task *task)
> +{
> +	struct cmdq_thread *thread = task->thread;
> +	struct cmdq_task *next_task;
> +
> +	dev_err(task->cmdq->mbox.dev, "task 0x%p error\n", task);
> +	WARN_ON(cmdq_thread_suspend(task->cmdq, thread) < 0);
> +	next_task = list_first_entry_or_null(&thread->task_busy_list,
> +			struct cmdq_task, list_entry);
> +	if (next_task)
> +		writel(next_task->pa_base, thread->base + CMDQ_THR_CURR_ADDR);
> +	cmdq_thread_resume(thread);
> +}
> +
> +static void cmdq_thread_irq_handler(struct cmdq *cmdq,
> +				    struct cmdq_thread *thread)
> +{
> +	struct cmdq_task *task, *tmp, *curr_task = NULL;
> +	u32 curr_pa, irq_flag, task_end_pa;
> +	bool err;
> +
> +	irq_flag = readl(thread->base + CMDQ_THR_IRQ_STATUS);
> +	writel(~irq_flag, thread->base + CMDQ_THR_IRQ_STATUS);
> +
> +	/*
> +	 * When ISR call this function, another CPU core could run
> +	 * "release task" right before we acquire the spin lock, and thus
> +	 * reset / disable this GCE thread, so we need to check the enable
> +	 * bit of this GCE thread.
> +	 */
> +	if (!(readl(thread->base + CMDQ_THR_ENABLE_TASK) & CMDQ_THR_ENABLED))
> +		return;
> +
> +	if (irq_flag & CMDQ_THR_IRQ_ERROR)
> +		err = true;
> +	else if (irq_flag & CMDQ_THR_IRQ_DONE)
> +		err = false;
> +	else
> +		return;
> +
> +	curr_pa = readl(thread->base + CMDQ_THR_CURR_ADDR);
> +
> +	list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
> +				 list_entry) {
> +		task_end_pa = task->pa_base + task->pkt->cmd_buf_size;
> +		if (curr_pa >= task->pa_base && curr_pa < task_end_pa)
> +			curr_task = task;
> +
> +		if (!curr_task || curr_pa == task_end_pa - CMDQ_INST_SIZE) {
> +			cmdq_task_exec_done(task, CMDQ_CB_NORMAL);
> +			kfree(task);
> +		} else if (err) {
> +			cmdq_task_exec_done(task, CMDQ_CB_ERROR);
> +			cmdq_task_handle_error(curr_task);
> +			kfree(task);
> +		}
> +
> +		if (curr_task)
> +			break;
> +	}
> +
> +	if (list_empty(&thread->task_busy_list)) {
> +		cmdq_thread_disable(cmdq, thread);
> +		clk_disable(cmdq->clock);
> +	}
> +}
> +
> +static irqreturn_t cmdq_irq_handler(int irq, void *dev)
> +{
> +	struct cmdq *cmdq = dev;
> +	unsigned long irq_status, flags = 0L;
> +	int bit;
> +
> +	irq_status = readl(cmdq->base + CMDQ_CURR_IRQ_STATUS) & CMDQ_IRQ_MASK;
> +	if (!(irq_status ^ CMDQ_IRQ_MASK))
> +		return IRQ_NONE;
> +
> +	for_each_clear_bit(bit, &irq_status, fls(CMDQ_IRQ_MASK)) {
> +		struct cmdq_thread *thread = &cmdq->thread[bit];
> +
> +		spin_lock_irqsave(&thread->chan->lock, flags);
> +		cmdq_thread_irq_handler(cmdq, thread);
> +		spin_unlock_irqrestore(&thread->chan->lock, flags);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int cmdq_suspend(struct device *dev)
> +{
> +	struct cmdq *cmdq = dev_get_drvdata(dev);
> +	struct cmdq_thread *thread;
> +	int i;
> +	bool task_running = false;
> +
> +	cmdq->suspended = true;
> +
> +	for (i = 0; i < cmdq->thread_nr; i++) {
> +		thread = &cmdq->thread[i];
> +		if (!list_empty(&thread->task_busy_list)) {
> +			task_running = true;
> +			break;
> +		}
> +	}
> +
> +	if (task_running)
> +		dev_warn(dev, "exist running task(s) in suspend\n");
> +
> +	clk_unprepare(cmdq->clock);
> +
> +	return 0;
> +}
> +
> +static int cmdq_resume(struct device *dev)
> +{
> +	struct cmdq *cmdq = dev_get_drvdata(dev);
> +
> +	WARN_ON(clk_prepare(cmdq->clock) < 0);
> +	cmdq->suspended = false;
> +	return 0;
> +}
> +
> +static int cmdq_remove(struct platform_device *pdev)
> +{
> +	struct cmdq *cmdq = platform_get_drvdata(pdev);
> +
> +	mbox_controller_unregister(&cmdq->mbox);
> +	clk_unprepare(cmdq->clock);
> +
> +	if (cmdq->mbox.chans)
> +		devm_kfree(&pdev->dev, cmdq->mbox.chans);
> +
> +	if (cmdq->thread)
> +		devm_kfree(&pdev->dev, cmdq->thread);
> +
> +	devm_kfree(&pdev->dev, cmdq);
> +
> +	return 0;
> +}
> +
> +static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
> +{
> +	struct cmdq_pkt *pkt = (struct cmdq_pkt *)data;
> +	struct cmdq_thread *thread = (struct cmdq_thread *)chan->con_priv;
> +	struct cmdq *cmdq = dev_get_drvdata(chan->mbox->dev);
> +	struct cmdq_task *task;
> +	unsigned long curr_pa, end_pa;
> +
> +	/* Client should not flush new tasks if suspended. */
> +	WARN_ON(cmdq->suspended);
> +
> +	task = kzalloc(sizeof(*task), GFP_ATOMIC);
> +	task->cmdq = cmdq;
> +	INIT_LIST_HEAD(&task->list_entry);
> +	task->pa_base = pkt->pa_base;
> +	task->thread = thread;
> +	task->pkt = pkt;
> +
> +	if (list_empty(&thread->task_busy_list)) {
> +		WARN_ON(clk_enable(cmdq->clock) < 0);
> +		WARN_ON(cmdq_thread_reset(cmdq, thread) < 0);
> +
> +		writel(task->pa_base, thread->base + CMDQ_THR_CURR_ADDR);
> +		writel(task->pa_base + pkt->cmd_buf_size,
> +		       thread->base + CMDQ_THR_END_ADDR);
> +		writel(thread->priority, thread->base + CMDQ_THR_PRIORITY);
> +		writel(CMDQ_THR_IRQ_EN, thread->base + CMDQ_THR_IRQ_ENABLE);
> +		writel(CMDQ_THR_ENABLED, thread->base + CMDQ_THR_ENABLE_TASK);
> +	} else {
> +		WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
> +		curr_pa = readl(thread->base + CMDQ_THR_CURR_ADDR);
> +		end_pa = readl(thread->base + CMDQ_THR_END_ADDR);
> +
> +		/*
> +		 * Atomic execution should remove the following wfe, i.e. only
> +		 * wait event at first task, and prevent to pause when running.
> +		 */
> +		if (thread->atomic_exec) {
> +			/* GCE is executing if command is not WFE */
> +			if (!cmdq_thread_is_in_wfe(thread)) {
> +				cmdq_thread_resume(thread);
> +				cmdq_thread_wait_end(thread, end_pa);
> +				WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
> +				/* set to this task directly */
> +				writel(task->pa_base,
> +				       thread->base + CMDQ_THR_CURR_ADDR);
> +			} else {
> +				cmdq_task_insert_into_thread(task);
> +				cmdq_task_remove_wfe(task);
> +				smp_mb(); /* modify jump before enable thread */
> +			}
> +		} else {
> +			/* check boundary */
> +			if (curr_pa == end_pa - CMDQ_INST_SIZE ||
> +			    curr_pa == end_pa) {
> +				/* set to this task directly */
> +				writel(task->pa_base,
> +				       thread->base + CMDQ_THR_CURR_ADDR);
> +			} else {
> +				cmdq_task_insert_into_thread(task);
> +				smp_mb(); /* modify jump before enable thread */
> +			}
> +		}
> +		writel(task->pa_base + pkt->cmd_buf_size,
> +		       thread->base + CMDQ_THR_END_ADDR);
> +		cmdq_thread_resume(thread);
> +	}
> +	list_move_tail(&task->list_entry, &thread->task_busy_list);
> +
> +	return 0;
> +}
> +
> +static int cmdq_mbox_startup(struct mbox_chan *chan)
> +{
> +	return 0;
> +}
> +
> +static void cmdq_mbox_shutdown(struct mbox_chan *chan)
> +{
> +}
> +
> +static const struct mbox_chan_ops cmdq_mbox_chan_ops = {
> +	.send_data = cmdq_mbox_send_data,
> +	.startup = cmdq_mbox_startup,
> +	.shutdown = cmdq_mbox_shutdown,
> +};
> +
> +static struct mbox_chan *cmdq_xlate(struct mbox_controller *mbox,
> +		const struct of_phandle_args *sp)
> +{
> +	int ind = sp->args[0];
> +	struct cmdq_thread *thread;
> +
> +	if (ind >= mbox->num_chans)
> +		return ERR_PTR(-EINVAL);
> +
> +	thread = (struct cmdq_thread *)mbox->chans[ind].con_priv;
> +	thread->priority = sp->args[1];
> +	thread->atomic_exec = (sp->args[2] != 0);
> +	thread->chan = &mbox->chans[ind];
> +
> +	return &mbox->chans[ind];
> +}
> +
> +static int cmdq_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	struct cmdq *cmdq;
> +	int err, i;
> +
> +	cmdq = devm_kzalloc(dev, sizeof(*cmdq), GFP_KERNEL);
> +	if (!cmdq)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	cmdq->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(cmdq->base)) {
> +		dev_err(dev, "failed to ioremap gce\n");
> +		return PTR_ERR(cmdq->base);
> +	}
> +
> +	cmdq->irq = platform_get_irq(pdev, 0);
> +	if (!cmdq->irq) {
> +		dev_err(dev, "failed to get irq\n");
> +		return -EINVAL;
> +	}
> +	err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,
> +			       "mtk_cmdq", cmdq);
> +	if (err < 0) {
> +		dev_err(dev, "failed to register ISR (%d)\n", err);
> +		return err;
> +	}
> +
> +	dev_dbg(dev, "cmdq device: addr:0x%p, va:0x%p, irq:%d\n",
> +		dev, cmdq->base, cmdq->irq);
> +
> +	cmdq->clock = devm_clk_get(dev, "gce");
> +	if (IS_ERR(cmdq->clock)) {
> +		dev_err(dev, "failed to get gce clk\n");
> +		return PTR_ERR(cmdq->clock);
> +	}
> +
> +	cmdq->thread_nr = (u32)(unsigned long)of_device_get_match_data(dev);
> +	cmdq->mbox.dev = dev;
> +	cmdq->mbox.chans = devm_kcalloc(dev, cmdq->thread_nr,
> +					sizeof(*cmdq->mbox.chans), GFP_KERNEL);
> +	if (!cmdq->mbox.chans)
> +		return -ENOMEM;
> +
> +	cmdq->mbox.num_chans = cmdq->thread_nr;
> +	cmdq->mbox.ops = &cmdq_mbox_chan_ops;
> +	cmdq->mbox.of_xlate = cmdq_xlate;
> +
> +	/* make use of TXDONE_BY_ACK */
> +	cmdq->mbox.txdone_irq = false;
> +	cmdq->mbox.txdone_poll = false;
> +
> +	cmdq->thread = devm_kcalloc(dev, cmdq->thread_nr,
> +					sizeof(*cmdq->thread), GFP_KERNEL);
> +	if (!cmdq->thread)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < cmdq->thread_nr; i++) {
> +		cmdq->thread[i].base = cmdq->base + CMDQ_THR_BASE +
> +				CMDQ_THR_SIZE * i;
> +		INIT_LIST_HEAD(&cmdq->thread[i].task_busy_list);
> +		cmdq->mbox.chans[i].con_priv = (void *)&cmdq->thread[i];
> +	}
> +
> +	err = mbox_controller_register(&cmdq->mbox);
> +	if (err < 0) {
> +		dev_err(dev, "failed to register mailbox: %d\n", err);
> +		return err;
> +	}
> +
> +	platform_set_drvdata(pdev, cmdq);
> +	WARN_ON(clk_prepare(cmdq->clock) < 0);
> +
> +	cmdq_init(cmdq);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops cmdq_pm_ops = {
> +	.suspend = cmdq_suspend,
> +	.resume = cmdq_resume,
> +};
> +
> +static const struct of_device_id cmdq_of_ids[] = {
> +	{.compatible = "mediatek,mt8173-gce", .data = (void *)16},
> +	{}
> +};
> +
> +static struct platform_driver cmdq_drv = {
> +	.probe = cmdq_probe,
> +	.remove = cmdq_remove,
> +	.driver = {
> +		.name = "mtk_cmdq",
> +		.pm = &cmdq_pm_ops,
> +		.of_match_table = cmdq_of_ids,
> +	}
> +};
> +
> +static int __init cmdq_drv_init(void)
> +{
> +	return platform_driver_register(&cmdq_drv);
> +}
> +
> +static void __exit cmdq_drv_exit(void)
> +{
> +	platform_driver_unregister(&cmdq_drv);
> +}
> +
> +subsys_initcall(cmdq_drv_init);
> +module_exit(cmdq_drv_exit);
> diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
> new file mode 100644
> index 0000000..ccb7342
> --- /dev/null
> +++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + *
> + */
> +
> +#ifndef __MTK_CMDQ_MAILBOX_H__
> +#define __MTK_CMDQ_MAILBOX_H__
> +
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#define CMDQ_INST_SIZE			8 /* instruction is 64-bit */
> +#define CMDQ_SUBSYS_SHIFT		16
> +#define CMDQ_OP_CODE_SHIFT		24
> +#define CMDQ_JUMP_PASS			CMDQ_INST_SIZE
> +
> +#define CMDQ_WFE_UPDATE			BIT(31)
> +#define CMDQ_WFE_WAIT			BIT(15)
> +#define CMDQ_WFE_WAIT_VALUE		0x1
> +
> +/*
> + * CMDQ_CODE_MASK:
> + *   set write mask
> + *   format: op mask
> + * CMDQ_CODE_WRITE:
> + *   write value into target register
> + *   format: op subsys address value
> + * CMDQ_CODE_JUMP:
> + *   jump by offset
> + *   format: op offset
> + * CMDQ_CODE_WFE:
> + *   wait for event and clear
> + *   it is just clear if no wait
> + *   format: [wait]  op event update:1 to_wait:1 wait:1
> + *           [clear] op event update:1 to_wait:0 wait:0
> + * CMDQ_CODE_EOC:
> + *   end of command
> + *   format: op irq_flag
> + */
> +enum cmdq_code {
> +	CMDQ_CODE_MASK = 0x02,
> +	CMDQ_CODE_WRITE = 0x04,
> +	CMDQ_CODE_JUMP = 0x10,
> +	CMDQ_CODE_WFE = 0x20,
> +	CMDQ_CODE_EOC = 0x40,
> +};
> +
> +enum cmdq_cb_status {
> +	CMDQ_CB_NORMAL = 0,
> +	CMDQ_CB_ERROR
> +};
> +
> +struct cmdq_cb_data {
> +	enum cmdq_cb_status	sta;
> +	void			*data;
> +};
> +
> +typedef void (*cmdq_async_flush_cb)(struct cmdq_cb_data data);
> +
> +struct cmdq_task_cb {
> +	cmdq_async_flush_cb	cb;
> +	void			*data;
> +};
> +
> +struct cmdq_pkt {
> +	void			*va_base;
> +	dma_addr_t		pa_base;
> +	size_t			cmd_buf_size; /* command occupied size */
> +	size_t			buf_size; /* real buffer size */
> +	struct cmdq_task_cb	cb;
> +	struct cmdq_task_cb	async_cb;
> +	void			*cl;
> +};
> +
> +#endif /* __MTK_CMDQ_MAILBOX_H__ */


