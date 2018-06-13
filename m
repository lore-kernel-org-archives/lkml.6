Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 167C6C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6CB5208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6CB5208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935428AbeFMTga (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:36:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934978AbeFMTg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:36:29 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5DJYJqa066590
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 15:36:28 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jk6kd00d0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 15:36:28 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Wed, 13 Jun 2018 13:36:27 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Jun 2018 13:36:23 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5DJaMlT62914592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Jun 2018 12:36:22 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89716C605B;
        Wed, 13 Jun 2018 13:36:22 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1ABCC6057;
        Wed, 13 Jun 2018 13:36:21 -0600 (MDT)
Received: from talon7.ibm.com (unknown [9.41.102.69])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jun 2018 13:36:21 -0600 (MDT)
From:   Eddie James <eajames@linux.vnet.ibm.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        wsa@the-dreams.de, robh+dt@kernel.org, benh@kernel.crashing.org,
        joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v10 0/7] i2c: Add FSI-attached I2C master algorithm
Date:   Wed, 13 Jun 2018 14:36:12 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18061319-0020-0000-0000-00000E2D67AB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009184; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01046493; UDB=6.00535962; IPR=6.00825469;
 MB=3.00021628; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-13 19:36:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061319-0021-0000-0000-000061ED134B
Message-Id: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-13_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=602 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806130207
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

Eddie James (7):
  dt-bindings: i2c: Add FSI-attached I2C master dt binding documentation
  i2c: Add FSI-attached I2C master algorithm
  i2c: fsi: Add port structures
  i2c: fsi: Add abort and hardware reset procedures
  i2c: fsi: Add transfer implementation
  i2c: fsi: Add I2C master locking
  i2c: fsi: Add bus recovery

 Documentation/devicetree/bindings/i2c/i2c-fsi.txt |  40 ++
 drivers/i2c/busses/Kconfig                        |  11 +
 drivers/i2c/busses/Makefile                       |   1 +
 drivers/i2c/busses/i2c-fsi.c                      | 727 ++++++++++++++++++++++
 4 files changed, 779 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-fsi.txt
 create mode 100644 drivers/i2c/busses/i2c-fsi.c

-- 
1.8.3.1

