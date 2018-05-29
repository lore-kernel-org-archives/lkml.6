Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968555AbeE2WZx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 18:25:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967882AbeE2WZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 18:25:50 -0400
From: Eddie James <eajames@linux.vnet.ibm.com>
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        wsa@the-dreams.de, robh+dt@kernel.org, benh@kernel.crashing.org,
        joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v7 0/7] i2c: Add FSI-attached I2C master algorithm
Date: Tue, 29 May 2018 17:24:18 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18052922-0012-0000-0000-000016571677
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009097; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01039557; UDB=6.00532065; IPR=6.00818685;
 MB=3.00021364; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-29 22:25:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052922-0013-0000-0000-0000530627C8
Message-Id: <1527632665-25707-1-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=519 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805290238
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds an algorithm for an I2C master physically located on an FSI
slave device. The I2C master has multiple ports, each of which may be connected
to an I2C slave. Access to the I2C master registers is achieved over FSI bus.

Due to the multi-port nature of the I2C master, the driver instantiates a new
I2C adapter for each port connected to a slave. The connected ports should be
defined in the device tree under the I2C master device.

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

Edward A. James (7):
  dt-bindings: i2c: Add FSI-attached I2C master dt binding documentation
  drivers/i2c: Add FSI-attached I2C master algorithm
  drivers/i2c: Add port structure to FSI algorithm
  drivers/i2c: Add abort and hardware reset procedures
  drivers/i2c: Add transfer implementation for FSI algorithm
  drivers/i2c: Add I2C master locking to FSI algorithm
  drivers/i2c: Add bus recovery for FSI algorithm

 Documentation/devicetree/bindings/i2c/i2c-fsi.txt |  40 ++
 drivers/i2c/busses/Kconfig                        |  11 +
 drivers/i2c/busses/Makefile                       |   1 +
 drivers/i2c/busses/i2c-fsi.c                      | 738 ++++++++++++++++++++++
 4 files changed, 790 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-fsi.txt
 create mode 100644 drivers/i2c/busses/i2c-fsi.c

-- 
1.8.3.1
