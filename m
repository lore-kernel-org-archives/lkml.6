Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964779AbeBMMuQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:50:16 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:45836 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935077AbeBMMuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:50:14 -0500
X-Google-Smtp-Source: AH8x224SE55szNAH/5oCQk+pcLL7L9h9DI+9BNwbcblQmx9kEzpgrj5wwl/wtvQEENaTDukXRmYheA==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: hch@lst.de, keith.busch@intel.com
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        javier@cnexlabs.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [RFC PATCH 0/1] nvme: implement get log page offset and dwords
Date: Tue, 13 Feb 2018 13:49:15 +0100
Message-Id: <20180213124916.28653-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces support for get log page offset and extends
the number of dwords to be 32 bits.

A function is introduced that takes the offset and implements the
support. This is needed for ocssd to retrieve the report chunk log
page, which can span a couple of megabytes.

The patch is based on Javier's report chunk implementation patch,
and is generalized to make it part of the nvme core. A follow up
patch will expose the extended function and let the lightnvm module
call it to retrieve the report chunk log page.

A couple of questions with respect to the function:

 1. Should we check the offset in the extended function to be dword
    aligned?
 2. Verify that when offset is defined, the nvme controller version
    is at least 1.2.1?
 3. Handle requests that are larger than supported by the mdts field?

My take is that the caller should handle all of the above.

Thanks!

Matias Bjørling (1):
  nvme: implement log page low/high offset and dwords

 drivers/nvme/host/core.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

-- 
2.11.0
