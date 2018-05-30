Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932497AbeE3VH5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:07:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932469AbeE3VHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:07:53 -0400
From: Eddie James <eajames@linux.vnet.ibm.com>
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        wsa@the-dreams.de, robh+dt@kernel.org, benh@kernel.crashing.org,
        joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, andy.shevchenko@gmail.com,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v8 0/7] i2c: Add FSI-attached I2C master algorithm
Date: Wed, 30 May 2018 16:07:37 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18053021-0004-0000-0000-000014334235
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009099; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01039988; UDB=6.00532325; IPR=6.00819121;
 MB=3.00021383; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-30 21:07:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053021-0005-0000-0000-00008778D2F0
Message-Id: <1527714464-8642-1-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-30_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=456 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805300224
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds an algorithm for an I2C master physically located on an FSI
slave device. The I2C master has multiple ports, each of which may be connected
to an I2C slave. Access to the I2C master registers is achieved over FSI bus.

Due to the multi-port nature of the I2C master, the driver instantiates a new
I2C adapter for each port connected to a slave. The connected ports should be
defined in the device tree under the I2C master device.

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
 drivers/i2c/busses/i2c-fsi.c                      | 722 ++++++++++++++++++++++
 4 files changed, 774 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-fsi.txt
 create mode 100644 drivers/i2c/busses/i2c-fsi.c

-- 
1.8.3.1
