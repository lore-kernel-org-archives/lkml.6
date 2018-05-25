Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967249AbeEYQIo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 12:08:44 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:57587 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966719AbeEYQIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 12:08:42 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] qcom: cmd-db: enforce CONFIG_OF_RESERVED_MEM dependency
Date: Fri, 25 May 2018 18:08:24 +0200
Message-Id: <20180525160836.125531-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:sPRHk80euo/+cajDazVMNbQyWWrZC/+Jf8GUaSacJfOEGr2OwxX
 aOKH5Og0D8j8YxFlBql8HGzW1jReZ6IPMQOXLnMRTaZPdcuqFTJDDWLWuhnrt9pfKZvyLRY
 E89sXpNidmMqRU21Ko//hrcKQN/366WI+osMOTn2oN1nn8fwPxJDMRmqevzJ5K3WOS0nsaX
 /a2G9AUkPMyzlOV5gPksg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bhIAYpb2B3w=:Rrv85xzNhfUE957bQzYPzQ
 WWUFx1NszY7uR0kE1KBPRfyw4S0noKh+9J6NQwq3fqYBhWABvJpPIw2mg4JmLztfGbiwNv3Fn
 1G5ddB8sMOwPgeZOxltX6/kjg9j8u6HQg4nUBq5sstvd1s+8Ei1XjdVOenPRdQRJonAd59PkI
 rYWO81f6Pi0Iv8TVl54HRCwWMcf5xDwJYve8Fa39qRzV+ZfY6ww7Y9h0EoI6nZwISeWI6Inb1
 Ek+VA8iQw/1TZeTSC3OTMsq8/EW/LmDJ7HGbzk+li+X0Rs0pDuqpNO8PfjdoTB2EwEd3JDE9B
 FlJ7DbyOW6JP5rHcJSlHeR1VT2dDeG6M0hfXxJ6Wy7lcv+YikUkKy67StFvu5a2NBfV7iejQT
 OJnEdnZ4ifq7xVItbq9GJWeI0MhTRVgsO0nTU+0xCvQqTpU9bMSJr/ZGHPwhgcNdnEegkHeL6
 iCaiVxTK1eWtSuSEQ5EFSl/jPA0mShpCXAU1SOba212djO1aDpAVetPC4EZmiyVJS/w6Boigh
 wAif+kDx06BY2MIDQ0RmGp1aKV5q74okq/L53u9FO2RcjiVLySZH9Vd5+PQ/eCnGOhbpQsxKO
 TiccSDoHMwChKZiaUNV/0ZZJByvbS4T++GKptuxS22lOUE5ZCKYvnQF1NG/9Xy0J9yxEHYHlC
 jKXQqwMHJIKNuOJWeG2aDwiy3bVREb+c3WA5su3e+WPHSma4TeH1re3cUEZhe/MhccPs=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_OF_RESERVED_MEM, gcc sees that the global cmd_db_header
variable is never initialized, and through code optimization concludes
that a lot of other code cannot possibly work after that:

drivers/soc/qcom/cmd-db.c: In function 'cmd_db_read_addr':
drivers/soc/qcom/cmd-db.c:197:21: error: 'ent.addr' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  return ret < 0 ? 0 : le32_to_cpu(ent.addr);
drivers/soc/qcom/cmd-db.c: In function 'cmd_db_read_aux_data':
drivers/soc/qcom/cmd-db.c:224:10: error: 'ent.len' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  ent_len = le16_to_cpu(ent.len);
drivers/soc/qcom/cmd-db.c:115:6: error: 'rsc_hdr.data_offset' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  u16 offset = le16_to_cpu(hdr->data_offset);
      ^~~~~~
drivers/soc/qcom/cmd-db.c:116:6: error: 'ent.offset' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  u16 loffset = le16_to_cpu(ent->offset);
      ^~~~~~~
drivers/soc/qcom/cmd-db.c: In function 'cmd_db_read_aux_data_len':
drivers/soc/qcom/cmd-db.c:250:38: error: 'ent.len' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  return ret < 0 ? 0 : le16_to_cpu(ent.len);
                                      ^
drivers/soc/qcom/cmd-db.c: In function 'cmd_db_read_slave_id':
drivers/soc/qcom/cmd-db.c:272:7: error: 'ent.addr' may be used uninitialized in this function [-Werror=maybe-uninitialized]

Using a hard CONFIG_OF_RESERVED_MEM dependency avoids this warning,
and we can remove the CONFIG_OF dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/qcom/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 9dc02f390ba3..5856e792d09c 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -5,7 +5,8 @@ menu "Qualcomm SoC drivers"
 
 config QCOM_COMMAND_DB
 	bool "Qualcomm Command DB"
-	depends on (ARCH_QCOM && OF) || COMPILE_TEST
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on OF_RESERVED_MEM
 	help
 	  Command DB queries shared memory by key string for shared system
 	  resources. Platform drivers that require to set state of a shared
-- 
2.9.0
