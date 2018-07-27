Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86303C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6F020842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CKpRY8I/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6F020842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389900AbeG0WhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:37:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35300 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389459AbeG0WhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:37:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id p10-v6so5543437ljg.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 14:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Kc9PAgGFdBs0v3kyJi1hDStw8858pvX+kI4wA6UOxpg=;
        b=CKpRY8I/wmiJ1BvkpTuSuo/IqGM10keEy1X5IUzIIYAMJZ8dAt9ZIvdB7Aa78pj5nd
         naouVaMBflCVdDIiTG8wYQJ4tgU+OdE2zP+umVTurr8nftGhomIwCQDz2YaaU2RANJB9
         QELABvvBRz9ilMB9cwwC1Co2yVMwBxFrENuvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Kc9PAgGFdBs0v3kyJi1hDStw8858pvX+kI4wA6UOxpg=;
        b=slmC0Yz1z87cQx7b338qJnALdExFwnSiSRisrvRzz2IXvS0ZJMP5YwvCNwW4cJQCQA
         epnf8qf5KYeet4jnQN3ZhKg1E4mh5b214DT1I5d+KABiCjNT70vniTdwZulHYeqNbWCh
         tHf+vWfPHueZfXsyipkOJW4gNJL0FjPWuWEfe9IuaipXZJBcj5tykIePrVdcAOtZytUG
         msFi/ynH0CAgVK9QTlSkpiELSz1JqynFNPumIk/yTEYwSxb1PeFEke4d6BUuSsbTMeup
         aIvmJD58LRUXHfZc60BZC37V4jpa2CAQjhVwPCuTzdKICDlYB1/h9tRRa22kRegk/kcm
         AOiQ==
X-Gm-Message-State: AOUpUlHLoISi+ThrTRFP3m4wOIMlgnkZzygUyQ//TC369/EBRhkoZLzJ
        73cwVobVWkZ7DQMC7vf3Nxmoux4638o=
X-Google-Smtp-Source: AAOMgpe1dGcYloo2kh9Hgrr75JbSIBDIgoUDxqHP8U8UVAF/ALRHw7fM06Hqhmkm6t/wU9v0Q0zImQ==
X-Received: by 2002:a2e:4055:: with SMTP id n82-v6mr5407269lja.99.1532726005577;
        Fri, 27 Jul 2018 14:13:25 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id y74-v6sm676508lfi.61.2018.07.27.14.13.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 14:13:24 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id f135-v6so4411072lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 14:13:23 -0700 (PDT)
X-Received: by 2002:a19:c742:: with SMTP id x63-v6mr4839746lff.9.1532726002653;
 Fri, 27 Jul 2018 14:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <1531967820-27483-1-git-send-email-daidavid1@codeaurora.org> <1531967820-27483-2-git-send-email-daidavid1@codeaurora.org>
In-Reply-To: <1531967820-27483-2-git-send-email-daidavid1@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 27 Jul 2018 14:12:46 -0700
X-Gmail-Original-Message-ID: <CAE=gft6wkMiOkkxBLusTDE_aNGhxH=Pybd5W6sSj+0s-qYe=8w@mail.gmail.com>
Message-ID: <CAE=gft6wkMiOkkxBLusTDE_aNGhxH=Pybd5W6sSj+0s-qYe=8w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] interconnect: qcom: Add sdm845 interconnect
 provider driver
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        georgi.djakov@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        daidavid1@codeaurora.org, amit.kucheria@linaro.org,
        Lina Iyer <ilina@codeaurora.org>, seansw@qti.qualcomm.com,
        grahamr@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thu, Jul 26, 2018 at 4:30 PM David Dai <daidavid1@codeaurora.org> wrote:
>
> Introduce Qualcomm SDM845 specific provider driver using the
> interconnect framework.
>
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> ---
>  .../bindings/interconnect/qcom-sdm845.txt          |  22 +
>  drivers/interconnect/qcom/Kconfig                  |   8 +
>  drivers/interconnect/qcom/Makefile                 |   1 +
>  drivers/interconnect/qcom/qcom-icc-ids.h           | 142 ++++
>  drivers/interconnect/qcom/sdm845.c                 | 826 +++++++++++++++++++++
>  5 files changed, 999 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-sdm845.txt
>  create mode 100644 drivers/interconnect/qcom/qcom-icc-ids.h
>  create mode 100644 drivers/interconnect/qcom/sdm845.c
>
...
> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
> new file mode 100644
> index 0000000..bf13053
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sdm845.c
> @@ -0,0 +1,826 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + *
> + */
> +
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/interconnect.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/sort.h>
> +
> +#include <soc/qcom/cmd-db.h>
> +#include <soc/qcom/rpmh.h>
> +#include <soc/qcom/tcs.h>
> +
> +#include "qcom-icc-ids.h"
> +
> +#define BCM_TCS_CMD_COMMIT_SHFT                30
> +#define BCM_TCS_CMD_COMMIT_MASK                0x40000000
> +#define BCM_TCS_CMD_VALID_SHFT         29
> +#define BCM_TCS_CMD_VALID_MASK         0x200010000
> +#define BCM_TCS_CMD_VOTE_X_SHFT                14
> +#define BCM_TCS_CMD_VOTE_MASK          0x3fff
> +#define BCM_TCS_CMD_VOTE_Y_SHFT                0
> +#define BCM_TCS_CMD_VOTE_Y_MASK                0xfffc000
> +
> +#define BCM_TCS_CMD(commit, valid, vote_x, vote_y) \
> +       ((commit << BCM_TCS_CMD_COMMIT_SHFT) |\
> +       (valid << BCM_TCS_CMD_VALID_SHFT) |\
> +       ((vote_x & BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_X_SHFT) |\
> +       ((vote_y & BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_Y_SHFT))

These values that are >8 bits (vote_x and vote_y) should be converted
from cpu to little endian.

> +
> +#define to_qcom_provider(_provider) \
> +       container_of(_provider, struct qcom_icc_provider, provider)
> +
> +#define DEFINE_QNODE(_name, _id, _channels, _buswidth,                 \
> +                       _numlinks, ...)                                 \
> +               static struct qcom_icc_node _name = {                   \
> +               .id = _id,                                              \
> +               .name = #_name,                                         \
> +               .channels = _channels,                                  \
> +               .buswidth = _buswidth,                                  \
> +               .num_links = _numlinks,                                 \
> +               .links = { __VA_ARGS__ },                               \
> +       }
> +
> +#define DEFINE_QBCM(_name, _bcmname, _keepalive, _numnodes, ...)       \
> +               static struct qcom_icc_bcm _name = {                    \
> +               .name = _bcmname,                                       \
> +               .keepalive = _keepalive,                                \
> +               .num_nodes = _numnodes,                                 \
> +               .nodes = { __VA_ARGS__ },                               \
> +       }
> +
> +struct qcom_icc_provider {
> +       struct icc_provider     provider;
> +       void __iomem            *base;
> +       struct device           *dev;
> +       struct qcom_icc_bcm     **bcms;
> +       size_t num_bcms;
> +};
> +
> +/**
> + * struct bcm_db - Auxiliary data pertaining to each Bus Clock Manager(BCM)
> + * @unit: bcm threshold values are in magnitudes of this
> + * @width: prototype width
> + * @vcd: virtual clock domain that this bcm belongs to
> + */
> +
> +struct bcm_db {
> +       u32 unit;
> +       u16 width;
> +       u8 vcd;
> +       u8 reserved;
> +};
> +
> +#define SDM845_MAX_LINKS       43
> +#define SDM845_MAX_BCMS                30
> +#define SDM845_MAX_BCM_PER_NODE        2
> +#define SDM845_MAX_VCD         10
> +
> +/**
> + * struct qcom_icc_node - Qualcomm specific interconnect nodes
> + * @name: the node name used in debugfs
> + * @links: an array of nodes where we can go next while traversing
> + * @id: a unique node identifier
> + * @num_links: the total number of @links
> + * @channels: num of channels at this node
> + * @buswidth: width of the interconnect between a node and the bus
> + * @sum_avg: current sum aggregate value of all avg bw requests
> + * @max_peak: current max aggregate value of all peak bw requests
> + * @bcms: list of bcms associated with this logical node
> + * @num_bcm: num of @bcms
> + */
> +struct qcom_icc_node {
> +       const char *name;
> +       u16 links[SDM845_MAX_LINKS];
> +       u16 id;
> +       u16 num_links;
> +       u16 channels;
> +       u16 buswidth;
> +       u64 sum_avg;
> +       u64 max_peak;
> +       struct qcom_icc_bcm *bcms[SDM845_MAX_BCM_PER_NODE];
> +       size_t num_bcms;
> +};
> +
> +/**
> + * struct qcom_icc_bcm - Qualcomm specific hardware accelerator nodes
> + * known as Bus Clock Manager(BCM)
> + * @name: the bcm node name used to fetch BCM data from command db
> + * @type: latency or bandwidth bcm
> + * @addr: address offsets used when voting to RPMH
> + * @vote_x: aggregated threshold values, represents sum_bw when @type is bw bcm
> + * @vote_y: aggregated threshold values, represents peak_bw when @type is bw bcm
> + * @dirty: flag used to indicate whether or bcm needs to be committed
> + * @aux_data: auxiliary data used when calculating threshold values and
> + * communicating with RPMh
> + * @list: used to link to other bcms when compiling lists for commit
> + * @num_nodes: total number of @num_nodes
> + * @nodes: list of qcom_icc_nodes that this BCM encapsulates
> + */
> +
> +struct qcom_icc_bcm {
> +       const char *name;
> +       u32 type;
> +       u32 addr;
> +       u64 vote_x;
> +       u64 vote_y;
> +       bool dirty;
> +       bool keepalive;
> +       struct bcm_db aux_data;
> +       struct list_head list;
> +       size_t num_nodes;
> +       struct qcom_icc_node *nodes[];
> +};
> +
> +struct qcom_icc_fabric {
> +       struct qcom_icc_node **nodes;
> +       size_t num_nodes;
> +       u32 base_offset;
> +       u32 qos_offset;
> +};
> +
> +struct qcom_icc_desc {
> +       struct qcom_icc_node **nodes;
> +       size_t num_nodes;
> +       struct qcom_icc_bcm **bcms;
> +       size_t num_bcms;
> +};
> +
...
> +
> +static int qcom_icc_init(struct icc_node *node)
> +{
> +       /* TODO: init qos and priority */
> +
> +       return 0;
> +}
> +
> +static int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
> +{
> +       struct qcom_icc_node *qn;
> +       int ret, i;
> +
> +       bcm->addr = cmd_db_read_addr(bcm->name);
> +       if (!bcm->addr) {
> +               dev_err(dev, "%s could not find RPMh address\n",
> +                       bcm->name);
> +               return -EINVAL;
> +       }
> +
> +       if (!cmd_db_read_aux_data_len(bcm->name)) {

I think you should validate that the aux data length being returned is
the length you expect it to be. Or maybe "at least" the length you
expect it to be, if this structure is meant to be backwards
compatible?

> +               dev_err(dev, "%s command db missing aux data\n",
> +                       bcm->name);
> +               return -EINVAL;
> +       }
> +
> +       ret = cmd_db_read_aux_data(bcm->name, (u8 *)&bcm->aux_data,
> +                                  sizeof(struct bcm_db));

This still doesn't work for big endian, after being read the
multi-byte members of this structure need to be converted from little
endian to cpu format.

> +       if (ret < 0) {
> +               dev_err(dev, "%s command db read error (%d)\n",
> +                       bcm->name, ret);
> +               return ret;
> +       }
> +
> +       for (i = 0; i < bcm->num_nodes; i++) {

This loop could use a comment describing what it's doing, which I
understand to be: Add links back to the BCM for each node in the BCM.

> +               qn = bcm->nodes[i];
> +               qn->bcms[qn->num_bcms] = bcm;
> +               qn->num_bcms++;
> +       }
> +
> +       return 0;
> +}
> +
> +static int qcom_tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x,
> +                                       u64 vote_y, u32 addr, bool commit)
> +{
> +       int ret = 0;
> +       bool valid = true;
> +
> +       if (!cmd)
> +               return ret;
> +
> +       if (vote_x == 0 && vote_y == 0)
> +               valid = false;
> +
> +       if (vote_x > BCM_TCS_CMD_VOTE_MASK)
> +               vote_x = BCM_TCS_CMD_VOTE_MASK;
> +
> +       if (vote_y > BCM_TCS_CMD_VOTE_MASK)
> +               vote_y = BCM_TCS_CMD_VOTE_MASK;
> +
> +       cmd->addr = addr;
> +       cmd->data = BCM_TCS_CMD(commit, valid, vote_x, vote_y);
> +
> +       /* Set the wait for completion flag on commands that have the commit

I think the preferred style of multiline commenting has /* on its own line.

> +        * set, in order to indicate to the RSC to not release the TCS slot
> +        * until hardware has acknowledged that this transaction has completed
> +        */
> +       if (commit)
> +               cmd->wait = true;
> +
> +       return ret;
> +}
> +
> +static void qcom_tcs_list_gen(struct list_head *bcm_list,
> +                                       struct tcs_cmd *tcs_list, int *n)
> +{
> +       struct qcom_icc_bcm *bcm;
> +       bool commit;
> +       size_t idx = 0, batch = 0, cur_vcd_size = 0;
> +
> +       memset(n, 0, sizeof(int) * SDM845_MAX_VCD);
> +
> +       list_for_each_entry(bcm, bcm_list, list) {
> +               commit = false;
> +               cur_vcd_size++;
> +               if ((bcm->aux_data.vcd !=
> +                       list_next_entry(bcm, list)->aux_data.vcd) ||
> +                       list_is_last(&bcm->list, bcm_list)) {

You should switch the order of these conditions. Otherwise for the
last node you end up reaching through the list head object to get
aux_data.vcd, which is a wild memory access.

> +                       commit = true;
> +                       cur_vcd_size = 0;
> +               }
> +               qcom_tcs_cmd_gen(&tcs_list[idx], bcm->vote_x, bcm->vote_y,
> +                               bcm->addr, commit);
> +               idx++;
> +               n[batch]++;
> +               if (n[batch] >= MAX_RPMH_PAYLOAD) {
> +                       if (!commit) {
> +                               n[batch] -= cur_vcd_size;
> +                               n[batch+1] = cur_vcd_size;
> +                       }
> +                       batch++;

I think I have my head around this, but it at least needs a comment
describing what it's doing, because it's still mind boggling. My
understanding is: "Avoid splitting requests for the same BCM across
multiple RPMh payloads. If the current set of BCM requests would be
split, move it to the next batch."

I would also include a warning if cur_vcd_size is > MAX_RPMH_PAYLOAD,
or if n[batch] <= cur_vcd_size. This would help with readability, and
help catch any sort of crazy situation not anticipated by this logic.

> +               }
> +       }
> +}
> +
> +static void qcom_icc_bcm_aggregate(struct qcom_icc_bcm *bcm)
> +{
> +       size_t i;
> +       u64 agg_avg = 0;
> +       u64 agg_peak = 0;
> +
> +       for (i = 0; i < bcm->num_nodes; i++) {
> +               agg_avg = max(agg_avg,
> +                       bcm->nodes[i]->sum_avg * bcm->aux_data.width /
> +                       (bcm->nodes[i]->buswidth * bcm->nodes[i]->channels));
> +               agg_peak = max(agg_peak,
> +                       bcm->nodes[i]->max_peak * bcm->aux_data.width /
> +                       bcm->nodes[i]->buswidth);
> +       }
> +
> +       bcm->vote_x = (u64)(agg_avg * 1000ULL / bcm->aux_data.unit);
> +       bcm->vote_y = (u64)(agg_peak * 1000ULL / bcm->aux_data.unit);
> +
> +       if (bcm->keepalive && bcm->vote_x == 0 && bcm->vote_y == 0) {
> +               bcm->vote_x = 1;
> +               bcm->vote_y = 1;
> +       }
> +
> +       bcm->dirty = false;
> +}
> +
> +static int qcom_icc_aggregate(struct icc_node *node, u32 avg_bw,
> +                               u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
> +{
> +       size_t i;
> +       struct qcom_icc_node *qn;
> +
> +       qn = node->data;
> +
> +       *agg_avg += avg_bw;
> +       *agg_peak = max_t(u64, agg_peak, peak_bw);
> +
> +       qn->sum_avg = *agg_avg;
> +       qn->max_peak = *agg_peak;
> +
> +       for (i = 0; i < qn->num_bcms; i++)
> +               qn->bcms[i]->dirty = true;
> +
> +       return 0;
> +}
> +
> +static int qcom_icc_set(struct icc_node *src, struct icc_node *dst,
> +                       u32 avg, u32 peak)
> +{
> +       struct qcom_icc_provider *qp;
> +       struct qcom_icc_node *qn;
> +       struct icc_node *node;
> +       struct icc_provider *provider;
> +       struct tcs_cmd cmds[SDM845_MAX_BCMS];
> +       struct list_head commit_list;
> +       int commit_idx[SDM845_MAX_VCD];
> +       int ret = 0, i;
> +
> +       if (!src)
> +               node = dst;
> +       else
> +               node = src;
> +
> +       qn = node->data;
> +       provider = node->provider;
> +       qp = to_qcom_provider(node->provider);
> +
> +       INIT_LIST_HEAD(&commit_list);
> +
> +       for (i = 0; i < qp->num_bcms; i++) {
> +               if (qp->bcms[i]->dirty) {
> +                       qcom_icc_bcm_aggregate(qp->bcms[i]);
> +                       list_add_tail(&qp->bcms[i]->list, &commit_list);
> +               }
> +       }
> +
> +       /* Construct the command list based on a pre ordered list of BCMs

Another networking-style comment.

> +        * based on VCD

period?

> +        */
> +       qcom_tcs_list_gen(&commit_list, cmds, commit_idx);
> +
> +       if (!commit_idx[0])
> +               return ret;
> +
> +       ret = rpmh_invalidate(qp->dev);
> +       if (ret) {
> +               pr_err("Error invalidating RPMH client (%d)\n", ret);
> +               return ret;
> +       }
> +
> +       ret = rpmh_write_batch(qp->dev, RPMH_ACTIVE_ONLY_STATE,
> +                              cmds, commit_idx);
> +       if (ret) {
> +               pr_err("Error sending AMC RPMH requests (%d)\n", ret);
> +               return ret;
> +       }
> +
> +       /* TODO: collect and send wake and sleep sets */
> +       return ret;
> +}
> +
> +static int cmp_vcd(const void *_l, const void *_r)
> +{
> +       const struct qcom_icc_bcm **l = (const struct qcom_icc_bcm **)_l;
> +       const struct qcom_icc_bcm **r = (const struct qcom_icc_bcm **)_r;
> +
> +       if (l[0]->aux_data.vcd < r[0]->aux_data.vcd)
> +               return -1;
> +       else if (l[0]->aux_data.vcd == r[0]->aux_data.vcd)
> +               return 0;
> +       else
> +               return 1;
> +}
> +
> +static int qnoc_probe(struct platform_device *pdev)
> +{
> +       const struct qcom_icc_desc *desc;
> +       struct qcom_icc_node **qnodes;
> +       struct qcom_icc_provider *qp;
> +       struct icc_provider *provider;
> +       size_t num_nodes, i;
> +       int ret;
> +
> +       desc = of_device_get_match_data(&pdev->dev);
> +       if (!desc)
> +               return -EINVAL;
> +
> +       qnodes = desc->nodes;
> +       num_nodes = desc->num_nodes;
> +
> +       qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
> +       if (!qp)
> +               return -ENOMEM;
> +
> +       provider = &qp->provider;
> +       provider->dev = &pdev->dev;
> +       provider->set = &qcom_icc_set;
> +       provider->aggregate = &qcom_icc_aggregate;
> +       INIT_LIST_HEAD(&provider->nodes);
> +       provider->data = qp;
> +
> +       qp->dev = &pdev->dev;
> +       qp->bcms = desc->bcms;
> +       qp->num_bcms = desc->num_bcms;
> +
> +       ret = icc_provider_add(provider);
> +       if (ret) {
> +               dev_err(&pdev->dev, "error adding interconnect provider\n");
> +               return ret;
> +       }
> +
> +       for (i = 0; i < num_nodes; i++) {
> +               struct icc_node *node;
> +               int ret;
> +               size_t j;
> +
> +               node = icc_node_create(qnodes[i]->id);
> +               if (IS_ERR(node)) {
> +                       ret = PTR_ERR(node);
> +                       goto err;

I think you need to clean up the nodes you've already created and
added, otherwise provider_del will end up printing a warning and
failing.

> +               }
> +
> +               node->name = qnodes[i]->name;
> +               node->data = qnodes[i];
> +               icc_node_add(node, provider);
> +
> +               dev_dbg(&pdev->dev, "registered node %p %s %d\n", node,
> +                       qnodes[i]->name, node->id);
> +
> +               ret = qcom_icc_init(node);
> +               if (ret)
> +                       dev_err(&pdev->dev, "%s init error (%d)\n", node->name,
> +                               ret);
> +
> +               /* populate links */
> +               for (j = 0; j < qnodes[i]->num_links; j++)
> +                       if (qnodes[i]->links[j])
> +                               icc_link_create(node, qnodes[i]->links[j]);
> +       }
> +
> +       for (i = 0; i < qp->num_bcms; i++)
> +               qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
> +
> +       /* Pre sort the BCMs based on VCD for ease of generating a command list

Another comment that needs the /* line on its own. It turns out I do
this a lot too :)

> +        * that groups the BCMs with the same VCD together. VCDs are numbered
> +        * with lowest being the most expensive time wise, ensuring that
> +        * those commands are being sent the earliest in the queue.
> +        */
> +       sort(qp->bcms, qp->num_bcms, sizeof(*qp->bcms), cmp_vcd, NULL);
> +
> +       platform_set_drvdata(pdev, provider);
> +       dev_info(&pdev->dev, "Registered SDM845 ICC\n");
> +
> +       return ret;
> +err:
> +       icc_provider_del(provider);
> +       return ret;
> +}
> +
> +static int qnoc_remove(struct platform_device *pdev)
> +{
> +       struct icc_provider *provider = platform_get_drvdata(pdev);
> +
> +       icc_provider_del(provider);

Don't you need to tear all the nodes down too? Otherwise this function
will fail. Should you check the return value as well and complain at
least, or maybe fail qnoc_remove entirely?

> +
> +       return 0;
> +}
> +
> +static const struct of_device_id qnoc_of_match[] = {
> +       { .compatible = "qcom,sdm845-rsc-hlos", .data = &sdm845_rsc_hlos },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, qnoc_of_match);
> +
> +static struct platform_driver qnoc_driver = {
> +       .probe = qnoc_probe,
> +       .remove = qnoc_remove,
> +       .driver = {
> +               .name = "qnoc-sdm845",
> +               .of_match_table = qnoc_of_match,
> +       },
> +};
> +module_platform_driver(qnoc_driver);
> +
> +MODULE_AUTHOR("David Dai <daidavid1@codeaurora.org>");
> +MODULE_DESCRIPTION("Qualcomm sdm845 NoC driver");
> +MODULE_LICENSE("GPL v2");
