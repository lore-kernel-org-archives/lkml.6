Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488C1C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E934F26390
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X+4dKmp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E934F26390
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934430AbeFZA7E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:59:04 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:39936 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755580AbeFZA7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:59:02 -0400
Received: by mail-io0-f195.google.com with SMTP id t135-v6so579404iof.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 17:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UePNDokaGtOS+yLA9yrR6ySTLlieH376aSPlzGm2o80=;
        b=X+4dKmp6jb5Btpsr9zhfFXFlAqh/a2iz2P9+afEbc0324Aifk/6rpO8zzaCCT823D9
         o3wTwsNQJyG57nGN8bWDp5LtsqWdIPLCjK0LlWKXfVld1qA/CyFnAa/S5MHKPT2+SW2d
         OEy9IP0qtxMMTHNwRd6k+9GkJQjr7slEN4gQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UePNDokaGtOS+yLA9yrR6ySTLlieH376aSPlzGm2o80=;
        b=SYVDVqxrRd5yEX7FhDZ8FT2g5w7oT3NrhugUhGQPv12XcNemTC+1fGTLAwiyabA9cV
         Shk5oxjw/De91s2/yo+a4qXctgZWllUGb4MRqheii54Jg8VA8pR6bJcjgZcKBQRsh3WZ
         zPSGIn9eXJ3tVhdNC9gdmFQ5CRebPf79KkU5YcUUWU1xbUUuCcSEHCXS04YAjYI52rXN
         Y+mplrnMvP5GRlSRD2rI3gbsra/RwKadD0C/leBAtT9p9IvxnjKBejKKrJUC9vLoy79C
         Bvd2lwtl5bhPoIUNbgTjlcEG2kywIe45N/dcWlSMnAOPODCqMy02zhOKp9V/0cq6WHgj
         E7jg==
X-Gm-Message-State: APt69E1V5WHM2Md8h1wFuWZe+k8JWPZPWv6yPDoAPh+Ae/gW2A91l/WO
        Jsi8iUu0LLYGDXeVBYNjVlhQYlcUpP4=
X-Google-Smtp-Source: AAOMgpfWVCdptQCEahgKe/tV6nE2OPKWtgcLNOZvD98m/L7Lqta9D+Ry/Cymx2DOPqL3z6cPs6231A==
X-Received: by 2002:a6b:9303:: with SMTP id v3-v6mr11956413iod.255.1529974741509;
        Mon, 25 Jun 2018 17:59:01 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id f193-v6sm372556itf.9.2018.06.25.17.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 17:59:00 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     andy.gross@linaro.org
Cc:     clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH resend 00/12] soc: qcom: smem: some refactoring
Date:   Mon, 25 Jun 2018 19:58:44 -0500
Message-Id: <20180626005856.14174-1-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(This is just a rebase of https://lkml.org/lkml/2018/5/1/670)

This series contains a few general cleanups in the Qualcomm SMEM
code, reorganizing some things so memory partitions are treated
more consistently, and to avoid some duplication.  A few patches
change existing behavior, as highlighted below.  Each of these
changes has been tested and verified to function with available
hardware.

					-Alex

Alex Elder (12):
  soc: qcom: smem: rename variable in qcom_smem_get_global()
  soc: qcom: smem: initialize region struct only when successful
  soc: qcom: smem: always ignore partitions with 0 offset or size
  soc: qcom: smem: small refactor in qcom_smem_enumerate_partitions()
  soc: qcom: smem: verify both host ids in partition header
  soc: qcom: smem: require order of host ids to match
  soc: qcom: smem: introduce qcom_smem_partition_header()
  soc: qcom: smem: verify partition header size
  soc: qcom: smem: verify partition offset_free_uncached
  soc: qcom: smem: small change in global entry loop
  soc: qcom: smem: verify partition host ids match
  soc: qcom: smem: a few last cleanups

 drivers/soc/qcom/smem.c | 173 +++++++++++++++++++---------------------
 1 file changed, 82 insertions(+), 91 deletions(-)

-- 
2.17.1

