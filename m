Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2058C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBD7208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="R62HRvKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EBD7208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389724AbeHARCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:02:36 -0400
Received: from mail-eopbgr720075.outbound.protection.outlook.com ([40.107.72.75]:7534
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389611AbeHARCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0gOs1M+jaMcwdqRG66aDm8PULJNXXCDus60/EOExHc=;
 b=R62HRvKcN3mM4vCTIeDRdxsrOks8I0kUx3W9xfvfjfcfAa4Kex/an3zMaxzJewHrChagvVStfRtCcIJhqC7aTg/P4ZdOqzuqvYaMdl+VKkn6BlsT4oVYPfwnPJywAmEDvWrVwaA4RiayyydchItHglfEt3mNTt0ynClKb/hMxcg=
Received: from BLUPR0301CA0018.namprd03.prod.outlook.com
 (2a01:111:e400:5259::28) by DM2PR03MB557.namprd03.prod.outlook.com
 (2a01:111:e400:241b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.21; Wed, 1 Aug
 2018 15:14:16 +0000
Received: from BY2FFO11FD014.protection.gbl (2a01:111:f400:7c0c::122) by
 BLUPR0301CA0018.outlook.office365.com (2a01:111:e400:5259::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.15 via Frontend Transport; Wed, 1 Aug 2018 15:14:16 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BY2FFO11FD014.mail.protection.outlook.com (10.1.14.76) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1017.15
 via Frontend Transport; Wed, 1 Aug 2018 15:14:15 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w71FEEe0013762
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Wed, 1 Aug 2018 08:14:14 -0700
Received: from linux.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Wed, 1 Aug 2018
 11:14:12 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <mchehab@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v2 1/6] iio: adxl372: New driver for Analog Devices ADXL372 Accelerometer
Date:   Wed, 1 Aug 2018 18:13:09 +0300
Message-ID: <1533136389-31600-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(346002)(376002)(136003)(396003)(2980300002)(438002)(189003)(199004)(316002)(16586007)(50226002)(106466001)(106002)(47776003)(53416004)(2351001)(54906003)(1720100001)(4326008)(7696005)(8936002)(2906002)(126002)(44832011)(426003)(486006)(8676002)(356003)(14444005)(476003)(478600001)(305945005)(966005)(7636002)(72206003)(246002)(51416003)(107886003)(50466002)(26005)(6916009)(6666003)(77096007)(36756003)(186003)(6306002)(7416002)(5660300001)(2616005)(336012)(48376002)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB557;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD014;1:KDU1mYw//bDTZ9f4ZVC8ihwoCYPcgbNbV70z7Zeq3BVNZ5v2KzUO11/wbimzmE2kMYCx27bWtXDdvcKFHk4a/8BmnJbt/XnlEeMOkzeFgJVUtRL51Cka0iAOmzVx/iKg
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fcc70fd-ea4c-4f70-b2a1-08d5f7c17213
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM2PR03MB557;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB557;3:8jqK6mIMceH6Z/BbspDl87SZo5xXnLFVls2ujh3dbOEiFzH0J+4tVelLvR9vld4c/KK9DCYXNpyRIbC1nZbTmrYcJjpOthOe7S0VH1pBT32p40bQVmL04s5I5Ui+kWsZqsglfhkYtj0KYi3VoaRKBQmHZqXhi2w/rDwclJNECWWOgvDfBYJVyLKI6uAe5ygKOSJdqx2TVQ9A2JTHwZ6EicgIrZgTQeqLycR1W/9nKMbyR44FG0fMBW1IIjFE61JW0+wvNKmkJ8dZMtKez+DYCBHS+k4uL/cTpkiWjFzGty8ZEKimtRYF4iHHghY1dxc09A1vuUk5muXFB8jnSrv5oElcPoLR6CXx6VX8/ixo1bA=;25:kqhTzaz6cH9Qo2NMWRSzf5x7ce/EHXMYrCebn/Ys8oB5tpdOFqFK851rsnJCzv5zE2FOTjl3j8LwNhrOLSBs4leVAYea75rJVlF5LfQ6a+nBb94enQZrCjl38WWc148NBYuk3hx98sp80j9lvIha5bjtgue3Qj8J4Zr2Sq2H/PZejKbwncZBOr3ty8Kmd8H4OsCd1rdk468NZT55126K6RHNybR4OLDQHjamNkZLIfjK8F/Jxa1zmFM+J5QkOy4gCjZJFQ/IHTd+DlFPwSzxXGBzIl6eDmQ5itiJj27ESFQta/wFf2Rt96uXHXn/KY6sPe6AjSC5zw5IfXkFVW4E5Q==
X-MS-TrafficTypeDiagnostic: DM2PR03MB557:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB557;31:vGTboGwdDerDWTukgURJYuGkUj5QwSKjk2ir/MmwWCHjE3v1RdKcS2xeVyrvDRfpQwXDaGtjvmFnNFHkScTCZxdLcfRU5UWjyoMAVmJIgzF7HmM7FT7SZzuZLXaI6BfYRqUpnrcWWeZemmNBSHtpcY7T2Pau9JTDe8GJWXvO9pVsCC71GI5z2Yh9XLzHhMPZmnEg1eL0FjGn9IFsWFqgbGDFEh9ILF/aiJZVkrBVlpU=;20:LY7cXxhfm6V7pPxots8FNXYlyfovfCTkhHOjA9ss6Z3PzAe6Og4KTysJ65vIOhPWReH09c72Ya4ePtzOet/6vbIqKyw0Q5Xuz+I3ClKmq3sEEzpGpl245Cv7CIJncMh7InGlpDx/8BLihcfw9c1y4AyYs9NycwO7v83YX737SsEeVYzcEXbtno7GN8XdtD87WrJ+Nt19ImcxHHSTf/cKFtRh3Jr46MJ948vbzR3zkWERuo5NgqJzQxUN09naC4G2bsrPwarl0AgEar7b8yM4tE9l2yhv0kuFeEGfsNIk5LlTuZbln5HYUJdhJFi85lN2krQENAO7GZkCFIqfAPGxya9JZoqB/g5bOCfnY6dEanlz35VBj0b/sH2of3VM9OASNt4s5QHb7gOgoZ1VchU3Uwdniig4vYaMUb+YN86qBTHum3jjukzP0FtfDel30fL8CPLVa2/rTvbsmb3X9rrDYUAFOwvO19zCZsBlxKG6wMRusOuEhbeSl9vx7G3KLy+g
X-Microsoft-Antispam-PRVS: <DM2PR03MB557C80A3FE6FC262F73E7C99D2D0@DM2PR03MB557.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(9452136761055)(232431446821674)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM2PR03MB557;BCL:0;PCL:0;RULEID:;SRVR:DM2PR03MB557;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB557;4:djLCbVJkQsNSui39TLhwsomoxf4vAWdgUb+48XTb9IdjJE28IPmboFR/cw+3LWgGFQokY213PkpHN1vqz4qDH+kdQ98HjEXrDfcBzzCozQtqOEIx54kfSq3QFJar4PTrhTMHmnN3okmrTDcpuL8wP/lKySBn+9UKOiBnnkNdr66p1eZK3zcbu/bXwfgvWLqKn2DAgV2jD6wfPkB52Dj9YIWE1WFlkpCQum/Bd6Pje4MZpa9yFarJe3ubpehtQVQvhx7qofByjX5dTAdgsjxeLbAXTGsFtbpysJV/0UZtg2cEKssDHMQ4F5maYiS4IjoHbnP9OpQ3DhmiyTEZUVf1mn8pp+ON5Q3eVfpw7x7QtShe6tbxaEg34dReu3waeyymY8PgGxRzlZ1qhK1j3VtsKRI9OinMzQRAT4DkwlFwxxI=
X-Forefront-PRVS: 0751474A44
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR03MB557;23:YCkJvXHh3CrHl3svO12IEvKgSC4TMgJftehqK82cuE?=
 =?us-ascii?Q?s1Yt+W/EhuIf7URA1fo62YlSUVu0nc2X7q+o2Q60nOrNYZ4i+r6f/D1mOOio?=
 =?us-ascii?Q?Asl9wpXeN+RijC5dhKVPHPeAbUgT7qHYB+F/Lhi3tskWDglyUCNUxqGTfxuQ?=
 =?us-ascii?Q?IVnBF67xcUys5K5UV7fxX8fJrFxhjrKyzWVAicK2jBSOgwdFxM+ZdUlWuBdi?=
 =?us-ascii?Q?mnSlb2uujN1zIVhCAMgZKClo2h4nDAS1djTi371e+mB3S750GV+HqYFmD4Nw?=
 =?us-ascii?Q?eta+FNpyUw+Tam/q+SPKkwRWREm831UXQRKnUP7n9ASAX1RTSpdAgL2zSplc?=
 =?us-ascii?Q?UVqw0IqYBHDNwPJ53Yx5dwS99vSh/jeO1lQNSgY7yZsnxcva14hMBz8SUolr?=
 =?us-ascii?Q?ixPJOVsycL290XMpz9lKwN4lGgOfapnuS9bzpkwSz9XrEpVm6gZsd7Hh7WUu?=
 =?us-ascii?Q?2eKP7wDnafqwlTd0xYEoZRUMNB6ENOaBzHJBynFTOuwdCdE/L07noNWGo/dy?=
 =?us-ascii?Q?3CLXND4CXxgtwbYyJnp/aucOybNYuvyqf6bBpmlf6p3FRr2DdegFE1OsBWga?=
 =?us-ascii?Q?laq1yKbL6Qn4Xkxvqrm3ROnD8qpOAbF65xJtc5nu5RW116i09ndL35EkPYbR?=
 =?us-ascii?Q?AHxvI384hG6G2cOVIPzzzegw+OK1Z7ZmX/iFqjxyw3+TZdU7FLjoUG27YwrG?=
 =?us-ascii?Q?k0omJgHvBurfYld3+h4RknkXw7hgiJtLuJ1eEu5f9eT4chDzJjPAO8/+2G6a?=
 =?us-ascii?Q?CIRqXGCbqVETYMwP6JBnF3cpGFji60WuCRbEzPgEgeSxmaasQ6UzGEqvlzW3?=
 =?us-ascii?Q?WVHcLOGKBqMtOr0wAYWklIcD7a5Q8mJabSrDXbzzoDspIIAz3Z1ZAeQAZub5?=
 =?us-ascii?Q?qff1YSMZusmoRy9IhthqN4AXvQRySVET13/6ntzlGAOnDm48AJyCmEHLXBuq?=
 =?us-ascii?Q?W8OBXXedJeZpfPSjKRnOwy44Abiv2St+4jtcbYwpcV/FjBzcSMpdRviiyhXd?=
 =?us-ascii?Q?8J0JYW4XMQSwmumXGMKIzWfswFnO7LT9CNQZtwPhPwhX9B5j6Wiw+VsCSQZr?=
 =?us-ascii?Q?ThTYvkbp5SvohPO16UXQmCJ1zhKZXneTQtWF+sa9mHPdqGZwismLj8lCI+80?=
 =?us-ascii?Q?dPWbdOtcTkmka25dCRjSIhyaAnfZApAjyJlduzEg3TjiIl4+8aaA=3D=3D?=
X-Microsoft-Antispam-Message-Info: j0MSLTcjRvPB5tEoTJPznVKjdRtJUppoBqVEUwr/wavNplfHddMYtjJNNEta6kJjes23qdZCZspr6TF9W0OkdrEQno52bUN/OKyO64PoNKOInC9f40Qx/KKKvrHt/GE8NEdSXKO8KlfSuY71MCwlOa4C28+4TkLFtVQB265wtXdj5PRMEZrNF16KrY9NKJYrOALAl5x9Ic9MTjnS9zl91ZL/+A3WsjrY5eJKDnNiFnUU5YCQv/U1jt7r0me9GFntcE32cRzgRLdO9tjmGai/ojbwJvQi14MVxnPA+DxRE01y85Uap26W61Fe2e2xPwwigyxu67jI9DyN4aYOoq0Rs/CXHNVXmufpCVcr9u4UOHM=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB557;6:IQMhlLtybVD93PYXPxi8JD1XXfFx0TSOIYLWZ0t8iJeHiUiPOHb2FGkhhG20sjGr/0dB0Q+hA1eMqPc2nSlGA96w78KlVva++KNADuVTxiMpVocfgysLLLl9oDO7KX0zx0FlrXWXyiXFGChpVsG6sSkcKNL4CRrxHU+4chGshiwUy5sIKL19Pp3ne/KY3CJ/a4x8UoZbhz6kc/IM5Oru2VY6n3HldZOw5ELmxD/ISY9HbfBXy4tB1IRCFjkQFBzccOWceNB6G3f0mPoim+/Iw92YCdzcWH49vfK6wdp8nJadllZw1bV5Xzuv4HNuD/m9uhZw1uvdhXFn/7II53NmvqpQ3IV2RniRz1Jwt+fKpwvTT5urs6TTLOsHc1dPX6gXUnH792n9+01D+TfSIBX3mvG1JW6XgNGesewd8xb3LcH05DRZToKWGEw0nsjXjXSbCzDX5U/LkNSgkXUJiYflmA==;5:+0q3nmXClNXkqmfvU7cTdt4A8E+P9VmlJl/VvGCa9t++lC20JTDel8Zg9cSCeF85rtjDBILxs6lfbuXZxPq6vmudFNMIGWZnZKfrTfzpLAi7AwyYaOJP53dW9aE9vbUjjZKQCStJrrAzg17nP+n2XcsZA7S7j3H4JvoDe85inKE=;7:J8l1O/2KD69pmvD0GZHxzQd/V7KxolUGqbthdSG0IinmnHPvSf6z6+oZEb26F1zg4THj/5qpn2sn4AKwVPrFSwAjGrKyyGuv4qyWFm66VyCfjgSXdQ9zaJSNZhCqpWmZ4c6802zKOplLHF8BgVtFp/dnICH8UdLTAPrBloE4DZ5vjgDxOOL5nD72yf2+PKI0+uxxxvnGrqQCtFhuld1rG0ptIFySXL4WqR+vendNsc9xhczGJ/rJVSWxPrhpAKzW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 15:14:15.4514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcc70fd-ea4c-4f70-b2a1-08d5f7c17213
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic support for Analog Devices ADXL372 SPI-Bus
Three-Axis Digital Accelerometer.

The device is probed and configured the with some initial default
values. With this basic driver, it is possible to read raw acceleration
data.

Datasheet:
http://www.analog.com/media/en/technical-documentation/data-sheets/ADXL372.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- removed ADXL372_RD_FLAG_MSK and ADXL372_WR_FLAG_MSK macros.
	- handled regmap read/write by setting reg_bits and pad_bits
	  fields in regmap_config struct.
	- removed the buffer specifications when defining the channels.
	- changed the activity and inactivity thresholds.
	- added two new functions for setting the activity and inactivity
	  timers: adxl372_set_inactivity_time_ms() and
	  adxl372_set_activity_time_ms().

 MAINTAINERS                 |   6 +
 drivers/iio/accel/Kconfig   |  11 +
 drivers/iio/accel/Makefile  |   1 +
 drivers/iio/accel/adxl372.c | 530 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 548 insertions(+)
 create mode 100644 drivers/iio/accel/adxl372.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 60b1028..2ba47bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -543,6 +543,12 @@ W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/input/misc/adxl34x.c
 
+ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
+M:	Stefan Popa <stefan.popa@analog.com>
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/accel/adxl372.c
+
 AF9013 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 62ae7e5..1b496ef 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -60,6 +60,17 @@ config ADXL345_SPI
 	  will be called adxl345_spi and you will also get adxl345_core
 	  for the core module.
 
+config ADXL372
+	tristate "Analog Devices ADXL372 3-Axis Accelerometer Driver"
+	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to add support for the Analog Devices ADXL372 triaxial
+	  acceleration sensor.
+	  To compile this driver as a module, choose M here: the
+	  module will be called adxl372.
+
 config BMA180
 	tristate "Bosch BMA180/BMA250 3-Axis Accelerometer Driver"
 	depends on I2C
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 636d4d1..5758ffc 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_ADIS16209) += adis16209.o
 obj-$(CONFIG_ADXL345) += adxl345_core.o
 obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
 obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
+obj-$(CONFIG_ADXL372) += adxl372.o
 obj-$(CONFIG_BMA180) += bma180.o
 obj-$(CONFIG_BMA220) += bma220_spi.o
 obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
new file mode 100644
index 0000000..7d5092d
--- /dev/null
+++ b/drivers/iio/accel/adxl372.c
@@ -0,0 +1,530 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ADXL372 3-Axis Digital Accelerometer SPI driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+/* ADXL372 registers definition */
+#define ADXL372_DEVID			0x00
+#define ADXL372_DEVID_MST		0x01
+#define ADXL372_PARTID			0x02
+#define ADXL372_REVID			0x03
+#define ADXL372_STATUS_1		0x04
+#define ADXL372_STATUS_2		0x05
+#define ADXL372_FIFO_ENTRIES_2		0x06
+#define ADXL372_FIFO_ENTRIES_1		0x07
+#define ADXL372_X_DATA_H		0x08
+#define ADXL372_X_DATA_L		0x09
+#define ADXL372_Y_DATA_H		0x0A
+#define ADXL372_Y_DATA_L		0x0B
+#define ADXL372_Z_DATA_H		0x0C
+#define ADXL372_Z_DATA_L		0x0D
+#define ADXL372_X_MAXPEAK_H		0x15
+#define ADXL372_X_MAXPEAK_L		0x16
+#define ADXL372_Y_MAXPEAK_H		0x17
+#define ADXL372_Y_MAXPEAK_L		0x18
+#define ADXL372_Z_MAXPEAK_H		0x19
+#define ADXL372_Z_MAXPEAK_L		0x1A
+#define ADXL372_OFFSET_X		0x20
+#define ADXL372_OFFSET_Y		0x21
+#define ADXL372_OFFSET_Z		0x22
+#define ADXL372_X_THRESH_ACT_H		0x23
+#define ADXL372_X_THRESH_ACT_L		0x24
+#define ADXL372_Y_THRESH_ACT_H		0x25
+#define ADXL372_Y_THRESH_ACT_L		0x26
+#define ADXL372_Z_THRESH_ACT_H		0x27
+#define ADXL372_Z_THRESH_ACT_L		0x28
+#define ADXL372_TIME_ACT		0x29
+#define ADXL372_X_THRESH_INACT_H	0x2A
+#define ADXL372_X_THRESH_INACT_L	0x2B
+#define ADXL372_Y_THRESH_INACT_H	0x2C
+#define ADXL372_Y_THRESH_INACT_L	0x2D
+#define ADXL372_Z_THRESH_INACT_H	0x2E
+#define ADXL372_Z_THRESH_INACT_L	0x2F
+#define ADXL372_TIME_INACT_H		0x30
+#define ADXL372_TIME_INACT_L		0x31
+#define ADXL372_X_THRESH_ACT2_H		0x32
+#define ADXL372_X_THRESH_ACT2_L		0x33
+#define ADXL372_Y_THRESH_ACT2_H		0x34
+#define ADXL372_Y_THRESH_ACT2_L		0x35
+#define ADXL372_Z_THRESH_ACT2_H		0x36
+#define ADXL372_Z_THRESH_ACT2_L		0x37
+#define ADXL372_HPF			0x38
+#define ADXL372_FIFO_SAMPLES		0x39
+#define ADXL372_FIFO_CTL		0x3A
+#define ADXL372_INT1_MAP		0x3B
+#define ADXL372_INT2_MAP		0x3C
+#define ADXL372_TIMING			0x3D
+#define ADXL372_MEASURE			0x3E
+#define ADXL372_POWER_CTL		0x3F
+#define ADXL372_SELF_TEST		0x40
+#define ADXL372_RESET			0x41
+#define ADXL372_FIFO_DATA		0x42
+
+#define ADXL372_DEVID_VAL		0xAD
+#define ADXL372_PARTID_VAL		0xFA
+#define ADXL372_RESET_CODE		0x52
+
+/* ADXL372_POWER_CTL */
+#define ADXL372_POWER_CTL_MODE_MSK		GENMASK_ULL(1, 0)
+#define ADXL372_POWER_CTL_MODE(x)		(((x) & 0x3) << 0)
+
+/* ADXL372_MEASURE */
+#define ADXL372_MEASURE_LINKLOOP_MSK		GENMASK_ULL(5, 4)
+#define ADXL372_MEASURE_LINKLOOP_MODE(x)	(((x) & 0x3) << 4)
+#define ADXL372_MEASURE_BANDWIDTH_MSK		GENMASK_ULL(2, 0)
+#define ADXL372_MEASURE_BANDWIDTH_MODE(x)	(((x) & 0x7) << 0)
+
+/* ADXL372_TIMING */
+#define ADXL372_TIMING_ODR_MSK			GENMASK_ULL(7, 5)
+#define ADXL372_TIMING_ODR_MODE(x)		(((x) & 0x7) << 5)
+
+/* ADXL372_FIFO_CTL */
+#define ADXL372_FIFO_CTL_FORMAT_MSK		GENMASK(5, 3)
+#define ADXL372_FIFO_CTL_FORMAT_MODE(x)		(((x) & 0x7) << 3)
+#define ADXL372_FIFO_CTL_MODE_MSK		GENMASK(2, 1)
+#define ADXL372_FIFO_CTL_MODE_MODE(x)		(((x) & 0x3) << 1)
+#define ADXL372_FIFO_CTL_SAMPLES_MSK		BIT(1)
+#define ADXL372_FIFO_CTL_SAMPLES_MODE(x)	(((x) > 0xFF) ? 1 : 0)
+
+/* ADXL372_STATUS_1 */
+#define ADXL372_STATUS_1_DATA_RDY(x)		(((x) >> 0) & 0x1)
+#define ADXL372_STATUS_1_FIFO_RDY(x)		(((x) >> 1) & 0x1)
+#define ADXL372_STATUS_1_FIFO_FULL(x)		(((x) >> 2) & 0x1)
+#define ADXL372_STATUS_1_FIFO_OVR(x)		(((x) >> 3) & 0x1)
+#define ADXL372_STATUS_1_USR_NVM_BUSY(x)	(((x) >> 5) & 0x1)
+#define ADXL372_STATUS_1_AWAKE(x)		(((x) >> 6) & 0x1)
+#define ADXL372_STATUS_1_ERR_USR_REGS(x)	(((x) >> 7) & 0x1)
+
+/* ADXL372_INT1_MAP */
+#define ADXL372_INT1_MAP_DATA_RDY_MSK		BIT(0)
+#define ADXL372_INT1_MAP_DATA_RDY_MODE(x)	(((x) & 0x1) << 0)
+#define ADXL372_INT1_MAP_FIFO_RDY_MSK		BIT(1)
+#define ADXL372_INT1_MAP_FIFO_RDY_MODE(x)	(((x) & 0x1) << 1)
+#define ADXL372_INT1_MAP_FIFO_FULL_MSK		BIT(2)
+#define ADXL372_INT1_MAP_FIFO_FULL_MODE(x)	(((x) & 0x1) << 2)
+#define ADXL372_INT1_MAP_FIFO_OVR_MSK		BIT(3)
+#define ADXL372_INT1_MAP_FIFO_OVR_MODE(x)	(((x) & 0x1) << 3)
+#define ADXL372_INT1_MAP_INACT_MSK		BIT(4)
+#define ADXL372_INT1_MAP_INACT_MODE(x)		(((x) & 0x1) << 4)
+#define ADXL372_INT1_MAP_ACT_MSK		BIT(5)
+#define ADXL372_INT1_MAP_ACT_MODE(x)		(((x) & 0x1) << 5)
+#define ADXL372_INT1_MAP_AWAKE_MSK		BIT(6)
+#define ADXL372_INT1_MAP_AWAKE_MODE(x)		(((x) & 0x1) << 6)
+#define ADXL372_INT1_MAP_LOW_MSK		BIT(7)
+#define ADXL372_INT1_MAP_LOW_MODE(x)		(((x) & 0x1) << 7)
+
+/*
+ * At +/- 200g with 12-bit resolution, scale is computed as:
+ * (200 + 200) * 9.81 / (2^12 - 1) = 0.958241
+ */
+#define ADXL372_USCALE	958241
+
+enum adxl372_op_mode {
+	ADXL372_STANDBY,
+	ADXL372_WAKE_UP,
+	ADXL372_INSTANT_ON,
+	ADXL372_FULL_BW_MEASUREMENT,
+};
+
+enum adxl372_act_proc_mode {
+	ADXL372_DEFAULT,
+	ADXL372_LINKED,
+	ADXL372_LOOPED,
+};
+
+enum adxl372_th_activity {
+	ADXL372_ACTIVITY,
+	ADXL372_ACTIVITY2,
+	ADXL372_INACTIVITY,
+};
+
+enum adxl372_odr {
+	ADXL372_ODR_400HZ,
+	ADXL372_ODR_800HZ,
+	ADXL372_ODR_1600HZ,
+	ADXL372_ODR_3200HZ,
+	ADXL372_ODR_6400HZ,
+};
+
+enum adxl372_bandwidth {
+	ADXL372_BW_200HZ,
+	ADXL372_BW_400HZ,
+	ADXL372_BW_800HZ,
+	ADXL372_BW_1600HZ,
+	ADXL372_BW_3200HZ,
+};
+
+#define ADXL372_ACCEL_CHANNEL(index, reg, axis) {			\
+	.type = IIO_ACCEL,						\
+	.address = reg,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+}
+
+static const struct iio_chan_spec adxl372_channels[] = {
+	ADXL372_ACCEL_CHANNEL(0, ADXL372_X_DATA_H, X),
+	ADXL372_ACCEL_CHANNEL(1, ADXL372_Y_DATA_H, Y),
+	ADXL372_ACCEL_CHANNEL(2, ADXL372_Z_DATA_H, Z),
+};
+
+struct adxl372_state {
+	struct spi_device		*spi;
+	struct regmap			*regmap;
+	enum adxl372_op_mode		op_mode;
+	enum adxl372_act_proc_mode	act_proc_mode;
+	enum adxl372_odr		odr;
+	enum adxl372_bandwidth		bw;
+	u32				act_time_ms;
+	u32				inact_time_ms;
+};
+
+static int adxl372_read_axis(struct adxl372_state *st, u8 addr)
+{
+	__be16 regval;
+	int ret;
+
+	ret = regmap_bulk_read(st->regmap, addr, &regval, sizeof(regval));
+	if (ret < 0)
+		return ret;
+
+	return be16_to_cpu(regval);
+}
+
+static int adxl372_set_op_mode(struct adxl372_state *st,
+			       enum adxl372_op_mode op_mode)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL372_POWER_CTL,
+				 ADXL372_POWER_CTL_MODE_MSK,
+				 ADXL372_POWER_CTL_MODE(op_mode));
+	if (ret < 0)
+		return ret;
+
+	st->op_mode = op_mode;
+
+	return ret;
+}
+
+static int adxl372_set_odr(struct adxl372_state *st,
+			   enum adxl372_odr odr)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL372_TIMING,
+				 ADXL372_TIMING_ODR_MSK,
+				 ADXL372_TIMING_ODR_MODE(odr));
+	if (ret < 0)
+		return ret;
+
+	st->odr = odr;
+
+	return ret;
+}
+
+static int adxl372_set_bandwidth(struct adxl372_state *st,
+				 enum adxl372_bandwidth bw)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL372_MEASURE,
+				 ADXL372_MEASURE_BANDWIDTH_MSK,
+				 ADXL372_MEASURE_BANDWIDTH_MODE(bw));
+	if (ret < 0)
+		return ret;
+
+	st->bw = bw;
+
+	return ret;
+}
+
+static int adxl372_set_act_proc_mode(struct adxl372_state *st,
+				     enum adxl372_act_proc_mode mode)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap,
+				 ADXL372_MEASURE,
+				 ADXL372_MEASURE_LINKLOOP_MSK,
+				 ADXL372_MEASURE_LINKLOOP_MODE(mode));
+	if (ret < 0)
+		return ret;
+
+	st->act_proc_mode = mode;
+
+	return ret;
+}
+
+static int adxl372_set_activity_threshold(struct adxl372_state *st,
+					  enum adxl372_th_activity act,
+					  bool ref_en, bool enable,
+					  unsigned int threshold)
+{
+	unsigned char buf[6];
+	unsigned char th_reg_high_val, th_reg_low_val, th_reg_high_addr;
+
+	/* scale factor is 100 mg/code */
+	th_reg_high_val = (threshold / 100) >> 3;
+	th_reg_low_val = ((threshold / 100) << 5) | (ref_en << 1) | enable;
+
+	switch (act) {
+	case ADXL372_ACTIVITY:
+		th_reg_high_addr = ADXL372_X_THRESH_ACT_H;
+		break;
+	case ADXL372_ACTIVITY2:
+		th_reg_high_addr = ADXL372_X_THRESH_ACT2_H;
+		break;
+	case ADXL372_INACTIVITY:
+		th_reg_high_addr = ADXL372_X_THRESH_INACT_H;
+		break;
+	}
+
+	buf[0] = th_reg_high_val;
+	buf[1] = th_reg_low_val;
+	buf[2] = th_reg_high_val;
+	buf[3] = th_reg_low_val;
+	buf[4] = th_reg_high_val;
+	buf[5] = th_reg_low_val;
+
+	return regmap_bulk_write(st->regmap, th_reg_high_addr,
+				 buf, ARRAY_SIZE(buf));
+}
+
+static int adxl372_set_activity_time_ms(struct adxl372_state *st,
+					unsigned int act_time_ms)
+{
+	unsigned int reg_val, scale_factor;
+	int ret;
+
+	/*
+	 * 3.3 ms per code is the scale factor of the TIME_ACT register for
+	 * ODR = 6400 Hz. It is 6.6 ms per code for ODR = 3200 Hz and below.
+	 */
+	if (st->odr == ADXL372_ODR_6400HZ)
+		scale_factor = 3300;
+	else
+		scale_factor = 6600;
+
+	reg_val = DIV_ROUND_CLOSEST(act_time_ms * 1000, scale_factor);
+
+	/* TIME_ACT register is 8 bits wide */
+	if (reg_val > 0xFF)
+		reg_val = 0xFF;
+
+	ret = regmap_write(st->regmap, ADXL372_TIME_ACT, reg_val);
+	if (ret < 0)
+		return ret;
+
+	st->act_time_ms = act_time_ms;
+
+	return ret;
+}
+
+static int adxl372_set_inactivity_time_ms(struct adxl372_state *st,
+					  unsigned int inact_time_ms)
+{
+	unsigned int reg_val_h, reg_val_l, res, scale_factor;
+	int ret;
+
+	/*
+	 * 13 ms per code is the scale factor of the TIME_INACT register for
+	 * ODR = 6400 Hz. It is 26 ms per code for ODR = 3200 Hz and below.
+	 */
+	if (st->odr == ADXL372_ODR_6400HZ)
+		scale_factor = 13;
+	else
+		scale_factor = 26;
+
+	res = DIV_ROUND_CLOSEST(inact_time_ms, scale_factor);
+	reg_val_h = (res >> 8) & 0xFF;
+	reg_val_l = res & 0xFF;
+
+	ret = regmap_write(st->regmap, ADXL372_TIME_INACT_H, reg_val_h);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADXL372_TIME_INACT_L, reg_val_l);
+	if (ret < 0)
+		return ret;
+
+	st->inact_time_ms = inact_time_ms;
+
+	return ret;
+}
+
+static int adxl372_setup(struct adxl372_state *st)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL372_DEVID, &regval);
+	if (ret < 0)
+		return ret;
+
+	if (regval != ADXL372_DEVID_VAL) {
+		dev_err(&st->spi->dev, "Invalid chip id %x\n", regval);
+		return -ENODEV;
+	}
+
+	ret = adxl372_set_op_mode(st, ADXL372_STANDBY);
+	if (ret < 0)
+		return ret;
+
+	/* Set threshold for activity detection to 1g */
+	ret = adxl372_set_activity_threshold(st, ADXL372_ACTIVITY,
+					     true, true, 1000);
+	if (ret < 0)
+		return ret;
+
+	/* Set threshold for inactivity detection to 100mg */
+	ret = adxl372_set_activity_threshold(st, ADXL372_INACTIVITY,
+					     true, true, 100);
+	if (ret < 0)
+		return ret;
+
+	/* Set activity processing in Looped mode */
+	ret = adxl372_set_act_proc_mode(st, ADXL372_LOOPED);
+	if (ret < 0)
+		return ret;
+
+	ret = adxl372_set_odr(st, ADXL372_ODR_6400HZ);
+	if (ret < 0)
+		return ret;
+
+	ret = adxl372_set_bandwidth(st, ADXL372_BW_3200HZ);
+	if (ret < 0)
+		return ret;
+
+	/* Set activity timer to 1ms */
+	ret = adxl372_set_activity_time_ms(st, 1);
+	if (ret < 0)
+		return ret;
+
+	/* Set inactivity timer to 10s */
+	ret = adxl372_set_inactivity_time_ms(st, 10000);
+	if (ret < 0)
+		return ret;
+
+	/* Set the mode of operation to full bandwidth measurement mode */
+	return adxl372_set_op_mode(st, ADXL372_FULL_BW_MEASUREMENT);
+}
+
+static int adxl372_reg_access(struct iio_dev *indio_dev,
+			      unsigned int reg,
+			      unsigned int writeval,
+			      unsigned int *readval)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+	else
+		return regmap_write(st->regmap, reg, writeval);
+}
+
+static int adxl372_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long info)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = adxl372_read_axis(st, chan->address);
+		if (ret < 0)
+			return ret;
+
+		*val = sign_extend32(ret >> chan->scan_type.shift,
+				     chan->scan_type.realbits - 1);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		*val2 = ADXL372_USCALE;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info adxl372_info = {
+	.read_raw = adxl372_read_raw,
+	.debugfs_reg_access = &adxl372_reg_access,
+};
+
+static const struct regmap_config adxl372_spi_regmap_config = {
+	.reg_bits = 7,
+	.pad_bits = 1,
+	.val_bits = 8,
+	.read_flag_mask = BIT(0),
+};
+
+static int adxl372_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct adxl372_state *st;
+	struct regmap *regmap;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
+
+	st->spi = spi;
+
+	regmap = devm_regmap_init_spi(spi, &adxl372_spi_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	st->regmap = regmap;
+
+	indio_dev->channels = adxl372_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adxl372_channels);
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->info = &adxl372_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = adxl372_setup(st);
+	if (ret < 0) {
+		dev_err(&st->spi->dev, "ADXL372 setup failed\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(&st->spi->dev, indio_dev);
+}
+
+static const struct spi_device_id adxl372_id[] = {
+	{ "adxl372", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, adxl372_id);
+
+static struct spi_driver adxl372_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+	.probe = adxl372_probe,
+	.id_table = adxl372_id,
+};
+
+module_spi_driver(adxl372_driver);
+
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

