Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CE9C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673F52082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673F52082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeKCAoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:44:01 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:47531 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbeKCAoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:44:01 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MGyl3-1gNoGW1WqZ-00E57J; Fri, 02 Nov 2018 16:34:59 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MGyl3-1gNoGW1WqZ-00E57J; Fri, 02 Nov 2018 16:34:59 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Hannes Reinecke <hare@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: myrb: fix sprintf buffer overflow warning
Date:   Fri,  2 Nov 2018 16:34:49 +0100
Message-Id: <20181102153458.1567593-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:jPqDSsZ4zPBvsadRKmf8ZBTp5DodxXKNbnxAhgbHmiSpOhpOyHd
 AofuR2qd4JZszfjrlTmA1QFNiwK3cjgCzkUcgdxSeHly5I0l7LPEOGR41U5ctK5Bs4qbzIS
 enUszkIrcPVIeXFlApXEreYMPI5nvUKzhlIp0JPUGQz6/RermkfUpNn6TGa+HFRTDkDpuFU
 EKU2JJnpT+4WM+L/YVMVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XqwE8iibaJs=:KuVl98V21he6SWdbaa0cPC
 4AYzXLSM4JtctKhwbNhoI8OfM2HTQRvtXKqKQEPIW5DO5dTMwCLdLQ28CV4FGrVmbGWvJHeL/
 rAb+gNICSdicddEzL31/y8ZP2dG8YaGMWpZHHdG3idrOzhzUO/51dpHc4IK9l/Z2Y92CzY6kh
 ix6KEsPvaMEHwWqLDG5yF0unUoR20bGtJ3SvTg86S4rsLMnp4z/97yrji8sT08YpNnwJnabym
 xcscrgGd6m2kmGQ7vdFdf7fyLD9uFJORstEBE0HXo05QVBFQg2R7EnM/pYYdk6L6E3+Ta48JF
 MxqIdeJu4mnaJbd7F/DMDUZSHMp/tIxJJzFYEFJbYqe3eT13INoED+8vwePXRzOKQBGkAWXfW
 62Bjg+IS9Lm+8fFYyo31vprkva25aafDPHTNAa5UdtiZ/+OFYbSRYepLt3FbMoQqRVyqqOXvJ
 yhlc1clyEsepmofcTuDt0OGogI2oytZNF3I7aic5kt9GcGhzXQEV/NHUHa9AUNsh9wrKBa26F
 6dAc9cDXgpvcXtnwsb3TyLu202J697nHHB8IP2MAdTdaUMQpuMhkgE/Jyv52SizrlPPT0CHcH
 wHTffH6VAx84ckceyx22eLmVOBe/TYtGxdOPsGdsKwgccUiqc1s88AzPrpD3UfQq+7bpzTKXR
 9MNlWzDsGhAtDIHMlGVGRBO7IQWo5inkG+AygXtjmuEPzZE82yVSaL9Nc28CNh3H2aYU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc warns that the 12 byte fw_version field might not be long enough to
contain the generated firmware name string:

drivers/scsi/myrb.c: In function 'myrb_get_hba_config':
drivers/scsi/myrb.c:1052:38: error: '%02d' directive writing between 2 and 3 bytes into a region of size between 2 and 5 [-Werror=format-overflow=]
  sprintf(cb->fw_version, "%d.%02d-%c-%02d",
                                      ^~~~
drivers/scsi/myrb.c:1052:26: note: directive argument in the range [0, 255]
  sprintf(cb->fw_version, "%d.%02d-%c-%02d",
                          ^~~~~~~~~~~~~~~~~
drivers/scsi/myrb.c:1052:2: note: 'sprintf' output between 10 and 14 bytes into a destination of size 12
  sprintf(cb->fw_version, "%d.%02d-%c-%02d",
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   enquiry2->fw.major_version,
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   enquiry2->fw.minor_version,
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   enquiry2->fw.firmware_type,
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   enquiry2->fw.turn_id);
   ~~~~~~~~~~~~~~~~~~~~~

I have not checked whether there are appropriate range checks before the
sprintf, but there is a range check after it that will bail out in case
of out of range version numbers. This means we can simply use snprintf()
instead of sprintf() to limit the output buffer size, and it will work
correctly.

Fixes: 081ff398c56c ("scsi: myrb: Add Mylex RAID controller (block interface)")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/myrb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index aeb282f617c5..0642f2d0a3bb 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -1049,7 +1049,8 @@ static int myrb_get_hba_config(struct myrb_hba *cb)
 		enquiry2->fw.firmware_type = '0';
 		enquiry2->fw.turn_id = 0;
 	}
-	sprintf(cb->fw_version, "%d.%02d-%c-%02d",
+	snprintf(cb->fw_version, sizeof(cb->fw_version),
+		"%d.%02d-%c-%02d",
 		enquiry2->fw.major_version,
 		enquiry2->fw.minor_version,
 		enquiry2->fw.firmware_type,
-- 
2.18.0

