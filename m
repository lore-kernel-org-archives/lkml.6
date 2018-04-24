Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932691AbeDXAUX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 20:20:23 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36480 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932647AbeDXAUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 20:20:20 -0400
X-Google-Smtp-Source: AIpwx4/25C71Y+i73vDYSl7V/bPOrz1LY4xpObeECkTKJXzCTergV+CWbJwbW9OwFAwiU1+Up692Gg==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-scsi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 0/3] Fix UFS and devfreq interaction
Date: Mon, 23 Apr 2018 17:20:13 -0700
Message-Id: <20180424002016.9205-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of f1d981eaecf8 ("PM / devfreq: Use the available min/max
frequency") the UFS host controller driver (UFSHCD) stopped probing for
platforms that supports frequency scaling, e.g. all modern Qualcomm platforms.

The cause of this was UFSHCD's reliance of not registering any frequencies and
then being called by devfreq to switch between the frequencies 0 and UINT_MAX.

The devfreq code implies that the client is able to pass the frequency table,
instead of relying on opp tables, so the first patch makes this actually work.
The second patch extracts the devfreq registration in the UFSHCD driver, both
to facilitate the third patch and to remove a dereference of an ERR_PTR() in
the case that devfreq registration fails. Finally, the third patch picks the
two frequencies from the freq-table provided in UFSHCD and pass these to
devfreq, as well as map these frequencies back to the step up/down actions.


With this UFS is once again functional on the db820c, and is needed to get UFS
working on SDM845 (both tested).

Bjorn Andersson (3):
  PM / devfreq: Actually support providing freq_table
  scsi: ufs: Extract devfreq registration
  scsi: ufs: Use freq table with devfreq

 drivers/devfreq/devfreq.c | 22 +++------------
 drivers/scsi/ufs/ufshcd.c | 68 ++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 57 insertions(+), 33 deletions(-)

-- 
2.16.2
