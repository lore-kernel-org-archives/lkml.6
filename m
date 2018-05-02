Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbeEBBKb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 21:10:31 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:32812 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeEBBK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 21:10:27 -0400
X-Google-Smtp-Source: AB8JxZppH+MlwG4uPqhAltNN+toJJf/qSIClY/jVqkzEhMzveCzNIlgTC/yWx+h1aLuNefljwysTtg==
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] soc: qcom: smem: some refactoring
Date: Tue,  1 May 2018 20:10:07 -0500
Message-Id: <20180502011019.22812-1-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
	These two are simple cleanups.

  soc: qcom: smem: always ignore partitions with 0 offset or size
  	This patch makes partitions with a zero offset always be
	ignored.  Previously this condition was flagged as an error
	in one place and ignored in another.

  soc: qcom: smem: small refactor in qcom_smem_enumerate_partitions()
  	This just simplifies a little logic in one spot.

  soc: qcom: smem: verify both host ids in partition header
  	This patch makes it so *both* IDs, not just one or the
	other, must use the special value SMEM_GLOBAL_HOST to
	signify the special global partition.

  soc: qcom: smem: require order of host ids to match
	A memory partition is described by an entry in a partition
	table, which identifies two hosts permitted to access the
	partition.  A partition also embeds a header, which also
	identifies the hosts.  Previously the host ids could be
	in any order; now the two host ids are required to be
	listed in the same order in the partition table and header.

  soc: qcom: smem: introduce qcom_smem_partition_header()
  soc: qcom: smem: verify partition header size
  soc: qcom: smem: verify partition offset_free_uncached
  soc: qcom: smem: small change in global entry loop
  soc: qcom: smem: verify partition host ids match
  	These patches together introduce a single function
	to locate a partition header in memory, and to validate its
	contents.  The common function is used in two place and
	removes some duplication.  The patches build up the function
	in steps to facilitate review.

  soc: qcom: smem: a few last cleanups
  	This patch gathers a small set of trivial cleanups.

 drivers/soc/qcom/smem.c | 173 +++++++++++++++++++++++-------------------------
 1 file changed, 82 insertions(+), 91 deletions(-)

-- 
2.14.1
