Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED653C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F612403A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F612403A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754044AbeGESkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:40:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753801AbeGESkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:40:39 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65IYQMg020694
        for <linux-kernel@vger.kernel.org>; Thu, 5 Jul 2018 14:40:39 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k1r4b9pk1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 14:40:39 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Thu, 5 Jul 2018 12:40:38 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Jul 2018 12:40:34 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w65IeXe83998196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Jul 2018 11:40:33 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55FBB136055;
        Thu,  5 Jul 2018 12:40:33 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84175136051;
        Thu,  5 Jul 2018 12:40:32 -0600 (MDT)
Received: from talon7.ibm.com (unknown [9.41.102.69])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  5 Jul 2018 12:40:32 -0600 (MDT)
From:   Eddie James <eajames@linux.vnet.ibm.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        wsa@the-dreams.de, robh+dt@kernel.org, benh@kernel.crashing.org,
        joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v11 0/8] i2c: Add FSI-attached I2C master algorithm
Date:   Thu,  5 Jul 2018 13:40:22 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18070518-0036-0000-0000-00000A0B6316
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009314; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01057019; UDB=6.00542279; IPR=6.00834939;
 MB=3.00022012; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-05 18:40:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070518-0037-0000-0000-000047FEFCBD
Message-Id: <1530816030-13010-1-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=481 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807050207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds an algorithm for an I2C master physically located on an FSI
slave device. The I2C master has multiple ports, each of which may be connected
to an I2C slave. Access to the I2C master registers is achieved over FSI bus.

Due to the multi-port nature of the I2C master, the driver instantiates a new
I2C adapter for each port connected to a slave. The connected ports should be
defined in the device tree under the I2C master device.

Changes since v10
 - Add myself to maintainers
 - Rework the reset path. Use generic bus recovery and only do the reset if SDA
   is low.
 - Fixed email signature on dts patch
 - Pulled in Ben H's fix for use-after-free in remove()

Changes since v9
 - Switch the status masks to use a combination of bits rather than directly
   coding the value
 - Remove the interrupt mask definition as it was unused
 - Fixed return value of master_xfer function (return number of xfrs, not 0)

Changes since v8
 - Drop unecessary else statements
 - Use i++ instead of ++i
 - Use kzalloc/kfree instead of devm_kzalloc/devm_kfree for port structure
 - Drop the list_empty check in remove

Changes since v7
 - Fix grammer in Kconfig (a -> an)
 - Change I2C registers to use BIT and GENMASK
 - Remove custom macros and use FIELD_PREP and FIELD_GET
 - Fix a few unecessary initializations and "return rc" that are always zero
 - Clean up the read/write fifo functions a bit
 - Few other clean-up items

Changes since v6
 - Remove spinlock for reset functionality; it's unecessary and doesn't work
   with the latest FSI core.
 - Use a mutex instead of a semaphore, and don't wait for timeout to get the
   lock.
 - Use usleeps instead of schedule_timeout; it's not worth the overhead when
   the wait should be very short in between sending the command and receiving
   the response.

Changes since v5
 - Fix reset functionality and do a reset after every transfer failure

Eddie James (8):
  dt-bindings: i2c: Add FSI-attached I2C master dt binding documentation
  i2c: Add FSI-attached I2C master algorithm
  i2c: fsi: Add port structures
  i2c: fsi: Add abort and hardware reset procedures
  i2c: fsi: Add transfer implementation
  i2c: fsi: Add I2C master locking
  i2c: fsi: Add bus recovery
  MAINTAINERS: Add Eddie as the maintainer for the FSI-attached I2C
    driver

 Documentation/devicetree/bindings/i2c/i2c-fsi.txt |  40 ++
 MAINTAINERS                                       |   8 +
 drivers/i2c/busses/Kconfig                        |  11 +
 drivers/i2c/busses/Makefile                       |   1 +
 drivers/i2c/busses/i2c-fsi.c                      | 753 ++++++++++++++++++++++
 5 files changed, 813 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-fsi.txt
 create mode 100644 drivers/i2c/busses/i2c-fsi.c

-- 
1.8.3.1

