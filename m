Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeEDWoe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 18:44:34 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33867 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbeEDWoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 18:44:32 -0400
X-Google-Smtp-Source: AB8JxZpk4yhSTzwWWwP1EZJhpfkRg6ztqA2f1Emo1iqlf74cHzL0kmKLC2TOci25ikyVF2FmuObO9Q==
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
Subject: [PATCH v2 0/2] Fix UFS and devfreq interaction
Date: Fri,  4 May 2018 15:44:25 -0700
Message-Id: <20180504224427.32606-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of f1d981eaecf8 ("PM / devfreq: Use the available min/max
frequency") the UFS host controller driver (UFSHCD) stopped probing for
platforms that supports frequency scaling, e.g. all modern Qualcomm platforms.

The cause of this was UFSHCD's reliance of not registering any frequencies and
then being called by devfreq to switch between the frequencies 0 and UINT_MAX.

The devfreq code implies that the client is able to pass the frequency table,
instead of relying on opp tables, but as concluded after v1 this is not
compliant with devfreq cooling, which will enable and disable opp entries in
order to limit the valid frequencies. So instead the UFSHCD driver is modified
to read the freq-table and register the first clock's two rates as the two
available opp levels.


This follows the first patch which facilitates the implementation of this in a
clean fashion, and removes the kernel panic which previously happened when
devfreq initialization failed.


With this UFS is once again functional on the db820c, and is needed to get UFS
working on SDM845 (both tested).

Bjorn Andersson (2):
  scsi: ufs: Extract devfreq registration
  scsi: ufs: Use freq table with devfreq

 drivers/scsi/ufs/ufshcd.c | 76 +++++++++++++++++++++++++++++++--------
 1 file changed, 61 insertions(+), 15 deletions(-)

-- 
2.17.0
