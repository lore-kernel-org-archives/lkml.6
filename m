Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E414C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29B724600
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29B724600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934492AbeFVQqW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:46:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934119AbeFVQqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:46:20 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5MGi5we099559
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 12:46:20 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2js4r90cmt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 12:46:19 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Fri, 22 Jun 2018 12:46:19 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Jun 2018 12:46:16 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5MGkFLX17564082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jun 2018 16:46:15 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B86F011206F;
        Fri, 22 Jun 2018 12:46:11 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A107C112066;
        Fri, 22 Jun 2018 12:46:11 -0400 (EDT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 22 Jun 2018 12:46:11 -0400 (EDT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com
Cc:     jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v3 0/4] Have IMA find and use a tpm_chip until system shutdown
Date:   Fri, 22 Jun 2018 12:46:09 -0400
X-Mailer: git-send-email 2.14.4
X-TM-AS-GCONF: 00
x-cbid: 18062216-0072-0000-0000-000003733BD7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009240; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01050751; UDB=6.00538515; IPR=6.00829721;
 MB=3.00021808; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-22 16:46:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062216-0073-0000-0000-00004873804E
Message-Id: <20180622164613.1609313-1-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=857 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806220186
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches converts IMA's usage of the tpm_chip to find a TPM
chip initially and use it until the machine is shut down. To do this we need
to introduce a kref for the tpm_chip that IMA and all other users of a
tpm_chip hold onto until they don't need the TPM chip anymore.

    Stefan

v2->v3:
  - renaming tpm_chip_find_get() to tpm_get_ops()
  - IMA does not lock access to ima_tpm_chip anymore
  - IMA does not have a reboot notifier to release the chip anymore

v1->v2:
  - use the kref of the device via get_device()/put_device()

Stefan Berger (4):
  tpm: rename tpm_chip_find_get() to tpm_get_ops()
  tpm: Implement tpm_chip_find() for other subsystems to find a TPM chip
  ima: Use tpm_chip_find() and call TPM functions with a tpm_chip
  ima: Get rid of ima_used_chip and use ima_tpm_chip != NULL instead

 drivers/char/tpm/tpm-chip.c         | 31 +++++++++++++++++++++++++++++--
 drivers/char/tpm/tpm-interface.c    | 14 +++++++-------
 drivers/char/tpm/tpm.h              |  2 +-
 include/linux/tpm.h                 |  5 +++++
 security/integrity/ima/ima.h        |  2 +-
 security/integrity/ima/ima_crypto.c |  4 ++--
 security/integrity/ima/ima_init.c   | 16 +++++-----------
 security/integrity/ima/ima_queue.c  |  4 ++--
 8 files changed, 52 insertions(+), 26 deletions(-)

-- 
2.13.6

