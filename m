Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeFDUap (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:30:45 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45476 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbeFDUan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:30:43 -0400
X-Google-Smtp-Source: ADUXVKLi2kPtvOWSAJHoHmOz5u7IYnmsup1y9hM0LTkvVlUlvM/WYQBJXjhozVkW2PsegOHnk+ltOA==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/4] Hexagon remoteproc spring cleaning
Date: Mon,  4 Jun 2018 13:30:34 -0700
Message-Id: <20180604203038.14080-1-bjorn.andersson@linaro.org>
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

Sricharan R (1):
  remoteproc: qcom: mdt_loader: Make the firmware authentication
    optional

 drivers/remoteproc/Kconfig          |   7 +
 drivers/remoteproc/Makefile         |   1 +
 drivers/remoteproc/qcom_adsp_pil.c  | 156 ++++--------------
 drivers/remoteproc/qcom_q6v5.c      | 243 ++++++++++++++++++++++++++++
 drivers/remoteproc/qcom_q6v5.h      |  46 ++++++
 drivers/remoteproc/qcom_q6v5_pil.c  | 157 ++----------------
 drivers/soc/qcom/mdt_loader.c       |  87 +++++++---
 include/linux/soc/qcom/mdt_loader.h |   4 +
 8 files changed, 405 insertions(+), 296 deletions(-)
 create mode 100644 drivers/remoteproc/qcom_q6v5.c
 create mode 100644 drivers/remoteproc/qcom_q6v5.h

-- 
2.17.0
