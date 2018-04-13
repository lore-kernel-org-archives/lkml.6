Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752700AbeDMQQ5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:16:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44486 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbeDMQQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:16:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7F13D601E8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Fri, 13 Apr 2018 10:16:52 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org
Subject: Re: [PATCH v5 01/10] drivers: qcom: rpmh-rsc: add RPMH controller
 for QCOM SoCs
Message-ID: <20180413161652.GB1209@codeaurora.org>
References: <20180405161834.3850-1-ilina@codeaurora.org>
 <20180405161834.3850-2-ilina@codeaurora.org>
 <20180410234042.GC6727@builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180410234042.GC6727@builder>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10 2018 at 17:40 -0600, Bjorn Andersson wrote:
>On Thu 05 Apr 09:18 PDT 2018, Lina Iyer wrote:
>[..]
>> diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
>[..]
>> +/**
>> + * struct tcs_response: Response object for a request
>> + *
>> + * @drv:   the controller
>> + * @msg:   the request for this response
>> + * @m:     the tcs identifier
>> + * @err:   error reported in the response
>> + * @list:  element in list of pending response objects
>> + */
>> +struct tcs_response {
>> +	struct rsc_drv *drv;
>> +	const struct tcs_request *msg;
>> +	u32 m;
>
>m is assigned in one place but never used.
>
Right. Remnant from the downstream driver that uses buffers of
responses.

>> +	int err;
>> +	struct list_head list;
>> +};
>[..]
>> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>[..]
>> +static struct tcs_group *get_tcs_from_index(struct rsc_drv *drv, int m)
>> +{
>> +	struct tcs_group *tcs;
>> +	int i;
>> +
>> +	for (i = 0; i < drv->num_tcs; i++) {
>> +		tcs = &drv->tcs[i];
>> +		if (tcs->mask & BIT(m))
>> +			return tcs;
>> +	}
>> +
>> +	WARN(i == drv->num_tcs, "Incorrect TCS index %d", m);
>> +
>> +	return NULL;
>> +}
>> +
>> +static struct tcs_response *setup_response(struct rsc_drv *drv,
>> +					   const struct tcs_request *msg, int m)
>> +{
>> +	struct tcs_response *resp;
>> +	struct tcs_group *tcs;
>> +
>> +	resp = kzalloc(sizeof(*resp), GFP_ATOMIC);
>
>I still don't like the idea that you allocate a response struct for each
>request, then upon getting an ack post this on a list and schedule a
>tasklet in order to optionally deliver the return value to the waiting
>caller.
>
>Why don't you just just add the "err" and a completion to the
>tcs_request struct and if it's a sync operation you complete that in
>your irq handler?
>
>That would remove the response struct, the list of them, the tasklet and
>the dynamic memory handling - at the "cost" of making the code possible
>to follow.
>
Hmm.. Ok. Will try to simplify.

>> +	if (!resp)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	resp->drv = drv;
>> +	resp->msg = msg;
>> +	resp->err = 0;
>> +
>> +	tcs = get_tcs_from_index(drv, m);
>> +	if (!tcs)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	assert_spin_locked(&tcs->lock);
>
>I tried to boot the kernel with the rpmh-clk and rpmh-regulator drivers
>and I kept hitting this assert.
>
>Turns out that find_free_tcs() finds an empty TCS with index 'm' within
>the tcs, then passes it to setup_response() which tries to use the 'm'
>to figure out which tcs contains the TCS we're operating on.
>
>But as 'm' is in tcs-local space and get_tcs_from_index() tries to
>lookup the TCS in the global drv space we get hold of the wrong TCS.
>
You are right. I will fix it. Thanks for point out. Wonder what is in
your DT, that caused this to be triggered. Clearly it's missing my
setup.

>> +	tcs->responses[m - tcs->offset] = resp;
>> +
>> +	return resp;
>> +}
>> +
>> +static void free_response(struct tcs_response *resp)
>> +{
>> +	kfree(resp);
>> +}
>> +
>> +static struct tcs_response *get_response(struct rsc_drv *drv, u32 m)
>> +{
>> +	struct tcs_group *tcs = get_tcs_from_index(drv, m);
>> +
>> +	return tcs->responses[m - tcs->offset];
>> +}
>> +
>> +static u32 read_tcs_reg(struct rsc_drv *drv, int reg, int m, int n)
>> +{
>> +	return readl_relaxed(drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * m +
>> +			     RSC_DRV_CMD_OFFSET * n);
>> +}
>> +
>> +static void write_tcs_reg(struct rsc_drv *drv, int reg, int m, int n, u32 data)
>> +{
>> +	writel_relaxed(data, drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * m +
>> +		       RSC_DRV_CMD_OFFSET * n);
>
>Do you really want this relaxed? Isn't the ordering of these
>significant?
>
The ordering isnt. I can make it not relaxed. Only ordering requirement
is that we tigger after writing everything.

>> +}
>> +
>> +static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int m, int n,
>> +			       u32 data)
>> +{
>> +	write_tcs_reg(drv, reg, m, n, data);
>> +	for (;;) {
>> +		if (data == read_tcs_reg(drv, reg, m, n))
>> +			break;
>> +		udelay(1);
>> +	}
>> +}
>> +
>> +static bool tcs_is_free(struct rsc_drv *drv, int m)
>> +{
>> +	return !test_bit(m, drv->tcs_in_use) &&
>> +	       read_tcs_reg(drv, RSC_DRV_STATUS, m, 0);
>> +}
>> +
>> +static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
>
>According to rpmh_rsc_probe() the tcs array is indexed by "type", so you
>can replace the entire function with:
>
>	return &drv->tcs[type];
>
Hmm. Ok.

>> +{
>> +	int i;
>> +	struct tcs_group *tcs;
>> +
>> +	for (i = 0; i < TCS_TYPE_NR; i++) {
>> +		if (type == drv->tcs[i].type)
>> +			break;
>> +	}
>> +
>> +	if (i == TCS_TYPE_NR)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	tcs = &drv->tcs[i];
>> +	if (!tcs->num_tcs)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	return tcs;
>> +}
>> +
>> +static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
>> +					 const struct tcs_request *msg)
>> +{
>> +	int type;
>> +
>> +	switch (msg->state) {
>> +	case RPMH_ACTIVE_ONLY_STATE:
>> +		type = ACTIVE_TCS;
>> +		break;
>> +	default:
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	return get_tcs_of_type(drv, type);
>> +}
>> +
>> +static void send_tcs_response(struct tcs_response *resp)
>> +{
>> +	struct rsc_drv *drv;
>> +	unsigned long flags;
>> +
>> +	if (!resp)
>> +		return;
>> +
>> +	drv = resp->drv;
>> +	spin_lock_irqsave(&drv->drv_lock, flags);
>> +	INIT_LIST_HEAD(&resp->list);
>> +	list_add_tail(&resp->list, &drv->response_pending);
>> +	spin_unlock_irqrestore(&drv->drv_lock, flags);
>> +
>> +	tasklet_schedule(&drv->tasklet);
>> +}
>> +
>> +/**
>> + * tcs_irq_handler: TX Done interrupt handler
>> + */
>> +static irqreturn_t tcs_irq_handler(int irq, void *p)
>> +{
>> +	struct rsc_drv *drv = p;
>> +	int m, i;
>> +	u32 irq_status, sts;
>> +	struct tcs_response *resp;
>> +	struct tcs_cmd *cmd;
>> +
>> +	irq_status = read_tcs_reg(drv, RSC_DRV_IRQ_STATUS, 0, 0);
>> +
>> +	for (m = 0; m < drv->num_tcs; m++) {
>> +		if (!(irq_status & (u32)BIT(m)))
>> +			continue;
>> +
>> +		resp = get_response(drv, m);
>> +		if (WARN_ON(!resp))
>
>This will only ever fail in the beginning of time, as soon as you've
>utilized every TCS at least once resp will never be NULL, as you never
>clear it.
>
>> +			goto skip_resp;
>> +
>> +		resp->err = 0;
>> +		for (i = 0; i < resp->msg->num_cmds; i++) {
>> +			cmd = &resp->msg->cmds[i];
>> +			sts = read_tcs_reg(drv, RSC_DRV_CMD_STATUS, m, i);
>> +			if (!(sts & CMD_STATUS_ISSUED) ||
>> +			   ((resp->msg->wait_for_compl || cmd->wait) &&
>> +			   !(sts & CMD_STATUS_COMPL))) {
>> +				resp->err = -EIO;
>> +				break;
>> +			}
>> +		}
>> +skip_resp:
>> +		/* Reclaim the TCS */
>> +		write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, m, 0, 0);
>> +		write_tcs_reg(drv, RSC_DRV_IRQ_CLEAR, 0, 0, BIT(m));
>> +		clear_bit(m, drv->tcs_in_use);
>> +		send_tcs_response(resp);
>
>As I suggested above, rather than putting resp on a list and schedule a
>tasklet to free and possibly deliver the value or "err" to a client just
>keep track of the current msg for the TCS for sync operations, set "err"
>and fire the completion (and then untie the request from the TCS).
>
Ok.

>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +/**
>> + * tcs_notify_tx_done: TX Done for requests that got a response
>> + *
>> + * @data: the tasklet argument
>> + *
>> + * Tasklet function to notify MBOX that we are done with the request.
>> + * Handles all pending reponses whenever run.
>
>This is accidental complexity from the downstream use of the mailbox
>framework, we don't need it.
>
Yes. will remove this.

>> + */
>> +static void tcs_notify_tx_done(unsigned long data)
>> +{
>> +	struct rsc_drv *drv = (struct rsc_drv *)data;
>> +	struct tcs_response *resp;
>> +	unsigned long flags;
>> +
>> +	for (;;) {
>> +		spin_lock_irqsave(&drv->drv_lock, flags);
>> +		resp = list_first_entry_or_null(&drv->response_pending,
>> +						struct tcs_response, list);
>> +		if (!resp) {
>> +			spin_unlock_irqrestore(&drv->drv_lock, flags);
>> +			break;
>> +		}
>> +		list_del(&resp->list);
>> +		spin_unlock_irqrestore(&drv->drv_lock, flags);
>> +		free_response(resp);
>> +	}
>> +}
>> +
>> +static void __tcs_buffer_write(struct rsc_drv *drv, int m, int n,
>> +			       const struct tcs_request *msg)
>> +{
>> +	u32 msgid, cmd_msgid;
>> +	u32 cmd_enable = 0;
>> +	u32 cmd_complete;
>> +	struct tcs_cmd *cmd;
>> +	int i, j;
>> +
>> +	cmd_msgid = CMD_MSGID_LEN;
>> +	cmd_msgid |= msg->wait_for_compl ? CMD_MSGID_RESP_REQ : 0;
>> +	cmd_msgid |= CMD_MSGID_WRITE;
>> +
>> +	cmd_complete = read_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, m, 0);
>> +
>> +	for (i = 0, j = n; i < msg->num_cmds; i++, j++) {
>> +		cmd = &msg->cmds[i];
>> +		cmd_enable |= BIT(j);
>> +		cmd_complete |= cmd->wait << j;
>> +		msgid = cmd_msgid;
>> +		msgid |= cmd->wait ? CMD_MSGID_RESP_REQ : 0;
>> +		write_tcs_reg(drv, RSC_DRV_CMD_MSGID, m, j, msgid);
>> +		write_tcs_reg(drv, RSC_DRV_CMD_ADDR, m, j, cmd->addr);
>> +		write_tcs_reg(drv, RSC_DRV_CMD_DATA, m, j, cmd->data);
>> +	}
>> +
>> +	write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, m, 0, cmd_complete);
>> +	cmd_enable |= read_tcs_reg(drv, RSC_DRV_CMD_ENABLE, m, 0);
>> +	write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, m, 0, cmd_enable);
>> +}
>> +
>> +static void __tcs_trigger(struct rsc_drv *drv, int m)
>> +{
>> +	u32 enable;
>
>"enable"?
>
Sorry?
>> +
>> +	/*
>> +	 * HW req: Clear the DRV_CONTROL and enable TCS again
>> +	 * While clearing ensure that the AMC mode trigger is cleared
>> +	 * and then the mode enable is cleared.
>> +	 */
>> +	enable = read_tcs_reg(drv, RSC_DRV_CONTROL, m, 0);
>> +	enable &= ~TCS_AMC_MODE_TRIGGER;
>> +	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, m, 0, enable);
>> +	enable &= ~TCS_AMC_MODE_ENABLE;
>> +	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, m, 0, enable);
>> +
>> +	/* Enable the AMC mode on the TCS and then trigger the TCS */
>> +	enable = TCS_AMC_MODE_ENABLE;
>> +	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, m, 0, enable);
>> +	enable |= TCS_AMC_MODE_TRIGGER;
>> +	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, m, 0, enable);
>> +}
>> +
>> +static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
>> +				  const struct tcs_request *msg)
>> +{
>> +	unsigned long curr_enabled;
>> +	u32 addr;
>> +	int i, j, k;
>> +	int m = tcs->offset;
>> +
>> +	for (i = 0; i < tcs->num_tcs; i++, m++) {
>> +		if (tcs_is_free(drv, m))
>> +			continue;
>> +
>> +		curr_enabled = read_tcs_reg(drv, RSC_DRV_CMD_ENABLE, m, 0);
>> +
>> +		for_each_set_bit(j, &curr_enabled, MAX_CMDS_PER_TCS) {
>> +			addr = read_tcs_reg(drv, RSC_DRV_CMD_ADDR, m, j);
>> +			for (k = 0; k < msg->num_cmds; k++) {
>> +				if (addr == msg->cmds[k].addr)
>> +					return -EBUSY;
>> +			}
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int find_free_tcs(struct tcs_group *tcs)
>> +{
>> +	int m;
>> +
>> +	for (m = 0; m < tcs->num_tcs; m++) {
>> +		if (tcs_is_free(tcs->drv, tcs->offset + m))
>> +			return m;
>
>The returned index is within the tcs but is passed to setup_response()
>where it's used as the index of the TCS, so this needs to return
>tcs->offset + m so that setup_response() will be able to find the tcs
>again.
>
Correct. Will fix.

>> +	}
>> +
>> +	return -EBUSY;
>> +}
>> +
>> +static int tcs_mbox_write(struct rsc_drv *drv, const struct tcs_request *msg)
>> +{
>> +	struct tcs_group *tcs;
>> +	int m;
>> +	struct tcs_response *resp = NULL;
>
>No need to initialize resp.
>
Ok.

>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	tcs = get_tcs_for_msg(drv, msg);
>> +	if (IS_ERR(tcs))
>> +		return PTR_ERR(tcs);
>> +
>> +	spin_lock_irqsave(&tcs->lock, flags);
>> +	m = find_free_tcs(tcs);
>> +	if (m < 0) {
>> +		ret = m;
>> +		goto done_write;
>> +	}
>> +
>> +	/*
>> +	 * The h/w does not like if we send a request to the same address,
>> +	 * when one is already in-flight or being processed.
>> +	 */
>> +	ret = check_for_req_inflight(drv, tcs, msg);
>
>This scans all TCS in the DRV for any operations on msg->cmds[*].addr,
>but you're only holding a lock for tcs. Either cross-tcs operations
>doesn't matter and check_for_req_inflight() can loose one of the loops
>or the locking used here is too optimistic.
>
We only need to look at the AMC TCSes and see if any of them are in use.
We dont care about the request being present in sleep/wake TCS.

>> +	if (ret)
>> +		goto done_write;
>> +
>> +	resp = setup_response(drv, msg, m);
>
>Alternatively we could just actually pass "tcs" to setup_response() so
>that it doesn't have to search for it based on drv and m. But I think
>it's cleaner if we just associate the msg with the TCS and complete that
>directly in the irq handler - if it's a sync operation.
>
Got it.

>> +	if (IS_ERR(resp)) {
>> +		ret = PTR_ERR(resp);
>> +		goto done_write;
>> +	}
>> +	resp->m = m;
>
>You never read resp->m...
>
Remnant. Will remove the structure itself.

>> +
>> +	set_bit(m, drv->tcs_in_use);
>> +	__tcs_buffer_write(drv, m, 0, msg);
>> +	__tcs_trigger(drv, m);
>> +
>> +done_write:
>> +	spin_unlock_irqrestore(&tcs->lock, flags);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * rpmh_rsc_send_data: Validate the incoming message and write to the
>> + * appropriate TCS block.
>> + *
>> + * @drv: the controller
>> + * @msg: the data to be sent
>> + *
>> + * Return: 0 on success, -EINVAL on error.
>> + * Note: This call blocks until a valid data is written to the TCS.
>> + */
>> +int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
>> +{
>> +	int ret;
>> +
>> +	if (!msg || !msg->cmds || !msg->num_cmds ||
>> +	    msg->num_cmds > MAX_RPMH_PAYLOAD)
>> +		return -EINVAL;
>
>You're the only caller of this function, which means that if this ever
>evaluates to true you will return -EINVAL and your bug will be way
>harder to find than if you just end up panicing because we dereferenced
>any of these null pointers.
>
>At least wrap the whole thing in a WARN_ON() to make it possible to
>detect when this happen.
>
Ok. Will do.

>> +
>> +	do {
>> +		ret = tcs_mbox_write(drv, msg);
>> +		if (ret == -EBUSY) {
>> +			pr_info_ratelimited("TCS Busy, retrying RPMH message send: addr=%#x\n",
>> +					    msg->cmds[0].addr);
>> +			udelay(10);
>> +		}
>> +	} while (ret == -EBUSY);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(rpmh_rsc_send_data);
>

Thanks for the review.

-- Lina
