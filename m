Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754093AbeEWFVE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 01:21:04 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34186 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754068AbeEWFU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 01:20:58 -0400
X-Google-Smtp-Source: AB8JxZq1Cqdc6l2DHHqA6JzLOo7sM6XlUOwrb0XOWZkEzLksgjqNgyYQXvKdQRo4QUGi49//lgOVcQ==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [RFC PATCH 0/5] Hexagon remoteproc spring cleaning
Date: Tue, 22 May 2018 22:20:49 -0700
Message-Id: <20180523052054.19025-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of support for the non-MSA Hexagon WCSS driver from
Sricharan and the non-PAS ADSP driver from Rohit it makes sense to overhaul the
structure of the Qualcomm "Q6V5 drivers".

The first patch is from Sricharan's series and included here for completeness.
The second patch introduces a set of helper functions, based on the current
state of the qcom_q6v5_pil driver. The third and forth patch migrates the PAS
and the MSA drivers over to using these helpers. Finally a (completely)
reworked version of Sricharan's WCSS remoteproc driver is introduced.


With this in place I suggest that we rename qcom_adsp_pil.c to qcom_q6v5_pas.c,
qcom_q6v5_pil.c to qcom_q6v5_msa.c and depending on the details of the non-PAS
ADSP we could potentially combine that into a qcom_q6v5_pil.c - or we carry
them as separate files.

Looking at the remaining non-essential parts of these drivers we have
memory-region handling and halt_axi handling. The prior is actively being
worked on and the latter should (if no better abstraction is presented) be
possible to just put in the new qcom_q6v5.c.

Bjorn Andersson (3):
  remoteproc: q6v5: Extract common resource handling
  remoteproc: qcom: adsp: Use common q6v5 helpers
  remoteproc: qcom: q6v5-pil: Use common q6v5 helpers

Sricharan R (2):
  remoteproc: qcom: mdt_loader: Make the firmware authentication
    optional
  remoteproc: qcom: Introduce Hexagon V5 based WCSS driver

 drivers/remoteproc/Kconfig          |  23 ++
 drivers/remoteproc/Makefile         |   2 +
 drivers/remoteproc/qcom_adsp_pil.c  | 156 ++------
 drivers/remoteproc/qcom_q6v5.c      | 243 ++++++++++++
 drivers/remoteproc/qcom_q6v5.h      |  46 +++
 drivers/remoteproc/qcom_q6v5_pil.c  | 157 +-------
 drivers/remoteproc/qcom_q6v5_wcss.c | 580 ++++++++++++++++++++++++++++
 drivers/soc/qcom/mdt_loader.c       |  87 +++--
 include/linux/soc/qcom/mdt_loader.h |   4 +
 9 files changed, 1002 insertions(+), 296 deletions(-)
 create mode 100644 drivers/remoteproc/qcom_q6v5.c
 create mode 100644 drivers/remoteproc/qcom_q6v5.h
 create mode 100644 drivers/remoteproc/qcom_q6v5_wcss.c

-- 
2.17.0
